//
//  UserLogin.h
//  uYoung
//
//  Created by 独自天涯 on 15/11/2.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "GlobalConfig.h"

@protocol UserLoginDelegate <NSObject>
@optional
- (void)postThirdData:(NSInteger)uid;

@end

@interface UserLogin : NSObject

+ (void)postThirdTypeLoginData:(NSDictionary*)dict delegate:(id<UserLoginDelegate>)delegate;

+ (void)loginWithEmailAndPwd:(NSString*)email pwd:(NSString*)pwd success:(void(^)(NSInteger uid))success;

+ (void)userRegisterWithEmailAndPwd:(NSString*)email pwd:(NSString*)pwd nickname:(NSString*)nickname success:(void(^)(NSInteger uid))success;

@end
