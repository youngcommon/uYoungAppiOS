//
//  CreateActivityController.m
//  uYoung
//
//  Created by 独自天涯 on 15/11/21.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "CreateActivityController.h"
#import "GlobalConfig.h"
#import "CreateActivityStep2Controller.h"
#import "ActivityDescTextView.h"
#import "NSString+StringUtil.h"

@interface CreateActivityController ()

@end

@implementation CreateActivityController

- (void)viewDidLoad {
    [super viewDidLoad];
    _backgroundImg.image = [self getScaleUIImage:@"uyoung.bundle/backcover" Height:30];
    
    _minDate = [NSDate date];
    NSDate *nextHour = [NSDate dateWithTimeInterval:60*60 sinceDate:_minDate];
    _maxDate = [NSDate dateWithTimeInterval:24*60*60*30*12 sinceDate:_minDate];
    
    _minTime = [self getTimeFromString:@"08:00"];
    _maxTime = [self getTimeFromString:@"23:50"];
    
    _from = _minDate;
    _to = nextHour;
    _priceType = 0;
    
    CGFloat sep = 14;//默认行距
    CGFloat sepInside = 2;//默认间距
    CGFloat labelHeight = 40;//默认输入行高
    CGFloat frontWidth = 80;//默认前部宽度
    CGFloat backWidth = 156;//默认后部宽度
    CGFloat x = (_backgroundView.frame.size.width - frontWidth - backWidth)/2;
    CGFloat y = 0;
    CGFloat labelOffset = 12;
    _labelFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];
    if (mScreenWidth==375) {//iPhone 6
        sep = 24;//默认行距
        sepInside = 4;//默认间距
        frontWidth = 100;//默认前部宽度
        backWidth = 185;//默认后部宽度
        y = 5;
    }else if(mScreenWidth>375){//iPhone 6+
        sep = 32;//默认行距
        sepInside = 4;//默认间距
        frontWidth = 110;//默认前部宽度
        backWidth = 210;//默认后部宽度
        y = 10;
        labelOffset = 30;
    }
    
    //活动名称
    _actNameImg = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, frontWidth, labelHeight)];
    [_actNameImg setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_mid" isFront:YES]];
    [_backgroundView addSubview:_actNameImg];
    
    UILabel *actNameLabel = [[UILabel alloc]initWithFrame:[self getLabelFrame:_actNameImg offset:labelOffset]];
    [actNameLabel setFont:_labelFont];
    [actNameLabel setTextAlignment:NSTextAlignmentRight];
    [actNameLabel setText:@"活动名称"];
    actNameLabel.textColor = [UIColor whiteColor];
    [_backgroundView addSubview:actNameLabel];
    
    _actNameInput = [[UITextField alloc]initWithFrame:CGRectMake(_actNameImg.frame.origin.x+_actNameImg.frame.size.width, y, backWidth, labelHeight)];
    _actNameInput.borderStyle = UITextBorderStyleNone;
    _actNameInput.placeholder = @"请输入活动名称";
    _actNameInput.font = _labelFont;
    _actNameInput.background = [self getScaleBackUIImage:@"uyoung.bundle/input_end_mid" isFront:NO];
    _actNameInput.returnKeyType = UIReturnKeyDone;
    _actNameInput.clearButtonMode = UITextFieldViewModeWhileEditing;
    _actNameInput.delegate = self;
    [_actNameInput setTag:9001];
    [_backgroundView addSubview:_actNameInput];
    
    y = y + _actNameImg.frame.size.height + sep;
    
    //活动日期
    _actDateImg = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, frontWidth, labelHeight)];
    [_actDateImg setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_top" isFront:YES]];
    [_backgroundView addSubview:_actDateImg];
    
    UILabel *actDateLabel = [[UILabel alloc]initWithFrame:[self getLabelFrame:_actDateImg offset:labelOffset]];
    [actDateLabel setFont:_labelFont];
    [actDateLabel setTextAlignment:NSTextAlignmentRight];
    [actDateLabel setText:@"活动日期"];
    actDateLabel.textColor = [UIColor whiteColor];
    [_backgroundView addSubview:actDateLabel];
    
    _actDateTextImg = [[UIImageView alloc]initWithFrame:CGRectMake(_actDateImg.frame.origin.x+_actDateImg.frame.size.width, y, backWidth, labelHeight)];
    [_actDateTextImg setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_end_top" isFront:NO]];
    [_backgroundView addSubview:_actDateTextImg];
    
    UIImageView *dateIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"uyoung.bundle/calender"]];
    CGRect f = [self getIconFrame:_actDateTextImg icon:dateIcon offset:dateIcon.frame.size.width/2];
    [dateIcon setFrame:f];
    [_backgroundView addSubview:dateIcon];
    
    UILabel *vline = [[UILabel alloc]initWithFrame:CGRectMake(dateIcon.frame.origin.x-dateIcon.frame.size.width/2, _actDateTextImg.frame.origin.y, 1, _actDateTextImg.frame.size.height)];
    vline.backgroundColor = UIColorFromRGB(0x85b200);
    [_backgroundView addSubview:vline];
    
    CGFloat contentX = _actDateTextImg.frame.origin.x;
    _actDateButton = [[UIButton alloc]initWithFrame:CGRectMake(contentX, _actDateTextImg.frame.origin.y, _actDateTextImg.frame.size.width, _actDateTextImg.frame.size.height)];
    _actDateButton.titleLabel.font = _labelFont;
    _actDateButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _actDateButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [_actDateButton setTitle:[self getSimpleDate:_minDate] forState:UIControlStateNormal];
    [_actDateButton setTitleColor:UIColorFromRGB(0x85b200) forState:UIControlStateNormal];
    _actDateButton.backgroundColor = [UIColor clearColor];
    [_actDateButton setTag:1003];
    [_actDateButton addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundView addSubview:_actDateButton];
    
    y = y + _actDateImg.frame.size.height + sepInside;
    
    //活动时间
    _actTimeImg = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, frontWidth, labelHeight)];
    [_actTimeImg setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_bottom" isFront:YES]];
    [_backgroundView addSubview:_actTimeImg];
    
    UILabel *actTimeLabel = [[UILabel alloc]initWithFrame:[self getLabelFrame:_actTimeImg offset:labelOffset]];
    [actTimeLabel setFont:_labelFont];
    [actTimeLabel setTextAlignment:NSTextAlignmentRight];
    [actTimeLabel setText:@"活动时间"];
    actTimeLabel.textColor = [UIColor whiteColor];
    [_backgroundView addSubview:actTimeLabel];
    
    _actTimeTextImg = [[UIImageView alloc]initWithFrame:CGRectMake(_actTimeImg.frame.origin.x+_actTimeImg.frame.size.width, y, backWidth, labelHeight)];
    [_actTimeTextImg setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_end_bottom" isFront:NO]];
    [_backgroundView addSubview:_actTimeTextImg];
    
    CGFloat hlineX = _actTimeTextImg.frame.origin.x+_actTimeTextImg.frame.size.width/2-5;
    
    _actTimeStartButton = [[UIButton alloc]initWithFrame:CGRectMake(_actTimeTextImg.frame.origin.x+10, _actTimeTextImg.frame.origin.y, hlineX-_actTimeTextImg.frame.origin.x-10-10, _actTimeTextImg.frame.size.height)];
    _actTimeStartButton.titleLabel.font = _labelFont;
    _actTimeStartButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _actTimeStartButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [_actTimeStartButton setTitle:[self getSimpleTime:_minTime] forState:UIControlStateNormal];
    [_actTimeStartButton setTitleColor:UIColorFromRGB(0x85b200) forState:UIControlStateNormal];
    _actTimeStartButton.backgroundColor = [UIColor clearColor];
    [_actTimeStartButton setImage:[UIImage imageNamed:@"uyoung.bundle/time"] forState:UIControlStateNormal];
    [_actTimeStartButton setTag:1002];
    [_actTimeStartButton addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundView addSubview:_actTimeStartButton];
    
    UILabel *hline = [[UILabel alloc]initWithFrame:CGRectMake(hlineX, _actTimeTextImg.frame.origin.y+_actTimeTextImg.frame.size.height/2, 10, 2)];
    hline.backgroundColor = UIColorFromRGB(0x85b200);
    [_backgroundView addSubview:hline];
    
    _actTimeEndButton = [[UIButton alloc]initWithFrame:CGRectMake(hline.frame.origin.x+hline.frame.size.width+10, _actTimeTextImg.frame.origin.y, _actTimeTextImg.frame.origin.x+_actTimeTextImg.frame.size.width-hlineX-hline.frame.size.width, _actTimeTextImg.frame.size.height)];
    _actTimeEndButton.titleLabel.font = _labelFont;
    _actTimeEndButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _actTimeEndButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [_actTimeEndButton setTitle:[self getSimpleTime:_maxTime] forState:UIControlStateNormal];
    [_actTimeEndButton setTitleColor:UIColorFromRGB(0x85b200) forState:UIControlStateNormal];
    _actTimeEndButton.backgroundColor = [UIColor clearColor];
    [_actTimeEndButton setImage:[UIImage imageNamed:@"uyoung.bundle/time"] forState:UIControlStateNormal];
    [_actTimeEndButton setTag:1001];
    [_actTimeEndButton addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundView addSubview:_actTimeEndButton];
    
    y = y + _actTimeImg.frame.size.height + sep;
    
    //活动类型
    _actTypeImg = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, frontWidth, labelHeight)];
    [_actTypeImg setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_top" isFront:YES]];
    [_backgroundView addSubview:_actTypeImg];
    
    UILabel *actTypeLabel = [[UILabel alloc]initWithFrame:[self getLabelFrame:_actTypeImg offset:labelOffset]];
    [actTypeLabel setFont:_labelFont];
    [actTypeLabel setTextAlignment:NSTextAlignmentRight];
    [actTypeLabel setText:@"活动类型"];
    actTypeLabel.textColor = [UIColor whiteColor];
    [_backgroundView addSubview:actTypeLabel];
    
    _actTypeTextImg = [[UIImageView alloc]initWithFrame:CGRectMake(_actTypeImg.frame.origin.x+_actTypeImg.frame.size.width, y, backWidth, labelHeight)];
    [_actTypeTextImg setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_end_top" isFront:NO]];
    [_backgroundView addSubview:_actTypeTextImg];
    
    UILabel *vTypeline = [[UILabel alloc]initWithFrame:CGRectMake(vline.frame.origin.x, _actTypeTextImg.frame.origin.y, 1, _actTypeTextImg.frame.size.height)];
    vTypeline.backgroundColor = UIColorFromRGB(0x85b200);
    [_backgroundView addSubview:vTypeline];
    
    UIImageView *downArrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"uyoung.bundle/down_arrow"]];
    [downArrow setFrame:CGRectMake(vTypeline.frame.origin.x+(_actTypeTextImg.frame.origin.x+_actTypeTextImg.frame.size.width-vTypeline.frame.origin.x)/2-downArrow.frame.size.width/2, _actTypeTextImg.frame.origin.y+_actTypeTextImg.frame.size.height/2-downArrow.frame.size.height/2, downArrow.frame.size.width, downArrow.frame.size.height)];
    [_backgroundView addSubview:downArrow];
    
    _actTypeSelButton = [[UIButton alloc]initWithFrame:CGRectMake(_actTypeTextImg.frame.origin.x+10, _actTypeTextImg.frame.origin.y, _actTypeTextImg.frame.size.width, _actTypeTextImg.frame.size.height)];
    _actTypeSelButton.titleLabel.font = _labelFont;
    _actTypeSelButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_actTypeSelButton setTitle:@"人像" forState:UIControlStateNormal];
    [_actTypeSelButton setTitleColor:UIColorFromRGB(0x85b200) forState:UIControlStateNormal];
    _actTypeSelButton.backgroundColor = [UIColor clearColor];
    [_actTypeSelButton addTarget:self action:@selector(selectActType) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundView addSubview:_actTypeSelButton];
    
    y = y + _actTypeImg.frame.size.height + sepInside;
    
    //参与人数
    _actNumImg = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, frontWidth, labelHeight)];
    [_actNumImg setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_bottom" isFront:YES]];
    [_backgroundView addSubview:_actNumImg];
    
    UILabel *actNumLabel = [[UILabel alloc]initWithFrame:[self getLabelFrame:_actNumImg offset:labelOffset]];
    [actNumLabel setFont:_labelFont];
    [actNumLabel setTextAlignment:NSTextAlignmentRight];
    [actNumLabel setText:@"参与人数"];
    actNumLabel.textColor = [UIColor whiteColor];
    [_backgroundView addSubview:actNumLabel];
    
    _actNumTextImg = [[UIImageView alloc]initWithFrame:CGRectMake(_actNumImg.frame.origin.x+_actNumImg.frame.size.width, y, backWidth, labelHeight)];
    [_actNumTextImg setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_end_bottom" isFront:NO]];
    [_backgroundView addSubview:_actNumTextImg];
    
    _actNumSlider = [[UISlider alloc]initWithFrame:CGRectMake(_actNumTextImg.frame.origin.x, _actNumTextImg.frame.origin.y+_actNumTextImg.frame.size.height/2-12/2, _actNumTextImg.frame.size.width-10, 12)];
    _actNumSlider.minimumValue = 2;
    _actNumSlider.maximumValue = 30;
    _actNumSlider.value = 4;
    _actNumSlider.continuous = YES ;
    [_actNumSlider setMinimumTrackImage:[self getSliderUIImage:@"uyoung.bundle/slider_max"] forState:UIControlStateNormal];
    [_actNumSlider setMaximumTrackImage:[self getSliderUIImage:@"uyoung.bundle/slider_min"] forState:UIControlStateNormal];
    [_actNumSlider setThumbImage:[UIImage imageNamed:@"uyoung.bundle/slider_thumb"] forState:UIControlStateNormal];
    [_actNumSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_backgroundView addSubview:_actNumSlider];
    
    UIFont *actNumFont = [UIFont fontWithName:@"HelveticaNeue" size:8];
    _actNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(_actNumSlider.frame.origin.x+10, _actNumSlider.frame.origin.y, _actNumSlider.frame.size.width/2, 12)];
    [_actNumLabel setFont:actNumFont];
    [_actNumLabel setText:@"4人"];
    [actNumLabel setTextAlignment:NSTextAlignmentLeft];
    [_actNumLabel setTextColor:[UIColor whiteColor]];
    [_backgroundView addSubview:_actNumLabel];
    
    y = y + _actNumImg.frame.size.height + sep;
    
    //费用
    _actPriceImg = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, frontWidth, labelHeight)];
    [_actPriceImg setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_mid" isFront:YES]];
    [_backgroundView addSubview:_actPriceImg];
    
    UILabel *actPriceLabel = [[UILabel alloc]initWithFrame:[self getLabelFrame:_actPriceImg offset:labelOffset]];
    [actPriceLabel setFont:_labelFont];
    [actPriceLabel setTextAlignment:NSTextAlignmentRight];
    [actPriceLabel setText:@"费用"];
    actPriceLabel.textColor = [UIColor whiteColor];
    [_backgroundView addSubview:actPriceLabel];
    
    _actPriceTextImg = [[UIImageView alloc]initWithFrame:CGRectMake(_actPriceImg.frame.origin.x+_actPriceImg.frame.size.width, y, backWidth, labelHeight)];
    [_actPriceTextImg setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_end_mid" isFront:NO]];
    [_backgroundView addSubview:_actPriceTextImg];
    
    _actFreeButton = [[UIButton alloc]initWithFrame:CGRectMake(_actPriceTextImg.frame.origin.x+10, _actPriceTextImg.frame.origin.y, _actPriceTextImg.frame.size.width/2-20, _actPriceTextImg.frame.size.height)];
    _actFreeButton.titleLabel.font = _labelFont;
    _actFreeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _actFreeButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [_actFreeButton setTitle:@"免费" forState:UIControlStateNormal];
    [_actFreeButton setTitleColor:UIColorFromRGB(0x85b200) forState:UIControlStateNormal];
    _actFreeButton.backgroundColor = [UIColor clearColor];
    [_actFreeButton setTag:2000];
    [_actFreeButton setImage:[UIImage imageNamed:@"uyoung.bundle/selected"] forState:UIControlStateNormal];
    [_actFreeButton addTarget:self action:@selector(changePrice:) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundView addSubview:_actFreeButton];
    
    _actAAButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_backgroundView addSubview:_actAAButton];
    
    _actAAButton = [[UIButton alloc]initWithFrame:CGRectMake(_actFreeButton.frame.origin.x+_actFreeButton.frame.size.width+10, _actFreeButton.frame.origin.y, _actPriceTextImg.frame.origin.x+_actPriceTextImg.frame.size.width-_actFreeButton.frame.origin.x-_actFreeButton.frame.size.width-10-10, _actFreeButton.frame.size.height)];
    _actAAButton.titleLabel.font = _labelFont;
    _actAAButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _actAAButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [_actAAButton setTitle:@"收费" forState:UIControlStateNormal];
    [_actAAButton setTitleColor:UIColorFromRGB(0x85b200) forState:UIControlStateNormal];
    _actAAButton.backgroundColor = [UIColor clearColor];
    [_actAAButton setTag:2001];
    [_actAAButton setImage:[UIImage imageNamed:@"uyoung.bundle/unselected"] forState:UIControlStateNormal];
    [_actAAButton addTarget:self action:@selector(changePrice:) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundView addSubview:_actAAButton];
    
    y = y + _actPriceImg.frame.size.height + sep;
    
    //活动地点
    _actAddrImg = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, frontWidth, labelHeight)];
    [_actAddrImg setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_mid" isFront:YES]];
    [_backgroundView addSubview:_actAddrImg];
    
    UILabel *actAddrLabel = [[UILabel alloc]initWithFrame:[self getLabelFrame:_actAddrImg offset:labelOffset]];
    [actAddrLabel setFont:_labelFont];
    [actAddrLabel setTextAlignment:NSTextAlignmentRight];
    [actAddrLabel setText:@"活动地点"];
    actAddrLabel.textColor = [UIColor whiteColor];
    [_backgroundView addSubview:actAddrLabel];
    
    _actAddrInput = [[UITextField alloc]initWithFrame:CGRectMake(_actAddrImg.frame.origin.x+_actAddrImg.frame.size.width, y, backWidth, labelHeight)];
    _actAddrInput.borderStyle = UITextBorderStyleNone;
    _actAddrInput.placeholder = @"请输入活动地址";
    _actAddrInput.font = _labelFont;
    _actAddrInput.background = [self getScaleBackUIImage:@"uyoung.bundle/input_end_mid" isFront:NO];
    _actAddrInput.returnKeyType = UIReturnKeyDone;
    _actAddrInput.clearButtonMode = UITextFieldViewModeWhileEditing;
    _actAddrInput.delegate = self;
    [_actAddrInput setTag:9002];
    [_backgroundView addSubview:_actAddrInput];
    
    y = y + _actAddrImg.frame.size.height + sep;
    
    UIImageView *actDescTitle = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, frontWidth+backWidth, labelHeight)];
    [actDescTitle setImage:[self getScaleBackUIImage:@"uyoung.bundle/text_input" isFront:YES]];
    [_backgroundView addSubview:actDescTitle];
    
    UILabel *actDescTitleLable = [[UILabel alloc]initWithFrame:[self getLabelFrame:actDescTitle offset:actDescTitle.frame.origin.x+actDescTitle.frame.size.width-actAddrLabel.frame.origin.x-actAddrLabel.frame.size.width]];
    [actDescTitleLable setFont:_labelFont];
    [actDescTitleLable setTextAlignment:NSTextAlignmentRight];
    [actDescTitleLable setText:@"活动描述"];
    actDescTitleLable.textColor = [UIColor whiteColor];
    [_backgroundView addSubview:actDescTitleLable];
    
    y = y + actDescTitle.frame.size.height;
    
    _actDescView = [[UIWebView alloc]initWithFrame:CGRectMake(x, y-1, frontWidth+backWidth, labelHeight)];
    if([NSString isBlankString:_descHtml]==NO){
        [_actDescView loadHTMLString:_descHtml baseURL:[NSURL fileURLWithPath: [[NSBundle mainBundle]  bundlePath]]];
    }
    _actDescView.layer.borderColor = [UIColorFromRGB(0x85b200)CGColor];
    _actDescView.layer.borderWidth = 1.f;
    [_backgroundView addSubview:_actDescView];
    
    y = y + _actDescView.frame.size.height + sep;
    
    [_backgroundView setContentSize:CGSizeMake(frontWidth+backWidth, y)];
    
    //增加键盘事件监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    //添加遮罩层
    _backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight)];
    _backview.backgroundColor = [UIColor darkGrayColor];
    _backview.alpha = 0.4;
    [self.view addSubview:_backview];
    [_backview setHidden:YES];
    
    //初始化日期选择器
    NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    _actDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, mScreenHeight/2, mScreenWidth, mScreenHeight/2-60)];
    _actDatePicker.locale = locale;
    _actDatePicker.datePickerMode = UIDatePickerModeDate;
    _actDatePicker.backgroundColor = UIColorFromRGB(0x85b200);
    _actDatePicker.minimumDate = _minDate;
    _actDatePicker.maximumDate = _maxDate;
    [_actDatePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
    [self.view addSubview:_actDatePicker];
    [_actDatePicker setHidden:YES];
    
    //创建选择按钮
    _selectedButton = [[UIButton alloc]initWithFrame:CGRectMake(0, mScreenHeight-60, mScreenWidth, 60)];
    _selectedButton.backgroundColor = UIColorFromRGB(0x85b200);
    [_selectedButton setTitle:@"确 定" forState:UIControlStateNormal];
    [_selectedButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_selectedButton];
    [_selectedButton setHidden:YES];
    
    [self initActTypeSelectView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getHtmlData:) name:@"getHtmlData" object:nil];
}

