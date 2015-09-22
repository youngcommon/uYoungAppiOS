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
    
    ActivityTableViewController *activityTabViewController = [[[NSBundle mainBundle] loadNibNamed:@"" owner:self options:nil] firstObject];
    [self addChildViewController:activityTabViewController];
    [self.activityTableView addSubview:activityTabViewController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
