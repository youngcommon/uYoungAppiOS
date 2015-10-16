        //
//  ActivityDetailViewController.m
//  uYoung
//
//  Created by CSDN on 15/9/25.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "ActivityDetailViewController.h"

@interface ActivityDetailViewController ()

@end

@implementation ActivityDetailViewController
@synthesize model;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.headerBackground.image = [self getScaleUIImage:@"uyoung.bundle/backcover" Height:30];
    
    self.userHeader.layer.cornerRadius = self.userHeader.frame.size.height/2;
    self.userHeader.layer.masksToBounds = YES;
    
    self.titleLable.text = self.model.title;
    self.actType.text = [NSString stringWithFormat:@"%@摄影", self.model.actType];
    
    self.actDate.text = [NSString stringWithFormat:@"%d月%d日", self.model.month, self.model.day];
    self.actTime.text = [NSString stringWithFormat:@"%@-%@", self.model.fromTime, self.model.toTime];
    self.addr.text = self.model.addr;
    if(self.model.price==0){
        [self.freeSignetImg setHidden:YES];
    }
    
    //========================活动地址约束调整=========================
    CGFloat addrTitleWidth = self.addrTitle.frame.size.width;
    CGSize addrTitleLabelSize = [self.addrTitle sizeThatFits:CGSizeMake(addrTitleWidth, MAXFLOAT)];
    [self.addrTitleHeight setConstant:addrTitleLabelSize.height];

    CGFloat addrWidth = self.addr.frame.size.width;
    CGSize addrLabelSize = [self.addr sizeThatFits:CGSizeMake(addrWidth, MAXFLOAT)];
    [self.addrHeight setConstant:addrLabelSize.height];
    //================================================
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fillActivityDetail:) name:@"fillActivityDetail" object:nil];
    
    //获取数据
    [ActivityDetail getActivityDetailWithId:self.model.activityId];
}

- (void)fillActivityDetail:(NSNotification*)notification
{
    NSDictionary *dic = (NSDictionary*)[notification object];
    self.detailModel = [MTLJSONAdapter modelOfClass:[ActivityDetailModel class] fromJSONDictionary:dic error:nil];
    
    self.enrollPersons.text = [NSString stringWithFormat:@"%d / %d", self.detailModel.realNum, self.detailModel.needNum];
    self.organizer.text = self.detailModel.nickName;
    [self.descTextView setText:self.detailModel.desc];
    [self.descTextView setFont:[UIFont systemFontOfSize:18]];
//    [self.descTextView updateConstraints];

}

- (void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)backView:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)toUserCenter:(UIButton *)sender {
    UserCenterController *userCenter = [[UserCenterController alloc] initWithNibName:@"UserCenterController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:userCenter animated:YES];
}

- (UIImage *)getScaleUIImage:(NSString*)name Height:(CGFloat)height{
    UIImage *bubble = [UIImage imageNamed:name];

    CGPoint center = CGPointMake(bubble.size.width / 2.0f, height);
    UIEdgeInsets capInsets = UIEdgeInsetsMake(center.y, 0, center.y+1, 2);
    return [bubble resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
    
}
@end
