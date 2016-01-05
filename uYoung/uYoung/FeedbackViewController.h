//
//  FeedbackViewController.h
//  uYoung
//
//  Created by 独自天涯 on 16/1/5.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedbackViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextView *content;
- (IBAction)back:(id)sender;
- (IBAction)submit:(id)sender;

@end
