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

@property (assign, nonatomic) NSInteger gender;

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

- (IBAction)genderSel:(UIButton *)sender;


//constraints
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *userHeaderButtonH;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *userHeaderButtonW;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *nicknameImageW;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *genderImageW;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *locationImageW;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *companyImageW;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *positionImageW;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *emailImageW;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mobileImageW;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *equipmentImageW;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *firstDistanceCons;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *secondDistanceCons;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *thirdDistanceCons;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *fourthDistanceCons;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topCons;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *firstSepCons;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *secondSepCons;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *thirdSepCons;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *headerTopCons;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *genderSelCons;



- (IBAction)back:(id)sender;

@end
