//
//  ActivityTableViewCell.m
//  uYoung
//
//  Created by CSDN on 15/9/21.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "ActivityTableViewCell.h"
#import <UIImageView+AFNetworking.h>

@implementation ActivityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
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

- (void) initWithActivityModel: (ActivityModel*)model{
    if(model.actType){
        self.actTypeLable.text = model.actType;
    }else{
        [self.actTypeLable setHighlighted:YES];
    }
    self.dayLabel.text = [NSString stringWithFormat:@"%i", model.day];
    self.monthLabel.text = [NSString stringWithFormat:@"%i月，",model.month];
    self.weekLabel.text = model.week;
    self.titleLabel.text = model.title;
    self.fromTimeLabel.text = model.fromTime;
    self.toTimeLabel.text = model.toTime;
    self.personNumLabel.text = [NSString stringWithFormat:@"%i人", model.personNum];
    self.addrLabel.text = model.addr;
    [self.headerImg setImageWithURL:[NSURL URLWithString:model.headerUrl] placeholderImage:[UIImage imageNamed:@"uyoung.bundle/icon"]];
    if(model.price==0){
        self.priceLabel.image = [UIImage imageNamed:@"uyoung.bundle/aa"];
    }else{
        self.priceLabel.image = [UIImage imageNamed:@"uyoung.bundle/free"];
    }
    
}

@end
