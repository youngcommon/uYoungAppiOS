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

@interface RootViewController : UIViewController<ActivityFilterDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *toggle;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UIView *header;
@property (strong, nonatomic) UIButton *userHeader;
@property (strong, nonatomic) ActivityFilterViewController *filter;
@property (assign, nonatomic) BOOL isFilter;
@property (strong, nonatomic) UILabel *userHeaderBackground;
@property (strong, nonatomic) ActivityTableViewController *activityTabViewController;

@property (strong, nonatomic) UIView *cover;

@property (assign, nonatomic) BOOL forceUpdate;

- (IBAction)showFilter:(id)sender;

@end
