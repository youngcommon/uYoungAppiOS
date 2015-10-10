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

@interface RootViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *toggle;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UIView *header;

@property (strong, nonatomic) ActivityTableViewController *activityTabViewController;

@end
