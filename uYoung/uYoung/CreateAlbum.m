//
//  CreateAlbum.m
//  uYoung
//
//  Created by CSDN on 15/12/11.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "CreateAlbum.h"
#import "GlobalConfig.h"
#import "Des3Encrypt.h"

@implementation CreateAlbum

+ (void)createAlbum:(NSDictionary*)dict delegate:(id<CreateAlbumDelegate>)delegate{
    
    NSString *url = [uyoung_host stringByAppendingString:@"album/add"];
    
//    NSString *stamp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date]timeIntervalSince1970]];
//    NSDictionary *encrypt = [Des3Encrypt getEncryptParams:dict stamp:stamp];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger result = [[responseObject objectForKey:@"result"] integerValue];
        if (result==100) {
            NSDictionary *resultData = [responseObject objectForKey:@"resultData"];
            NSMutableDictionary *data = [[NSMutableDictionary alloc]initWithDictionary:resultData];
            [data removeObjectForKey:@"createTime"];
            AlbumModel *detail = [MTLJSONAdapter modelOfClass:[AlbumModel class] fromJSONDictionary:data error:nil];
            [delegate successCreateAlbum:detail];
        }else if(result==NOT_LOGIN){
            [[NSNotificationCenter defaultCenter] postNotificationName:NOT_LOGIN_NOTICE object:nil];
        }else{
            [delegate successCreateAlbum:nil];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [delegate successCreateAlbum:nil];
    }];
}

@end
