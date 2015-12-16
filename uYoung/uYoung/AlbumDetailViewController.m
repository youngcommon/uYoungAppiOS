//
//  AlbumDetailViewController.m
//  uYoung
//
//  Created by 独自天涯 on 15/12/5.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "AlbumDetailViewController.h"
#import "AlbumPicCollectionCell.h"
#import "AddPicCollectionViewCell.h"
#import "GlobalConfig.h"
#import "UIImageView+LazyInit.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "PhotoDetailModel.h"
#import "AlbumUploadViewController.h"

@interface AlbumDetailViewController ()

@end

@implementation AlbumDetailViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _userHeader.layer.cornerRadius = _userHeader.frame.size.height/2;
    _userHeader.layer.masksToBounds = YES;
    
    [_userHeader.imageView lazyInitSmallImageWithUrl:_userHeaderUrl];
    [_albumName setText:_albumNameStr];
    [_nickName setText:_nickNameStr];
    [_createDate setText:_createDateStr];
    [_totalPics setText:[NSString stringWithFormat:@"%d张照片", (int)[_pics count]]];
    
    UINib *nib = [UINib nibWithNibName:@"AlbumPicCollectionCell" bundle:nil];
    [_allPics registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    
    if (_pics==nil||_pics==NULL) {
        _pics = [[NSArray alloc]init];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_pics count] + 1;
//    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    if ([_pics count]==0||index==[_pics count]) {//说明是添加相片按钮
        UINib *nib = [UINib nibWithNibName:@"AddPicCollectionViewCell" bundle:nil];
        [_allPics registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
        
        AddPicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        return cell;
    }else{
        AlbumPicCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        [cell initCellWithPhotoDetail:((PhotoDetailModel*)_pics[indexPath.row])];
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(124, 100);
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.row;
    if ([_pics count]==0||index==([_pics count])) {//如果是上传照片被点击
        
        /*if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            _camera = [[UIImagePickerController alloc] init];
            _camera.delegate = self;
            _camera.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //此处设置只能使用相机，禁止使用视频功能
            _camera.mediaTypes = @[(NSString*)kUTTypeImage];
            
            [self presentViewController:_camera animated:YES completion:nil];
        }*/
        AlbumUploadViewController *upload = [[AlbumUploadViewController alloc] initWithNibName:@"AlbumUploadViewController" bundle:[NSBundle mainBundle]];
        [self presentViewController:upload animated:YES completion:nil];
//        [self.navigationController pushViewController:upload animated:YES];
        
    }else{
        //跳转到图片下载逻辑
        
    }
}

//点击相册中的图片或照相机照完后点击use后触发的方法
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//    UIImage *img;
//    if ([info objectForKey:UIImagePickerControllerEditedImage]) {
//        img = [info objectForKey:UIImagePickerControllerEditedImage];
//    }else{
//        img = [info objectForKey:UIImagePickerControllerOriginalImage];
//    }

//    NSInteger uid = [UserDetailModel currentUser].id;
//    long times = [[NSDate date]timeIntervalSince1970];
    
    //上传图片至七牛云
//    [[UploadImageUtil dispatchOnce]uploadImage:img withKey:[NSString stringWithFormat:@"uy_act_%d_%ld", (int)uid, times] delegate:self];
    
//    [self dismissViewControllerAnimated:YES completion:nil];
    
//}

//用户取消回调
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
