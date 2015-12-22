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
#import "PhotoDetailModel.h"

@protocol CreateAlbumDelegate <NSObject>

@optional
- (void)successCreateAlbum:(AlbumDetailModel*)detail;
- (void)finishUploadImage:(PhotoDetailModel*)result;
@end

@interface CreateAlbum : NSObject

+ (void)createAlbum:(NSDictionary*)dict delegate:(id<CreateAlbumDelegate>)delegate;
+ (void)uploadAlbumImage:(NSArray*)arr delegate:(id<CreateAlbumDelegate>)delegate;

@end
