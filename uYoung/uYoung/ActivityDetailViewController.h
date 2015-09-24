//
//  ActivityDetailViewController.h
//  uYoung
//
//  Created by CSDN on 15/9/25.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"

@interface ActivityDetailViewController : UIViewController

@property (strong, nonatomic) ActivityModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
- (IBAction)backView:(UIButton *)sender;

@end
