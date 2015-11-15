//
//  ActivityDetailModel.m
//  uYoung
//
//  Created by CSDN on 15/10/16.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "ActivityDetailModel.h"
#import "ActivityDetailEnrollsModel.h"

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
             @"nickName": @"oriUserNickName",
             @"oriUserId": @"oriUserId",
             @"feeType": @"feeType",
             @"desc": @"description",
             @"avatarUrl": @"oriUserAvatarUrl",
             @"enrollDictArr":@"signUpUserList"
             };
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    NSArray * a =  [MTLJSONAdapter modelsOfClass:[ActivityDetailEnrollsModel class] fromJSONArray:self.enrollDictArr error:nil];
    if (a&&[a count]>0) {
        self.enrolls = [[NSArray alloc]initWithArray:a];
    }
    return self;
}

@end
