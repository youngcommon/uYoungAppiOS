//
//  ActivityList.m
//  uYoung
//
//  Created by CSDN on 15/10/9.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "ActivityList.h"

@implementation ActivityList

+ (void)getActivityListWithPageNum:(NSInteger)pageNum status:(NSInteger)status isTop:(BOOL)isTop{
    if(pageNum<=0){
        pageNum = 1;
    }
    
    NSString *url = [uyoung_host stringByAppendingString:@"activity/getPageByStatus"];
    
    NSDictionary *parameters = @{@"pageNum": [NSString stringWithFormat:@"%d", (int)pageNum],
                                 @"pageSize":[NSString stringWithFormat:@"%d", (int)pageSize],
                                 @"status": [NSString stringWithFormat:@"%d", (int)status]};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger result = [[responseObject objectForKey:@"result"] integerValue];
        if(result==100){//说明获得正确结果
            NSDictionary *resultData = [responseObject objectForKey:@"resultData"];
            if(resultData){
                NSArray *a = (NSArray*)[resultData objectForKey:@"dataList"];
                if (isTop) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"insertRowAtTop" object:a];
                }else{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"insertRowAtBottom" object:a];
                }
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

@end
