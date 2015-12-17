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
    
    _backCover.image = [self getScaleUIImage:@"uyoung.bundle/backcover" Height:30];
    
    _userHeader.layer.cornerRadius = _userHeader.frame.size.height/2;
    _userHeader.layer.masksToBounds = YES;
    
    [_userHeader lazyInitSmallImageWithUrl:_userHeaderUrl];
    [_nickName setText:_nickNameStr];
    [_albumName setText:_albumNameStr];
    [_createDate setText:[NSString stringWithFormat:@"%@创建", _createDateStr]];
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
    
    CGFloat size;
    if (mScreenWidth==375) {//iPhone 6
        size = 125;
    }else if(mScreenWidth>375){//iPhone 6+
        size = 140;
    }else{
        size = 110;
    }
    return CGSizeMake(size, size);
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.row;
    if ([_pics count]==0||index==([_pics count])) {//如果是上传照片被点击
        
        AlbumUploadViewController *upload = [[AlbumUploadViewController alloc] initWithNibName:@"AlbumUploadViewController" bundle:[NSBundle mainBundle]];
        [self presentViewController:upload animated:YES completion:nil];
        
    }else{
        //跳转到图片下载逻辑
        
    }
}

- (UIImage *)getScaleUIImage:(NSString*)name Height:(CGFloat)height{
    UIImage *bubble = [UIImage imageNamed:name];
    
    CGPoint center = CGPointMake(bubble.size.width / 2.0f, height);
    UIEdgeInsets capInsets = UIEdgeInsetsMake(center.y, 0, center.y+1, 2);
    return [bubble resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
    
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
