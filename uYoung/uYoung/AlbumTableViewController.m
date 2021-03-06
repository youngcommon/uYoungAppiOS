//
//  AlbumTableViewController.m
//  uYoung
//
//  Created by CSDN on 15/10/15.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "AlbumTableViewController.h"
#import "UserAlbumList.h"
#import "AlbumDetailViewController.h"
#import "AlbumModel.h"
#import "UserDetailModel.h"

@interface AlbumTableViewController ()

@end

@implementation AlbumTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userAlbumList:) name:@"userAlbumList" object:nil];
    
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    //注册下拉刷新功能
    __weak AlbumTableViewController *weakself = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakself refreshData];
    }];
    [self.tableView.pullToRefreshView setTitle:@"下拉更新" forState:SVPullToRefreshStateStopped];
    [self.tableView.pullToRefreshView setTitle:@"释放更新" forState:SVPullToRefreshStateTriggered];
    [self.tableView.pullToRefreshView setTitle:@"卖力加载中..." forState:SVPullToRefreshStateLoading];
    self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 40, 0);
    [self.tableView triggerPullToRefresh];
    
    _nodata = [[UIImageView alloc]init];
    [_nodata setHidden:YES];
    [self.tableView addSubview:_nodata];
    
}

- (void)viewDidAppear:(BOOL)animated{
    UIImage *img = [UIImage imageNamed:@"uyoung.bundle/nodata"];
    [_nodata setImage:img];
    CGRect frame = self.tableView.frame;
    CGFloat x = (frame.size.width-img.size.width)/2;
    CGFloat y = (frame.size.height-img.size.height)/2;
    CGRect newFrame = CGRectMake(x, y, img.size.width, img.size.height);
    [_nodata setFrame:newFrame];
}

- (void)refreshData{
    [UserAlbumList getUserAlbumListWithUid:_userId];
}

- (void)viewDidDisappear:(BOOL)animated{
    //停止菊花
    [self.tableView.pullToRefreshView stopAnimating];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
        [self.tableView reloadData];
        [self.tableView reloadInputViews];
        [_nodata setHidden:YES];
    }
    [self.tableView.pullToRefreshView stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.albumListData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"AlbumCell";
    
    AlbumCoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"AlbumCoverTableViewCell" owner:self options:nil] objectAtIndex:0];
        UINib *nib = [UINib nibWithNibName:@"AlbumCoverTableViewCell" bundle:[NSBundle mainBundle]];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];//注册cell复用
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell fillDataWithAlbumModel:_albumListData[indexPath.row]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//不展示点击效果
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(mScreenWidth<375){
        return 200;
    }else if(mScreenWidth==375){
        return 240;
    }else{
        return 280;
    }
//    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AlbumModel *model = (AlbumModel*)_albumListData[indexPath.row];
    [AlbumDetail getAlbumDetailByAlbumId:model.id delegate:self];
    
    //背景不变色
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{     //当在Cell上滑动时会调用此函数
    
    UserDetailModel *user = [UserDetailModel currentUser];
    if (user==nil||[user isEqual:[NSNull null]]||user.id!=_userId) {
        return UITableViewCellEditingStyleNone;
    }else{
        return  UITableViewCellEditingStyleDelete;  //返回此值时,Cell会做出响应显示Delete按键,点击Delete后会调用下面的函数,别给传递UITableViewCellEditingStyleDelete参数
    }
    
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath { //对选中的Cell根据editingStyle进行操作
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        AlbumModel *model = (AlbumModel*)_albumListData[indexPath.row];
        if (model!=nil&&model.id>0) {
            UserDetailModel *user = [UserDetailModel currentUser];
            //调用删除相册接口
            [UserAlbumList deleteUserAlbum:model.id uid:user.id success:^(BOOL success) {
                if (success) {
                    //删除成功，处理table数据
                    [self.albumListData removeObjectAtIndex:indexPath.row];
                    [self.tableView reloadData];
                }
                [self.tableView reloadInputViews];
            }];
        }
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

- (NSString*)getDateStrByTimeInterval:(long)interval{
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:interval/1000.0];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setTimeZone:[NSTimeZone localTimeZone]];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString * na = [df stringFromDate:date];
    return na;
}

@end
