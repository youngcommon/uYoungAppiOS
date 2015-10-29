//
//  LoginViewController.m
//  uYoung
//
//  Created by CSDN on 15/10/23.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import <TencentOpenAPI/TencentOAuth.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_acctFrontImage setImage:[self getScaleUIImage:@"uyoung.bundle/input_top.png" isFront:YES]];
    [_pwdFrontImage setImage:[self getScaleUIImage:@"uyoung.bundle/input_bottom.png" isFront:YES]];
    _acctBackInput.background = [self getScaleUIImage:@"uyoung.bundle/input_end_top.png" isFront:NO];
    _pwdBackInput.background = [self getScaleUIImage:@"uyoung.bundle/input_end_bottom.png" isFront:NO];
    
    _loginButton.layer.cornerRadius = 6.f;
    _loginButton.layer.masksToBounds = YES;
    
    if (mScreenWidth<375) {
        [_coverMsgImage setHidden:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)doubanLogin:(UIButton *)sender {
    
}

- (IBAction)qqLogin:(UIButton *)sender{
    NSArray* permissions = [NSArray arrayWithObjects:
                            kOPEN_PERMISSION_GET_USER_INFO,
                            kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                            kOPEN_PERMISSION_ADD_ALBUM,
                            kOPEN_PERMISSION_ADD_IDOL,
                            kOPEN_PERMISSION_ADD_ONE_BLOG,
                            kOPEN_PERMISSION_ADD_PIC_T,
                            kOPEN_PERMISSION_ADD_SHARE,
                            kOPEN_PERMISSION_ADD_TOPIC,
                            kOPEN_PERMISSION_CHECK_PAGE_FANS,
                            kOPEN_PERMISSION_DEL_IDOL,
                            kOPEN_PERMISSION_DEL_T,
                            kOPEN_PERMISSION_GET_FANSLIST,
                            kOPEN_PERMISSION_GET_IDOLLIST,
                            kOPEN_PERMISSION_GET_INFO,
                            kOPEN_PERMISSION_GET_OTHER_INFO,
                            kOPEN_PERMISSION_GET_REPOST_LIST,
                            kOPEN_PERMISSION_LIST_ALBUM,
                            kOPEN_PERMISSION_UPLOAD_PIC,
                            kOPEN_PERMISSION_GET_VIP_INFO,
                            kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                            kOPEN_PERMISSION_GET_INTIMATE_FRIENDS_WEIBO,
                            kOPEN_PERMISSION_MATCH_NICK_TIPS_WEIBO,
                            nil];
    
    [((AppDelegate *)[[UIApplication sharedApplication] delegate]).tencentOAuth authorize:permissions inSafari:NO];
}

- (IBAction)sinaWeiboLogin:(UIButton *)sender {
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = SinaWeiboRedirectURI;
    request.scope = @"all";
    [WeiboSDK sendRequest:request];
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
@end
