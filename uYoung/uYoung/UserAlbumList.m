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
                if (arr!=nil&&![arr isEqual:[NSNull null]]&&arr!=NULL&&[arr count]>0) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"userAlbumList" object:arr];
                }
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
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
        NSLog(@"##deleteUserAlbum--->%@", responseObject);
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
