//
//  ActivityPublish.h
//  uYoung
//
//  Created by CSDN on 15/12/4.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "GlobalConfig.h"

@protocol ActivityPublishDelegate <NSObject>

@optional
-(void)publishEnd:(BOOL)isSuccess;
@end

@interface ActivityPublish : NSObject

+ (void)publishActWithDict:(NSDictionary*)dict delegate:(id<ActivityPublishDelegate>)delegate;

@end
