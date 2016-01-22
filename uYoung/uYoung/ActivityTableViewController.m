//
//  ActivityTableViewController.m
//  uYoung
//
//  Created by CSDN on 15/9/21.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "ActivityTableViewController.h"
#import "ActivityDetailViewController.h"
#import "UIWindow+YoungHUD.h"

@interface ActivityTableViewController ()

@end

@implementation ActivityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentPage = 1;
    self.status = 0;
    
    [self initPullAndPushView];
    
    _nodata = [[UIImageView alloc]init];
    [_nodata setHidden:YES];
    [self.view addSubview:_nodata];
    
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

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated{
    //停止菊花
    [self.tableView.pullToRefreshView stopAnimating];
    //停止菊花
    [self.tableView.infiniteScrollingView stopAnimating];
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
    
    [cell initWithActivityModel:self.activityListData[[indexPath row]] showHeader:_showHeader];
    
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
        [weakself resetActivityList:[[NSDictionary alloc]init]];
    }];
    
    //注册上拉刷新功能
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakself getDataFromNet:NO];
    }];
    
    [self.tableView.pullToRefreshView setTitle:@"下拉更新" forState:SVPullToRefreshStateStopped];
    [self.tableView.pullToRefreshView setTitle:@"释放更新" forState:SVPullToRefreshStateTriggered];
    [self.tableView.pullToRefreshView setTitle:@"卖力加载中..." forState:SVPullToRefreshStateLoading];
    self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 40, 0);
    [self.tableView triggerPullToRefresh];
}

- (void)resetActivityList:(NSDictionary*)param{
    if(param!=nil&&[param count]>0){
        _params = [[NSMutableDictionary alloc]initWithDictionary:param];
    }else if(_params==nil||[_params isEqual:[NSNull null]]||[_params count]==0){
        _params = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@(1),@"createTimeSort", @"desc",@"sort", nil];
    }
    self.noMorePage = NO;
    //根据参数请求网络，获得数据
    [_params setObject:@(pageSize) forKey:@"pageSize"];
    [_params setObject:@(1) forKey:@"pageNum"];
    if (_userid>0) {
        [_params setObject:@(_userid) forKey:@"creatorUid"];
    }
    [ActivityList getActivityListWithParam:_params isTop:YES delegate:self];
}

- (void)reloadDataWithArray:(NSArray*)arr{
    if(arr!=nil&&![arr isEqual:[NSNull null]]&&[arr count]>0){
        NSArray *data = [MTLJSONAdapter modelsOfClass:[ActivityModel class] fromJSONArray:arr error:nil];
        [self.activityListData removeAllObjects];
        self.activityListData = [[NSMutableArray alloc] initWithArray:data];
        [self.tableView reloadData];
        [self.tableView reloadInputViews];
        self.currentPage = self.currentPage + 1;
        if (self.activityListData==nil||[self.activityListData count]==0) {
            [_nodata setHidden:YES];
        }
        [_nodata setHidden:YES];
    }else{
        if (self.activityListData==nil||[self.activityListData count]==0) {
            [_nodata setHidden:NO];
        }else{
            [_nodata setHidden:YES];
        }
    }
}

- (void)getDataFromNet:(BOOL)isTop{
    if (_params==nil||[_params isEqual:[NSNull null]]) {
        _params = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@(1),@"createTimeSort", @"desc",@"sort", nil];
    }
    [_params setObject:@(pageSize) forKey:@"pageSize"];
    if (_userid>0) {
        [_params setObject:@(_userid) forKey:@"creatorUid"];
    }
    if (isTop) {
        [_params setObject:@(1) forKey:@"pageNum"];
        [ActivityList getActivityListWithParam:_params isTop:isTop delegate:self];
    }else{
        if (self.noMorePage){
            //停止菊花
            [self.tableView.infiniteScrollingView stopAnimating];
        }else{
            [_params setObject:@(self.currentPage) forKey:@"pageNum"];
            [ActivityList getActivityListWithParam:_params isTop:isTop delegate:self];
        }
    }
}

- (void)insertRowAtTop:(NSArray*)arr{
    int64_t delayinseconds = 2.0;
    dispatch_time_t poptime = dispatch_time(DISPATCH_TIME_NOW, delayinseconds * NSEC_PER_SEC);
    dispatch_after(poptime, dispatch_get_main_queue(), ^(void){
        
        if ([arr isEqual:[NSNull null]]||arr==nil||[arr count]<pageSize) {
            self.noMorePage = YES;
        }else{
            self.noMorePage = NO;
        }
        [self reloadDataWithArray:arr];

        //停止菊花
        [self.tableView.pullToRefreshView stopAnimating];
        
        [self.view.window showHUDWithText:@"" Type:ShowDismiss Enabled:YES];
        
        if(self.activityListData!=nil&&[self.activityListData count]>0){
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    });
}

- (void)insertRowAtBottom:(NSArray*)arr hasError:(BOOL)error{
    int64_t delayinseconds = 2.0;
    dispatch_time_t poptime = dispatch_time(DISPATCH_TIME_NOW, delayinseconds * NSEC_PER_SEC);
    dispatch_after(poptime, dispatch_get_main_queue(), ^(void){
        //开始更新
        [self.tableView beginUpdates];
        
        NSArray *data = [MTLJSONAdapter modelsOfClass:[ActivityModel class] fromJSONArray:arr error:nil];
        for (id model in data) {//把数据向队尾插入
            [self.activityListData addObject:model];
            [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:([self.activityListData count]-1) inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
        }
        if ([arr count]<pageSize&&!error) {//如果小于pageSize，说明是最后一页了
            self.noMorePage = YES;
        }else{
            self.currentPage = self.currentPage + 1;
        }

        //结束更新
        [self.tableView endUpdates];

        //停止菊花
        [self.tableView.infiniteScrollingView stopAnimating];
        
        [self.view.window showHUDWithText:@"" Type:ShowDismiss Enabled:YES];
    });
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.view.window showHUDWithText:@"" Type:ShowDismiss Enabled:YES];
}

@end
