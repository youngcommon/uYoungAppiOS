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
    
    if (mScreenWidth<375) {
        [_tipsImg setHidden:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)login:(id)sender {
    
    NSString *email = _emailInput.text;
    NSString *pwd = _pwdInput.text;
    if ([NSString isBlankString:email]) {
        [[UYoungAlertViewUtil shareInstance]createAlertView:@"请输入邮箱" Message:@"" CancelTxt:@"知道了" OtherTxt:@"" Tag:1 Delegate:self];
    }
    if ([NSString isBlankString:pwd]) {
        [[UYoungAlertViewUtil shareInstance]createAlertView:@"请输入密码" Message:@"" CancelTxt:@"知道了" OtherTxt:@"" Tag:2 Delegate:self];
    }
    
    //登陆流程
    pwd = [pwd stringToMD5];
    
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
