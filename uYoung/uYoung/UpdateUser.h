//
//  UpdateUser.h
//  uYoung
//
//  Created by 独自天涯 on 15/11/16.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <AFNetworking.h>
#import "GlobalConfig.h"

@protocol UpdateUserDelegate <NSObject>
@optional
- (void)didUpdateEnd:(BOOL)isSuccess;

@end

@interface UpdateUser : NSObject

+ (void)updateUserWithDictionary:(NSDictionary*)dict delegate:(id<UpdateUserDelegate>)delegate;

@end
