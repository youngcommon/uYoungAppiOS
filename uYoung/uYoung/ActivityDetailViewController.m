//
//  ActivityDetailViewController.m
//  uYoung
//
//  Created by CSDN on 15/9/25.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "ActivityDetailViewController.h"

@interface ActivityDetailViewController ()

@end

@implementation ActivityDetailViewController
@synthesize model;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headerImg.layer.cornerRadius = self.headerImg.frame.size.height/2;
    self.headerImg.layer.masksToBounds = YES;
    
    self.titleLable.text = self.model.title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)backView:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
