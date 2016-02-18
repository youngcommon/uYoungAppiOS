//
//  UploadImageUtil.h
//  uYoung
//
//  Created by CSDN on 15/11/17.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QiniuSDK.h>
#import <AFNetworking.h>
#import <AFHTTPRequestOperationManager+Synchronous.h>
#import "PicExif.h"

@protocol UploadImgDelegate <NSObject>

@optional
- (void)getImgKey:(NSString*)key host:(NSString*)host exif:(PicExif*)exif;

@end

@interface UploadImageUtil : NSObject

- (void)uploadAlbumImage:(UIImage*)img withKey:(NSString*)key exif:(PicExif*)exif delegate:(id<UploadImgDelegate>)delegate;

- (void)uploadImage:(UIImage*)img withKey:(NSString*)key exif:(PicExif*)exif delegate:(id<UploadImgDelegate>)delegate;

+ (void)lazyInitAvatarOfButton:(NSString*)url button:(UIButton*)button;

+ (instancetype)dispatchOnce;

@end
