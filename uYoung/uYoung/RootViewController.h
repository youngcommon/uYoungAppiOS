//
//  RootViewController.h
//  uYoung
//
//  Created by CSDN on 15/9/22.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConfig.h"
#import "ActivityTableViewController.h"
#import "mantle.h"
#import "ActivityFilterViewController.h"
#import "CityModel.h"

@interface RootViewController : UIViewController<ActivityFilterDelegate, UIAlertViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *toggle;
@property (weak, nonatomic) IBOutlet UIView *header;
@property (weak, nonatomic) IBOutlet UIButton *cityButton;
@property (strong, nonatomic) UIButton *userHeader;
@property (strong, nonatomic) ActivityFilterViewController *filter;
@property (assign, nonatomic) BOOL isFilter;
@property (strong, nonatomic) UILabel *userHeaderBackground;
@property (strong, nonatomic) ActivityTableViewController *activityTabViewController;

@property (strong, nonatomic) UIView *cover;
@property (strong, nonatomic) UIPickerView *citySelector;
@property (strong, nonatomic) UIButton *selectedButton;
@property (strong, nonatomic) UIButton *cancelButton;

@property (assign, nonatomic) BOOL forceUpdate;
@property (assign, nonatomic) NSInteger cityId;
@property (strong, nonatomic) NSString *cityName;
@property (strong, nonatomic) NSArray *allCity;

- (IBAction)showFilter:(id)sender;
- (IBAction)changeCity:(id)sender;

@end
