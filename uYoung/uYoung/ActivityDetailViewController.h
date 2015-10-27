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
#import "LoginViewController.h"

@interface ActivityDetailViewController : UIViewController

@property (strong, nonatomic) ActivityModel *model;
@property (strong, nonatomic) ActivityDetailModel *detailModel;

@property (weak, nonatomic) IBOutlet UIImageView *headerBackground;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *userHeader;
@property (weak, nonatomic) IBOutlet UILabel *actDate;
@property (weak, nonatomic) IBOutlet UILabel *actTime;
@property (weak, nonatomic) IBOutlet UILabel *actType;
@property (weak, nonatomic) IBOutlet UILabel *enrollPersons;
@property (weak, nonatomic) IBOutlet UILabel *organizer;
@property (weak, nonatomic) IBOutlet UILabel *addr;
@property (weak, nonatomic) IBOutlet UILabel *addrTitle;
@property (weak, nonatomic) IBOutlet UIImageView *freeSignetImg;
@property (weak, nonatomic) IBOutlet UIScrollView *descScrollView;
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addrHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addrTitleHeight;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

//分页导航
@property (strong, nonatomic) UIImageView *descImageView;
@property (strong, nonatomic) UIImageView *enrollImageView;
@property (strong, nonatomic) UILabel *descLabel;
@property (strong, nonatomic) UILabel *enrollLabel;

- (IBAction)backView:(UIButton *)sender;
- (IBAction)toUserCenter:(UIButton *)sender;
@end
