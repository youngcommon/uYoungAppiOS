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

+ (void)getAllActTypes:(id<GlobalNetworkDelegate>)delegate{
    NSString *url = [uyoung_host stringByAppendingString:@"activity/types"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger result = [[responseObject objectForKey:@"result"] integerValue];
        if (result==100) {
            NSArray *types = [responseObject objectForKey:@"resultData"];
            [delegate successGetActTypes:types];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    
}

+ (void)getAllCityies:(id<GlobalNetworkDelegate>)delegate{
    NSString *url = [uyoung_host stringByAppendingString:@"common/cities"];
    
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
            NSArray *cities = [responseObject objectForKey:@"resultData"];
            [delegate successGetCities:cities];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];

}

+ (void)getAllActStatus:(id<GlobalNetworkDelegate>)delegate{
    NSString *url = [uyoung_host stringByAppendingString:@"activity/statuses"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger result = [[responseObject objectForKey:@"result"] integerValue];
        if (result==100) {
            NSArray *status = [responseObject objectForKey:@"resultData"];
            [delegate successGetActStatus:status];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

@end
