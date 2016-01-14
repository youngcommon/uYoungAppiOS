//
//  UYoungAlertViewUtil.h
//  uYoung
//
//  Created by 独自天涯 on 15/11/16.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UYoungAlertViewUtil : UIView

@property (nonatomic, strong) UIAlertView *alert;

+(UYoungAlertViewUtil *)shareInstance;

- (void)dismissAlertView;
- (void)createAlertView:(NSString*)title Message:(NSString*)message CancelTxt:(NSString*)cancelTxt OtherTxt:(NSString*)otherTxt Tag:(NSInteger)tag Delegate:(id<UIAlertViewDelegate>)delegate;

- (void)createAlertViewWith:(NSString*)title Delegate:(id<UIAlertViewDelegate>)delegate;

@end
