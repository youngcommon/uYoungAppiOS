//
//  UploadImageUtil.h
//  uYoung
//
//  Created by CSDN on 15/11/17.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QiniuSDK.h>
#import "GlobalNetwork.h"

@protocol UploadImgDelegate <NSObject>

@optional
- (void)getImgKey:(NSString*)key host:(NSString*)host;

@end

@interface UploadImageUtil : NSObject

- (void)uploadImage:(UIImage*)img withKey:(NSString*)key delegate:(id<UploadImgDelegate>)delegate;

+ (void)lazyInitAvatarOfButton:(NSString*)url button:(UIButton*)button;

+ (instancetype)dispatchOnce;

@end
