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

@interface ActivityList : NSObject

+ (void)getActivityListWithPageNum:(NSInteger)pageNum status:(NSInteger)status isTop:(BOOL)isTop;

@end
