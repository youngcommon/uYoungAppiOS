//
//  ActivityDetailViewController.h
//  uYoung
//
//  Created by CSDN on 15/9/25.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"
#import "ActivityDetailModel.h"
#import "GlobalConfig.h"
#import "UserCenterController.h"
#import "ActivityDetail.h"
#import "EnrollCollectionView.h"
#import "ThirdLoginViewController.h"

@interface ActivityDetailViewController : UIViewController<EnrollCollectionViewDelegate>

@property (strong, nonatomic) ActivityModel *model;
@property (strong, nonatomic) ActivityDetailModel *detailModel;
@property (strong, nonatomic) UserDetailModel *loginUser;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIImageView *headerBackground;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *userHeader;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sepLineCons;
@property (strong, nonatomic) UILabel *actDate;
@property (strong, nonatomic) UILabel *actDateTitle;
@property (strong, nonatomic) UILabel *actTime;
@property (strong, nonatomic) UILabel *actTimeTitle;
@property (strong, nonatomic) UILabel *actType;
@property (strong, nonatomic) UILabel *actTypeTitle;
@property (strong, nonatomic) UILabel *enrollPersons;
@property (strong, nonatomic) UILabel *enrollPersonsTitle;
@property (strong, nonatomic) UILabel *organizer;
@property (strong, nonatomic) UILabel *organizerTitle;
@property (strong, nonatomic) UILabel *addr;
@property (strong, nonatomic) UILabel *addrTitle;

@property (weak, nonatomic) IBOutlet UIImageView *freeSignetImg;
@property (weak, nonatomic) IBOutlet UIScrollView *descScrollView;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

//分页导航
@property (strong, nonatomic) UIImageView *descImageView;
@property (strong, nonatomic) UIImageView *enrollImageView;
@property (strong, nonatomic) UILabel *descLabel;
@property (strong, nonatomic) UILabel *enrollLabel;

- (IBAction)backView:(UIButton *)sender;
- (IBAction)toUserCenter:(UIButton *)sender;
@end
