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
            [self loginSuccessWithDictionary:self.sinaInfoDic];
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
        [self loginSuccessWithDictionary:self.userLoginInfoDic];
    }
}

- (void)loginSuccessWithDictionary:(NSDictionary*)dict{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"loginSuccess" object:nil];
}

@end
