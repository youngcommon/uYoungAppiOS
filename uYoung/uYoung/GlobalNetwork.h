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
-(void)successGetQNToken:(NSString*)token;

@end

@interface GlobalNetwork : NSObject

+ (void)getQNUploadToken:(id<GlobalNetworkDelegate>)delegate;

@end
