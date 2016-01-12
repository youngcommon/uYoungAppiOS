//
//  RegisterViewController.h
//  uYoung
//
//  Created by 独自天涯 on 16/1/12.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *nickFront;
@property (strong, nonatomic) IBOutlet UITextField *nickInput;
@property (strong, nonatomic) IBOutlet UIImageView *emailFront;
@property (strong, nonatomic) IBOutlet UITextField *emailInput;
@property (strong, nonatomic) IBOutlet UIImageView *pwdFront;
@property (strong, nonatomic) IBOutlet UITextField *pwdInput;
@property (strong, nonatomic) IBOutlet UIImageView *repwdFront;
@property (strong, nonatomic) IBOutlet UITextField *repwdInput;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;


- (IBAction)registerUser:(id)sender;
- (IBAction)cancelRegister:(id)sender;
@end
