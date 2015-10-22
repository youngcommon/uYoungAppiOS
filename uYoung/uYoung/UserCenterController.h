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

@property (strong, nonatomic) UIButton *myAlbumButton;
@property (strong, nonatomic) UIButton *myActButton;

@property (strong, nonatomic) UserDetailModel *userDetailModel;

@property (strong, nonatomic) AlbumTableViewController *albumTableViewController;
@property (strong, nonatomic) ActivityTableViewController *activityTableViewController;

@property (assign, nonatomic) NSInteger userId;

- (IBAction)getBack:(id)sender;

@end