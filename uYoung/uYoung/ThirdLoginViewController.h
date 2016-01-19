//
//  ThirdLoginViewController.h
//  uYoung
//
//  Created by CSDN on 15/10/23.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@interface ThirdLoginViewController : LoginViewController

@property (weak, nonatomic) IBOutlet UIImageView *coverMsgImage;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topCons;

- (IBAction)doubanLogin:(UIButton *)sender;
- (IBAction)qqLogin:(UIButton *)sender;
- (IBAction)sinaWeiboLogin:(UIButton *)sender;
- (IBAction)cancelLogin:(id)sender;

@end
