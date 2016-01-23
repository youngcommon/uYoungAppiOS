//
//  AlbumDetail.m
//  uYoung
//
//  Created by 独自天涯 on 15/12/9.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "AlbumDetail.h"
#import "GlobalConfig.h"
#import "Des3Encrypt.h"

@implementation AlbumDetail

+ (void)getAlbumDetailByAlbumId:(long)albumId delegate:(id<AlbumDetailDelegate>)delegate{
    NSDictionary *parameters = @{@"albumId": @(albumId)};
    
    NSString *stamp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date]timeIntervalSince1970]];
    NSDictionary *encrypt = [Des3Encrypt getEncryptParams:parameters stamp:stamp];
    
    NSString *url = [uyoung_host stringByAppendingString:@"album/getDetailById"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager POST:url parameters:encrypt success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger result = [[responseObject objectForKey:@"result"] integerValue];
        if (result==100) {
            NSDictionary *resultData = [responseObject objectForKey:@"resultData"];
            if (resultData!=nil&&![resultData isEqual:[NSNull null]]) {
                AlbumDetailModel *detail = [MTLJSONAdapter modelOfClass:[AlbumDetailModel class] fromJSONDictionary:resultData error:nil];
                [delegate successGetAlbumDetail:detail];
            }else{
                [delegate successGetAlbumDetail:nil];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [delegate successGetAlbumDetail:nil];
    }];
}

@end
