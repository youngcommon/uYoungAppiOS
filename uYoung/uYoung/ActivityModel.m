//
//  ActivityModel.m
//  uYoung
//
//  Created by CSDN on 15/9/23.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "ActivityModel.h"

@implementation ActivityModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"activityId": @"id",
             @"title": @"title",
             @"actType": @"activityTypeDesc",
             @"personNum": @"needNum",
             @"day": @"day",
             @"month": @"mon",
             @"week": @"weekDesc",
             @"fromTime": @"fromTime",
             @"toTime": @"toTime",
             @"addr": @"address",
             @"headerUrl": @"oriUserAvatarUrl",
             @"local": @"local",
             @"price": @"feeType",
             @"status": @"status"
             };
}

@end