- (void)getHtmlData:(NSNotification*)noti{
    NSString *html = (NSString*)noti.object;
    _descHtml = html;
    if([NSString isBlankString:_descHtml]==NO){
        [_actDescView loadHTMLString:_descHtml baseURL:[NSURL fileURLWithPath: [[NSBundle mainBundle]  bundlePath]]];
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) buttonPressed:(id)sender{
    [_backview setHidden:YES];
    [_selectedButton setHidden:YES];
    [_actDatePicker setHidden:YES];
}

-(void)dateChanged:(id)sender{
    UIDatePicker *control = (UIDatePicker*)sender;
    NSDate *date = control.date;
    switch (_currentButton) {
        case 1001://结束时间
            [_actTimeEndButton setTitle:[self getSimpleTime:date] forState:UIControlStateNormal];
            _maxTime = date;
            break;
        case 1002://开始时间
            [_actTimeStartButton setTitle:[self getSimpleTime:date] forState:UIControlStateNormal];
            _minTime = date;
            break;
        default:
            [_actDateButton setTitle:[self getSimpleDate:date] forState:UIControlStateNormal];
            _selectDate = date;
            break;
    }
}

-(void)selectActType{
    CGRect frame = _actTypesTable.frame;
    if(frame.size.height==0){
        CGFloat maxHeight = (_actAddrImg.frame.origin.y+_actAddrImg.frame.size.height)-(_actTypeTextImg.frame.origin.y+_actTypeTextImg.frame.size.height);
        CGFloat height = [_actTypes count]*30;
        if (height>maxHeight) {
            height = maxHeight;
        }
        frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, height);
    }else{
        frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 0);
    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.2];
    [_actTypesTable setFrame:frame];
    [UIView commitAnimations];
}

