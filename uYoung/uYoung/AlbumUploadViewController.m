//
//  AlbumUploadViewController.m
//  uYoung
//
//  Created by 独自天涯 on 15/12/16.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "AlbumUploadViewController.h"
#import "ZLPhotoAssets.h"
#import "UIImageView+WebCache.h"
#import "GlobalConfig.h"
#import "UIImage+scales.h"
#import "UserDetailModel.h"
#import "NSString+StringUtil.h"
#import "UIWindow+YoungHUD.h"
#import "PicExifUtil.h"
#import "PicExif.h"
#import "LoginViewController.h"
#import "LoginFilterUtil.h"

@interface AlbumUploadViewController ()

@end

@implementation AlbumUploadViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"AlbumPicCollectionCell" bundle:nil];
    [_imageCollection registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    
    _assets = [[NSMutableArray alloc]initWithCapacity:0];
    _imgParams = [[NSMutableArray alloc]initWithCapacity:1];
    _oriImage = [[NSMutableArray alloc]initWithCapacity:1];
    _exifArr = [[NSMutableArray alloc]initWithCapacity:1];
    
    _backcover = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight)];
    [_backcover setBackgroundColor:[UIColor lightGrayColor]];
    _backcover.alpha = 0.6;
    [_backcover setHidden:YES];
    [self.view addSubview:_backcover];
    
    [self selectPhotos];
}

-(void)viewDidAppear:(BOOL)animated{
    _counter = 0;
    _photoDetailModels = [[NSMutableArray alloc]initWithCapacity:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showSysPhoto:(id)sender {
    [self selectPhotos];
}

- (IBAction)uploadImages:(id)sender {
    if(_assets!=nil&&[_assets count]>0&&[_assets count]==[_oriImage count]){
        dispatch_group_t group = dispatch_group_create();
        dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
        [_backcover setHidden:NO];
        [self.view.window showHUDWithText:@"正在上传..." Type:ShowLoading Enabled:YES];
        NSString *format = @"uy_user/%ld/album/%ld/t/%@";
        for (int i=0; i<[_oriImage count]; i++) {
            dispatch_group_enter(group);
            dispatch_group_async(group, queue, ^{
                long timer = [[NSDate date]timeIntervalSince1970];
                NSString *t = [NSString stringWithFormat:@"%ld%d", timer, i];
                NSString *key = [NSString stringWithFormat:format, _owneruid, _albumid, t];
                UIImage *image = _oriImage[i];
                [[UploadImageUtil dispatchOnce]uploadAlbumImageSycro:image withKey:key exif:_exifArr[i] albumId:_albumid ownerId:_owneruid complete:^(PhotoDetailModel *detail, NSInteger state) {
                    _state = state;
                    if (detail!=nil) {
                        [_photoDetailModels addObject:detail];
                        NSData *qiniuHostData = [[NSUserDefaults standardUserDefaults]objectForKey:@"qiniu_host"];
                        NSString *qiniuHost = [NSKeyedUnarchiver unarchiveObjectWithData:qiniuHostData];
                        _coverUrl = [qiniuHost stringByAppendingString:detail.photoUrl];
                    }
                    dispatch_group_leave(group);
                }];
            });
        }
        dispatch_group_notify(group, queue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                //更新相册封面
                [UploadImageUtil updateAlbumCover:_coverUrl albumId:_albumid];
                [_backcover setHidden:YES];
                if (_state==200) {
                    [self.view.window showHUDWithText:@"上传完成" Type:ShowPhotoYes Enabled:YES];
                }else if(_state==-3){
                    [self.view.window showHUDWithText:@"请重新登录" Type:ShowPhotoNo Enabled:YES];
                }else{
                    [self.view.window showHUDWithText:@"上传出现错误" Type:ShowPhotoNo Enabled:YES];
                }
                [self dismissViewControllerAnimated:YES completion:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshAlbum" object:_photoDetailModels];
            });
        });
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_assets count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIImage *image;
    AlbumPicCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    ZLPhotoAssets *asset = self.assets[indexPath.row];
    PicExif *exif = [[PicExif alloc]init];
    if ([asset isKindOfClass:[ZLPhotoAssets class]]) {
        image = asset.originImage;
        exif = [[PicExifUtil shareInstance]getWithALAsset:asset.asset];
    }else if ([asset isKindOfClass:[NSString class]]){
        [cell.img sd_setImageWithURL:[NSURL URLWithString:(NSString *)asset] placeholderImage:[UIImage imageNamed:@"pc_circle_placeholder"]];
        image = cell.img.image;
    }else if([asset isKindOfClass:[UIImage class]]){
        image = (UIImage*)asset;
    }
    [cell.img setImage:[image scaleToSize:cell.frame.size]];
    cell.oriImg = image;
    [cell hiddenLabels];

    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    // 图片游览器
    ZLPhotoPickerBrowserViewController *pickerBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];
    // 数据源/delegate
    pickerBrowser.delegate = self;
    pickerBrowser.dataSource = self;
    // 是否可以删除照片
    pickerBrowser.editing = YES;
    // 当前选中的值
    pickerBrowser.currentIndexPath = [NSIndexPath indexPathForItem:indexPath.row inSection:0];
    // 展示控制器
    [pickerBrowser showPickerVc:self];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(mScreenWidth/2, mScreenWidth/2);
}

