//
//  UserCenterController.h
//  uYoung
//
//  Created by CSDN on 15/10/13.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCenterController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *headerBackgroundLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet UIImageView *headerBackBlurImg;


- (IBAction)getBack:(id)sender;

@end
