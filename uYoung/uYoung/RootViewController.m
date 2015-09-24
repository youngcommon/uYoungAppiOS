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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat y = 20;
    
    y += self.header.frame.size.height;
    
    self.activityTabViewController = [[ActivityTableViewController alloc]init];
    self.activityTabViewController.view.frame = CGRectMake(0, y, mScreenWidth, mScreenHeight - y);
    [self.activityTabViewController.tableView setBackgroundColor:[UIColor clearColor]];
    self.activityTabViewController.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self addChildViewController:self.activityTabViewController];
    [self.view addSubview:self.activityTabViewController.view];
    
    [self.toggle addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    [self initActivityList:1];
}

- (void)initActivityList: (NSInteger)type{
    
    NSArray *data = [MTLJSONAdapter modelsOfClass:[ActivityModel class] fromJSONArray:[self getTestListData] error:nil];
    
    [self.activityTabViewController.activityListData removeAllObjects];
    [self.activityTabViewController.activityListData addObject:data];
    [self.activityTabViewController.tableView reloadData];
    
}

- (void)segmentAction:(UISegmentedControl*)seg{
    NSInteger index = seg.selectedSegmentIndex;
    [self initActivityList:index];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSArray*)getTestListData{
    
    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:2];
    NSString *template = @"{'id':%d,'title':'%@','acttype':'%@','pnum':%d,'day':'%@','mon':'%@','week':'%@','from':'%@','to':'%@','addr':'%@','header':'%@','local':'%@','p':%d,'status':'%@'}";
    for (int i=0; i<20; i++) {
        [arr addObject:
         [NSString stringWithFormat:template,i,@"hanasfbawie",(i%2==0?@"人像":@"风景"),i+1,[NSString stringWithFormat:@"%d月",i],@"15",@"周一",@"17:00", @"18:00",@"回龙观二街三号",@"",@"北京-昌平",i%2, @"进行中"]
         ];
    }
    return arr;
}


@end








