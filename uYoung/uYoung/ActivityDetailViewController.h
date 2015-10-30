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
#import "UYoungUser.h"

@interface ActivityDetailViewController : UIViewController

@property (strong, nonatomic) ActivityModel *model;
@property (strong, nonatomic) ActivityDetailModel *detailModel;
@property (strong, nonatomic) UYoungUser *loginUser;

@property (weak, nonatomic) IBOutlet UIImageView *headerBackground;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *userHeader;

@property (weak, nonatomic) IBOutlet UILabel *actDate;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *actDateConsHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *actDateConsWidth;

@property (weak, nonatomic) IBOutlet UILabel *actDateTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *actDateTitleConsWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *actDateTitleConsHeight;

@property (weak, nonatomic) IBOutlet UILabel *actTime;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *actTimeConsHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *actTImeConsWidth;

@property (weak, nonatomic) IBOutlet UILabel *actTimeTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *actTimeTitleConsWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *actTimeTitleConsHeight;

@property (weak, nonatomic) IBOutlet UILabel *actType;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *actTypeConsWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *actTypeConsHeight;

@property (weak, nonatomic) IBOutlet UILabel *actTypeTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *actTypeTitleConsWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *actTypeTitleConsHeight;

@property (weak, nonatomic) IBOutlet UILabel *enrollPersons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *enrollPersonsConsWidht;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *enrollPersonsConsHeight;

@property (weak, nonatomic) IBOutlet UILabel *enrollPersonsTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *enrollPersonsTitleConsHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *enrollPersonsTitleConsWidth;

@property (weak, nonatomic) IBOutlet UILabel *organizer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orgConsHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orgConsWidth;

@property (weak, nonatomic) IBOutlet UILabel *organizerTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orgConsTitleWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orgConsTitleHeight;

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
