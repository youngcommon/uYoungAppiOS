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
    self.actType.text = [NSString stringWithFormat:@"%@摄影", self.model.actType];
    
    self.enrollPersons.text = [NSString stringWithFormat:@"%@ / %@", self.model.personNum, @"10"];
    self.actDate.text = [NSString stringWithFormat:@"%@月%@日", self.model.month, self.model.day];
    self.actTime.text = [NSString stringWithFormat:@"%@-%@", self.model.fromTime, self.model.toTime];
    self.addr.text = self.model.addr;
    if(self.model.price==0){
        [self.freeSignetImg setHidden:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)backView:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
