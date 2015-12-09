//
//  AlbumDetailViewController.m
//  uYoung
//
//  Created by 独自天涯 on 15/12/5.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "AlbumDetailViewController.h"
#import "AlbumPicCollectionCell.h"
#import "GlobalConfig.h"
#import "UIImageView+LazyInit.h"

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
    [_totalPics setText:[NSString stringWithFormat:@"%d", (int)[_pics count]]];
    
    UINib * nib = [UINib nibWithNibName:@"AlbumPicCollectionCell" bundle:nil];
    [_allPics registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return [_pics count];
    return 13;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AlbumPicCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.isAlbum = NO;
    [cell initCellWithDict:_pics[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(124, 100);
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //跳转到图片下载逻辑
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
