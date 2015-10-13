//
//  ActivityDetailViewController.h
//  uYoung
//
//  Created by CSDN on 15/9/25.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"
#import "GlobalConfig.h"
#import "UserCenterController.h"

@interface ActivityDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *headerBackground;
@property (strong, nonatomic) ActivityModel *model;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *userHeader;
- (IBAction)backView:(UIButton *)sender;
- (IBAction)toUserCenter:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *actDate;
@property (weak, nonatomic) IBOutlet UILabel *actTime;
@property (weak, nonatomic) IBOutlet UILabel *actType;
@property (weak, nonatomic) IBOutlet UILabel *enrollPersons;
@property (weak, nonatomic) IBOutlet UILabel *organizer;
@property (weak, nonatomic) IBOutlet UILabel *addr;
@property (weak, nonatomic) IBOutlet UIImageView *freeSignetImg;
@property (weak, nonatomic) IBOutlet UIScrollView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *button;


@end
