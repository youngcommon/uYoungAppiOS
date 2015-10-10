//
//  RootViewController.m
//  uYoung
//
//  Created by CSDN on 15/9/22.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "RootViewController.h"
#import "ActivityModel.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat y = 20;
    
    y += self.header.frame.size.height;
    
    self.activityTabViewController = [[ActivityTableViewController alloc]init];
    
    [self addChildViewController:self.activityTabViewController];
    [self.view addSubview:self.activityTabViewController.view];
    
    self.activityTabViewController.tableView.frame = CGRectMake(0, y, self.view.frame.size.width, self.view.frame.size.height - y);
    [self.activityTabViewController.tableView setBackgroundColor:[UIColor clearColor]];
    self.activityTabViewController.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.toggle addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)segmentAction:(UISegmentedControl*)seg{
    NSInteger index = seg.selectedSegmentIndex;
    [self.activityTabViewController initActivityList:(index+1)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end








