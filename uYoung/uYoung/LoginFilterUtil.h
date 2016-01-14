//
//  LoginFilterUtil.h
//  uYoung
//
//  Created by CSDN on 16/1/14.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserLoginViewController.h"
#import "ThirdLoginViewController.h"
#import "LoginViewController.h"

@interface LoginFilterUtil : NSObject

+(LoginFilterUtil *)shareInstance;

- (LoginViewController*)getLoginViewController;

@end
