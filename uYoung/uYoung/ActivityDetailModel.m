//
//  ActivityDetailModel.m
//  uYoung
//
//  Created by CSDN on 15/10/16.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "ActivityDetailModel.h"

@implementation ActivityDetailModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"activityId": @"id",
             @"title": @"title",
             @"activityTypeDesc": @"activityTypeDesc",
             @"needNum": @"needNum",
             @"realNum": @"realNum",
             @"day": @"day",
             @"month": @"mon",
             @"fromTime": @"fromTime",
             @"toTime": @"toTime",
             @"address": @"address",
             @"nickName": @"nickName",
             @"feeType": @"feeType",
             @"desc": @"description",
             @"avatarUrl": @"avatarUrl"
             };
}

@end
