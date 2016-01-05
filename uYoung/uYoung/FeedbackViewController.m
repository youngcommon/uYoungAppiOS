//
//  FeedbackViewController.m
//  uYoung
//
//  Created by 独自天涯 on 16/1/5.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import "FeedbackViewController.h"
#import "GlobalNetwork.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submit:(id)sender {
    NSString *emailTxt = _email.text;
    NSString *contentTxt = _content.text;
    [GlobalNetwork submitFeedback:emailTxt content:contentTxt handle:^(BOOL isSuccess) {
        if (isSuccess) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}
@end
