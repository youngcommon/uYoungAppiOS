//
//  UserDetail.h
//  uYoung
//
//  Created by CSDN on 15/10/16.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "GlobalConfig.h"

@protocol UserDetailDelegate <NSObject>
@optional
- (void)fillUserDetail:(NSDictionary*)dict;

@end

@interface UserDetail : NSObject

+ (void)getUserDetailWithId:(NSInteger)userId delegate:(id<UserDetailDelegate>)delegate;

@end
