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
        [self.view.window showHUDWithText:@"正在上传..." Type:ShowLoading Enabled:YES];
        NSString *format = @"uy_user/%ld/album/%ld/t/%@";
        for (int i=0; i<[_oriImage count]; i++) {
            long timer = [[NSDate date]timeIntervalSince1970];
            NSString *t = [NSString stringWithFormat:@"%ld%d", timer, i];
            NSString *key = [NSString stringWithFormat:format, _owneruid, _albumid, t];
            UIImage *image = _oriImage[i];
            [[UploadImageUtil dispatchOnce]uploadImage:image withKey:key delegate:self];
        }
    }
}

#pragma mark - 上传成功后回调
- (void)getImgKey:(NSString*)key host:(NSString *)host{
    if ([NSString isBlankString:host]) {
        host = QINIU_HOST;
    }
    //写入uYoung数据库
    if ([NSString isBlankString:key]==NO) {
        NSMutableDictionary *param = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@(_owneruid),@"createUserId", @(_albumid),@"albumId", key,@"photoUrl", @"xxx",@"photoName", nil];
        [_imgParams addObject:param];
    }
    if ([_assets count]==[_imgParams count]) {//说明图片已经全部上传完毕
        [CreateAlbum uploadAlbumImage:_imgParams delegate:self];
    }
}

#pragma mark - 更新uYoung数据后回调
- (void)finishUploadImage:(PhotoDetailModel*)result{
    _counter += 1;
    if (result!=nil) {
        [_photoDetailModels addObject:result];
    }
    if ([_imgParams count]==_counter) {
        [self.view.window showHUDWithText:@"上传完成" Type:ShowPhotoYes Enabled:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshAlbum" object:_photoDetailModels];
        //更新相册封面
        NSData *qiniuHostData = [[NSUserDefaults standardUserDefaults]objectForKey:@"qiniu_host"];
        NSString *qiniuHost = [NSKeyedUnarchiver unarchiveObjectWithData:qiniuHostData];
        NSString *url = [qiniuHost stringByAppendingString:result.photoUrl];
        [CreateAlbum updateAlbumCover:url albumId:result.albumId success:nil];
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
    if ([asset isKindOfClass:[ZLPhotoAssets class]]) {
        image = asset.originImage;
        NSDictionary *imageData = [[NSMutableDictionary alloc]initWithDictionary:asset.asset.defaultRepresentation.metadata];
        NSDictionary *exifData = [imageData objectForKey:(NSString *)kCGImagePropertyExifDictionary];
        NSLog(@"=============exif===========\n%@", exifData);
    }else if ([asset isKindOfClass:[NSString class]]){
        [cell.img sd_setImageWithURL:[NSURL URLWithString:(NSString *)asset] placeholderImage:[UIImage imageNamed:@"pc_circle_placeholder"]];
        image = cell.img.image;
    }else if([asset isKindOfClass:[UIImage class]]){
        image = (UIImage*)asset;
    }
    [cell.img setImage:[image scaleToSize:cell.frame.size]];
    cell.oriImg = image;
    
    
    [cell hiddenLabels];
    [_oriImage addObject:image];

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
    pickerVc.maxCount = 9;
    pickerVc.topShowPhotoPicker = YES;
    pickerVc.status = PickerViewShowStatusSavePhotos;
    pickerVc.delegate = self;
    pickerVc.selectPickers = self.assets;
    [pickerVc showPickerVc:self];
}

#pragma mark - 相册回调
- (void)pickerViewControllerDoneAsstes:(NSArray *)assets{
    self.assets = [NSMutableArray arrayWithArray:assets];
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
