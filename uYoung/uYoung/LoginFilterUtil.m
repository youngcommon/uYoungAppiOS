//
//  LoginFilterUtil.m
//  uYoung
//
//  Created by CSDN on 16/1/14.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import "LoginFilterUtil.h"

@implementation LoginFilterUtil

+(LoginFilterUtil *)shareInstance{
    static dispatch_once_t pred;
    static LoginFilterUtil *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[LoginFilterUtil alloc] init];
    });
    return shared;
}

- (UIViewController*)getLoginViewController{
    UIViewController *ctl;
    //获取当前审核状态
    NSArray *arrPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *strDocBase = ([arrPaths count] > 0) ? [arrPaths objectAtIndex:0] : nil;
    NSString *filename=[strDocBase stringByAppendingPathComponent:@"global_config.plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    BOOL isInreview = YES;
    if (data!=nil) {
        isInreview = [data[@"inreview"]boolValue];
    }
    if(isInreview){//如果是审核状态
        ctl = [[UserLoginViewController alloc]initWithNibName:@"UserLoginViewController" bundle:[NSBundle mainBundle]];
    }else{
        ctl = [[ThirdLoginViewController alloc]initWithNibName:@"ThirdLoginViewController" bundle:[NSBundle mainBundle]];
    }
    return ctl;
}

@end
