//
//  AppDelegate.m
//  uYoung
//
//  Created by CSDN on 15/9/18.
//  Copyright (c) 2015年 uYoungCommon. All rights reserved.
//

#import "AppDelegate.h"
#import <TencentOpenAPI/TencentOAuth.h>

#if __QQAPI_ENABLE__
#import "TencentOpenAPI/QQApiInterface.h"
#import "QQAPIDemoEntry.h"
#endif

@interface AppDelegate () <TencentSessionDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [NSThread sleepForTimeInterval:3];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.root = [[RootViewController alloc]initWithNibName:@"RootViewController" bundle:[NSBundle mainBundle]];
    
    self.window.rootViewController = self.root;
    self.navController = [[UINavigationController alloc] initWithRootViewController:self.root];
    self.navController.delegate = self;
    
    [self.window addSubview:self.navController.view];
    [self.window makeKeyAndVisible];
    
    //注册QQ SSO
    self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:QQAppKey andDelegate:self];
    
    //注册新浪微博SSO
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:SinaWeiboAppKey];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fillUserDetail:) name:@"fillUserDetail" object:nil];

    return YES;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ( viewController ==  self.root) {
        [navigationController setNavigationBarHidden:YES animated:animated];
    } else if ( [navigationController isNavigationBarHidden] ) {
        [navigationController setNavigationBarHidden:YES animated:animated];
    } 
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:self]||[TencentOAuth HandleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WeiboSDK handleOpenURL:url delegate:self] || [TencentOAuth HandleOpenURL:url];
}

#pragma mark 微博及微信
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        if(response.statusCode !=-1) {//-1的时候，表明用户取消了
            self.sinaInfoDic = response.userInfo;
            [self loginSuccess];
        }
    }
}

#pragma mark QQ登录回调
- (void)getUserInfoResponse:(APIResponse*) response
{
    if (response.retCode== 0) {
        NSMutableDictionary * dict=[response.jsonResponse mutableCopy];
        [dict setValue:_tencentOAuth.openId forKey:@"uid"];
        [dict setValue:_tencentOAuth.accessToken forKey:@"access_token"];
        
        self.userLoginInfoDic = [dict copy];
        [self loginSuccess];
    }
}

- (void)tencentDidLogin
{
    if (_tencentOAuth.accessToken && 0 != [_tencentOAuth.accessToken length]){
        //  记录登录用户的OpenID、Token以及过期时间
        [_tencentOAuth getUserInfo];
    }
}

- (void)loginSuccess{
    NSString *thirdUid;
    NSString *accessToken;
    NSString *refreshToken;
    NSString *nickName;
    NSString *gender;
    NSString *city;
    NSInteger userType;
    NSString *avaterUrl;
    NSString *expireIn;
    NSDictionary *dict;
    if(self.userLoginInfoDic&&self.userLoginInfoDic[@"uid"]>0){
        //说明是QQ登陆
        thirdUid = self.userLoginInfoDic[@"uid"];
        accessToken = self.userLoginInfoDic[@"access_token"];
        nickName = self.userLoginInfoDic[@"nickname"];
        gender = self.userLoginInfoDic[@"gender"];
        NSInteger genderVal = 0;
        if (gender&&[gender isKindOfClass:[NSString class]]&&gender.length>0&&[gender isEqualToString:@"男"]) {
            genderVal = 1;
        }
        city = self.userLoginInfoDic[@"city"];
        userType = 1;
        avaterUrl = self.userLoginInfoDic[@"figureurl_qq_2"];
        dict = [[NSDictionary alloc]initWithObjectsAndKeys: thirdUid, @"thirdUid", accessToken, @"accessToken", nickName, @"nickName", @(userType), @"userType", avaterUrl, @"avatarUrl", @(genderVal), @"gender", city, @"city", nil];
    }else{
        //说明是微博登陆
        thirdUid = self.sinaInfoDic[@"uid"];
        accessToken = self.sinaInfoDic[@"access_token"];
        refreshToken = self.sinaInfoDic[@"refresh_token"];
        nickName = self.sinaInfoDic[@"app"][@"name"];
        userType = 2;
        avaterUrl = self.sinaInfoDic[@"app"][@"logo"];
        expireIn = self.sinaInfoDic[@"expires_in"];
        dict = [[NSDictionary alloc]initWithObjectsAndKeys: thirdUid, @"thirdUid", accessToken, @"accessToken", refreshToken, @"refreshToken", nickName, @"nickName", @(userType), @"userType", avaterUrl, @"avatarUrl", expireIn, @"expireIn", nil];
    }
    
    //保存登陆成功数据
    [UserLogin postThirdTypeLoginData:dict delegate:self];
    
}

- (void)postThirdData:(NSInteger)uid{
    [UserDetail getUserDetailWithId:uid delegate:self];
}

- (void)fillUserDetail:(NSDictionary*)dict{
    UserDetailModel *userDetailModel = [MTLJSONAdapter modelOfClass:[UserDetailModel class] fromJSONDictionary:dict error:nil];
    [userDetailModel save];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"loginSuccess" object:userDetailModel];
}

@end
