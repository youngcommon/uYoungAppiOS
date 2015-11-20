//
//  GlobalNetwork.h
//  uYoung
//
//  Created by 独自天涯 on 15/11/17.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <AFNetworking.h>
#import "GlobalConfig.h"

@protocol GlobalNetworkDelegate <NSObject>

@optional
-(void)successGetCities:(NSArray*)arr;

@end

@interface GlobalNetwork : NSObject

+ (void)getAllCityies:(id<GlobalNetworkDelegate>)delegate;

@end
