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
#import "UIImageView+LazyInit.h"
#import "UIWindow+YoungHUD.h"
#import "UYoungAlertViewUtil.h"

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
    self.activityTabViewController.showHeader = YES;
    [self addChildViewController:self.activityTabViewController];
    [self.view addSubview:self.activityTabViewController.view];
    
    self.activityTabViewController.tableView.frame = CGRectMake(0, y, self.view.frame.size.width, self.view.frame.size.height - y);
    [self.activityTabViewController.tableView setBackgroundColor:[UIColor clearColor]];
    self.activityTabViewController.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.toggle setHidden:YES];
    /*[self.toggle addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];*/
    
//    NSDictionary *defaultParam = [[NSDictionary alloc]initWithObjectsAndKeys:@(1),@"createTimeSort", @"desc",@"sort", nil];
//    [self.activityTabViewController resetActivityList:defaultParam];
    
    _userHeaderBackground = [[UILabel alloc]initWithFrame:CGRectMake(mScreenWidth/2-33, mScreenHeight-10-66, 66, 66)];
    _userHeaderBackground.backgroundColor = UIColorFromRGB(0x85b200);
    _userHeaderBackground.alpha = 0.6;
    _userHeaderBackground.layer.cornerRadius = _userHeaderBackground.frame.size.height/2;
    _userHeaderBackground.layer.masksToBounds = YES;
    [self.view addSubview:_userHeaderBackground];
    
    _userHeader = [[UIButton alloc]initWithFrame:CGRectMake(_userHeaderBackground.frame.origin.x+5, _userHeaderBackground.frame.origin.y+5, 56, 56)];
    _userHeader.layer.cornerRadius = _userHeader.frame.size.height/2;
    _userHeader.layer.masksToBounds = YES;
    [_userHeader addTarget:self action:@selector(gotoUserCenter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_userHeader];
    
    _cover = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight)];
    [_cover setBackgroundColor:[UIColor lightGrayColor]];
    _cover.alpha = 0.5f;
    [self.view addSubview:_cover];
    [_cover setHidden:YES];
    
    _filter = [[ActivityFilterViewController alloc]initWithNibName:@"ActivityFilterViewController" bundle:[NSBundle mainBundle]];
    _filter.view.frame = CGRectMake(mScreenWidth+_filter.view.frame.size.width, 0, _filter.view.frame.size.width, _filter.view.frame.size.height);
    _filter.delegate = self;
    [self addChildViewController:_filter];
    [self.view addSubview:_filter.view];
    
    _isFilter = NO;
    
    [self checkUpdate];
    
}

- (void)checkUpdate{
    //查看是否有新版本客户端
    [GlobalNetwork checkNewVersion:^(NSDictionary *dict) {
        if (dict!=nil&&![dict isEqual:[NSNull null]]) {
            NSString *version = dict[@"version"];//最新版本
            BOOL inReview = [dict[@"status"]boolValue];//审核状态, YES代表审核通过
            // app版本
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            NSString *app_version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            if (![app_version isEqualToString:version]&&inReview) {//如果当前客户端版本同最新版本不同且最新版本已通过审核
                _forceUpdate = [dict[@"isUpdate"]boolValue];//是否强制更新
                NSString *updateContent = dict[@"updateContent"];
                if ([NSString isBlankString:updateContent]) {
                    updateContent = nil;
                }
                NSString *cancelTxt = @"再说吧";
                if(_forceUpdate){
                    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight)];
                    view.backgroundColor = [UIColor lightGrayColor];
                    view.alpha = 0.8;
                    [self.view addSubview:view];
                    cancelTxt = nil;
                }
                [[UYoungAlertViewUtil shareInstance]createAlertView:@"有更新啦~~" Message:updateContent CancelTxt:cancelTxt OtherTxt:@"去更新" Tag:0 Delegate:self];
            }
        }
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    [self initUserAvater];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (_forceUpdate||buttonIndex==1) {
        NSString *str = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1050432865";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

- (void)gotoUserCenter{
    UserCenterController *userCenter = [[UserCenterController alloc] initWithNibName:@"UserCenterController" bundle:[NSBundle mainBundle]];
    userCenter.userDetailModel = [UserDetailModel currentUser];
    [self.navigationController pushViewController:userCenter animated:YES];
}

/*- (void)segmentAction:(UISegmentedControl*)seg{
    NSInteger index = seg.selectedSegmentIndex;
    [self.activityTabViewController initActivityList:(index+1)];
}*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initUserAvater{
    UserDetailModel *loginUser = [UserDetailModel currentUser];
    if ([NSString isBlankString:loginUser.avatarUrl]==NO) {
        NSString *avatarUrl = loginUser.avatarUrl;
        [UploadImageUtil lazyInitAvatarOfButton:avatarUrl button:_userHeader];
    }else{
        [_userHeader setBackgroundImage:[UIImage imageNamed:@"uyoung.bundle/logo_icon"] forState:UIControlStateNormal];
    }
}

- (IBAction)showFilter:(id)sender {
    if (_isFilter==NO) {
        CGRect filterFrame = CGRectMake(mScreenWidth-_filter.view.frame.size.width, 0, _filter.view.frame.size.width, _filter.view.frame.size.height);
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3];
        [self.filter.view setFrame:filterFrame];
        [UIView commitAnimations];
        _isFilter = YES;
        [_cover setHidden:NO];
    }else{
        CGRect filterFrame = CGRectMake(mScreenWidth+_filter.view.frame.size.width, 0, _filter.view.frame.size.width, _filter.view.frame.size.height);
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3];
        [self.filter.view setFrame:filterFrame];
        [UIView commitAnimations];
        _isFilter = NO;
        [_cover setHidden:YES];
    }
}

-(void)commitWithFilterData:(NSDictionary*)data{
    [self.view.window showHUDWithText:@"加载中..." Type:ShowLoading Enabled:YES];
    [self.activityTabViewController resetActivityList:data];
    [self showFilter:nil];
}

@end








