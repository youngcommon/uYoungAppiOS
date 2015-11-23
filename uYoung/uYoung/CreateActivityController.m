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
    _actAddrInput.background = [self getScaleBackUIImage:@"uyoung.bundle/input_end_mid" isFront:NO];
    [_backgroundView addSubview:_actAddrInput];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
@end
