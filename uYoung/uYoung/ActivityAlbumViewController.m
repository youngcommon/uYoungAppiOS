//
//  ActivityAlbumViewController.m
//  uYoung
//
//  Created by 独自天涯 on 15/11/26.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "ActivityAlbumViewController.h"
#import "ActivityAlbumCollectionViewCell.h"
#import "AlbumDetailModel.h"
#import "AlbumDetailViewController.h"
#import "UserDetailModel.h"
#import "UIWindow+YoungHUD.h"

@interface ActivityAlbumViewController ()

@end

@implementation ActivityAlbumViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _albums.backgroundColor = [UIColor clearColor];
    UINib * nib = [UINib nibWithNibName:@"ActivityAlbumCollectionViewCell" bundle:nil];
    [_albums registerNib:nib forCellWithReuseIdentifier:@"Cell"];
    
    [_actTitle setText:[NSString stringWithFormat:@"%@相册", _actTitleStr]];
    
    _nodata = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"uyoung.bundle/nodata"]];
    CGFloat height = (self.view.frame.size.height-_nodata.frame.size.height)/2;
    [_nodata setFrame:CGRectMake((self.view.frame.size.width-_nodata.frame.size.width)/2, height, _nodata.frame.size.width, _nodata.frame.size.height)];
    [self.albums addSubview:_nodata];
    [_nodata setHidden:YES];
    
    if(_hadSigned&&!_hadAlbum){
        [_uploadAlbumView setHidden:NO];
    }else{
        [_uploadAlbumView setHidden:YES];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    if (_actAlbum==nil||[_actAlbum count]==0) {
        [_nodata setHidden:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_actAlbum count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ActivityAlbumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell initCellData:_actAlbum[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ActivityAlbumModel *model = _actAlbum[indexPath.row];
    [AlbumDetail getAlbumDetailByAlbumId:model.albumId delegate:self];
}

-(void)successGetAlbumDetail:(AlbumDetailModel*)model{
    if (model!=nil) {
        AlbumDetailViewController *viewCtl = [[AlbumDetailViewController alloc]initWithNibName:@"AlbumDetailViewController" bundle:[NSBundle mainBundle]];
        viewCtl.albumNameStr = [NSString stringWithFormat:@"%@相册", model.oriNickName];
        viewCtl.ownerUid = model.oriUserId;
        viewCtl.nickNameStr = model.oriNickName;
        viewCtl.userHeaderUrl = model.oriUrl;
        viewCtl.createDateStr = [self getDateStrByTimeInterval:model.createTime];
        viewCtl.pics = [[NSMutableArray alloc]initWithArray:model.photos];
        [self.navigationController pushViewController:viewCtl animated:YES];
    }
}

- (NSString*)getDateStrByTimeInterval:(long)interval{
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:interval/1000.0];
    NSDateFormatter *df = [[NSDateFormatter alloc] init ];
    [df setTimeZone:[NSTimeZone localTimeZone]];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString * na = [df stringFromDate:date];
    return na;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)uploadMyActAlbum:(id)sender {
    UserDetailModel *user = [UserDetailModel currentUser];
    if (user!=nil&&user!=NULL) {
        [self.view.window showHUDWithText:@"正在创建相册" Type:ShowLoading Enabled:YES];
        NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:@(user.id),@"createUserId",_actTitleStr,@"albumName",_actTitleStr,@"title",@(0),@"totalLikeCount",@(0),@"totalPhotoCount", @(_actId),@"activityId", nil];
        [CreateAlbum createAlbum:dict delegate:self];
    }
}

- (void)successCreateAlbum:(AlbumModel*)detail{
    [self.view.window showHUDWithText:@"创建成功" Type:ShowPhotoYes Enabled:YES];
    [AlbumDetail getAlbumDetailByAlbumId:detail.id delegate:self];
}

@end
