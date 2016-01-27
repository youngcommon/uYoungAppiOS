//
//  UserLogin.m
//  uYoung
//
//  Created by 独自天涯 on 15/11/2.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "UserLogin.h"
#import "Des3Encrypt.h"

@implementation UserLogin

+ (void)postThirdTypeLoginData:(NSDictionary*)dict delegate:(id<UserLoginDelegate>)delegate{
    
    NSString *url = [uyoung_host stringByAppendingString:@"/third/login"];
    
//    NSString *stamp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date]timeIntervalSince1970]];
//    NSDictionary *encrypt = [Des3Encrypt getEncryptParams:dict stamp:stamp];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger result = [[responseObject objectForKey:@"result"] integerValue];
        if (result==100) {
            NSDictionary *dict = [responseObject objectForKey:@"resultData"];
            NSString *sessionid = dict[@"sessionId"];
            NSInteger uid = [dict[@"uid"]integerValue];
            NSData *sessiondata = [NSKeyedArchiver archivedDataWithRootObject:sessionid];
            [[NSUserDefaults standardUserDefaults] setObject:sessiondata forKey:@"sessionid"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [delegate postThirdData:uid];
        }else{
            [delegate postThirdData:0];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [delegate postThirdData:0];
    }];
}

+ (void)loginWithEmailAndPwd:(NSString*)email pwd:(NSString*)pwd success:(void(^)(NSInteger uid))success{
    NSString *url = [uyoung_host stringByAppendingString:@"login"];
    
    NSDictionary *parameters = @{@"email":email, @"password":pwd};
    
//    NSString *stamp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date]timeIntervalSince1970]];
//    NSDictionary *encrypt = [Des3Encrypt getEncryptParams:parameters stamp:stamp];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger result = [[responseObject objectForKey:@"result"] integerValue];
        if (result==100) {
            NSDictionary *dict = [responseObject objectForKey:@"resultData"];
            NSString *sessionid = dict[@"sessionId"];
            NSInteger uid = [dict[@"uid"]integerValue];
            
            NSData *sessiondata = [NSKeyedArchiver archivedDataWithRootObject:sessionid];
            [[NSUserDefaults standardUserDefaults] setObject:sessiondata forKey:@"sessionid"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            success(uid);
        }else{
            success(0);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        success(0);
    }];
}

+ (void)userRegisterWithEmailAndPwd:(NSString*)email pwd:(NSString*)pwd nickname:(NSString*)nickname success:(void(^)(BOOL isSuccess, NSString *msg))success{
    NSString *url = [uyoung_host stringByAppendingString:@"reg/reg"];
    
    NSDictionary *parameters = @{@"email":email, @"password":pwd, @"nickName":nickname};
    
//    NSString *stamp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date]timeIntervalSince1970]];
//    NSDictionary *encrypt = [Des3Encrypt getEncryptParams:parameters stamp:stamp];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger result = [[responseObject objectForKey:@"result"] integerValue];
        if (result==100) {
            success(YES, @"");
        }else{
            success(NO, @"");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        success(NO, @"网络错误，请稍后再试");
    }];
}

@end
