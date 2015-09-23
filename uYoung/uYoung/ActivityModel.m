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
             @"askId": @"id",
             @"username": @"username",
             @"title":@"title",
             @"nickname":@"nickname",
             @"answerCount":@"answer_count",
             @"coinCount":@"c_coin",
             @"createdAt":@"created_at",
             @"votesCount":@"votes_count",
             @"answers":@"all_answers",
             @"bestAnswer":@"best_answer",
             @"questionStatus":@"question_status",
             @"m_Tag_list":@"tag_list"
             };
}
- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
//    NSArray * a =  [MTLJSONAdapter modelsOfClass:[ActivityModel class] fromJSONArray:self.answers error:nil];
    
    
    return self;
}

@end
