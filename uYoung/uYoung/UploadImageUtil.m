//
//  UploadImageUtil.m
//  uYoung
//
//  Created by CSDN on 15/11/17.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "UploadImageUtil.h"
#import "GlobalConfig.h"
#import "NSString+StringUtil.h"

@implementation UploadImageUtil

+(void)uploadImage:(UIImage*)img withKey:(NSString*)key delegate:(id<UploadImgDelegate>)delegate{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:QINIU_TOKEN];
    if ([NSString isBlankString:token]) {
        return;
    }
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    NSData *data = UIImageJPEGRepresentation(img, 1.0);
    [upManager putData:data key:key token:token complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        NSString *qiniuHost = [[NSUserDefaults standardUserDefaults] objectForKey:QINIU_HOST];
        NSString *url = [[qiniuHost stringByAppendingString:@"/"]stringByAppendingString:key];
        [delegate getImgUrl:url];
    } option:nil];
}

@end
