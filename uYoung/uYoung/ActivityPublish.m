//
//  ActivityPublish.m
//  uYoung
//
//  Created by CSDN on 15/12/4.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "ActivityPublish.h"

@implementation ActivityPublish

+ (void)publishActWithDict:(NSDictionary*)dict delegate:(id<ActivityPublishDelegate>)delegate{
    NSString *url = [uyoung_host stringByAppendingString:@"/activity/add"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger result = [[responseObject objectForKey:@"result"] integerValue];
        if (result==100) {
            [delegate publishEnd:YES];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [delegate publishEnd:NO];
    }];
}

@end
