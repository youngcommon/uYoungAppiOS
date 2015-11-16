//
//  UYoungAlertViewUtil.m
//  uYoung
//
//  Created by 独自天涯 on 15/11/16.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "UYoungAlertViewUtil.h"

@implementation UYoungAlertViewUtil

+(UYoungAlertViewUtil *)shareInstance{
    static dispatch_once_t pred;
    static UYoungAlertViewUtil *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[UYoungAlertViewUtil alloc] init];
    });
    return shared;
}

- (void)dismissAlertView{
    if (self.alert) {
        [self.alert dismissWithClickedButtonIndex:0 animated:NO];
    }
}

- (void)createAlertView:(NSString*)title Message:(NSString*)message CancelTxt:(NSString*)cancelTxt OtherTxt:(NSString*)otherTxt Tag:(NSInteger)tag Delegate:(id<UIAlertViewDelegate>)delegate{
    [self dismissAlertView];
    self.alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelTxt otherButtonTitles:otherTxt, nil];
    self.alert.delegate = delegate;
    [self.alert setTag:tag];
    [self.alert show];
}

@end
