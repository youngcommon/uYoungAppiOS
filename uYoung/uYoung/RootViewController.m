//
//  RootViewController.m
//  uYoung
//
//  Created by CSDN on 15/9/22.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "RootViewController.h"
#import "ActivityModel.h"
#import "UserCenterController.h"
#import <UIImageView+AFNetworking.h>
#import "CreateActivityController.h"
#import "ActivityAlbumViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat y = 20;
    
    y += self.header.frame.size.height;
    
    self.activityTabViewController = [[ActivityTableViewController alloc]init];
    
    [self addChildViewController:self.activityTabViewController];
    [self.view addSubview:self.activityTabViewController.view];
    
    self.activityTabViewController.tableView.frame = CGRectMake(0, y, self.view.frame.size.width, self.view.frame.size.height - y);
    [self.activityTabViewController.tableView setBackgroundColor:[UIColor clearColor]];
    self.activityTabViewController.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.toggle addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    [self.activityTabViewController initActivityList:1];
    
    UILabel *userHeaderBackground = [[UILabel alloc]initWithFrame:CGRectMake(mScreenWidth/2-33, mScreenHeight-10-66, 66, 66)];
    userHeaderBackground.backgroundColor = UIColorFromRGB(0x85b200);
    userHeaderBackground.alpha = 0.6;
    userHeaderBackground.layer.cornerRadius = userHeaderBackground.frame.size.height/2;
    userHeaderBackground.layer.masksToBounds = YES;
    [self.view addSubview:userHeaderBackground];
    
    _userHeader = [[UIButton alloc]initWithFrame:CGRectMake(userHeaderBackground.frame.origin.x+5, userHeaderBackground.frame.origin.y+5, 56, 56)];
    _userHeader.layer.cornerRadius = _userHeader.frame.size.height/2;
    _userHeader.layer.masksToBounds = YES;
    [_userHeader addTarget:self action:@selector(gotoUserCenter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_userHeader];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [self initUserAvater];
}

- (void)gotoUserCenter{
    
//    UserCenterController *userCenter = [[UserCenterController alloc] initWithNibName:@"UserCenterController" bundle:[NSBundle mainBundle]];
//    [self.navigationController pushViewController:userCenter animated:YES];
//    CreateActivityController *editUserViewCtl = [[CreateActivityController alloc] initWithNibName:@"CreateActivityController" bundle:[NSBundle mainBundle]];
    ActivityAlbumViewController *editUserViewCtl = [[ActivityAlbumViewController alloc] initWithNibName:@"ActivityAlbumViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:editUserViewCtl animated:YES];
    
}

- (void)segmentAction:(UISegmentedControl*)seg{
    NSInteger index = seg.selectedSegmentIndex;
    [self.activityTabViewController initActivityList:(index+1)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initUserAvater{
    __weak UIButton *header = _userHeader;
    
    UserDetailModel *loginUser = [UserDetailModel currentUser];
    if ([NSString isBlankString:loginUser.avatarUrl]==NO) {
        NSString *avaterUrl = loginUser.avatarUrl;
        NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:avaterUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        [_userHeader.imageView setImageWithURLRequest:theRequest placeholderImage:[UIImage imageNamed:UserDefaultHeader] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
            [header setBackgroundImage:image forState:UIControlStateNormal];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
        }];
    }else{
        [_userHeader setBackgroundImage:[UIImage imageNamed:@"uyoung.bundle/logo_icon"] forState:UIControlStateNormal];
    }
}

@end








