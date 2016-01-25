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
#import <UIImageView+WebCache.h>
#import "Des3Encrypt.h"

@implementation UploadImageUtil

+ (instancetype)dispatchOnce{
    static UploadImageUtil *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

- (void)uploadImage:(UIImage*)img withKey:(NSString*)key exif:(PicExif*)exif delegate:(id<UploadImgDelegate>)delegate{
    
    NSString *url = [uyoung_host stringByAppendingString:@"/qn/qnUpToken"];
    
    //imei
    NSString *imei = [[[UIDevice currentDevice]identifierForVendor]UUIDString];
    
    NSString *stamp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date]timeIntervalSince1970]];
    NSDictionary *encrypt = [Des3Encrypt getEncryptParams:@{@"deviceId":imei, @"key":key} stamp:stamp];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager POST:url parameters:encrypt success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger result = [[responseObject objectForKey:@"result"] integerValue];
        if (result==100) {
            NSDictionary *data = [responseObject objectForKey:@"resultData"];
            [self successGetQNToken:data withKey:key andImg:img exif:exif delegate:delegate];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

-(void)successGetQNToken:(NSDictionary*)dict withKey:(NSString*)key andImg:(UIImage*)img exif:(PicExif*)exif delegate:(id<UploadImgDelegate>)delegate;{
    NSString *token = dict[@"upToken"];
    NSString *qiniuHost = dict[@"url"];
    if ([NSString isBlankString:token]) {
        return;
    }
    
    [self saveQiniuHost:qiniuHost];
    
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    NSData *data = UIImageJPEGRepresentation(img, 1.0);
    NSNumber *num = @([data length]);
    long length = [num longValue]/(1000*1000);
    if(length>6){//如果上传的照片大于6M，则进行压缩
        data = UIImageJPEGRepresentation(img, 0.8);
    }
    
    /*QNUploadOption *option = [[QNUploadOption alloc]initWithProgressHandler:^(NSString *key, float percent) {
        NSLog(@"##UploadImg-->key:%@; percent:%f", key, percent);
    }];*/
    
    __block BOOL flag = NO;
    QNUploadOption *option = [[QNUploadOption alloc]initWithMime:nil progressHandler:nil params:nil checkCrc:YES cancellationSignal:^BOOL{
        return flag;
    }];

    [upManager putData:data key:key token:token complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        [delegate getImgKey:key host:qiniuHost exif:exif];
    } option:option];
    
}

- (void)saveQiniuHost:(NSString*)host{
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:host];
    [[NSUserDefaults standardUserDefaults] setObject:archivedData forKey:@"qiniu_host"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)lazyInitAvatarOfButton:(NSString*)url button:(UIButton*)button{
    __weak UIButton *weakB = button;
    NSRange range = [url rangeOfString:QINIU_DEFAULT_HOST];
    if (range.length) {//说明是七牛云的头像
        long timer = [[NSDate date] timeIntervalSince1970];
        url = [NSString stringWithFormat:@"%@-%@?%ld", url, @"actdesc200", timer];
    }    [button.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:UserDefaultHeader] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        [weakB setBackgroundImage:image forState:UIControlStateNormal];
    }];
    
}

@end
