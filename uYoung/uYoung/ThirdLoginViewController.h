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

@property (strong, nonatomic) IBOutlet UIImageView *acctFrontImage;
@property (strong, nonatomic) IBOutlet UIImageView *pwdFrontImage;
@property (strong, nonatomic) IBOutlet UITextField *acctBackInput;
@property (strong, nonatomic) IBOutlet UITextField *pwdBackInput;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIImageView *coverMsgImage;


- (IBAction)doubanLogin:(UIButton *)sender;
- (IBAction)qqLogin:(UIButton *)sender;
- (IBAction)sinaWeiboLogin:(UIButton *)sender;

@end
