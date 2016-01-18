//
//  EnrollCollectionCell.m
//  uYoung
//
//  Created by CSDN on 15/10/18.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "EnrollCollectionCell.h"
#import <UIImageView+AFNetworking.h>
#import "UIImageView+LazyInit.h"

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
    
    [_enrollUserHeader lazyInitSmallImageWithUrl:_enrollUser.avatar suffix:@"actdesc200"];
    
    NSString *nickName = _enrollUser.nickName;
    if (nickName==nil) {
        nickName = @"这里是昵称";
    }
    [_enrollUserNick setText:nickName];
    
    [_isConfirmLabel setHidden:!model.confirm];
}

@end
