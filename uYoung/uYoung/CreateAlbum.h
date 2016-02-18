//
//  CreateAlbum.h
//  uYoung
//
//  Created by CSDN on 15/12/11.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import <AFHTTPRequestOperationManager+Synchronous.h>
#import "AlbumModel.h"
#import "PhotoDetailModel.h"

@protocol CreateAlbumDelegate <NSObject>

@optional
- (void)successCreateAlbum:(AlbumModel*)detail;
- (void)finishUploadImage:(PhotoDetailModel*)result;
@end

@interface CreateAlbum : NSObject

+ (void)createAlbum:(NSDictionary*)dict delegate:(id<CreateAlbumDelegate>)delegate;
+ (void)uploadAlbumImage:(NSArray*)arr delegate:(id<CreateAlbumDelegate>)delegate;
+ (void)updateAlbumCover:(NSString*)coverUrl albumId:(long)albumId success:(void(^)(BOOL success))success;

@end
