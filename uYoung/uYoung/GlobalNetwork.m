//
//  GlobalNetwork.m
//  uYoung
//
//  Created by 独自天涯 on 15/11/17.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "GlobalNetwork.h"
#import "NSString+StringUtil.h"

@implementation GlobalNetwork

+ (void)getQNUploadToken:(id<GlobalNetworkDelegate>)delegate{
    NSString *url = [uyoung_host stringByAppendingString:@"/common/qnUpToken"];
    
    NSString *md5Format = @"%@uYoungSign_QNToken%d";
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]initWithCapacity:3];
    
    //imei
    NSString *imei = [[[UIDevice currentDevice]identifierForVendor]UUIDString];
    //timestamp
    long timestamp = [[NSDate date] timeIntervalSince1970];
    NSString *sign = [[NSString stringWithFormat:md5Format, imei, timestamp] stringToMD5];
    [parameters setValue:sign forKey:@"sign"];
    [parameters setValue:imei forKey:@"deviceId"];
    [parameters setValue:@(timestamp) forKey:@"timestamp"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger result = [[responseObject objectForKey:@"result"] integerValue];
        if (result==100) {
            NSString *token = [responseObject objectForKey:@"resultData"];
            [delegate successGetQNToken:token];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

@end
