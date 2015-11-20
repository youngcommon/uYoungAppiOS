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
#import "EditUserViewController.h"

@implementation UserCenterController

- (void)viewDidLoad{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshViews:) name:@"usercenter" object:nil];
    
    _userDetailModel = [UserDetailModel currentUser];
    
    if (_userDetailModel==nil||_userDetailModel.id==0) {
        LoginViewController *loginViewCtl = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
//        [self.view.window.rootViewController presentViewController:loginViewCtl animated:YES completion:nil];
        loginViewCtl.source = @"usercenter";
        [self presentViewController:loginViewCtl animated:YES completion:nil];
    }else{
        [self initViewWithUser];
    }
    
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
    CGFloat y = self.headerBackBlurImg.frame.size.height - buttonHeight;
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
    
    //默认加载我的相册Controller
    self.albumTableViewController = [[AlbumTableViewController alloc]init];
    self.albumTableViewController.userId = _userDetailModel.id;
    [self addChildViewController:self.albumTableViewController];
    [self.view addSubview:self.albumTableViewController.view];
    
    CGFloat indexY = self.headerBackBlurImg.frame.origin.y + self.headerBackBlurImg.frame.size.height;
    self.albumTableViewController.tableView.frame = CGRectMake(0, indexY, self.view.frame.size.width, self.view.frame.size.height - indexY);
    [self.albumTableViewController.tableView setBackgroundColor:[UIColor clearColor]];
    self.albumTableViewController.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //加载我的活动列表
    self.activityTableViewController = [[ActivityTableViewController alloc]init];
    [self addChildViewController:self.activityTableViewController];
    [self.view addSubview:self.activityTableViewController.view];
    
    self.activityTableViewController.tableView.frame = CGRectMake(0, indexY, self.view.frame.size.width, self.view.frame.size.height - indexY);
    [self.activityTableViewController.tableView setBackgroundColor:[UIColor clearColor]];
    self.activityTableViewController.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.activityTableViewController.view setHidden:YES];
    
    //创建相册名称输入框
    _createAlbumView = [[UIView alloc]initWithFrame:CGRectMake(0-mScreenWidth, mScreenHeight-36-15+10/2, mScreenWidth, 36)];
    [_createAlbumView setBackgroundColor:[UIColor whiteColor]];
    _createAlbumView.alpha = 0.7;
    [self.view addSubview:_createAlbumView];
    
    _createAlbumText = [[UITextField alloc]initWithFrame:CGRectMake(10+60+10, mScreenHeight-26-15, mScreenWidth-10*3-60-10-30-10, 26)];
    [_createAlbumText setPlaceholder:@" 请输入相册名称"];
    [_createAlbumText setHidden:YES];
    _createAlbumText.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_createAlbumText];
    
    //创建相册按钮
    _createAlbum = [[UIButton alloc] initWithFrame:CGRectMake(10, mScreenHeight-26-15, 60, 26)];
    [_createAlbum setTitle:@"创建相册" forState:UIControlStateNormal];
    [_createAlbum setTitleColor:UIColorFromRGB(0x4a90e2) forState:UIControlStateNormal];
    _createAlbum.titleLabel.font = [UIFont systemFontOfSize:12];
    _createAlbum.layer.borderColor = [UIColorFromRGB(0x4a90e2)CGColor];
    _createAlbum.layer.borderWidth = 1.0f;
    _createAlbum.layer.cornerRadius = 4;
    [_createAlbum addTarget:self action:@selector(createAlbums) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_createAlbum];
    
    //创建取消按钮
    _cancelCreate = [[UIButton alloc] initWithFrame:CGRectMake(10, mScreenHeight-26-15, 60, 26)];
    [_cancelCreate setTitle:@"取消创建" forState:UIControlStateNormal];
    [_cancelCreate setTitleColor:UIColorFromRGB(0x4a90e2) forState:UIControlStateNormal];
    _cancelCreate.titleLabel.font = [UIFont systemFontOfSize:12];
    _cancelCreate.layer.borderColor = [UIColorFromRGB(0x4a90e2)CGColor];
    _cancelCreate.layer.borderWidth = 1.0f;
    _cancelCreate.layer.cornerRadius = 4;
    [_cancelCreate addTarget:self action:@selector(cancelCreates) forControlEvents:UIControlEventTouchUpInside];
    [_cancelCreate setHidden:YES];
    [self.view addSubview:_cancelCreate];
    
}

