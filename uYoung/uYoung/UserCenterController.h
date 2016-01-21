//
//  UserCenterController.h
//  uYoung
//
//  Created by CSDN on 15/10/13.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConfig.h"
#import "AlbumTableViewController.h"
#import "ActivityTableViewController.h"
#import "UserDetail.h"
#import "UserDetailModel.h"
#import "NSString+StringUtil.h"
#import "EditUserViewController.h"
#import "ThirdLoginViewController.h"
#import "SystemConfigViewController.h"

@interface UserCenterController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *positionTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTitleTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *cameraTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *cameraLabel;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;

@property (weak, nonatomic) IBOutlet UILabel *headerBackgroundLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet UIImageView *headerBackBlurImg;
@property (weak, nonatomic) IBOutlet UIImageView *genderImageView;
@property (strong, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *sysconfigButton;

@property (strong, nonatomic) UIButton *myAlbumButton;
@property (strong, nonatomic) UIButton *myActButton;
@property (assign, nonatomic) NSInteger tag;//标记那个button当前被选中

@property (strong, nonatomic) UIView *cover;
@property (strong, nonatomic) SystemConfigViewController *sysCtl;
@property (assign, nonatomic) CGRect oriFrame;

@property (assign, nonatomic) CGFloat delta;

@property (strong, nonatomic) UserDetailModel *userDetailModel;

@property (strong, nonatomic) AlbumTableViewController *albumTableViewController;
@property (strong, nonatomic) ActivityTableViewController *activityTableViewController;

@property (assign, nonatomic) long userId;
@property (assign, nonatomic) BOOL isSelf;//标记是否为登陆用户自己的个人中心

- (IBAction)editUser:(id)sender;
- (IBAction)systemConfig:(id)sender;

- (IBAction)getBack:(id)sender;

@end
