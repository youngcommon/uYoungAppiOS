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

- (void)createAlertViewWith:(NSString*)title Delegate:(id<UIAlertViewDelegate>)delegate{
    [self dismissAlertView];
    self.alert = [[UIAlertView alloc] initWithTitle:nil message:title delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    self.alert.delegate = delegate;
    self.alert.tag = 1001;
    [self.alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    UITextField *nameField = [self.alert textFieldAtIndex:0];
    nameField.placeholder = @"请输相册名称(20字以内)";
    [nameField addTarget:self action:@selector(inputCheck:) forControlEvents:UIControlEventEditingChanged];
    [self.alert show];
}

- (void)createAlertViewWith:(NSString*)title tag:(NSInteger)tag Delegate:(id<UIAlertViewDelegate>)delegate{
    [self dismissAlertView];
    self.alert = [[UIAlertView alloc] initWithTitle:nil message:title delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    self.alert.delegate = delegate;
    self.alert.tag = tag;
    [self.alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    UITextField *nameField = [self.alert textFieldAtIndex:0];
    nameField.placeholder = @"请输相册名称(20字以内)";
    [nameField addTarget:self action:@selector(inputCheck:) forControlEvents:UIControlEventEditingChanged];
    [self.alert show];
}

- (void)inputCheck:(UITextField *)sender{
    NSInteger textLength = 20;
    if (sender.text.length > textLength) {
        sender.text = [sender.text substringToIndex:textLength];
    }
}

@end
