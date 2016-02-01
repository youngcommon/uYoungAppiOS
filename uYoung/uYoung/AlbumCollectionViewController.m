//
//  AlbumCollectionViewController.m
//  uYoung
//
//  Created by CSDN on 16/2/1.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import "AlbumCollectionViewController.h"
#import "UserAlbumList.h"
#import "AlbumDetailViewController.h"

@interface AlbumCollectionViewController ()

@end

@implementation AlbumCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init{
    //创建流水布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize =  CGSizeMake(160, 100);
    
    //设置水平滚动
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 设置cell之间间距
    layout.minimumInteritemSpacing = 0;
    // 设置行距
    layout.minimumLineSpacing = 0;
    
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userAlbumList:) name:@"userAlbumList" object:nil];
    
    UINib *nib = [UINib nibWithNibName:@"AlbumCoverCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.pagingEnabled = YES;
    //隐藏水平滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    //取消弹簧效果
//    self.collectionView.bounces = NO;
    
    _nodata = [[UIImageView alloc]init];
    [_nodata setHidden:YES];
    [self.collectionView addSubview:_nodata];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated{
    [self refreshData];
    
    UIImage *img = [UIImage imageNamed:@"uyoung.bundle/nodata"];
    [_nodata setImage:img];
    CGRect frame = self.collectionView.frame;
    CGFloat x = (frame.size.width-img.size.width)/2;
    CGFloat y = (frame.size.height-img.size.height)/2;
    CGRect newFrame = CGRectMake(x, y, img.size.width, img.size.height);
    [_nodata setFrame:newFrame];
}

- (void)refreshData{
    [UserAlbumList getUserAlbumListWithUid:_userId];
}

- (void)userAlbumList:(NSNotification*)notification
{
    NSArray *arr = (NSArray*)[notification object];
    NSArray *data = [MTLJSONAdapter modelsOfClass:[AlbumModel class] fromJSONArray:arr error:nil];
    if ((data==nil||[data isEqual:[NSNull null]])&&[_albumListData count]==0) {//需要添加说明button
        [_nodata setHidden:NO];
    }else{
        [_albumListData removeAllObjects];
        _albumListData = [[NSMutableArray alloc] initWithArray:data];
        [self.collectionView reloadData];
        [self.collectionView reloadInputViews];
        [_nodata setHidden:YES];
    }
}

-(void)successGetAlbumDetail:(AlbumDetailModel*)model{
    if (model!=nil) {
        AlbumDetailViewController *viewCtl = [[AlbumDetailViewController alloc]initWithNibName:@"AlbumDetailViewController" bundle:[NSBundle mainBundle]];
        viewCtl.albumNameStr = model.albumDesc;
        viewCtl.ownerUid = model.oriUserId;
        viewCtl.albumid = model.albumId;
        viewCtl.nickNameStr = model.oriNickName;
        viewCtl.userHeaderUrl = model.oriUrl;
        viewCtl.createDateStr = [self getDateStrByTimeInterval:model.createTime];
        viewCtl.pics = [[NSMutableArray alloc]initWithArray:model.photos];
        [self.navigationController pushViewController:viewCtl animated:YES];
    }
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_albumListData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AlbumCoverCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [cell fillDataWithAlbumModel:_albumListData[indexPath.row]];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    AlbumModel *model = (AlbumModel*)_albumListData[indexPath.row];
    [AlbumDetail getAlbumDetailByAlbumId:model.id delegate:self];
    
    //背景不变色
//    [self.collectionView deselectRowAtIndexPath:indexPath animated:NO];
}

- (NSString*)getDateStrByTimeInterval:(long)interval{
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:interval/1000.0];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setTimeZone:[NSTimeZone localTimeZone]];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString * na = [df stringFromDate:date];
    return na;
}


@end
