//
//  UserCenterController.m
//  uYoung
//
//  Created by CSDN on 15/10/13.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "UserCenterController.h"
#import <UIImageView+AFNetworking.h>

@implementation UserCenterController

- (void)viewDidLoad{
    
    self.headerBackgroundLabel.layer.cornerRadius = self.headerBackgroundLabel.frame.size.height/2;
    self.headerBackgroundLabel.layer.masksToBounds = YES;
    
    self.headerImg.layer.cornerRadius = self.headerImg.frame.size.height/2;
    self.headerImg.layer.masksToBounds = YES;
    self.headerImg.layer.borderWidth = 1.;
    self.headerImg.layer.borderColor = [[UIColor brownColor] CGColor];
    
    [self.headerBackBlurImg setImageWithURL:[NSURL URLWithString:@"http://img.61gequ.com/allimg/2011-4/201142614314278502.jpg"] placeholderImage:[UIImage imageNamed:@""]];
    
    
}

- (IBAction)getBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
