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
    if(mScreenWidth>375){
        if (mScreenWidth==375) {//iPhone 6
            font = [UIFont fontWithName:fontName size:14];
        }else{//iPhone 6+
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
    }
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
    _myAlbumButton = [[UIButton alloc]initWithFrame:CGRectMake(x, y, buttonWidth, buttonHeight)];
    [_myAlbumButton setTitle:@"我的相册(5)" forState:UIControlStateNormal];
    [_myAlbumButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_myAlbumButton setBackgroundColor:UIColorFromRGB(0x027AFF)];
    [_myAlbumButton setAlpha:0.65];
    [_myAlbumButton setTag:0];
    [_myAlbumButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_myAlbumButton];
    
    _myActButton = [[UIButton alloc]initWithFrame:CGRectMake(x+buttonWidth, y, buttonWidth, buttonHeight)];
    [_myActButton setTitle:@"我的活动(10)" forState:UIControlStateNormal];
    [_myActButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_myActButton setBackgroundColor:UIColorFromRGB(0x027AFF)];
    [_myActButton setAlpha:0.3];
    [_myActButton setTag:1];
    [_myActButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_myActButton];
    
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://img.61gequ.com/allimg/2011-4/201142614314278502.jpg"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [self.headerBackBlurImg setImageWithURLRequest:theRequest placeholderImage:[UIImage imageNamed:@""]     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
        [self.headerBackBlurImg setImageToBlur:image blurRadius:80. completionBlock:nil];
        [self.headerImg setImage:image];
    
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){}];
    
    //默认加载我的相册Controller
    self.albumTableViewController = [[AlbumTableViewController alloc]init];
    
    [self addChildViewController:self.albumTableViewController];
    [self.view addSubview:self.albumTableViewController.view];
    
    CGFloat indexY = self.headerBackBlurImg.frame.origin.y + self.headerBackBlurImg.frame.size.height;
    self.albumTableViewController.tableView.frame = CGRectMake(0, indexY, self.view.frame.size.width, self.view.frame.size.height - indexY);
    [self.albumTableViewController.tableView setBackgroundColor:[UIColor clearColor]];
    self.albumTableViewController.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void) buttonClick:(id)sender{
    if(sender&&[sender isKindOfClass:[UIButton class]]){
        UIButton *button = sender;
        NSInteger tag = button.tag;
        if (tag==0) {//点击的我的相册
            [_myActButton setAlpha:0.3];
            [_myAlbumButton setAlpha:0.65];
        }else if(tag==1){//点击我的活动
            [_myAlbumButton setAlpha:0.3];
            [_myActButton setAlpha:0.65];
        }
    }
}

- (IBAction)getBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
