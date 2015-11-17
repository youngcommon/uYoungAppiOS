//
//  UploadImageUtil.m
//  uYoung
//
//  Created by CSDN on 15/11/17.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "UploadImageUtil.h"

@implementation UploadImageUtil

+(void)uploadImage:(UIImage*)img withKey:(NSString*)key delegate:(id<UploadImgDelegate>)delegate{
    NSString *token = @"";
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    NSData *data = UIImageJPEGRepresentation(img, 1.0);
    [upManager putData:data key:key token:token complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        NSLog(@"%@", info);
        NSLog(@"%@", resp);
        [delegate getImgUrl:resp[@"url"]];
    } option:nil];
}

@end
