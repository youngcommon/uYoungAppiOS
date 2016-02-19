//
//  ActivityDetail.m
//  uYoung
//
//  Created by CSDN on 15/10/16.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "ActivityDetail.h"
#import "Des3Encrypt.h"
#import "GlobalConfig.h"

@implementation ActivityDetail

+ (void)getActivityDetailWithId:(NSInteger)activityId{
    NSString *url = [uyoung_host stringByAppendingString:@"activity/getById"];
    
    NSDictionary *parameters = @{@"id": [NSString stringWithFormat:@"%d", (int)activityId]};
    
//    NSString *stamp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date]timeIntervalSince1970]];
//    NSDictionary *encrypt = [Des3Encrypt getEncryptParams:parameters stamp:stamp];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger result = [[responseObject objectForKey:@"result"] integerValue];
        if(result==100){//说明获得正确结果
            NSDictionary *resultData = [responseObject objectForKey:@"resultData"];
            if(resultData){
                [[NSNotificationCenter defaultCenter] postNotificationName:@"fillActivityDetail" object:resultData];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

+ (void)getSignStatusWithUser:(long)userId actId:(long)actId opts:(void(^)(NSInteger status))status{
    NSString *url = [uyoung_host stringByAppendingString:@"activity/getSignUp"];
    
    NSDictionary *parameters = @{@"uid":@(userId), @"activityId":@(actId)};
    
//    NSString *stamp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date]timeIntervalSince1970]];
//    NSDictionary *encrypt = [Des3Encrypt getEncryptParams:parameters stamp:stamp];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger result = [[responseObject objectForKey:@"result"] integerValue];
        if(result==100){//说明获得正确结果
            NSDictionary *resultData = [responseObject objectForKey:@"resultData"];
            if(resultData!=nil&&[resultData isEqual:[NSNull null]]==NO){
                NSInteger statusValue = [[resultData objectForKey:@"status"]integerValue];
                status(statusValue);
            }else{
                status(0);
            }
        }else if(result==NOT_LOGIN){
            [[NSNotificationCenter defaultCenter] postNotificationName:NOT_LOGIN_NOTICE object:nil];
        }else{
            status(0);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        status(0);
    }];
}

+ (void)signupActivity:(long)userId actId:(long)actId opts:(void(^)(BOOL success))success{
    NSString *url = [uyoung_host stringByAppendingString:@"activity/signUp"];
    
    NSDictionary *parameters = @{@"uid":@(userId), @"activityId":@(actId)};
    
//    NSString *stamp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date]timeIntervalSince1970]];
//    NSDictionary *encrypt = [Des3Encrypt getEncryptParams:parameters stamp:stamp];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger result = [[responseObject objectForKey:@"result"] integerValue];
        if(result==100){//说明获得正确结果
            success(YES);
        }else if(result==NOT_LOGIN){
            [[NSNotificationCenter defaultCenter] postNotificationName:NOT_LOGIN_NOTICE object:nil];
        }else{
            success(NO);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        success(NO);
    }];
}

+ (void)unsignedActivity:(long)userId actId:(long)actId opts:(void(^)(BOOL success))success{
    NSString *url = [uyoung_host stringByAppendingString:@"activity/calSignUp"];
    
    NSDictionary *parameters = @{@"uid":@(userId), @"activityId":@(actId)};
    
//    NSString *stamp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date]timeIntervalSince1970]];
//    NSDictionary *encrypt = [Des3Encrypt getEncryptParams:parameters stamp:stamp];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger result = [[responseObject objectForKey:@"result"] integerValue];
        if(result==100){//说明获得正确结果
            success(YES);
        }else if(result==NOT_LOGIN){
            [[NSNotificationCenter defaultCenter] postNotificationName:NOT_LOGIN_NOTICE object:nil];
        }else{
            success(NO);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        success(NO);
    }];
}

+ (void)cancelActivity:(long)userId actId:(long)actId opts:(void(^)(BOOL success))success{
    NSString *url = [uyoung_host stringByAppendingString:@"activity/cal"];
    
    NSDictionary *parameters = @{@"uid":@(userId), @"activityId":@(actId)};
    
//    NSString *stamp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date]timeIntervalSince1970]];
//    NSDictionary *encrypt = [Des3Encrypt getEncryptParams:parameters stamp:stamp];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger result = [[responseObject objectForKey:@"result"] integerValue];
        if(result==100){//说明获得正确结果
            success(YES);
        }else if(result==NOT_LOGIN){
            [[NSNotificationCenter defaultCenter] postNotificationName:NOT_LOGIN_NOTICE object:nil];
        }else{
            success(NO);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        success(NO);
    }];
}

+ (void)signActivity:(long)userId actId:(long)actId opts:(void(^)(BOOL success))success{
    NSString *url = [uyoung_host stringByAppendingString:@"activity/conSignUp"];
    
    NSDictionary *parameters = @{@"uid":@(userId), @"activityId":@(actId)};
    
//    NSString *stamp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date]timeIntervalSince1970]];
//    NSDictionary *encrypt = [Des3Encrypt getEncryptParams:parameters stamp:stamp];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger result = [[responseObject objectForKey:@"result"] integerValue];
        if(result==100){//说明获得正确结果
            success(YES);
        }else if(result==NOT_LOGIN){
            [[NSNotificationCenter defaultCenter] postNotificationName:NOT_LOGIN_NOTICE object:nil];
        }else{
            success(NO);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        success(NO);
    }];
}

+ (BOOL)isSignedActivity:(long)uid actId:(long)actId{
    
    NSDictionary *param = @{@"uid":@(uid), @"activityId":@(actId)};
    NSString *url = [uyoung_host stringByAppendingString:@"activity/getSignUp"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 5;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    NSError *error = nil;
    NSDictionary *dict = [manager syncGET:url parameters:param operation:NULL error:&error];
    NSInteger result = [[dict objectForKey:@"result"]integerValue];
    if (result==100) {
        NSDictionary *resultData = dict[@"resultData"];
        if (resultData!=nil) {
            return YES;
        }
    }
    return NO;
}

@end
