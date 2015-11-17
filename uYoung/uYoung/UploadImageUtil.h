//
//  UploadImageUtil.h
//  uYoung
//
//  Created by CSDN on 15/11/17.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QiniuSDK.h>

@protocol UploadImgDelegate <NSObject>

@optional
- (void)getImgUrl:(NSString*)url;

@end

@interface UploadImageUtil : NSObject

+(void)uploadImage:(UIImage*)img withKey:(NSString*)key delegate:(id<UploadImgDelegate>)delegate;

@end
