//
//  PhotoDownload.h
//  uYoung
//
//  Created by 独自天涯 on 15/12/22.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import <UIImageView+AFNetworking.h>

@protocol PhotoDownloadDelegate <NSObject>

@optional
- (void)downloadExifFinish:(NSDictionary*)dict;
@end

@interface PhotoDownload : NSObject

+ (void)downloadPhotoExif:(NSString*)url delegate:(id<PhotoDownloadDelegate>)delegate;

+ (void)getDownloadUrl:(long)photoId finish:(void (^)(NSString *downloadUrl, NSString *exifUrl))finish;

+ (void)photoIsLike:(long)uid photoId:(long)photoId ops:(void (^)(BOOL isLike))ops;

+ (void)photoLike:(long)uid photoId:(long)photoId;

@end
