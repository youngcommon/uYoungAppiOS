//
//  ActivityTableViewController.m
//  uYoung
//
//  Created by CSDN on 15/9/21.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "ActivityTableViewController.h"
#import "ActivityDetailViewController.h"
#import "ActivityList.h"

@interface ActivityTableViewController ()

@end

@implementation ActivityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentPage = 1;
    self.status = 1;
    
    [self initPullAndPushView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadedData:) name:@"loadedData" object:nil];
}

- (void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.activityListData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ActivityTableViewCell";
    
    ActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ActivityTableViewCell" owner:self options:nil] objectAtIndex:0];
        UINib *nib = [UINib nibWithNibName:@"ActivityTableViewCell" bundle:[NSBundle mainBundle]];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];//注册cell复用
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell initWithActivityModel:self.activityListData[[indexPath row]]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    ActivityDetailViewController *detailController = [[ActivityDetailViewController alloc]initWithNibName:@"ActivityDetailViewController" bundle:[NSBundle mainBundle]];
    [detailController setModel:(ActivityModel*)[self.activityListData objectAtIndex:[indexPath row]]];
    //消除跳转残影
    detailController.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:detailController animated:YES];

}

- (void)initPullAndPushView{
    //注册下拉刷新功能
    __weak ActivityTableViewController *weakself = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakself insertRowAtTop];
    }];
    
    //注册上拉刷新功能
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakself insertRowAtBottom];
    }];
    
    [self.tableView.pullToRefreshView setTitle:@"下拉更新" forState:SVPullToRefreshStateStopped];
    [self.tableView.pullToRefreshView setTitle:@"释放更新" forState:SVPullToRefreshStateTriggered];
    [self.tableView.pullToRefreshView setTitle:@"卖力加载中..." forState:SVPullToRefreshStateLoading];
    self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 40, 0);
    [self.tableView triggerPullToRefresh];
}

- (void)initActivityList: (NSInteger)type{
    //根据参数请求网络，获得数据
    [ActivityList getActivityListWithPageNum:self.currentPage status:self.status];
}

- (void)loadedData:(NSNotification*)notification{
    NSArray *arr = (NSArray*)[notification object];
    if(arr!=nil&&[arr count]>0){
        NSArray *data = [MTLJSONAdapter modelsOfClass:[ActivityModel class] fromJSONArray:arr error:nil];
        
        [self.activityListData removeAllObjects];
        self.activityListData = [[NSMutableArray alloc] initWithArray:data];
        [self.tableView reloadData];
        [self.tableView reloadInputViews];
    }
}

- (void)insertRowAtTop
{
    int64_t delayinseconds = 2.0;
    dispatch_time_t poptime = dispatch_time(DISPATCH_TIME_NOW, delayinseconds * NSEC_PER_SEC);
    dispatch_after(poptime, dispatch_get_main_queue(), ^(void){
        //开始更新
        [self.tableView beginUpdates];

        [ActivityList getActivityListWithPageNum:self.currentPage-1 status:self.status];

        //结束更新
        [self.tableView endUpdates];

        //停止菊花
        [self.tableView.pullToRefreshView stopAnimating];
    });
}

- (void)insertRowAtBottom
{
    int64_t delayinseconds = 2.0;
    dispatch_time_t poptime = dispatch_time(DISPATCH_TIME_NOW, delayinseconds * NSEC_PER_SEC);
    dispatch_after(poptime, dispatch_get_main_queue(), ^(void){
        //开始更新
        [self.tableView beginUpdates];

        //插入数据到数据源(数组的结尾)
//        [self.tableView.dataSource addobject:[nsstring stringwithformat:@"%@", [nsdate date].description]];

        //在tableview中插入一行(row结尾)
//        [_tableview insertrowsatindexpaths:@[[nsindexpath indexpathforrow:_datasource.count - 1  insection:0]]withrowanimation:uitableviewrowanimationbottom];
        [ActivityList getActivityListWithPageNum:self.currentPage+1 status:self.status];

        //结束更新
        [self.tableView endUpdates];

        //停止菊花
        [self.tableView.infiniteScrollingView stopAnimating];
    });
}

@end
