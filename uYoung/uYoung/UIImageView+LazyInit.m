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

@implementation UIImageView (LazyInit)

- (void)lazyInitSmallImageWithUrl:(NSString*)url{
    __weak UIImageView *img = self;
    url = [NSString stringWithFormat:@"%@-actdesc200", url];
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [self setImageWithURLRequest:theRequest placeholderImage:[UIImage imageNamed:UserDefaultHeader] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
        [img setImage:image];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
        [img setImage:[UIImage imageNamed:UserDefaultHeader]];
    }];
}

@end
