//
//  ThirdLoginViewController.m
//  uYoung
//
//  Created by CSDN on 15/10/23.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "ThirdLoginViewController.h"
#import "AppDelegate.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "DoubanLoginViewController.h"
#import "GlobalConfig.h"

@interface ThirdLoginViewController ()

@end

@implementation ThirdLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (mScreenWidth==375) {
//        [_coverMsgImage setHidden:YES];
    }
    
    [_topCons setConstant:mScreenWidth/4];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:@"loginSuccess" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)doubanLogin:(UIButton *)sender {
    NSString *str = [NSString stringWithFormat:@"https://www.douban.com/service/auth2/auth?client_id=%@&redirect_uri=%@&response_type=token", DOUBAN_API_KEY, DOUBAN_REDIRECT_URL];
    
    NSString *urlStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    DoubanLoginViewController *webViewController = [[DoubanLoginViewController alloc] initWithRequestURL:url];
//    [self.navigationController pushViewController:webViewController animated:YES];
    [self presentViewController:webViewController animated:YES completion:nil];
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

- (IBAction)cancelLogin:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"popLoginView" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loginSuccess:(NSNotification*)noti{
    UserDetailModel *detail = (UserDetailModel*)[noti object];
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:self.source object:detail];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
