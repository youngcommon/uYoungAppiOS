//
//  ActivityDetail.h
//  uYoung
//
//  Created by CSDN on 15/10/16.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import <AFHTTPRequestOperationManager+Synchronous.h>
#import "GlobalConfig.h"

@interface ActivityDetail : NSObject

+ (void)getActivityDetailWithId:(NSInteger)activityId;

+ (void)getSignStatusWithUser:(long)userId actId:(long)actId opts:(void(^)(NSInteger status))status;

+ (void)signupActivity:(long)userId actId:(long)actId opts:(void(^)(BOOL success))success;

+ (void)unsignedActivity:(long)userId actId:(long)actId opts:(void(^)(BOOL success))success;

+ (void)cancelActivity:(long)userId actId:(long)actId opts:(void(^)(BOOL success))success;

+ (void)signActivity:(long)userId actId:(long)actId opts:(void(^)(BOOL success))success;

+ (BOOL)isSignedActivity:(long)uid actId:(long)actId;

@end
