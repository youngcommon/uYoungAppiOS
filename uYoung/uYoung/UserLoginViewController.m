//
//  UserLoginViewController.m
//  uYoung
//
//  Created by 独自天涯 on 16/1/12.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import "UserLoginViewController.h"
#import "GlobalConfig.h"
#import "NSString+StringUtil.h"
#import "UYoungAlertViewUtil.h"
#import "RegisterViewController.h"
#import "UserLogin.h"
#import "NSString+StringUtil.h"
#import "UserDetailModel.h"
#import "UserDetail.h"

@interface UserLoginViewController ()

@end

@implementation UserLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UYoungAlertViewUtil shareInstance]dismissAlertView];
    
    [_emailFront setImage:[self getScaleUIImage:@"uyoung.bundle/input_top.png" isFront:YES]];
    [_pwdFront setImage:[self getScaleUIImage:@"uyoung.bundle/input_bottom.png" isFront:YES]];
    _emailInput.background = [self getScaleUIImage:@"uyoung.bundle/input_end_top.png" isFront:NO];
    _pwdInput.background = [self getScaleUIImage:@"uyoung.bundle/input_end_bottom.png" isFront:NO];
    
    _loginButton.layer.cornerRadius = 6.f;
    _loginButton.layer.masksToBounds = YES;
    _loginButton.layer.borderWidth = 1;
    _loginButton.layer.borderColor = [UIColorFromRGB(0x85b200)CGColor];
    _loginButton.enabled = NO;
    
    if (mScreenWidth<375) {
        [_tipsImg setHidden:YES];
    }
    
    //增加键盘事件监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    //登录成功事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:@"loginSuccess" object:nil];
    
}

- (void)loginSuccess:(NSNotification*)noti{
    UserDetailModel *detail = (UserDetailModel*)[noti object];
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:self.source object:detail];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)toRegister:(id)sender {
    RegisterViewController *ctl = [[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:[NSBundle mainBundle]];
    [self presentViewController:ctl animated:YES completion:nil];
}

- (IBAction)loginButtonValidate:(id)sender {
    NSString *email = _emailInput.text;
    NSString *pwd = _pwdInput.text;
    if (![NSString isBlankString:email]&&[email isValidateEmail]&&[pwd isValidatePassword]) {
        _loginButton.enabled = YES;
    }
}

- (IBAction)login:(id)sender {
    
    NSString *email = _emailInput.text;
    NSString *pwd = _pwdInput.text;
    if ([NSString isBlankString:email]) {
        [[UYoungAlertViewUtil shareInstance]createAlertView:@"请输入邮箱" Message:@"" CancelTxt:@"知道了" OtherTxt:nil Tag:1 Delegate:self];
    }
    if ([NSString isBlankString:pwd]) {
        [[UYoungAlertViewUtil shareInstance]createAlertView:@"请输入密码" Message:@"" CancelTxt:@"知道了" OtherTxt:nil Tag:2 Delegate:self];
    }
    
    //登陆流程
    pwd = [pwd stringToMD5];
    [UserLogin loginWithEmailAndPwd:email pwd:pwd success:^(NSInteger uid) {
        if (uid>0) {
            [UserDetail getUserDetailWithId:uid success:^(UserDetailModel *userDetailModel) {
                [userDetailModel save];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"loginSuccess" object:userDetailModel];
            }];
        }else{
            [[UYoungAlertViewUtil shareInstance]createAlertView:@"登录失败" Message:@"请您稍后再试" CancelTxt:@"好的" OtherTxt:nil Tag:5 Delegate:self];
        }
    }];
    
}

- (IBAction)cancelLogin:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"popLoginView" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)getScaleUIImage:(NSString*)name isFront:(BOOL)isFront{
    UIImage *bubble = [UIImage imageNamed:name];
    
    UIEdgeInsets capInsets;
    if (isFront) {
        capInsets = UIEdgeInsetsMake(0, 10, 0, 6);
    }else{
        capInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    }
    return [bubble resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [[UYoungAlertViewUtil shareInstance]dismissAlertView];
}

- (void)keyboardWillShow:(NSNotification *)notify {
    //sv为弹出键盘的视图，UITextField
    CGFloat kbHeight = [[notify.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;//获取键盘高度。
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //    CGFloat screenHeight = self.view.bounds.size.height;
    CGFloat screenHeight = self.view.frame.size.height;
    
    if (_viewBottom + kbHeight < screenHeight) return;//若键盘没有遮挡住视图则不进行整个视图上移
    
    // 键盘会盖住输入框, 要移动整个view了
    _delta = _viewBottom + kbHeight - screenHeight + 100;
    
    CGRect viewFrame = CGRectMake(0, 0-_delta, self.view.frame.size.width, self.view.frame.size.height);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:duration];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
}

- (void)keyboardWillHidden:(NSNotification *)notify {//键盘消失
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect viewFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:duration];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
    _delta = 0.0f;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    _isRegister = NO;
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (_isRegister==NO) {
        _isRegister = YES;
        _viewBottom = textField.frame.origin.y + textField.frame.size.height;
    }
    
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[UYoungAlertViewUtil shareInstance]dismissAlertView];
}

@end
