//
//  ActivityFilterViewController.h
//  uYoung
//
//  Created by CSDN on 15/12/7.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ActivityFilterDelegate <NSObject>
@optional

@end

@interface ActivityFilterViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *createTimeButton;
@property (strong, nonatomic) IBOutlet UIButton *actTimeButton;
@property (strong, nonatomic) IBOutlet UIButton *actTypeButton;
@property (strong, nonatomic) IBOutlet UIButton *actStatusButton;
@property (strong, nonatomic) IBOutlet UISwitch *priceSwitch;
@property (strong, nonatomic) IBOutlet UIButton *commitButton;

- (IBAction)commit:(id)sender;
@end
