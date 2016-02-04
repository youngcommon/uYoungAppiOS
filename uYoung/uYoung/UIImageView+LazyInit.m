//
//  UIImageView+LazyInit.m
//  uYoung
//
//  Created by CSDN on 15/12/7.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "UIImageView+LazyInit.h"
#import <UIImageView+AFNetworking.h>
#import "GlobalConfig.h"
#import "UIImageView+WebCache.h"
#import "NSString+StringUtil.h"

@implementation UIImageView (LazyInit)

- (void)lazyInitSmallImageWithUrl:(NSString*)url suffix:(NSString*)suffix{
    [self lazyInitSmallImageWithUrl:url suffix:suffix placeholdImg:UserDefaultHeader];
}

/*- (void)lazyInitSmallImageWithUrl:(NSString*)url suffix:(NSString*)suffix placeholdImg:(NSString*)imagenamed{
    __weak UIImageView *img = self;
    if ([NSString isBlankString:url]==NO) {
        url = [NSString stringWithFormat:@"%@-%@", url, suffix];
        NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        [self setImageWithURLRequest:theRequest placeholderImage:[UIImage imageNamed:imagenamed] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
            [img setImage:image];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
            [img setImage:[UIImage imageNamed:imagenamed]];
        }];
    }else{
        [self setImage:[UIImage imageNamed:imagenamed]];
    }
}*/

- (void)lazyInitSmallImageWithUrl:(NSString*)url suffix:(NSString*)suffix placeholdImg:(NSString*)imagenamed{
    __weak UIImageView *img = self;
    if ([NSString isBlankString:url]==NO) {
        NSRange range = [url rangeOfString:QINIU_DEFAULT_HOST];
        if (range.length) {//说明是七牛云的头像
            url = [NSString stringWithFormat:@"%@-%@", url, suffix];
        }
//        SDWebImageManager *manager = [SDWebImageManager sharedManager];
//        BOOL isCached = [manager cachedImageExistsForURL:[NSURL URLWithString:url]];
//        NSLog(@"##图片:%@-->##%@", url, isCached?@"已缓存":@"未缓存");
        [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:imagenamed] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
            if (error!=nil&&image==nil) {
                [img setImage:[UIImage imageNamed:imagenamed]];
            }else{
                [img setImage:image];
            }
        }];
    }else{
        [self setImage:[UIImage imageNamed:imagenamed]];
    }
}

@end
