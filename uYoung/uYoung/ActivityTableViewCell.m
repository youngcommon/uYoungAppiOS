//
//  ActivityTableViewCell.m
//  uYoung
//
//  Created by CSDN on 15/9/21.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "ActivityTableViewCell.h"
#import <UIImageView+AFNetworking.h>
#import "GlobalConfig.h"

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
    self.dayLabel.text = [NSString stringWithFormat:@"%d", (int)model.day];
    self.monthLabel.text = [NSString stringWithFormat:@"%d月，",(int)model.month];
    self.weekLabel.text = model.week;
    self.titleLabel.text = model.title;
    self.fromTimeLabel.text = model.fromTime;
    self.toTimeLabel.text = model.toTime;
    self.personNumLabel.text = [NSString stringWithFormat:@"%d人", (int)model.personNum];
    self.addrLabel.text = model.addr;
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:model.headerUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:600.0];
    [self.headerImg setImageWithURLRequest:theRequest placeholderImage:[UIImage imageNamed:UserDefaultHeader] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
        [_headerImg setImage:image];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
        UIImage *img = [UIImage imageNamed:UserDefaultHeader];
        [_headerImg setImage:img];
    }];
    if(model.price==0){
        self.priceLabel.image = [UIImage imageNamed:@"uyoung.bundle/aa"];
    }else{
        self.priceLabel.image = [UIImage imageNamed:@"uyoung.bundle/free"];
    }
    
}

@end
