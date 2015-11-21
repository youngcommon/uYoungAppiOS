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

//活动名称
@property (strong, nonatomic) UILabel *actNameLabel;
@property (strong, nonatomic) UITextField *actNameInput;
//活动日期
@property (strong, nonatomic) UILabel *actDateLabel;
@property (strong, nonatomic) UILabel *actDateTextLabel;
@property (strong, nonatomic) UIButton *actDateButotn;
@property (strong, nonatomic) UIPickerView *actDatePicker;
//活动时间
//活动类型
//参与人数
//费用
//活动地点

- (IBAction)back:(id)sender;

@end
