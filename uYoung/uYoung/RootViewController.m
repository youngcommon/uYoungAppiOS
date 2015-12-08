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
    
}

- (void)viewDidAppear:(BOOL)animated{
    [self initUserAvater];
}

- (void)gotoUserCenter{
    
//    UserCenterController *userCenter = [[UserCenterController alloc] initWithNibName:@"UserCenterController" bundle:[NSBundle mainBundle]];
//    [self.navigationController pushViewController:userCenter animated:YES];
    CreateActivityController *editUserViewCtl = [[CreateActivityController alloc] initWithNibName:@"CreateActivityController" bundle:[NSBundle mainBundle]];
//    ActivityAlbumViewController *editUserViewCtl = [[ActivityAlbumViewController alloc] initWithNibName:@"ActivityAlbumViewController" bundle:[NSBundle mainBundle]];
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
    UserDetailModel *loginUser = [UserDetailModel currentUser];
    if ([NSString isBlankString:loginUser.avatarUrl]==NO) {
        [_userHeader.imageView lazyInitSmallImageWithUrl:loginUser.avatarUrl];
        /*NSString *avaterUrl = loginUser.avatarUrl;
        NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:avaterUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        [_userHeader.imageView setImageWithURLRequest:theRequest placeholderImage:[UIImage imageNamed:UserDefaultHeader] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
            [header setBackgroundImage:image forState:UIControlStateNormal];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
        }];*/
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
    [self showFilter:nil];
}

@end








