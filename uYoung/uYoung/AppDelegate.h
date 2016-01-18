//
//  AppDelegate.h
//  uYoung
//
//  Created by CSDN on 15/9/18.
//  Copyright (c) 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import <TencentOpenAPI/TencentApiInterface.h>
#import "WeiboSDK.h"
#import "UserDetail.h"
#import "UserLogin.h"
#import "UserDetailModel.h"
#import "GlobalNetwork.h"

#define kMAIN_SCREEN_WIDTH   ([[UIScreen mainScreen] bounds].size.width)
#define kMAIN_SCREEN_HEIGHT  ([[UIScreen mainScreen] bounds].size.height)

@class TencentOAuth;
@interface AppDelegate : UIResponder <UIApplicationDelegate, UINavigationControllerDelegate, WeiboSDKDelegate, UserLoginDelegate, GlobalNetworkDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RootViewController *root;
@property (strong, nonatomic) UINavigationController *navController;

@property (strong, nonatomic) TencentOAuth *tencentOAuth;
@property (nonatomic, strong) NSDictionary *userLoginInfoDic;
@property (nonatomic, strong) NSMutableDictionary *sinaInfoDic;
@property (nonatomic, strong) NSDictionary *doubanDic;
@property (nonatomic, strong) NSString *doubanToken;

-(void)doubanSuccessLogin:(NSDictionary*)dict withToken:(NSString*)token;

@end

