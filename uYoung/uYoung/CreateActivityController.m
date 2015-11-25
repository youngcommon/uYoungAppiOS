//
//  CreateActivityController.m
//  uYoung
//
//  Created by 独自天涯 on 15/11/21.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "CreateActivityController.h"
#import "GlobalConfig.h"

@interface CreateActivityController ()

@end

@implementation CreateActivityController

- (void)viewDidLoad {
    [super viewDidLoad];
    _backgroundImg.image = [self getScaleUIImage:@"uyoung.bundle/backcover" Height:30];
    
    CGFloat sep = 14;//默认行距
    CGFloat sepInside = 2;//默认间距
    CGFloat labelHeight = 40;//默认输入行高
    CGFloat frontWidth = 80;//默认前部宽度
    CGFloat backWidth = 156;//默认后部宽度
    CGFloat x = (_backgroundView.frame.size.width - frontWidth - backWidth)/2;
    CGFloat y = 30;
    CGFloat labelOffset = 12;
    UIFont *labelFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];
    
    //活动名称
    _actNameImg = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, frontWidth, labelHeight)];
    [_actNameImg setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_mid" isFront:YES]];
    [_backgroundView addSubview:_actNameImg];
    
    UILabel *actNameLabel = [[UILabel alloc]initWithFrame:[self getLabelFrame:_actNameImg offset:labelOffset]];
    [actNameLabel setFont:labelFont];
    [actNameLabel setTextAlignment:NSTextAlignmentRight];
    [actNameLabel setText:@"活动名称"];
    actNameLabel.textColor = [UIColor whiteColor];
    [_backgroundView addSubview:actNameLabel];
    
    _actNameInput = [[UITextField alloc]initWithFrame:CGRectMake(_actNameImg.frame.origin.x+_actNameImg.frame.size.width, y, backWidth, labelHeight)];
    _actNameInput.borderStyle = UITextBorderStyleNone;
    _actNameInput.placeholder = @"请输入活动名称";
    _actNameInput.font = labelFont;
    _actNameInput.background = [self getScaleBackUIImage:@"uyoung.bundle/input_end_mid" isFront:NO];
    [_backgroundView addSubview:_actNameInput];
    
    y = y + _actNameImg.frame.size.height + sep;
    
    //活动日期
    _actDateImg = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, frontWidth, labelHeight)];
    [_actDateImg setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_top" isFront:YES]];
    [_backgroundView addSubview:_actDateImg];
    
    UILabel *actDateLabel = [[UILabel alloc]initWithFrame:[self getLabelFrame:_actDateImg offset:labelOffset]];
    [actDateLabel setFont:labelFont];
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
    _actDateButton.titleLabel.font = labelFont;
    _actDateButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _actDateButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [_actDateButton setTitle:@"2015-12-30" forState:UIControlStateNormal];
    [_actDateButton setTitleColor:UIColorFromRGB(0x85b200) forState:UIControlStateNormal];
    _actDateButton.backgroundColor = [UIColor clearColor];
    [_actDateButton addTarget:self action:@selector(selectDate) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundView addSubview:_actDateButton];
    
    y = y + _actDateImg.frame.size.height + sepInside;
    
    //活动时间
    _actTimeImg = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, frontWidth, labelHeight)];
    [_actTimeImg setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_bottom" isFront:YES]];
    [_backgroundView addSubview:_actTimeImg];
    
    UILabel *actTimeLabel = [[UILabel alloc]initWithFrame:[self getLabelFrame:_actTimeImg offset:labelOffset]];
    [actTimeLabel setFont:labelFont];
    [actTimeLabel setTextAlignment:NSTextAlignmentRight];
    [actTimeLabel setText:@"活动时间"];
    actTimeLabel.textColor = [UIColor whiteColor];
    [_backgroundView addSubview:actTimeLabel];
    
    _actTimeTextImg = [[UIImageView alloc]initWithFrame:CGRectMake(_actTimeImg.frame.origin.x+_actTimeImg.frame.size.width, y, backWidth, labelHeight)];
    [_actTimeTextImg setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_end_bottom" isFront:NO]];
    [_backgroundView addSubview:_actTimeTextImg];
    
    CGFloat hlineX = _actTimeTextImg.frame.origin.x+_actTimeTextImg.frame.size.width/2-5;
    
    _actTimeStartButton = [[UIButton alloc]initWithFrame:CGRectMake(_actTimeTextImg.frame.origin.x+10, _actTimeTextImg.frame.origin.y, hlineX-_actTimeTextImg.frame.origin.x-10-10, _actTimeTextImg.frame.size.height)];
    _actTimeStartButton.titleLabel.font = labelFont;
    _actTimeStartButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _actTimeStartButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [_actTimeStartButton setTitle:@"23:58" forState:UIControlStateNormal];
    [_actTimeStartButton setTitleColor:UIColorFromRGB(0x85b200) forState:UIControlStateNormal];
    _actTimeStartButton.backgroundColor = [UIColor clearColor];
    [_actTimeStartButton setImage:[UIImage imageNamed:@"uyoung.bundle/time"] forState:UIControlStateNormal];
//    [_actTimeStartButton addTarget:self action:@selector(selectDate) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundView addSubview:_actTimeStartButton];
    
    UILabel *hline = [[UILabel alloc]initWithFrame:CGRectMake(hlineX, _actTimeTextImg.frame.origin.y+_actTimeTextImg.frame.size.height/2, 10, 2)];
    hline.backgroundColor = UIColorFromRGB(0x85b200);
    [_backgroundView addSubview:hline];
    
    _actTimeEndButton = [[UIButton alloc]initWithFrame:CGRectMake(hline.frame.origin.x+hline.frame.size.width+10, _actTimeTextImg.frame.origin.y, _actTimeTextImg.frame.origin.x+_actTimeTextImg.frame.size.width-hlineX-hline.frame.size.width, _actTimeTextImg.frame.size.height)];
    _actTimeEndButton.titleLabel.font = labelFont;
    _actTimeEndButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _actTimeEndButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [_actTimeEndButton setTitle:@"23:58" forState:UIControlStateNormal];
    [_actTimeEndButton setTitleColor:UIColorFromRGB(0x85b200) forState:UIControlStateNormal];
    _actTimeEndButton.backgroundColor = [UIColor clearColor];
    [_actTimeEndButton setImage:[UIImage imageNamed:@"uyoung.bundle/time"] forState:UIControlStateNormal];
    //    [_actTimeStartButton addTarget:self action:@selector(selectDate) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundView addSubview:_actTimeEndButton];
    
    y = y + _actTimeImg.frame.size.height + sep;
    
    //活动类型
    _actTypeImg = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, frontWidth, labelHeight)];
    [_actTypeImg setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_top" isFront:YES]];
    [_backgroundView addSubview:_actTypeImg];
    
    UILabel *actTypeLabel = [[UILabel alloc]initWithFrame:[self getLabelFrame:_actTypeImg offset:labelOffset]];
    [actTypeLabel setFont:labelFont];
    [actTypeLabel setTextAlignment:NSTextAlignmentRight];
    [actTypeLabel setText:@"活动类型"];
    actTypeLabel.textColor = [UIColor whiteColor];
    [_backgroundView addSubview:actTypeLabel];
    
    _actTypeTextImg = [[UIImageView alloc]initWithFrame:CGRectMake(_actTypeImg.frame.origin.x+_actTypeImg.frame.size.width, y, backWidth, labelHeight)];
    [_actTypeTextImg setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_end_top" isFront:NO]];
    [_backgroundView addSubview:_actTypeTextImg];
    
    y = y + _actTypeImg.frame.size.height + sepInside;
    
    //参与人数
    _actNumImg = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, frontWidth, labelHeight)];
    [_actNumImg setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_bottom" isFront:YES]];
    [_backgroundView addSubview:_actNumImg];
    
    UILabel *actNumLabel = [[UILabel alloc]initWithFrame:[self getLabelFrame:_actNumImg offset:labelOffset]];
    [actNumLabel setFont:labelFont];
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
    [actPriceLabel setFont:labelFont];
    [actPriceLabel setTextAlignment:NSTextAlignmentRight];
    [actPriceLabel setText:@"费用"];
    actPriceLabel.textColor = [UIColor whiteColor];
    [_backgroundView addSubview:actPriceLabel];
    
    _actPriceTextImg = [[UIImageView alloc]initWithFrame:CGRectMake(_actPriceImg.frame.origin.x+_actPriceImg.frame.size.width, y, backWidth, labelHeight)];
    [_actPriceTextImg setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_end_mid" isFront:NO]];
    [_backgroundView addSubview:_actPriceTextImg];
    
    y = y + _actPriceImg.frame.size.height + sep;
    
    //活动地点
    _actAddrImg = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, frontWidth, labelHeight)];
    [_actAddrImg setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_mid" isFront:YES]];
    [_backgroundView addSubview:_actAddrImg];
    
    UILabel *actAddrLabel = [[UILabel alloc]initWithFrame:[self getLabelFrame:_actAddrImg offset:labelOffset]];
    [actAddrLabel setFont:labelFont];
    [actAddrLabel setTextAlignment:NSTextAlignmentRight];
    [actAddrLabel setText:@"活动地点"];
    actAddrLabel.textColor = [UIColor whiteColor];
    [_backgroundView addSubview:actAddrLabel];
    
    _actAddrInput = [[UITextField alloc]initWithFrame:CGRectMake(_actAddrImg.frame.origin.x+_actAddrImg.frame.size.width, y, backWidth, labelHeight)];
    _actAddrInput.borderStyle = UITextBorderStyleNone;
    _actAddrInput.placeholder = @"请输入活动地址";
    _actAddrInput.font = labelFont;
    _actAddrInput.background = [self getScaleBackUIImage:@"uyoung.bundle/input_end_mid" isFront:NO];
    [_backgroundView addSubview:_actAddrInput];
    
    //初始化日期选择器
    NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    _actDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, mScreenHeight/2, mScreenWidth, mScreenHeight/2-60)];
    _actDatePicker.locale = locale;
    _actDatePicker.backgroundColor = UIColorFromRGB(0x85b200);
    [self.view addSubview:_actDatePicker];
    [_actDatePicker setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) sliderValueChanged:(id)sender{
    UISlider* control = (UISlider*)sender;
    if(control == _actNumSlider){
        float value = control.value;
        [_actNumLabel setText:[NSString stringWithFormat:@"%d人", (int)value]];
        _actNum = (int)value;
    }
}

- (void)selectDate{
    [_actDatePicker setHidden:NO];
}

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

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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

@end
