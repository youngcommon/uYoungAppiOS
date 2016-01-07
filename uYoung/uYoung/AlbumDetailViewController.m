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
#import "JZAlbumViewController.h"
#import "UserDetailModel.h"

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
    _delList = [[NSMutableArray alloc]initWithCapacity:0];
    
    UserDetailModel *loginUser = [UserDetailModel currentUser];
    [_uploadPicButton setHidden:(loginUser.id!=_ownerUid)];
    [_editButton setHidden:(loginUser.id!=_ownerUid)];
    _inEdit = NO;
    [_cancelButton setHidden:YES];
    
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
    PhotoDetailModel *model = (PhotoDetailModel*)_pics[indexPath.row];
    AlbumPicCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.showLabels = YES;
    [cell initCellWithPhotoDetail:model];
    BOOL isSel = [_delList containsObject:@(model.id)];
    [cell changeSelectImg:isSel];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((mScreenWidth-20)/2, (mScreenWidth-20)/2);
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_inEdit) {
        AlbumPicCollectionCell *cell = (AlbumPicCollectionCell*)[collectionView cellForItemAtIndexPath:indexPath];
        long id = ((PhotoDetailModel*)cell.model).id;
        BOOL isSel = [_delList containsObject:@(id)];
        if(isSel){
            [_delList removeObject:@(id)];
        }else{
            [_delList addObject:@(id)];
        }
        [cell changeSelectImg:!isSel];
    }else{
        //跳转到图片下载逻辑
        JZAlbumViewController *jzAlbumVC = [[JZAlbumViewController alloc]init];
        jzAlbumVC.currentIndex = indexPath.row;//这个参数表示当前图片的index，默认是0
        jzAlbumVC.imgArr = [[NSMutableArray alloc]initWithArray:_pics];//图片数组，可以是url，也可以是UIImage
        [self presentViewController:jzAlbumVC animated:YES completion:nil];
    }
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

- (IBAction)edit:(id)sender {
    if (!_inEdit) {
        [_editButton setTitle:@"删除" forState:UIControlStateNormal];
        _inEdit = YES;
        [_cancelButton setHidden:NO];
    }else{
        [_editButton setTitle:@"Edit" forState:UIControlStateNormal];
        _inEdit = NO;
    }
    [self cellSelectButtonSwitch];
}

- (IBAction)cancelEdit:(id)sender {
    [_editButton setTitle:@"Edit" forState:UIControlStateNormal];
    _inEdit = NO;
    [_cancelButton setHidden:YES];
    [self cellSelectButtonSwitch];
}

-(void)cellSelectButtonSwitch{
    NSArray *cells = [_allPics visibleCells];
    if (cells&&[cells count]>0) {
        for (int i=0; i<[cells count]; i++) {
            AlbumPicCollectionCell *cell = (AlbumPicCollectionCell*)cells[i];
            [cell.selImg setHidden:!_inEdit];
        }
    }
}
@end
