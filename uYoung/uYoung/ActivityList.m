//
//  ActivityList.m
//  uYoung
//
//  Created by CSDN on 15/10/9.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "ActivityList.h"
#import "Des3Encrypt.h"

@implementation ActivityList

+ (void)getActivityListWithParam:(NSDictionary*)param isTop:(BOOL)isTop delegate:(id<ActivityListDelegate>)delegate{
    //参数过滤
    NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithDictionary:param];
    NSInteger isFree = [[params objectForKey:@"feeType"]integerValue];
    if (isFree==1) {
        [params removeObjectForKey:@"feeType"];
    }
    NSInteger actType = [[params objectForKey:@"activityType"]integerValue];
    if (actType==-1) {
        [params removeObjectForKey:@"activityType"];
    }
    NSInteger status = [[params objectForKey:@"status"]integerValue];
    if (status==-1) {
        [params removeObjectForKey:@"status"];
    }
    long userid = [[params objectForKey:@"creatorUid"]longValue];
    if (userid<=0) {
        [params removeObjectForKey:@"creatorUid"];
    }
    
    NSString *stamp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date]timeIntervalSince1970]];
    NSDictionary *encrypt = [Des3Encrypt getEncryptParams:params stamp:stamp];
    
    NSString *url = [uyoung_host stringByAppendingString:@"activity/getPageByCondition"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager GET:url parameters:encrypt success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger result = [[responseObject objectForKey:@"result"] integerValue];
        if(result==100){//说明获得正确结果
            NSDictionary *resultData = [responseObject objectForKey:@"resultData"];
            if(resultData){
                NSArray *a = (NSArray*)[resultData objectForKey:@"dataList"];
                if (isTop) {
                    [delegate insertRowAtTop:a];
                }else{
                    [delegate insertRowAtBottom:a hasError:NO];
                }
            }else{
                if (isTop) {
                    [delegate insertRowAtTop:nil];
                }else{
                    [delegate insertRowAtBottom:nil hasError:YES];
                }
            }
        }else{
            if (isTop) {
                [delegate insertRowAtTop:nil];
            }else{
                [delegate insertRowAtBottom:nil hasError:YES];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (isTop) {
            [delegate insertRowAtTop:nil];
        }else{
            [delegate insertRowAtBottom:nil hasError:YES];
        }
    }];
    
}

+ (void)getActivityListWithPageNum:(NSInteger)pageNum status:(NSInteger)status isTop:(BOOL)isTop{
    if(pageNum<=0){
        pageNum = 1;
    }
    
    NSString *url = [uyoung_host stringByAppendingString:@"activity/getPageByStatus"];
    
    NSDictionary *parameters = @{@"pageNum": [NSString stringWithFormat:@"%d", (int)pageNum],
                                 @"pageSize":[NSString stringWithFormat:@"%d", (int)pageSize],
                                 @"status": [NSString stringWithFormat:@"%d", (int)status]};
    
    NSString *stamp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date]timeIntervalSince1970]];
    NSDictionary *encrypt = [Des3Encrypt getEncryptParams:parameters stamp:stamp];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager GET:url parameters:encrypt success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