-(void)initActTypeSelectView{
    NSData *acttypelistdata = [[NSUserDefaults standardUserDefaults]objectForKey:@"acttype"];
    if (acttypelistdata) {
        _actTypes = [NSKeyedUnarchiver unarchiveObjectWithData:acttypelistdata];
    } else {
        _actTypes = [[NSArray alloc]init];
    }
    _actTypesTable = [[UITableView alloc]initWithFrame:CGRectMake(_actTypeTextImg.frame.origin.x, _actTypeTextImg.frame.origin.y+_actTypeTextImg.frame.size.height-1, _actTypeTextImg.frame.size.width, 0)];
    _actTypesTable.delegate = self;
    _actTypesTable.dataSource = self;
    _actTypesTable.layer.borderColor = [UIColorFromRGB(0x85b200)CGColor];
    _actTypesTable.layer.borderWidth = 1;
    [_backgroundView addSubview:_actTypesTable];
}

-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event{
    //当用户点击他处时，收回弹出的选择view
    if(_actTypesTable.frame.size.height>0){
        [self selectActType];
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_actTypes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithFrame:CGRectZero];
        [[cell textLabel]setFont:_labelFont];
        cell.textLabel.textColor = UIColorFromRGB(0x85b200);
        [[cell textLabel]setText:_actTypes[indexPath.row][@"cnDesc"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _actType = (int)_actTypes[indexPath.row][@"type"];
    [_actTypeSelButton setTitle:_actTypes[indexPath.row][@"cnDesc"] forState:UIControlStateNormal];
    [self selectActType];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - slider处理
- (void) sliderValueChanged:(id)sender{
    UISlider* control = (UISlider*)sender;
    if(control == _actNumSlider){
        float value = control.value;
        [_actNumLabel setText:[NSString stringWithFormat:@"%d人", (int)value]];
        _actNum = (int)value;
    }
}

- (void)selectDate:(UIButton*)sender{
    //当用户点击他处时，收回弹出的选择view
    if(_actTypesTable.frame.size.height>0){
        [self selectActType];
    }
    
    [_backview setHidden:NO];
    
    NSInteger tag = sender.tag;
    _currentButton = tag;
    switch (tag) {
        case 1001://结束时间
            _actDatePicker.datePickerMode = UIDatePickerModeTime;
            _actDatePicker.minuteInterval = 10;
            _actDatePicker.minimumDate = _from;
            _actDatePicker.maximumDate = _maxTime;
            break;
        case 1002://开始时间
            _actDatePicker.datePickerMode = UIDatePickerModeTime;
            _actDatePicker.minuteInterval = 10;
            _actDatePicker.maximumDate = _to;
            _actDatePicker.minimumDate = _minTime;
            break;
        default:
            _actDatePicker.datePickerMode = UIDatePickerModeDate;
            break;
    }
    [_selectedButton setHidden:NO];
    [_actDatePicker setHidden:NO];
}

#pragma mark - 收费、免费切换
- (void)changePrice:(UIButton *)sender {
    NSInteger tag = sender.tag;
    if (tag==2000) {//说明选择的是免费
        UIButton *f = (UIButton*)[_backgroundView viewWithTag:2001];
        [f setImage:[UIImage imageNamed:@"uyoung.bundle/unselected"] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"uyoung.bundle/selected"] forState:UIControlStateNormal];
        _priceType = 0;
    }else{//说明选择收费
        UIButton *m = (UIButton*)[_backgroundView viewWithTag:2000];
        [m setImage:[UIImage imageNamed:@"uyoung.bundle/unselected"] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"uyoung.bundle/selected"] forState:UIControlStateNormal];
        _priceType = 1;
    }

}

#pragma mark - 返回按钮
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)toStep2:(id)sender {
//    CreateActivityStep2Controller *step2 = [[CreateActivityStep2Controller alloc]initWithNibName:@"CreateActivityStep2Controller" bundle:[NSBundle mainBundle]];
//    [self.navigationController pushViewController:step2 animated:YES];
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBarHidden = NO;

    ActivityDescTextView *descView = [[ActivityDescTextView alloc]init];
    [self.navigationController pushViewController:descView animated:NO];

}

