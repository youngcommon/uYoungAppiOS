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

@interface RootViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *toggle;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UIView *header;
@property (strong, nonatomic) UIButton *userHeader;
@property (strong, nonatomic) ActivityFilterViewController *filter;
@property (assign, nonatomic) BOOL isFilter;
@property (strong, nonatomic) UILabel *userHeaderBackground;
@property (strong, nonatomic) ActivityTableViewController *activityTabViewController;

@property (assign, nonatomic) CGRect viewFrameOrigin;
@property (assign, nonatomic) CGRect headerFrameOrigin;
@property (assign, nonatomic) CGRect filterFrameOrigin;
@property (assign, nonatomic) CGRect headBackOrigin;
@property (assign, nonatomic) CGRect headFrameOrigin;

- (IBAction)showFilter:(id)sender;

@end
