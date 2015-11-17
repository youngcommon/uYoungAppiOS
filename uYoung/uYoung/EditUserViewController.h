//
//  EditUserViewController.h
//  uYoung
//
//  Created by 独自天涯 on 15/11/4.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "GlobalConfig.h"
#import "UserDetailModel.h"
#import "UpdateUser.h"
#import "UserDetail.h"
#import "UploadImageUtil.h"

@interface EditUserViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UpdateUserDelegate, UserDetailDelegate, UploadImgDelegate>

@property (assign, nonatomic) NSInteger gender;
@property (assign, nonatomic) BOOL locationIsDown;
@property (strong, nonatomic) UIPickerView *citySelector;
@property (strong, nonatomic) NSArray *cityArr;
@property (strong, nonatomic) NSArray *provinceArr;
@property (strong, nonatomic) NSDictionary *citydict;
@property (strong, nonatomic) UIButton *selectedButton;
@property (strong, nonatomic) UIButton *cancelButton;
@property (nonatomic, strong) UIImagePickerController *camera;
@property (strong, nonatomic) NSString *avater;
@property (strong, nonatomic) UserDetailModel *loginUser;
@property (strong, nonatomic) UserDetailModel *tempLoginUser;

- (IBAction)updateUser:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *maleButton;
@property (weak, nonatomic) IBOutlet UIButton *femaleButton;
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
@property (weak, nonatomic) IBOutlet UIButton *locationSelButton;
@property (weak, nonatomic) IBOutlet UIImageView *locationSelImage;


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


- (IBAction)locationSel:(UIButton *)sender;

- (IBAction)back:(id)sender;
- (IBAction)changeHeader:(UIButton *)sender;
- (IBAction)textfieldEditingChanged:(UITextField *)sender;

@end
