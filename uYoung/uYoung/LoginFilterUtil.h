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

@interface LoginFilterUtil : NSObject

+(LoginFilterUtil *)shareInstance;

- (UIViewController*)getLoginViewController;

@end
