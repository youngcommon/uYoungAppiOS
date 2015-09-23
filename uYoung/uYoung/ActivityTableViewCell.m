//
//  ActivityTableViewCell.m
//  uYoung
//
//  Created by CSDN on 15/9/21.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "ActivityTableViewCell.h"

@implementation ActivityTableViewCell

- (void)awakeFromNib {
    
    [self setBackgroundColor:[UIColor clearColor]];
    
    //设置活动类型边框
    self.actTypeLable.layer.borderWidth = 0.5;
    self.actTypeLable.layer.borderColor = [UIColorFromRGB(0x9B9B9B) CGColor];
    self.actTypeLable.layer.cornerRadius = 3;
    self.actTypeLable.layer.masksToBounds = YES;
    
    //设置用户头像边框
    self.headerImg.layer.borderWidth = 1;
    self.headerImg.layer.borderColor = [UIColorFromRGB(0x9B9B9B) CGColor];
    self.headerImg.layer.cornerRadius = 10;
    self.headerImg.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
