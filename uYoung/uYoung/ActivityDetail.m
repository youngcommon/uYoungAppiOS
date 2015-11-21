//
//  ActivityDetail.m
//  uYoung
//
//  Created by CSDN on 15/10/16.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "ActivityDetail.h"

@implementation ActivityDetail

+ (void)getActivityDetailWithId:(NSInteger)activityId{
    NSString *url = [uyoung_host stringByAppendingString:@"activity/getById"];
    
    NSDictionary *parameters = @{@"id": [NSString stringWithFormat:@"%d", (int)activityId]};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger result = [[responseObject objectForKey:@"result"] integerValue];
        if(result==100){//说明获得正确结果
            NSDictionary *resultData = [responseObject objectForKey:@"resultData"];
            if(resultData){
                [[NSNotificationCenter defaultCenter] postNotificationName:@"fillActivityDetail" object:resultData];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
