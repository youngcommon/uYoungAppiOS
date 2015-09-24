//
//  RootViewController.m
//  uYoung
//
//  Created by CSDN on 15/9/22.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "RootViewController.h"
#import "ActivityTableViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat y = 20;
    
    y += self.header.frame.size.height;
    
    ActivityTableViewController *activityTabViewController = [[ActivityTableViewController alloc]init];
    NSLog(@"%f", kMAIN_SCREEN_HEIGHT);
    activityTabViewController.view.frame = CGRectMake(0, y, kMAIN_SCREEN_WIDTH, kMAIN_SCREEN_HEIGHT - y);
    [activityTabViewController.tableView setBackgroundColor:[UIColor clearColor]];
    activityTabViewController.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self addChildViewController:activityTabViewController];
    [self.view addSubview:activityTabViewController.view];
    
    [self.toggle addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    [self initActivityList:1];
}

- (void)initActivityList: (NSInteger)type{
    NSInteger selected = self.toggle.selectedSegmentIndex;
    NSLog(@"select--->%d", selected);
}

- (void)segmentAction:(UISegmentedControl*)seg{
    NSInteger index = seg.selectedSegmentIndex;
    [self initActivityList:index];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
