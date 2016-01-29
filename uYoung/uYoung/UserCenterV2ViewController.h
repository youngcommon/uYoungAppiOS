//
//  UserCenterV2ViewController.h
//  uYoung
//
//  Created by 独自天涯 on 16/1/28.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityTableViewController.h"
#import "AlbumTableViewController.h"
#import "UserDetailModel.h"
#import "SystemConfigViewController.h"

@interface UserCenterV2ViewController : UIViewController

@property (strong, nonatomic) UserDetailModel *userDetailModel;
@property (assign, nonatomic) BOOL isSelf;
@property (assign, nonatomic) CGRect oriFrame;

@property (strong, nonatomic) IBOutlet UIButton *sysconfigButton;
@property (strong, nonatomic) IBOutlet UIImageView *headerImg;
@property (strong, nonatomic) IBOutlet UILabel *nickLabel;
@property (strong, nonatomic) IBOutlet UIImageView *genderImg;
@property (strong, nonatomic) IBOutlet UIButton *editButton;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *albumLineLabel;
@property (strong, nonatomic) IBOutlet UILabel *actLineLabel;

@property (strong, nonatomic) UILabel *companyLabel;
@property (strong, nonatomic) UILabel *currentTitleLabel;
@property (strong, nonatomic) UILabel *cameraLabel;
@property (strong, nonatomic) UIView *cover;
@property (strong, nonatomic) SystemConfigViewController *sysCtl;
@property (strong, nonatomic) ActivityTableViewController *postActCtl;
@property (strong, nonatomic) ActivityTableViewController *signedActCtl;
@property (strong, nonatomic) AlbumTableViewController *albumCtl;

- (IBAction)back:(id)sender;
- (IBAction)sysconfig:(id)sender;
- (IBAction)editUser:(id)sender;
@end
