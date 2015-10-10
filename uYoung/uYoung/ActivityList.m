//
//  ActivityList.m
//  uYoung
//
//  Created by CSDN on 15/10/9.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "ActivityList.h"

@implementation ActivityList

+ (NSMutableArray*)getActivityListWithPageNum:(NSInteger)pageNum status:(NSInteger)status{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:15];
    
    NSString *url = [uyoung_host stringByAppendingString:@"activity/getPageByStatus"];
//    url = @"http://ms.csdn.net/proxy/all_questions";
    
    NSDictionary *parameters = @{@"pageNum": [NSString stringWithFormat:@"%ld", pageNum],
                                 @"pageSize": @"15",
                                 @"status": [NSString stringWithFormat:@"%ld", status]};
    
//    parameters = @{@"page":@"1"};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        NSString *str = [responseObject objectForKey:@"KEY 1"];
        NSArray *arr = [responseObject objectForKey:@"KEY 2"];
        NSDictionary *dic = [responseObject objectForKey:@"KEY 3"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    return arr;
}


@end
