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
             @"actType":@"nickname",
             @"personNum":@"answer_count",
             @"day":@"c_coin",
             @"month":@"created_at",
             @"week":@"votes_count",
             @"fromTime":@"all_answers",
             @"toTime":@"best_answer",
             @"addr":@"question_status",
             @"headerUrl":@"best_answer",
             @"addr":@"question_status",
             @"status":@"tag_list"
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
