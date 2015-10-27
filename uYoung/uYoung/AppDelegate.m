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
    
    self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:QQAppKey andDelegate:self];

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
    
#if __QQAPI_ENABLE__
    [QQApiInterface handleOpenURL:url delegate:(id<QQApiInterfaceDelegate>)[QQAPIDemoEntry class]];
#endif
    
    if (YES == [TencentOAuth CanHandleOpenURL:url])
    {
        return [TencentOAuth HandleOpenURL:url];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
#if __QQAPI_ENABLE__
    [QQApiInterface handleOpenURL:url delegate:(id<QQApiInterfaceDelegate>)[QQAPIDemoEntry class]];
#endif
    
    if (YES == [TencentOAuth CanHandleOpenURL:url])
    {
        return [TencentOAuth HandleOpenURL:url];
    }
    return YES;
}

#pragma mark QQ登录回调
- (void)tencentDidLogin
{
    if (_tencentOAuth.accessToken && 0 != [_tencentOAuth.accessToken length]){
        //  记录登录用户的OpenID、Token以及过期时间
        [_tencentOAuth getUserInfo];
    }else{
        
    }
}

-(void)tencentDidNotLogin:(BOOL)cancelled
{
    if (cancelled)
        NSLog(@"用户取消登陆");
    else
        NSLog(@"登陆失败");
}

-(void)tencentDidNotNetWork
{
    NSLog(@"无网络连接，请设置网络");
}

- (void)getUserInfoResponse:(APIResponse*) response
{
    if (response.retCode== 0) {
        NSMutableDictionary * dict=[response.jsonResponse mutableCopy];
        [dict setValue:_tencentOAuth.openId forKey:@"uid"];
        [dict setValue:_tencentOAuth.accessToken forKey:@"access_token"];
        
        self.userLoginInfoDic = [dict copy];
    }
}

@end
