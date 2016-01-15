//
//  ActivityList.h
//  uYoung
//
//  Created by CSDN on 15/10/9.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "GlobalConfig.h"

@protocol ActivityListDelegate <NSObject>

@optional
- (void)insertRowAtTop:(NSArray*)data;
- (void)insertRowAtBottom:(NSArray*)data hasError:(BOOL)error;

@end

@interface ActivityList : NSObject

+ (void)getActivityListWithParam:(NSDictionary*)param isTop:(BOOL)isTop delegate:(id<ActivityListDelegate>)delegate;
//+ (void)getActivityListWithPageNum:(NSInteger)pageNum status:(NSInteger)status isTop:(BOOL)isTop;

@end
