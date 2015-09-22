//
//  AppDelegate.h
//  uYoung
//
//  Created by CSDN on 15/9/18.
//  Copyright (c) 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMAIN_SCREEN_WIDTH   ([[UIScreen mainScreen] bounds].size.width)
#define kMAIN_SCREEN_HEIGHT  ([[UIScreen mainScreen] bounds].size.height)

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;

@end

