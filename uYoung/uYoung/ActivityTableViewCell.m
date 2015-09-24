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
    
    //init Cell
    [self initWithActivityModel:self.model];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void) initWithActivityModel: (ActivityModel*)model{
    self.actTypeLable.text = model.actType;
    self.dayLabel.text = model.day;
    self.monthLabel.text = [NSString stringWithFormat:@"%@，",model.month];
    self.weekLabel.text = model.week;
    self.titleLabel.text = model.title;
    self.fromTimeLabel.text = model.fromTime;
    self.toTimeLabel.text = model.toTime;
    self.personNumLabel.text = [NSString stringWithFormat:@"%d", model.personNum.intValue];
    self.addrLabel.text = model.addr;
    self.headerImg.image = [UIImage imageNamed:model.headerUrl];
    if(model.price==0){
        self.priceLabel.image = [UIImage imageNamed:@"uyoung.bundel/aa"];
    }else{
        self.priceLabel.image = [UIImage imageNamed:@"uyoung.bundel/free"];
    }
    
}

@end
