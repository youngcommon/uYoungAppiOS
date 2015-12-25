//
//  PhotoDownload.m
//  uYoung
//
//  Created by 独自天涯 on 15/12/22.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "PhotoDownload.h"
#import "GlobalConfig.h"

@implementation PhotoDownload

+ (void)downloadPhotoExif:(NSString*)url delegate:(id<PhotoDownloadDelegate>)delegate{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"7xnzko.com1.z0.glb.clouddn.com" forHTTPHeaderField:@"Host"];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [delegate downloadExifFinish:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [delegate downloadExifFinish:nil];
    }];
}

+ (void)getDownloadUrl:(long)photoId finish:(void (^)(NSString *downloadUrl, NSString *exifUrl))finish{
    NSString *url = [uyoung_host stringByAppendingString:@"photo/downloadUrl"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    NSDictionary *param = @{@"id": @(photoId)};
    
    [manager GET:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger result = [[responseObject objectForKey:@"result"] integerValue];
        if (result==100) {
            NSDictionary *resultData = [responseObject objectForKey:@"resultData"];
            NSString *downloadUrl = resultData[@"downLoadUrl"];
            NSString *exifUrl = resultData[@"exifUrl"];
            finish(downloadUrl, exifUrl);
        }else{
            finish(@"", @"");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        finish(@"", @"");
    }];
}

//获取用户是否like照片
+ (void)photoIsLike:(long)uid photoId:(long)photoId ops:(void (^)(BOOL isLike))ops{
    NSString *url = [uyoung_host stringByAppendingString:@"photoLike/get"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    NSDictionary *param = @{@"uid": @(uid), @"photoId":@(photoId)};
    
    [manager GET:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger result = [[responseObject objectForKey:@"result"] integerValue];
        if (result==100) {
            BOOL resultData = [[responseObject objectForKey:@"resultData"]boolValue];
            ops(resultData);
        }else{
            ops(NO);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ops(NO);
    }];
}

//like和unlike图片
+ (void)photoLike:(long)uid photoId:(long)photoId{
    NSString *url = [uyoung_host stringByAppendingString:@"photoLike/like"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *param = @{@"uid": @(uid), @"photoId":@(photoId)};
    
    [manager GET:url parameters:param success:nil failure:nil];
}

@end