- (void)refreshViews:(NSNotification*)no{
    _userDetailModel = (UserDetailModel*)[no object];
    if (_userDetailModel&&[_userDetailModel isEqual:[NSNull null]]==NO&&_userDetailModel.id>0) {
        [self initViewWithUser];
    }
}

- (void)initViewWithUser{
    
    //判断，如果用户资料未填写，则弹出完善资料页面
//    if ([NSString isBlankString:self.userDetailModel.nickName]||[NSString isBlankString:self.userDetailModel.avatarUrl]||[NSString isBlankString:self.userDetailModel.company]||[NSString isBlankString:self.userDetailModel.position]) {
//        EditUserViewController *editUserViewCtl = [[EditUserViewController alloc] initWithNibName:@"EditUserViewController" bundle:[NSBundle mainBundle]];
//        [self.navigationController pushViewController:editUserViewCtl animated:YES];
//    }
    
    NSString *avatarUrl = self.userDetailModel.avatarUrl;
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:avatarUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:2000.0];
    [self.headerBackBlurImg setImageWithURLRequest:theRequest placeholderImage:[UIImage imageNamed:UserDefaultHeader] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
        [self.headerBackBlurImg setImageToBlur:image blurRadius:80. completionBlock:nil];
        [self.headerImg setImage:image];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
        UIImage *img = [UIImage imageNamed:UserDefaultHeader];
        [self.headerBackBlurImg setImageToBlur:img blurRadius:80. completionBlock:nil];
        [self.headerImg setImage:img];
    }];
    
    [self.nicknameLabel setText:self.userDetailModel.nickName];
    [self.positionLabel setText:[NSString stringWithFormat:@"%@-%@", self.userDetailModel.cityName, self.userDetailModel.locationName]];
    [self.companyLabel setText:self.userDetailModel.company];
    [self.currentTitleLabel setText:self.userDetailModel.position];
    [self.cameraLabel setText:self.userDetailModel.equipment];
    [self.genderImageView setImage:(self.userDetailModel.gender==1?[UIImage imageNamed:@"uyoung.bundle/man"]:[UIImage imageNamed:@"uyoung.bundle/woman"])];
    
}

- (void) buttonClick:(id)sender{
    if(sender&&[sender isKindOfClass:[UIButton class]]){
        UIButton *button = sender;
        NSInteger tag = button.tag;
        if (tag==0) {//点击的我的相册
            [_myActButton setAlpha:0.3];
            [_myAlbumButton setAlpha:0.65];
            [self.activityTableViewController.view setHidden:YES];
            [self.albumTableViewController.view setHidden:NO];
            [_createAlbum setHidden:NO];
        }else if(tag==1){//点击我的活动
            [_myAlbumButton setAlpha:0.3];
            [_myActButton setAlpha:0.65];
            [self.activityTableViewController.view setHidden:NO];
            [self.albumTableViewController.view setHidden:YES];
            [_createAlbum setHidden:YES];
            [_createAlbumText setHidden:YES];
            [_cancelCreate setHidden:YES];
            CGPoint origin = _createAlbumView.frame.origin;
            CGSize size = _createAlbumView.frame.size;
            CGRect frame = CGRectMake(0-mScreenWidth, origin.y, size.width, size.height);
            _createAlbumView.frame = frame;
        }
    }
}

- (IBAction)editUser:(id)sender {
    EditUserViewController *editUserViewCtl = [[EditUserViewController alloc] initWithNibName:@"EditUserViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:editUserViewCtl animated:YES];
}

- (IBAction)getBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createAlbums{
    CGPoint origin = _createAlbumView.frame.origin;
    CGSize size = _createAlbumView.frame.size;
    CGRect frame = CGRectMake(0, origin.y, size.width, size.height);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.1];
    [_createAlbumView setFrame:frame];
    [UIView commitAnimations];
    [_createAlbumText setHidden:NO];
    [_cancelCreate setHidden:NO];
    [_createAlbum setHidden:YES];
}

- (void)cancelCreates{
    [_cancelCreate setHidden:YES];
    [_createAlbumText setHidden:YES];
    [_createAlbum setHidden:NO];
    CGPoint origin = _createAlbumView.frame.origin;
    CGSize size = _createAlbumView.frame.size;
    CGRect frame = CGRectMake(0-mScreenWidth, origin.y, size.width, size.height);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.1];
    [_createAlbumView setFrame:frame];
    [UIView commitAnimations];
}
@end
