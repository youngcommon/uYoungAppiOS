//
//  UpdateUser.m
//  uYoung
//
//  Created by 独自天涯 on 15/11/16.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "UpdateUser.h"
#import "Des3Encrypt.h"

@implementation UpdateUser

+ (void)updateUserWithDictionary:(NSDictionary*)dict delegate:(id<UpdateUserDelegate>)delegate{
    
    NSString *url = [uyoung_host stringByAppendingString:@"userInfo/updateById"];
    
//    NSString *stamp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date]timeIntervalSince1970]];
//    NSDictionary *encrypt = [Des3Encrypt getEncryptParams:dict stamp:stamp];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger result = [[responseObject objectForKey:@"result"] integerValue];
        if (result==100) {
            [delegate didUpdateEnd:YES];
        }else if(result==NOT_LOGIN){
            [[NSNotificationCenter defaultCenter] postNotificationName:NOT_LOGIN_NOTICE object:nil];
        }else{
            [delegate didUpdateEnd:NO];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [delegate didUpdateEnd:NO];
    }];
    
}

@end
