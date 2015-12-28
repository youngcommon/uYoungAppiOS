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
#import <UIImageView+AFNetworking.h>

@implementation UploadImageUtil

+ (instancetype)dispatchOnce{
    static UploadImageUtil *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

- (void)uploadImage:(UIImage*)img withKey:(NSString*)key delegate:(id<UploadImgDelegate>)delegate{
    
    _img = img;
    _key = key;
    _delegate = delegate;
    
    NSString *url = [uyoung_host stringByAppendingString:@"/qn/qnUpToken"];
    
    NSString *md5Format = @"%@uYoungSign_QNToken%d";
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]initWithCapacity:3];
    
    //imei
    NSString *imei = [[[UIDevice currentDevice]identifierForVendor]UUIDString];
    //timestamp
    long timestamp = [[NSDate date] timeIntervalSince1970];
    NSString *sign = [[NSString stringWithFormat:md5Format, imei, timestamp] stringToMD5];
    [parameters setValue:sign forKey:@"sign"];
    [parameters setValue:imei forKey:@"deviceId"];
    [parameters setValue:@(timestamp) forKey:@"timestamp"];
    [parameters setValue:key forKey:@"key"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger result = [[responseObject objectForKey:@"result"] integerValue];
        if (result==100) {
            NSDictionary *data = [responseObject objectForKey:@"resultData"];
            [self successGetQNToken:data];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

-(void)successGetQNToken:(NSDictionary*)dict{
    NSString *token = dict[@"upToken"];
    NSString *qiniuHost = [@"http://" stringByAppendingString:dict[@"url"]];
    if ([NSString isBlankString:token]) {
        return;
    }
    
    [self saveQiniuHost:qiniuHost];
    
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    NSData *data = UIImageJPEGRepresentation(_img, 1.0);
    NSNumber *num = @([data length]);
    long length = [num longValue]/(1000*1000);
    if(length>6){//如果上传的照片大于6M，则进行压缩
        data = UIImageJPEGRepresentation(_img, 0.8);
    }

    [upManager putData:data key:_key token:token complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        [_delegate getImgKey:key host:qiniuHost];
    } option:nil];
    
}

- (void)saveQiniuHost:(NSString*)host{
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:host];
    [[NSUserDefaults standardUserDefaults] setObject:archivedData forKey:@"qiniu_host"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)lazyInitAvatarOfButton:(NSString*)url button:(UIButton*)button{
    __weak UIButton *weakB = button;
    long timer = [[NSDate date] timeIntervalSince1970];
    NSString *avatarUrl = [NSString stringWithFormat:@"%@-%@?%ld", url, @"actdesc200", timer];
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:avatarUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [button.imageView setImageWithURLRequest:theRequest placeholderImage:[UIImage imageNamed:UserDefaultHeader] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
        [weakB setBackgroundImage:image forState:UIControlStateNormal];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
        UIImage *img = [UIImage imageNamed:UserDefaultHeader];
        [weakB setBackgroundImage:img forState:UIControlStateNormal];
    }];
}

@end
