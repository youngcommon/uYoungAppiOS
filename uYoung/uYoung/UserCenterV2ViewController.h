//
//  UserCenterV2ViewController.h
//  uYoung
//
//  Created by 独自天涯 on 16/1/28.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityTableViewController.h"
//#import "AlbumTableViewController.h"
#import "AlbumCollectionViewController.h"
#import "UserDetailModel.h"
#import "SystemConfigViewController.h"

@interface UserCenterV2ViewController : UIViewController

@property (strong, nonatomic) UserDetailModel *userDetailModel;
@property (assign, nonatomic) BOOL isSelf;
@property (assign, nonatomic) CGRect oriFrame;
@property (assign, nonatomic) CGRect headerOriFrame;
@property (assign, nonatomic) CGRect headerNewFrame;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *headerViewCons;

//headerView under
@property (strong, nonatomic) IBOutlet UILabel *companyTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *companyLabel;
@property (strong, nonatomic) IBOutlet UILabel *positionTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *positionLabel;
@property (strong, nonatomic) IBOutlet UILabel *equipTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *equipLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UILabel *mobileTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *mobileLabel;
//headerView above

@property (weak, nonatomic) IBOutlet UIImageView *headerViewBack;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIView *albumView;
@property (strong, nonatomic) IBOutlet UIButton *sysconfigButton;
@property (strong, nonatomic) IBOutlet UIImageView *headerImg;
@property (strong, nonatomic) IBOutlet UILabel *nickLabel;
@property (strong, nonatomic) IBOutlet UIImageView *genderImg;
@property (strong, nonatomic) IBOutlet UIButton *editButton;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *albumLineLabel;
@property (strong, nonatomic) IBOutlet UIButton *createAlbumButton;
@property (strong, nonatomic) IBOutlet UIButton *createActButton;
@property (strong, nonatomic) IBOutlet UIButton *detailButton;
@property (strong, nonatomic) IBOutlet UIButton *createdActBtn;
@property (strong, nonatomic) IBOutlet UIButton *signedActBtn;

@property (strong, nonatomic) UIImageView *backBlurHeader;
@property (strong, nonatomic) UIView *cover;
@property (strong, nonatomic) SystemConfigViewController *sysCtl;
@property (strong, nonatomic) ActivityTableViewController *postActCtl;
@property (strong, nonatomic) ActivityTableViewController *signedActCtl;
@property (strong, nonatomic) AlbumCollectionViewController *albumCtl;

- (IBAction)back:(id)sender;
- (IBAction)sysconfig:(id)sender;
- (IBAction)editUser:(id)sender;
- (IBAction)create:(UIButton*)sender;
- (IBAction)toggleUserDetail:(UIButton *)sender;
- (IBAction)changeActList:(UIButton *)sender;

@end
