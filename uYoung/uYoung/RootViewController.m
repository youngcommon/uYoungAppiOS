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
    self.activityTabViewController.tableView.frame = CGRectMake(0, y, mScreenWidth, mScreenHeight - y);
    [self.activityTabViewController.tableView setBackgroundColor:[UIColor clearColor]];
    self.activityTabViewController.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self initActivityList:0];
    
    [self addChildViewController:self.activityTabViewController];
    [self.view addSubview:self.activityTabViewController.view];
    
    [self.toggle addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)initActivityList: (NSInteger)type{
    
    //根据参数请求网络，获得数据
    NSArray *list;
    if(type==0){
        list = [self getTestListData];
    }else{
        list = [self getTestListData2];
    }
    NSArray *data = [MTLJSONAdapter modelsOfClass:[ActivityModel class] fromJSONArray:list error:nil];
    
    [self.activityTabViewController.activityListData removeAllObjects];
    self.activityTabViewController.activityListData = [[NSMutableArray alloc] initWithArray:data];
    [self.activityTabViewController.tableView reloadData];
    [self.activityTabViewController.tableView reloadInputViews];
    
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
    for (int i=0; i<20; i++) {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
         [NSNumber numberWithInt:i],@"id",
         @"asdfnaonfoanfraef",@"title",
         (i%2==0?@"人像":@"风景"),@"acttype",
         [NSString stringWithFormat:@"%d人", i+1],@"pnum",
         @"22",@"day",
         [NSString stringWithFormat:@"%d月",i],@"mon",
         @"周一",@"week",
         @"16:00",@"from",
         @"18:00",@"to",
         @"回龙观二街三号",@"addr",
         @"",@"header",
         @"北京-昌平",@"local",
         [NSNumber numberWithInt:i%2],@"p",
         [NSNumber numberWithInt:0],@"status"
         , nil];
        [arr addObject:dict];
    }
    
    return arr;
}

- (NSArray*)getTestListData2{
    
    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:2];
    for (int i=12; i>0; i--) {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSNumber numberWithInt:i],@"id",
                              @"asdfnaonfoanfraef",@"title",
                              (i%2==0?@"人像":@"风景"),@"acttype",
                              [NSString stringWithFormat:@"%d人", i+1],@"pnum",
                              @"5",@"day",
                              [NSString stringWithFormat:@"%d月",i],@"mon",
                              @"周一",@"week",
                              @"16:00",@"from",
                              @"18:00",@"to",
                              @"beadf二街三号",@"addr",
                              @"",@"header",
                              @"北京-昌平",@"local",
                              [NSNumber numberWithInt:i%2],@"p",
                              [NSNumber numberWithInt:0],@"status"
                              , nil];
        [arr addObject:dict];
    }
    
    return arr;
}

- (void) navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
}

@end








