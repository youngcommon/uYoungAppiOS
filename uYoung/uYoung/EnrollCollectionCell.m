//
//  EnrollCollectionCell.m
//  uYoung
//
//  Created by CSDN on 15/10/18.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "EnrollCollectionCell.h"
#import <UIImageView+AFNetworking.h>

@implementation EnrollCollectionCell

- (void)awakeFromNib{
    self.layer.borderColor = [UIColorFromRGB(0x85b200) CGColor];
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 4;
    _enrollUserHeader.layer.cornerRadius = _enrollUserHeader.frame.size.width / 2;
    _enrollUserHeader.layer.masksToBounds = YES;
    _enrollUserHeader.userInteractionEnabled = YES;
}

- (void)updateFrameWithModel:(ActivityDetailEnrollsModel*)model{
    _enrollUser = model;
    NSString *avatarUrl = _enrollUser.avatar;
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:avatarUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [_enrollUserHeader setImageWithURLRequest:theRequest placeholderImage:[UIImage imageNamed:UserDefaultHeader] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
        [_enrollUserHeader setImage:image];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
        [_enrollUserHeader setImage:[UIImage imageNamed:UserDefaultHeader]];
    }];
    
    NSString *nickName = _enrollUser.nickName;
    if (nickName==nil) {
        nickName = @"这里是昵称";
    }
    [_enrollUserNick setText:nickName];
}

@end
