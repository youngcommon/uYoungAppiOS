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

@interface AlbumUploadViewController ()

@end

@implementation AlbumUploadViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"AlbumPicCollectionCell" bundle:nil];
    [_imageCollection registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    
    _assets = [[NSMutableArray alloc]initWithCapacity:0];
    
}

/*- (void)viewWillAppear:(BOOL)animated{
    if (_assets==nil||[_assets count]==0) {
        [self selectPhotos];
    }
}*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)showSysPhoto:(id)sender {
    [self selectPhotos];
}

- (IBAction)uploadImages:(id)sender {
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_assets count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AlbumPicCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    ZLPhotoAssets *asset = self.assets[indexPath.row];
    if ([asset isKindOfClass:[ZLPhotoAssets class]]) {
        [cell.img setImage:asset.originImage];
    }else if ([asset isKindOfClass:[NSString class]]){
        [cell.img sd_setImageWithURL:[NSURL URLWithString:(NSString *)asset] placeholderImage:[UIImage imageNamed:@"pc_circle_placeholder"]];
    }else if([asset isKindOfClass:[UIImage class]]){
        [cell.img setImage:(UIImage*)asset];
    }
    cell.img.contentMode = UIViewContentModeCenter;
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(125, 125);
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [_imageCollection deselectItemAtIndexPath:indexPath animated:YES];
    
    AlbumPicCollectionCell *cell = (AlbumPicCollectionCell *)[_imageCollection cellForItemAtIndexPath:indexPath];
    
    [self setupPhotoBrowser:cell];
    
}

#pragma mark - 选择相册
- (void)selectPhotos {
    // 创建控制器
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    // 默认显示相册里面的内容SavePhotos
    // 最多能选6张图片
    pickerVc.maxCount = 9;
    pickerVc.topShowPhotoPicker = YES;
//    pickerVc.status = PickerViewShowStatusCameraRoll;
    pickerVc.status = PickerViewShowStatusSavePhotos;
    pickerVc.delegate = self;
    [pickerVc showPickerVc:self];
}

#pragma mark - 相册回调
- (void)pickerViewControllerDoneAsstes:(NSArray *)assets{
    [self.assets addObjectsFromArray:assets];
    [self.imageCollection reloadData];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

#pragma mark - setupCell click ZLPhotoPickerBrowserViewController
- (void) setupPhotoBrowser:(AlbumPicCollectionCell *) cell{
    NSIndexPath *indexPath = [self.imageCollection indexPathForCell:cell];
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
