//
//  UserDetail.m
//  uYoung
//
//  Created by CSDN on 15/10/16.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "UserDetail.h"
#import "Des3Encrypt.h"

@implementation UserDetail

+ (void)getUserDetailWithId:(NSInteger)userId success:(void(^)(UserDetailModel *userDetailModel))success{
    NSString *url = [uyoung_host stringByAppendingString:@"userInfo/getByUid"];
    
    NSDictionary *parameters = @{@"uid": [NSString stringWithFormat:@"%d", (int)userId]};
    
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
                UserDetailModel *userDetailModel = [MTLJSONAdapter modelOfClass:[UserDetailModel class] fromJSONDictionary:resultData error:nil];
                success(userDetailModel);
            }else{
                success(nil);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        success(nil);
    }];
}


@end
