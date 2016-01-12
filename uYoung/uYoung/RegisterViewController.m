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
    [UserLogin userRegisterWithEmailAndPwd:email pwd:pwd nickname:nickname success:^(NSInteger uid) {
        
    }];
}

- (IBAction)cancelRegister:(id)sender {
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

@end
