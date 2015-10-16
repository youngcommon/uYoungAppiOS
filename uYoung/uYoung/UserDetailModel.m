//
//  UserDetailModel.m
//  uYoung
//
//  Created by CSDN on 15/10/16.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "UserDetailModel.h"

@implementation UserDetailModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"id": @"id",
             @"realName": @"realName",
             @"nickName": @"nickName",
             @"email": @"email",
             @"gender": @"gender",
             @"avatarUrl": @"avatarUrl",
             @"phone": @"phone",
             @"company": @"company",
             @"position": @"position",
             @"equipment": @"equipment"
             };
}

@end
