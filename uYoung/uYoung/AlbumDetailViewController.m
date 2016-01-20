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
#import "UserAlbumList.h"
#import "NSString+StringUtil.h"
#import "UYoungAlertViewUtil.h"
#import "UIWindow+YoungHUD.h"

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
    [_albumName setText:_albumNameStr==nil?@"未命名":_albumNameStr];
    [_createDate setText:[NSString stringWithFormat:@"创建于%@", _createDateStr]];
    [_totalPics setText:[NSString stringWithFormat:@"%d张照片", (int)[_pics count]]];
    
    UINib *nib = [UINib nibWithNibName:@"AlbumPicCollectionCell" bundle:nil];
    [_allPics registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    
    /*if (_pics==nil||_pics==NULL) {
        _pics = [[NSMutableArray alloc]init];
    }*/
    _delList = [[NSMutableArray alloc]initWithCapacity:0];
    _delPhotoList = [[NSMutableString alloc]initWithString:@","];
    
    UserDetailModel *loginUser = [UserDetailModel currentUser];
    [_uploadPicButton setHidden:(loginUser.id!=_ownerUid)];
    [_editButton setHidden:(loginUser.id!=_ownerUid)];
    _inEdit = NO;
    [_cancelButton setHidden:YES];
    
    _cover = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight)];
    _cover.backgroundColor = [UIColor lightGrayColor];
    _cover.alpha = 0.5;
    [self.view addSubview:_cover];
    [_cover setHidden:YES];
    
}

- (void)viewDidAppear:(BOOL)animated{
    if (_isNew) {
        [_cover setHidden:NO];
        [[UYoungAlertViewUtil shareInstance]createAlertViewWith:@"创建相册" Delegate:self];
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

- (void)successCreateAlbum:(AlbumModel*)detail{
    if (detail!=nil) {
        [self.view.window showHUDWithText:@"创建成功" Type:ShowPhotoYes Enabled:YES];
        self.albumid = detail.id;
        [_cover setHidden:YES];
    }else{
        [self.view.window showHUDWithText:@"创建失败" Type:ShowPhotoNo Enabled:YES];
        [[UYoungAlertViewUtil shareInstance]createAlertViewWith:@"创建相册" Delegate:self];
    }
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
    if(_inEdit){
        [cell.selImg setHidden:NO];
    }else{
        [cell.selImg setHidden:YES];
    }
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
            NSRange range = [_delPhotoList rangeOfString:[NSString stringWithFormat:@"%d,", (int)id]];
            [_delPhotoList deleteCharactersInRange:range];
        }else{
            [_delList addObject:@(id)];
            [_delPhotoList appendString:[NSString stringWithFormat:@"%d,", (int)id]];
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
        if (_delPhotoList.length==1) {
            [[UYoungAlertViewUtil shareInstance]createAlertView:@"请选择要删除的照片" Message:@"" CancelTxt:@"好的" OtherTxt:nil Tag:1 Delegate:self];
        }else{
            //删除逻辑
            [[UYoungAlertViewUtil shareInstance]createAlertView:@"是否要删除照片?" Message:@"删除的照片不可恢复" CancelTxt:@"再想想" OtherTxt:@"删除" Tag:0 Delegate:self];
        }
    }
    [self cellSelectButtonSwitch];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSInteger tag = alertView.tag;
    if (tag==1001) {
        UITextField *nameField = [alertView textFieldAtIndex:0];
        NSString *name = nameField.text;
        if (buttonIndex==1&&![NSString isBlankString:name]) {
            _albumNameStr = name;
            [_albumName setText:_albumNameStr];
            [[UYoungAlertViewUtil shareInstance]dismissAlertView];
            UserDetailModel *user = [UserDetailModel currentUser];
            if (user!=nil&&user!=NULL) {
                [self.view.window showHUDWithText:@"正在创建相册" Type:ShowLoading Enabled:YES];
                NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:@(user.id),@"createUserId",_albumNameStr,@"albumName",_albumNameStr,@"title",@(0),@"totalLikeCount",@(0),@"totalPhotoCount", nil];
                [CreateAlbum createAlbum:dict delegate:self];
            }
        }else if(buttonIndex==0){
            _albumNameStr = @"未命名";
            [[UYoungAlertViewUtil shareInstance]dismissAlertView];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        if (buttonIndex==0) {
            [[UYoungAlertViewUtil shareInstance]dismissAlertView];
        }else{
            //删除所选照片
            [UserAlbumList deleteAlbumPhoto:_delPhotoList success:^(BOOL success) {
                if ([_delList count]>0&&[_pics count]>0) {
                    NSMutableIndexSet *indexSets = [[NSMutableIndexSet alloc]init];
                    for(int i=0;i<[_pics count];i++){
                        PhotoDetailModel *model =  _pics[i];
                        long id = model.id;
                        NSRange range = [_delPhotoList rangeOfString:[NSString stringWithFormat:@"%d,", (int)id]];
                        if (range.length>0) {
                            [indexSets addIndex:i];
                        }
                    }
                    if ([indexSets count]>0) {
                        [_pics removeObjectsAtIndexes:indexSets];
                    }
                    [self.allPics reloadData];
                    [self.allPics reloadInputViews];
                }
                _delPhotoList = [[NSMutableString alloc]initWithString:@","];
            }];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if ([NSString isBlankString:_albumNameStr]) {
        [[UYoungAlertViewUtil shareInstance]createAlertViewWith:@"创建相册" Delegate:self];
    }
}

- (IBAction)cancelEdit:(id)sender {
    [_editButton setTitle:@"Edit" forState:UIControlStateNormal];
    _inEdit = NO;
    [_cancelButton setHidden:YES];
    [self cellSelectButtonSwitch];
    [_delList removeAllObjects];
    _delPhotoList = [[NSMutableString alloc]initWithString:@","];
    NSArray *cells = [_allPics visibleCells];
    if (cells&&[cells count]>0) {
        for (int i=0; i<[cells count]; i++) {
            AlbumPicCollectionCell *cell = (AlbumPicCollectionCell*)cells[i];
            [cell changeSelectImg:NO];
        }
    }
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
