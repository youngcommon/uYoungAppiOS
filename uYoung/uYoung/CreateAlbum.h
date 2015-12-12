//
//  CreateAlbum.h
//  uYoung
//
//  Created by CSDN on 15/12/11.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "AlbumDetailModel.h"

@protocol CreateAlbumDelegate <NSObject>

@optional
- (void)successCreateAlbum:(AlbumDetailModel*)detail;
@end

@interface CreateAlbum : NSObject

+ (void)createAlbum:(NSDictionary*)dict delegate:(id<CreateAlbumDelegate>)delegate;

@end
