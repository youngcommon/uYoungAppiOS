//
//  UILoginFilterViewController.m
//  uYoung
//
//  Created by CSDN on 16/1/28.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import "UILoginFilterViewController.h"
#import "LoginViewController.h"
#import "LoginFilterUtil.h"
#import "GlobalConfig.h"

@interface UILoginFilterViewController ()

@end

@implementation UILoginFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toLogin) name:NOT_LOGIN_NOTICE object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)toLogin{
    LoginViewController *ctl = [[LoginFilterUtil shareInstance]getLoginViewController];
    ctl.source = @"loginfilter";
    BOOL ani = YES;
    if (mScreenWidth==320) {
        ani = NO;
    }
    [self presentViewController:ctl animated:ani completion:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