#pragma mark - 选择相册
- (void)selectPhotos {
    // 创建控制器
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    // 默认显示相册里面的内容SavePhotos
    // 最多能选6张图片
    if (_leftCount<=6) {
        pickerVc.maxCount = _leftCount;
    }else{
        pickerVc.maxCount = 6;
    }
    pickerVc.topShowPhotoPicker = YES;
    pickerVc.status = PickerViewShowStatusSavePhotos;
    pickerVc.delegate = self;
    pickerVc.selectPickers = self.assets;
    [pickerVc showPickerVc:self];
}

#pragma mark - 相册回调
- (void)pickerViewControllerDoneAsstes:(NSArray *)assets{
    self.assets = [NSMutableArray arrayWithArray:assets];
    if (assets!=nil) {
        for (int i=0; i<[assets count]; i++) {
            if ([assets[i] isKindOfClass:[ZLPhotoAssets class]]) {
                ZLPhotoAssets *asset = (ZLPhotoAssets*)assets[i];
                UIImage *image = asset.originImage;
                [_oriImage addObject:image];
                PicExif *exif = [[PicExifUtil shareInstance]getWithALAsset:asset.asset];
                [_exifArr addObject:exif];
            }
        }
    }
    [self.imageCollection reloadData];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

#pragma mark - <ZLPhotoPickerBrowserViewControllerDataSource>
- (long)numberOfSectionInPhotosInPickerBrowser:(ZLPhotoPickerBrowserViewController *)pickerBrowser{
    return 1;
}

- (long)photoBrowser:(ZLPhotoPickerBrowserViewController *)photoBrowser numberOfItemsInSection:(NSUInteger)section{
    return self.assets.count;
}

#pragma mark - 每个组展示什么图片,需要包装下ZLPhotoPickerBrowserPhoto
- (ZLPhotoPickerBrowserPhoto *) photoBrowser:(ZLPhotoPickerBrowserViewController *)pickerBrowser photoAtIndexPath:(NSIndexPath *)indexPath{
    ZLPhotoAssets *imageObj = [self.assets objectAtIndex:indexPath.row];
    // 包装下imageObj 成 ZLPhotoPickerBrowserPhoto 传给数据源
    ZLPhotoPickerBrowserPhoto *photo = [ZLPhotoPickerBrowserPhoto photoAnyImageObjWith:imageObj];
    AlbumPicCollectionCell *cell = (AlbumPicCollectionCell *)[self.imageCollection cellForItemAtIndexPath:indexPath];
    photo.toView = cell.img;
    photo.thumbImage = cell.img.image;
    return photo;
}

#pragma mark - <ZLPhotoPickerBrowserViewControllerDelegate>
#pragma mark 删除照片调用
- (void)photoBrowser:(ZLPhotoPickerBrowserViewController *)photoBrowser removePhotoAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row > [self.assets count]) return;
    [self.assets removeObjectAtIndex:indexPath.row];
    [self.imageCollection reloadData];
}

@end
