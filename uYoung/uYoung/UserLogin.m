//
//  UserLogin.m
//  uYoung
//
//  Created by 独自天涯 on 15/11/2.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "UserLogin.h"

@implementation UserLogin

+ (void)postThirdTypeLoginData:(NSDictionary*)dict{
    
    NSString *url = [uyoung_host stringByAppendingString:@"/third/login"];
    
    NSDictionary *parameters = dict;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger result = [[responseObject objectForKey:@"result"] integerValue];
        if (result==100) {
            NSInteger uid = [[responseObject objectForKey:@"resultData"] integerValue];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"postThirdData" object:@(uid)];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
