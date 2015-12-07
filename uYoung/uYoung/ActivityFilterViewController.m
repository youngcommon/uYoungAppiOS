//
//  ActivityFilterViewController.m
//  uYoung
//
//  Created by CSDN on 15/12/7.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "ActivityFilterViewController.h"
#import "GlobalConfig.h"

@interface ActivityFilterViewController ()

@end

@implementation ActivityFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _createTimeButton.layer.borderColor = [UIColorFromRGB(0x4a90e2)CGColor];
    _createTimeButton.layer.borderWidth = 1;
    _createTimeButton.layer.cornerRadius = 4;
    _createTimeButton.layer.masksToBounds = YES;
    
    _commitButton.layer.cornerRadius = 4;
    _commitButton.layer.masksToBounds = YES;
    
    _actTypeButton.layer.borderColor = [UIColorFromRGB(0x4a90e2)CGColor];
    _actTypeButton.layer.borderWidth = 1;
    _actTypeButton.layer.cornerRadius = 4;
    _actTypeButton.layer.masksToBounds = YES;
    
    _actStatusButton.layer.borderColor = [UIColorFromRGB(0x4a90e2)CGColor];
    _actStatusButton.layer.borderWidth = 1;
    _actStatusButton.layer.cornerRadius = 4;
    _actStatusButton.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)commit:(id)sender {
}
@end
