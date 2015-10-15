//
//  ActivityList.m
//  uYoung
//
//  Created by CSDN on 15/10/9.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "ActivityList.h"

@implementation ActivityList

+ (void)getActivityListWithPageNum:(NSInteger)pageNum status:(NSInteger)status{
    if(pageNum<=0){
        pageNum = 1;
    }
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:15];
    
    NSString *url = [uyoung_host stringByAppendingString:@"activity/getPageByStatus"];
    
    NSDictionary *parameters = @{@"pageNum": [NSString stringWithFormat:@"%ld", pageNum],
                                 @"pageSize": @"15",
                                 @"status": [NSString stringWithFormat:@"%ld", status]};
    
    __weak NSMutableArray *weakarr = arr;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSInteger result = [[responseObject objectForKey:@"result"] integerValue];
        if(result==100){//说明获得正确结果
            NSDictionary *resultData = [responseObject objectForKey:@"resultData"];
            if(resultData){
                NSArray *a = (NSArray*)[resultData objectForKey:@"dataList"];
                for (NSInteger i=0; i<[a count]; i++) {
                    [weakarr addObject:a[i]];
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:@"loadedData" object:a];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
}

@end
