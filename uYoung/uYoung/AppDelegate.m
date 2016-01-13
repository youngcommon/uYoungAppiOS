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

#import "CityModel.h"
#import "UploadImageUtil.h"

@interface AppDelegate () <TencentSessionDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [NSThread sleepForTimeInterval:3];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.root = [[RootViewController alloc]initWithNibName:@"RootViewController" bundle:[NSBundle mainBundle]];
    
    [self.root.view setFrame:CGRectMake(0, -100, mScreenWidth, mScreenHeight)];
    
    self.navController = [[UINavigationController alloc] initWithRootViewController:self.root];
//    self.navController.delegate = self;
    self.navController.navigationBar.translucent = NO;
    self.navController.navigationBarHidden = YES;
    
//    self.window.rootViewController = self.root;
    self.window.rootViewController = self.navController;
    
//    [self.window addSubview:self.navController.view];
    [self.window makeKeyAndVisible];
    
    //注册QQ SSO
    self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:QQAppKey andDelegate:self];
    
    //注册新浪微博SSO
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:SinaWeiboAppKey];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fillUserDetail:) name:@"fillUserDetail" object:nil];
    
    //获得城市
    [GlobalNetwork getAllCityies:self];
    //获得所有类别
    [GlobalNetwork getAllActTypes:self];
    //获得所有状态
    [GlobalNetwork getAllActStatus:self];
    //判断当前是否处于审核中
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"global_config" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    BOOL isInreview = [data[@"inreview"]boolValue];
    if (isInreview) {//如果当前是审核中，则需要再次获取审核状态
        [GlobalNetwork isInreview:^(BOOL inreview) {
            NSDictionary *reviewData = @{@"inreview":@(inreview)};
            BOOL isSuccess = [reviewData writeToFile:plistPath atomically:YES];
            NSLog(@"####%@####", isSuccess?@"success":@"NO");
        }];
    }
    
    //注册键盘跟随
//    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
//    manager.enable = YES;
//    manager.shouldResignOnTouchOutside = YES;
//    manager.shouldToolbarUsesTextFieldTintColor = YES;
//    manager.enableAutoToolbar = NO;
    
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

-(void)successGetCities:(NSArray*)arr{
    NSArray * a =  [MTLJSONAdapter modelsOfClass:[CityModel class] fromJSONArray:arr error:nil];
    
//    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"cities_locations" ofType:@"plist"];
//    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
//    
//    data = [[a arrayByAddingObjectsFromArray:data] mutableCopy];
//
//    BOOL success = [data writeToFile:plistPath atomically:YES];
    
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:a];
    [[NSUserDefaults standardUserDefaults] setObject:archivedData forKey:@"citylist"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

-(void)successGetActTypes:(NSArray*)arr{
    
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:arr];
    [[NSUserDefaults standardUserDefaults] setObject:archivedData forKey:@"acttype"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

-(void)successGetActStatus:(NSArray*)arr{
    
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:arr];
    [[NSUserDefaults standardUserDefaults] setObject:archivedData forKey:@"actstatus"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
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

-(void)doubanSuccessLogin:(NSDictionary*)dict withToken:(NSString*)token{
    if (dict!=nil&&[dict count]>0) {
        self.doubanDic = dict;
        self.doubanToken = token;
        [self loginSuccess];
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
        NSInteger genderVal = 2;
        if (gender&&[gender isKindOfClass:[NSString class]]&&gender.length>0&&[gender isEqualToString:@"男"]) {
            genderVal = 1;
        }
        city = self.userLoginInfoDic[@"city"];
        userType = 2;
        avaterUrl = self.userLoginInfoDic[@"figureurl_qq_2"];
        dict = [[NSDictionary alloc]initWithObjectsAndKeys: thirdUid, @"thirdUid", accessToken, @"accessToken", nickName, @"nickName", @(userType), @"userType", avaterUrl, @"avatarUrl", @(genderVal), @"gender", city, @"city", nil];
    }else if(self.doubanDic&&self.doubanDic[@"id"]>0){
        thirdUid = self.doubanDic[@"id"];
        nickName = self.doubanDic[@"name"];
        avaterUrl = self.doubanDic[@"large_avatar"];
        userType = 1;
        city = self.doubanDic[@"loc_name"];
        accessToken = self.doubanToken;
        dict = [[NSDictionary alloc]initWithObjectsAndKeys:accessToken, @"accessToken", thirdUid, @"thirdUid", nickName, @"nickName", @(userType), @"userType", avaterUrl, @"avatarUrl", city, @"city", nil];
    }else{
        //说明是微博登陆
        thirdUid = self.sinaInfoDic[@"uid"];
        accessToken = self.sinaInfoDic[@"access_token"];
        refreshToken = self.sinaInfoDic[@"refresh_token"];
        nickName = self.sinaInfoDic[@"app"][@"name"];
        userType = 3;
        avaterUrl = self.sinaInfoDic[@"app"][@"logo"];
        expireIn = self.sinaInfoDic[@"expires_in"];
        dict = [[NSDictionary alloc]initWithObjectsAndKeys: thirdUid, @"thirdUid", accessToken, @"accessToken", refreshToken, @"refreshToken", nickName, @"nickName", @(userType), @"userType", avaterUrl, @"avatarUrl", expireIn, @"expireIn", nil];
    }
    
    //保存登陆成功数据
    [UserLogin postThirdTypeLoginData:dict delegate:self];
    
}

- (void)postThirdData:(NSInteger)uid{
    [UserDetail getUserDetailWithId:uid success:^(UserDetailModel *userDetailModel) {
        [userDetailModel save];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"loginSuccess" object:userDetailModel];
    }];
}

@end
