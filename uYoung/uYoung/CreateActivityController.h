//
//  CreateActivityController.h
//  uYoung
//
//  Created by 独自天涯 on 15/11/21.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityPublish.h"

@interface CreateActivityController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, ActivityPublishDelegate, UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *backgroundImg;
@property (weak, nonatomic) IBOutlet UIScrollView *backgroundView;

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
@property (strong, nonatomic) UILabel *actNumLabel;
//费用
@property (strong, nonatomic) UIImageView *actPriceImg;
@property (strong, nonatomic) UIImageView *actPriceTextImg;
@property (strong, nonatomic) UIButton *actFreeButton;
@property (strong, nonatomic) UIButton *actAAButton;
//活动地点
@property (strong, nonatomic) UIImageView *actAddrImg;
@property (strong, nonatomic) UITextField *actAddrInput;
//活动描述
@property (strong, nonatomic) UIWebView *actDescView;
//picker按钮
@property (strong, nonatomic) UIButton *selectedButton;

@property (assign, nonatomic) CGFloat viewBottom;
@property (assign, nonatomic) BOOL isRegister;
@property (strong, nonatomic) UIFont *labelFont;
@property (strong, nonatomic) UIView *backview;
@property (assign, nonatomic) CGFloat labelHeight;
@property (assign, nonatomic) CGFloat frontWidth;
@property (assign, nonatomic) CGFloat backWidth;
@property (assign, nonatomic) CGFloat sep;
@property (assign, nonatomic) BOOL isLoadingFinished;
//存储各字段值
@property (assign, nonatomic) CGFloat delta;
@property (strong, nonatomic) NSDate *maxDate;
@property (strong, nonatomic) NSDate *minDate;
@property (strong, nonatomic) NSDate *selectDate;
@property (strong, nonatomic) NSDate *maxTime;
@property (strong, nonatomic) NSDate *minTime;
@property (strong, nonatomic) NSString *actTitle;
@property (strong, nonatomic) NSDate *from;
@property (strong, nonatomic) NSDate *to;
@property (assign, nonatomic) long actType;
@property (assign, nonatomic) NSInteger actNum;
@property (assign, nonatomic) NSInteger priceType;
@property (assign, nonatomic) NSString *addr;
@property (assign, nonatomic) NSInteger currentButton;//保存当前点击的时间选择器按钮
//保存活动类型数据
@property (strong, nonatomic) NSArray *actTypes;
@property (strong, nonatomic) UITableView *actTypesTable;
@property (strong, nonatomic) NSString *descHtml;

- (IBAction)back:(id)sender;
- (IBAction)createAct:(id)sender;


- (void)toStep2;

@end
