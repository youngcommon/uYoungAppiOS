//
//  UserAlbumList.m
//  uYoung
//
//  Created by CSDN on 15/10/22.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "UserAlbumList.h"

@implementation UserAlbumList

+ (void)getUserAlbumListWithUid:(NSInteger)userId{
    
    NSString *url = [uyoung_host stringByAppendingString:@"album/getByUid"];
    
    NSDictionary *parameters = @{@"uid": [NSString stringWithFormat:@"%d", (int)userId]};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger result = [[responseObject objectForKey:@"result"] integerValue];
        if (result==100) {
            NSDictionary *resultData = [responseObject objectForKey:@"resultData"];
            if(resultData){
                NSArray *arr = resultData[@"dataList"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"userAlbumList" object:arr];
            }else{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"userAlbumList" object:nil];
            }
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"userAlbumList" object:nil];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"userAlbumList" object:nil];
    }];
}

+ (void)getUserAlbumListWithActId:(NSInteger)actId success:(void(^)(NSArray* arr))success{
    NSString *url = [uyoung_host stringByAppendingString:@"album/getByAid"];
    
    NSDictionary *parameters = @{@"activityId": @(actId)};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger result = [[responseObject objectForKey:@"result"] integerValue];
        if (result==100) {
            NSArray *resultData = [responseObject objectForKey:@"resultData"];
            if(resultData){
                success(resultData);
            }
        }else{
            success(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        success(nil);
    }];
}

+ (void)deleteUserAlbum:(long)albumId uid:(long)uid success:(void(^)(BOOL success))success{
    NSString *url = [uyoung_host stringByAppendingString:@"album/deleteById"];
    
    NSDictionary *parameters = @{@"id":@(albumId), @"uid":@(uid)};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger result = [[responseObject objectForKey:@"result"] integerValue];
        if (result==100) {
            success(YES);
        }else{
            success(NO);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        success(NO);
    }];
}

+ (void)deleteAlbumPhoto:(NSMutableString*)ids success:(void(^)(BOOL success))success{
    NSString *url = [uyoung_host stringByAppendingString:@"photo/deleteById"];
    
    NSMutableString *allId = [[NSMutableString alloc]initWithString:ids];
    if ([allId hasSuffix:@","]&&allId.length>1) {
        [allId deleteCharactersInRange:NSMakeRange([allId length]-1, 1)];
    }
    if ([allId hasPrefix:@","]) {
        [allId deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    NSDictionary *parameters = @{@"ids":allId};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger result = [[responseObject objectForKey:@"result"] integerValue];
        if (result==100) {
            success(YES);
        }else{
            success(NO);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        success(NO);
    }];
}

@end
