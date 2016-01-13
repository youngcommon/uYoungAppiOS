//
//  RegisterViewController.m
//  uYoung
//
//  Created by 独自天涯 on 16/1/12.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import "RegisterViewController.h"
#import "NSString+StringUtil.h"
#import "UYoungAlertViewUtil.h"
#import "GlobalConfig.h"
#import "UserLogin.h"
#import "UIWindow+YoungHUD.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UYoungAlertViewUtil shareInstance]dismissAlertView];

    [_nickFront setImage:[self getScaleUIImage:@"uyoung.bundle/input_top.png" isFront:YES]];
    [_emailFront setImage:[self getScaleUIImage:@"uyoung.bundle/input_fr_mid.png" isFront:YES]];
    [_pwdFront setImage:[self getScaleUIImage:@"uyoung.bundle/input_fr_mid.png" isFront:YES]];
    [_repwdFront setImage:[self getScaleUIImage:@"uyoung.bundle/input_bottom.png" isFront:YES]];
    _nickInput.background = [self getScaleUIImage:@"uyoung.bundle/input_end_top.png" isFront:NO];
    _emailInput.background = [self getScaleUIImage:@"uyoung.bundle/input_bk_mid.png" isFront:NO];
    _pwdInput.background = [self getScaleUIImage:@"uyoung.bundle/input_bk_mid.png" isFront:NO];
    _repwdInput.background = [self getScaleUIImage:@"uyoung.bundle/input_end_bottom.png" isFront:NO];
    
    _registerButton.layer.cornerRadius = 6.f;
    _registerButton.layer.masksToBounds = YES;
    _registerButton.layer.borderWidth = 1;
    _registerButton.layer.borderColor = [UIColorFromRGB(0x85b200)CGColor];
    
    //增加键盘事件监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)registerUser:(id)sender {
    NSString *nickname = _nickInput.text;
    NSString *email = _emailInput.text;
    NSString *pwd = _pwdInput.text;
    NSString *repwd = _repwdInput.text;
    if ([NSString isBlankString:nickname]) {
        [[UYoungAlertViewUtil shareInstance]createAlertView:@"昵称不能为空" Message:@"" CancelTxt:@"知道了" OtherTxt:@"" Tag:1 Delegate:self];
    }
    if ([NSString isBlankString:email]) {
        [[UYoungAlertViewUtil shareInstance]createAlertView:@"请输入邮箱" Message:@"" CancelTxt:@"知道了" OtherTxt:@"" Tag:1 Delegate:self];
    }
    if ([NSString isBlankString:pwd]) {
        [[UYoungAlertViewUtil shareInstance]createAlertView:@"请输入密码" Message:@"" CancelTxt:@"知道了" OtherTxt:@"" Tag:2 Delegate:self];
    }
    if ([NSString isBlankString:repwd]) {
        [[UYoungAlertViewUtil shareInstance]createAlertView:@"请输入验证密码" Message:@"" CancelTxt:@"知道了" OtherTxt:@"" Tag:2 Delegate:self];
    }
    if (![pwd isEqualToString:repwd]) {
        [[UYoungAlertViewUtil shareInstance]createAlertView:@"密码输入错误" Message:@"两次输入的密码不一致，请确认" CancelTxt:@"知道了" OtherTxt:@"" Tag:2 Delegate:self];
    }
    
    //注册流程
    pwd = [pwd stringToMD5];
    [UserLogin userRegisterWithEmailAndPwd:email pwd:pwd nickname:nickname success:^(BOOL isSuccess, NSString *msg) {
        if (isSuccess) {
            [[UYoungAlertViewUtil shareInstance]createAlertView:@"注册成功" Message:@"返回后请使用注册信息再次登陆" CancelTxt:@"好的" OtherTxt:@"" Tag:3 Delegate:self];
        }else{
            [[UYoungAlertViewUtil shareInstance]createAlertView:@"注册失败" Message:msg CancelTxt:@"再试试" OtherTxt:@"" Tag:4 Delegate:self];
        }
    }];
}

- (IBAction)cancelRegister:(id)sender {
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
    if (alertView.tag==3) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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

@end
