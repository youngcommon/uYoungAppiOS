//
//  PhotoDownload.h
//  uYoung
//
//  Created by 独自天涯 on 15/12/22.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@protocol PhotoDownloadDelegate <NSObject>

@optional
- (void)downloadImageFinish:(UIImage*)image;
- (void)downloadExifFinish:(NSDictionary*)dict;
@end

@interface PhotoDownload : NSObject

+ (void)downloadPhotoExif:(NSString*)url delegate:(id<PhotoDownloadDelegate>)delegate;

@end
