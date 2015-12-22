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
#import "PhotoDetailViewController.h"

@interface AlbumDetailViewController ()

@end

@implementation AlbumDetailViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refresh:) name:@"refreshAlbum" object:nil];
    
    _userHeader.layer.cornerRadius = _userHeader.frame.size.height/2;
    _userHeader.layer.masksToBounds = YES;
    
    
    [_userHeader lazyInitSmallImageWithUrl:_userHeaderUrl suffix:@"actdesc200"];
    [_nickName setText:_nickNameStr];
    [_albumName setText:_albumNameStr];
    [_createDate setText:[NSString stringWithFormat:@"创建于%@", _createDateStr]];
    [_totalPics setText:[NSString stringWithFormat:@"%d张照片", (int)[_pics count]]];
    
    UINib *nib = [UINib nibWithNibName:@"AlbumPicCollectionCell" bundle:nil];
    [_allPics registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    
    if (_pics==nil||_pics==NULL) {
        _pics = [[NSArray alloc]init];
    }
}

- (void)refresh:(NSNotification*)notification{
    NSArray *photoDetailModels = (NSArray*)[notification object];
    NSMutableArray *temp = [[NSMutableArray alloc]initWithArray:_pics];
    [temp addObjectsFromArray:photoDetailModels];
    _pics = [temp copy];
    [_totalPics setText:[NSString stringWithFormat:@"%d张照片", (int)[_pics count]]];
    [_allPics reloadData];
    [_allPics reloadInputViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_pics count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AlbumPicCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell initCellWithPhotoDetail:((PhotoDetailModel*)_pics[indexPath.row])];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((mScreenWidth-20)/2, (mScreenWidth-20)/2);
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //跳转到图片下载逻辑
    PhotoDetailModel *model = ((PhotoDetailModel*)_pics[indexPath.row]);
    PhotoDetailViewController *ctl = [[PhotoDetailViewController alloc]initWithNibName:@"PhotoDetailViewController" bundle:[NSBundle mainBundle]];
    ctl.photoUrl = model.photoUrl;
    [self.navigationController pushViewController:ctl animated:YES];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)selectPics:(id)sender {
    AlbumUploadViewController *upload = [[AlbumUploadViewController alloc] initWithNibName:@"AlbumUploadViewController" bundle:[NSBundle mainBundle]];
    upload.albumid = _albumid;
    upload.owneruid = _ownerUid;
    [self presentViewController:upload animated:YES completion:nil];
}
@end
