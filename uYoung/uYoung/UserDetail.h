//
//  UserDetail.h
//  uYoung
//
//  Created by CSDN on 15/10/16.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "GlobalConfig.h"

@interface UserDetail : NSObject

+ (void)getUserDetailWithId:(NSInteger)userId;

@end
