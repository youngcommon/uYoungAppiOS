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
#import "NSString+StringUtil.h"

@implementation UIImageView (LazyInit)

- (void)lazyInitSmallImageWithUrl:(NSString*)url suffix:(NSString*)suffix{
    __weak UIImageView *img = self;
    if ([NSString isBlankString:url]==NO) {
        url = [NSString stringWithFormat:@"%@-%@", url, suffix];
        NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        [self setImageWithURLRequest:theRequest placeholderImage:[UIImage imageNamed:UserDefaultHeader] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
            [img setImage:image];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
            [img setImage:[UIImage imageNamed:UserDefaultHeader]];
        }];
    }
}

@end
