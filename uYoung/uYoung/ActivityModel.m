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
             @"title":@"title",
             @"actType":@"acttype",
             @"personNum":@"pnum",
             @"day":@"day",
             @"month":@"mon",
             @"week":@"week",
             @"fromTime":@"from",
             @"toTime":@"to",
             @"addr":@"addr",
             @"headerUrl":@"header",
             @"local":@"local",
             @"price":@"p",
             @"status":@"status"
             };
}
//- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
//    self = [super initWithDictionary:dictionaryValue error:error];
//    if (self == nil) return nil;
//    
//    self =  [MTLJSONAdapter modelsOfClass:[ActivityModel class] fromJSONArray:self.answers error:nil];
//    
//    
//    return self;
//}

@end
