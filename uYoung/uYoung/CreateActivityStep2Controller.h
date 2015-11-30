//
//  CreateActivityStep2Controller.h
//  uYoung
//
//  Created by 独自天涯 on 15/11/30.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityDescTextView.h"

@interface CreateActivityStep2Controller : UIViewController

@property (strong, nonatomic) NSDictionary *step1Data;

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImg;
@property (strong, nonatomic) IBOutlet UIImageView *dividLine;

- (IBAction)createActivity:(id)sender;
- (IBAction)back:(id)sender;
@end
