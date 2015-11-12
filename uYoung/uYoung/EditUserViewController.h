//
//  EditUserViewController.h
//  uYoung
//
//  Created by 独自天涯 on 15/11/4.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConfig.h"

@interface EditUserViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *backCoverImageView;
@property (strong, nonatomic) IBOutlet UIButton *userHeaderButton;
@property (strong, nonatomic) IBOutlet UIImageView *nicknameImage;
@property (strong, nonatomic) IBOutlet UITextField *nicknameInput;
@property (strong, nonatomic) IBOutlet UIImageView *genderImage;
@property (strong, nonatomic) IBOutlet UIImageView *genderBackImage;
@property (strong, nonatomic) IBOutlet UIImageView *locationImage;
@property (strong, nonatomic) IBOutlet UIImageView *locationBackImage;
@property (strong, nonatomic) IBOutlet UIImageView *companyImage;
@property (strong, nonatomic) IBOutlet UITextField *companyInput;
@property (strong, nonatomic) IBOutlet UIImageView *positionImage;
@property (strong, nonatomic) IBOutlet UITextField *positionInput;
@property (strong, nonatomic) IBOutlet UIImageView *emailImage;
@property (strong, nonatomic) IBOutlet UITextField *emailInput;
@property (strong, nonatomic) IBOutlet UIImageView *mobileImage;
@property (strong, nonatomic) IBOutlet UITextField *mobileInput;
@property (strong, nonatomic) IBOutlet UIImageView *equipmentImage;
@property (strong, nonatomic) IBOutlet UITextField *equipmentInput;

- (IBAction)back:(id)sender;

@end
