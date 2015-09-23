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
    activityTabViewController.view.frame = CGRectMake(0, y, kMAIN_SCREEN_WIDTH, kMAIN_SCREEN_HEIGHT);
    
    [self addChildViewController:activityTabViewController];
    [self.view addSubview:activityTabViewController.view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
