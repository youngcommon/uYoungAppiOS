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
-(void)successGetActTypes:(NSArray*)arr;
-(void)successGetActStatus:(NSArray*)arr;
@end

@interface GlobalNetwork : NSObject

+ (void)getAllActTypes:(id<GlobalNetworkDelegate>)delegate;
+ (void)getAllCityies:(id<GlobalNetworkDelegate>)delegate;
+ (void)getAllActStatus:(id<GlobalNetworkDelegate>)delegate;

@end
