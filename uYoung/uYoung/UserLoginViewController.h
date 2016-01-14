//
//  UserLoginViewController.h
//  uYoung
//
//  Created by 独自天涯 on 16/1/12.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserLoginViewController : UIViewController<UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *tipsImg;
@property (strong, nonatomic) IBOutlet UITextField *emailInput;
@property (strong, nonatomic) IBOutlet UIImageView *emailFront;
@property (strong, nonatomic) IBOutlet UITextField *pwdInput;
@property (strong, nonatomic) IBOutlet UIImageView *pwdFront;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@property (assign, nonatomic) CGFloat delta;
@property (assign, nonatomic) CGFloat viewBottom;
@property (assign, nonatomic) BOOL isRegister;

- (IBAction)toRegister:(id)sender;
- (IBAction)loginButtonValidate:(id)sender;
- (IBAction)login:(id)sender;
- (IBAction)cancelLogin:(id)sender;
@end
