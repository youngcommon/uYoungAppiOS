//
//  CreateActivityController.h
//  uYoung
//
//  Created by 独自天涯 on 15/11/21.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateActivityController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *backgroundImg;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;

//活动名称
@property (strong, nonatomic) UIImageView *actNameImg;
@property (strong, nonatomic) UITextField *actNameInput;
//活动日期
@property (strong, nonatomic) UIImageView *actDateImg;
@property (strong, nonatomic) UIImageView *actDateTextImg;
@property (strong, nonatomic) UIButton *actDateButton;
@property (strong, nonatomic) UIDatePicker *actDatePicker;
//活动时间
@property (strong, nonatomic) UIImageView *actTimeImg;
@property (strong, nonatomic) UIImageView *actTimeTextImg;
@property (strong, nonatomic) UIImageView *timeIconImageView;
@property (strong, nonatomic) UIButton *actTimeStartButton;
@property (strong, nonatomic) UIButton *actTimeEndButton;
@property (strong, nonatomic) UIDatePicker *actTimePicker;
//活动类型
@property (strong, nonatomic) UIImageView *actTypeImg;
@property (strong, nonatomic) UIImageView *actTypeTextImg;
@property (strong, nonatomic) UIButton *actTypeSelButton;
@property (strong, nonatomic) UIImageView *actTypeImageView;
//参与人数
@property (strong, nonatomic) UIImageView *actNumImg;
@property (strong, nonatomic) UIImageView *actNumTextImg;
@property (strong, nonatomic) UISlider *actNumSlider;
//费用
@property (strong, nonatomic) UIImageView *actPriceImg;
@property (strong, nonatomic) UIImageView *actPriceTextImg;
@property (strong, nonatomic) UIButton *actFreeButton;
@property (strong, nonatomic) UIButton *actAAButton;
//活动地点
@property (strong, nonatomic) UIImageView *actAddrImg;
@property (strong, nonatomic) UITextField *actAddrInput;

- (IBAction)back:(id)sender;

@end