#pragma mark - 图片处理
- (UIImage *)getSliderUIImage:(NSString*)name{
    UIImage *bubble = [UIImage imageNamed:name];
    UIEdgeInsets capInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    return [bubble resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
}

- (UIImage *)getScaleUIImage:(NSString*)name Height:(CGFloat)height{
    UIImage *bubble = [UIImage imageNamed:name];
    
    CGPoint center = CGPointMake(bubble.size.width / 2.0f, height);
    UIEdgeInsets capInsets = UIEdgeInsetsMake(center.y, 0, center.y+1, 2);
    return [bubble resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
    
}

- (UIImage *)getScaleBackUIImage:(NSString*)name isFront:(BOOL)isFront{
    UIImage *bubble = [UIImage imageNamed:name];
    
    UIEdgeInsets capInsets;
    if (isFront) {
        capInsets = UIEdgeInsetsMake(0, 10, 0, 6);
    }else{
        capInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    }
    return [bubble resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
    
}
- (CGRect)getLabelFrame:(UIView*)view offset:(CGFloat)offset{
    CGFloat offsetX = view.frame.origin.x + view.frame.size.width - offset - 48;
    CGFloat offsetY = view.frame.origin.y + (view.frame.size.height-16)/2;
    return CGRectMake(offsetX, offsetY, 48, 16);
}

- (CGRect)getIconFrame:(UIView*)view icon:(UIImageView*)icon offset:(CGFloat)offset{
    CGFloat offsetX = view.frame.origin.x + view.frame.size.width - offset - icon.frame.size.width;
    CGFloat offsetY = view.frame.origin.y + (view.frame.size.height-icon.frame.size.height)/2;
    return CGRectMake(offsetX, offsetY, icon.frame.size.width, icon.frame.size.height);
}

- (CGRect)getIconFrameFromFront:(UIView*)view icon:(UIImageView*)icon offset:(CGFloat)offset{
    CGFloat offsetX = view.frame.origin.x + offset;
    CGFloat offsetY = view.frame.origin.y + (view.frame.size.height-icon.frame.size.height)/2;
    return CGRectMake(offsetX, offsetY, icon.frame.size.width, icon.frame.size.height);
}

#pragma mark - 时间处理
- (NSString*)getSimpleDate:(NSDate*)date{
    //设置时间输出格式：
    NSDateFormatter * df = [[NSDateFormatter alloc] init ];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString * na = [df stringFromDate:date];
    return na;
}

- (NSString*)getSimpleTime:(NSDate*)date{
    //设置时间输出格式：
    NSDateFormatter * df = [[NSDateFormatter alloc] init ];
    [df setDateFormat:@"HH:mm"];
    NSString * na = [df stringFromDate:date];
    return na;
}

- (NSDate*)getTimeFromString:(NSString*)date{
    NSDateFormatter * df = [[NSDateFormatter alloc] init ];
    [df setDateFormat:@"HH:mm"];
    return [df dateFromString:date];
}

#pragma mark - 键盘、输入框相关接口方法
//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //当用户点击他处时，收回弹出的选择view
    if(_actTypesTable.frame.size.height>0){
        [self selectActType];
    }
    
    if (_isRegister==NO) {
        _isRegister = YES;
        _viewBottom = textField.frame.origin.y + textField.frame.size.height;
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    _isRegister = NO;
    return YES;
}

- (void)keyboardWillShow:(NSNotification *)notify {
    //sv为弹出键盘的视图，UITextField
    CGFloat kbHeight = [[notify.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;//获取键盘高度。
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGFloat screenHeight = self.view.bounds.size.height;

    if (_viewBottom + kbHeight < screenHeight) return;//若键盘没有遮挡住视图则不进行整个视图上移
    
    // 键盘会盖住输入框, 要移动整个view了
    _delta = _viewBottom + kbHeight - screenHeight + 100;
    
    CGRect viewFrame = CGRectMake(0, 0-_delta, self.view.frame.size.width, self.view.frame.size.height);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:duration];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
}

- (void)keyboardWillHidden:(NSNotification *)notify {//键盘消失
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect viewFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:duration];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
    _delta = 0.0f;
}

@end
