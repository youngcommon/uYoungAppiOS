//
//  ActivityTableViewController.m
//  uYoung
//
//  Created by CSDN on 15/9/21.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "ActivityTableViewController.h"
#import "ActivityDetailViewController.h"

@interface ActivityTableViewController ()

@end

@implementation ActivityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initPullAndPushView];
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
//    return 1;
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
    [self.navigationController pushViewController:detailController animated:YES];

}

- (void)initPullAndPushView{
    //注册下拉刷新功能
    __weak ActivityTableViewController *weakself = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
//        [weakself insertrowattop];
//        [NSThread sleepForTimeInterval:3];
        [weakself.tableView.pullToRefreshView stopAnimating];
    }];
    
    //注册上拉刷新功能
    [self.tableView addInfiniteScrollingWithActionHandler:^{
//        [weakself insertrowatbottom];
//        [NSThread sleepForTimeInterval:3];
        [weakself.tableView.infiniteScrollingView stopAnimating];
    }];
    
    [self.tableView.pullToRefreshView setTitle:@"下拉更新" forState:SVPullToRefreshStateStopped];
    [self.tableView.pullToRefreshView setTitle:@"释放更新" forState:SVPullToRefreshStateTriggered];
    [self.tableView.pullToRefreshView setTitle:@"卖力加载中..." forState:SVPullToRefreshStateLoading];
//    self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 40, 0);
//    [self.tableView triggerPullToRefresh];
}


@end
