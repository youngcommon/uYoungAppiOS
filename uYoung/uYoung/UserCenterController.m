//
//  UserCenterController.m
//  uYoung
//
//  Created by CSDN on 15/10/13.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "UserCenterController.h"
#import <UIImageView+AFNetworking.h>
#import <UIImageView+LBBlurredImage.h>

@implementation UserCenterController

- (void)viewDidLoad{
    //根据屏幕宽度，增加label字号，6增一，plus增二
    NSString *fontName = [self.positionTitleLabel.font fontName];
    UIFont *font;
    if(mScreenWidth==375){//iPhone 6
        font = [UIFont fontWithName:fontName size:14];
    }else if(mScreenWidth>375){//iPhone 6+
        font = [UIFont fontWithName:fontName size:16];
    }
    [self.positionTitleLabel setFont:font];
    [self.positionLabel setFont:font];
    [self.companyTitleLabel setFont:font];
    [self.companyLabel setFont:font];
    [self.currentTitleTitleLabel setFont:font];
    [self.currentTitleLabel setFont:font];
    [self.cameraTitleLabel setFont:font];
    [self.cameraLabel setFont:font];
//    NSLog(@"%f+++++++++++++", mScreenWidth);
    //========================================
    
    self.headerBackgroundLabel.layer.cornerRadius = self.headerBackgroundLabel.frame.size.height/2;
    self.headerBackgroundLabel.layer.masksToBounds = YES;
    
    self.headerImg.layer.cornerRadius = self.headerImg.frame.size.height/2;
    self.headerImg.layer.masksToBounds = YES;
    self.headerImg.layer.borderWidth = 1.;
    self.headerImg.layer.borderColor = [[UIColor brownColor] CGColor];
    
    CGFloat buttonWidth = mScreenWidth / 2;
    CGFloat buttonHeight = 46;
    CGFloat x = 0;
    CGFloat y = self.headerBackBlurImg.frame.origin.y + self.headerBackBlurImg.frame.size.height - buttonHeight;
    //增加我的相册和我的活动按钮
    UIButton *myAlbumButton = [[UIButton alloc]initWithFrame:CGRectMake(x, y, buttonWidth, buttonHeight)];
    [myAlbumButton setTitle:@"我的相册(5)" forState:UIControlStateNormal];
    [myAlbumButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [myAlbumButton setBackgroundColor:UIColorFromRGB(0x027AFF)];
    [myAlbumButton setAlpha:0.65];
    [self.view addSubview:myAlbumButton];
    
    UIButton *myActButton = [[UIButton alloc]initWithFrame:CGRectMake(x+buttonWidth, y, buttonWidth, buttonHeight)];
    [myActButton setTitle:@"我的活动(10)" forState:UIControlStateNormal];
    [myActButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [myActButton setBackgroundColor:UIColorFromRGB(0x027AFF)];
    [myActButton setAlpha:0.3];
    [self.view addSubview:myActButton];
    
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://img.61gequ.com/allimg/2011-4/201142614314278502.jpg"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [self.headerBackBlurImg setImageWithURLRequest:theRequest placeholderImage:[UIImage imageNamed:@""]     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
        [self.headerBackBlurImg setImageToBlur:image blurRadius:80. completionBlock:nil];
        [self.headerImg setImage:image];
    
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){}];
    
}

- (IBAction)getBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
