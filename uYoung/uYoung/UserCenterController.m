//
//  UserCenterController.m
//  uYoung
//
//  Created by CSDN on 15/10/13.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "UserCenterController.h"
#import "UIImageView+WebCache.h"
#import <UIImageView+LBBlurredImage.h>
#import "EditUserViewController.h"
#import "CreateActivityController.h"
#import "AlbumDetailViewController.h"
#import "UIWindow+YoungHUD.h"
#import "LoginFilterUtil.h"

@implementation UserCenterController

- (void)popLoginView{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad{
    if (_userDetailModel==nil||_userDetailModel.id==0) {
        LoginViewController *ctl = [[LoginFilterUtil shareInstance]getLoginViewController];
        ctl.source = @"usercenter";
        [self presentViewController:ctl animated:YES completion:nil];
    }else{
        [self initViewWithUser];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshViews:) name:@"usercenter" object:nil];
    //取消登录监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(popLoginView) name:@"popLoginView" object:nil];
    
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
//    self.headerImg.layer.borderWidth = 1.;
    self.headerImg.layer.borderColor = [[UIColor brownColor] CGColor];
    
    CGFloat buttonWidth = mScreenWidth / 2;
    CGFloat buttonHeight = 46;
    CGFloat x = 0;
    CGFloat y = self.headerBackBlurImg.frame.size.height - buttonHeight;
    //增加我的相册和我的活动按钮
    _myAlbumButton = [[UIButton alloc]initWithFrame:CGRectMake(x, y, buttonWidth, buttonHeight)];
    [_myAlbumButton setTitle:@"我的相册" forState:UIControlStateNormal];
    [_myAlbumButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_myAlbumButton setBackgroundColor:UIColorFromRGB(0x027AFF)];
    [_myAlbumButton setAlpha:0.65];
    [_myAlbumButton setTag:0];
    [_myAlbumButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_myAlbumButton];
    
    _myActButton = [[UIButton alloc]initWithFrame:CGRectMake(x+buttonWidth, y, buttonWidth, buttonHeight)];
    [_myActButton setTitle:@"我的活动" forState:UIControlStateNormal];
    [_myActButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_myActButton setBackgroundColor:UIColorFromRGB(0x027AFF)];
    [_myActButton setAlpha:0.3];
    [_myActButton setTag:1];
    [_myActButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_myActButton];
    
    //默认加载我的相册Controller
    self.albumTableViewController = [[AlbumTableViewController alloc]init];
    self.albumTableViewController.userId = _userDetailModel.id;
    self.albumTableViewController.tableView.showsHorizontalScrollIndicator = NO;
    self.albumTableViewController.tableView.showsVerticalScrollIndicator = NO;
    [self addChildViewController:self.albumTableViewController];
    [self.view addSubview:self.albumTableViewController.view];
    
    CGFloat indexY = self.headerBackBlurImg.frame.origin.y + self.headerBackBlurImg.frame.size.height;
    CGRect frame = CGRectMake(0, indexY, self.view.frame.size.width, self.view.frame.size.height - indexY);
    
    self.albumTableViewController.tableView.frame = frame;
    [self.albumTableViewController.tableView setBackgroundColor:[UIColor clearColor]];
    self.albumTableViewController.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    //加载我的活动列表
    self.activityTableViewController = [[ActivityTableViewController alloc]init];
    self.activityTableViewController.userid = _userDetailModel.id;
    self.activityTableViewController.showHeader = NO;
    [self addChildViewController:self.activityTableViewController];
    [self.view addSubview:self.activityTableViewController.view];
    
    self.activityTableViewController.tableView.frame = frame;
    [self.activityTableViewController.tableView setBackgroundColor:[UIColor clearColor]];
    self.activityTableViewController.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.activityTableViewController.view setHidden:YES];
    
//    22,418,40,40
    //创建按钮
    UIButton *createButton = [[UIButton alloc]initWithFrame:CGRectMake(22, mScreenHeight-22-40, 40, 40)];
    [createButton setImage:[UIImage imageNamed:@"uyoung.bundle/plusone"] forState:UIControlStateNormal];
    [createButton addTarget:self action:@selector(create) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createButton];
    
    //添加系统设置遮罩
    _cover = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight)];
    [_cover setBackgroundColor:[UIColor lightGrayColor]];
    _cover.alpha = 0.5;
    [_cover setHidden:YES];
    [self.view addSubview:_cover];
    
    //添加系统设置页面
    _sysCtl = [[SystemConfigViewController alloc]initWithNibName:@"SystemConfigViewController" bundle:[NSBundle mainBundle]];
    _sysCtl.view.frame = CGRectMake(mScreenWidth, 0, _sysCtl.view.frame.size.width, self.view.frame.size.height);
    [self addChildViewController:_sysCtl];
    [self.view addSubview:_sysCtl.view];
    
    UserDetailModel *loginUser = [UserDetailModel currentUser];
    if (loginUser.id!=_userDetailModel.id) {//说明不是自己的详情
        [_editButton setHidden:YES];
        [_myAlbumButton setTitle:@"他的相册" forState:UIControlStateNormal];
        [_myActButton setTitle:@"他的活动" forState:UIControlStateNormal];
        _isSelf = NO;
    }else{
        _isSelf = YES;
    }
    
    _tag = 0;
    
}

- (void)refreshViews:(NSNotification*)no{
    _userDetailModel = (UserDetailModel*)[no object];
    if (_userDetailModel&&[_userDetailModel isEqual:[NSNull null]]==NO&&_userDetailModel.id>0) {
        [self initViewWithUser];
        self.albumTableViewController.userId = _userDetailModel.id;
        [self.albumTableViewController refreshData];
    }
}

- (void)initViewWithUser{
    
    //判断，如果用户资料未填写，则弹出完善资料页面
    if ([NSString isBlankString:self.userDetailModel.nickName]||[NSString isBlankString:self.userDetailModel.avatarUrl]||[NSString isBlankString:self.userDetailModel.company]||[NSString isBlankString:self.userDetailModel.position]) {
        EditUserViewController *editUserViewCtl = [[EditUserViewController alloc] initWithNibName:@"EditUserViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:editUserViewCtl animated:YES];
    }
    
    NSString *avatarUrl = self.userDetailModel.avatarUrl;
    NSRange range = [avatarUrl rangeOfString:QINIU_DEFAULT_HOST];
    if (range.length) {//说明是七牛云的头像
        long timer = [[NSDate date]timeIntervalSince1970];
        avatarUrl = [NSString stringWithFormat:@"%@-%@?%ld", avatarUrl, @"actdesc200", timer];
    }
    [self.headerImg sd_setImageWithURL:[NSURL URLWithString:avatarUrl] placeholderImage:[UIImage imageNamed:UserDefaultHeader] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        if (image!=nil&&![image isEqual:[NSNull null]]) {
            [self.headerBackBlurImg setImageToBlur:image blurRadius:kLBBlurredImageDefaultBlurRadius completionBlock:nil];
        }else{
            image = [UIImage imageNamed:UserDefaultHeader];
        }
        [self.headerImg setImage:image];
    }];
    
    NSString *nick = self.userDetailModel.nickName;
    [self.nicknameLabel setText:[NSString isBlankString:nick]?@"暂无数据":nick];
    NSString *city = self.userDetailModel.cityName;
    NSString *location = self.userDetailModel.locationName;
    NSString *position = [NSString isBlankString:city]?@"暂无数据":([NSString isBlankString:location]?city:[NSString stringWithFormat:@"%@-%@", city, location]);
    [self.positionLabel setText:position];
    NSString *comp = self.userDetailModel.company;
    [self.companyLabel setText:[NSString isBlankString:comp]?@"暂无数据":comp];
    NSString *title = self.userDetailModel.position;
    [self.currentTitleLabel setText:[NSString isBlankString:title]?@"暂无数据":title];
    NSString *equipment = self.userDetailModel.equipment;
    [self.cameraLabel setText:[NSString isBlankString:equipment]?@"暂无数据":equipment];
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
        }else if(tag==1){//点击我的活动
            [_myAlbumButton setAlpha:0.3];
            [_myActButton setAlpha:0.65];
            [self.activityTableViewController.view setHidden:NO];
            [self.albumTableViewController.view setHidden:YES];
        }
        _tag = tag;
    }
}

- (IBAction)editUser:(id)sender {
    EditUserViewController *editUserViewCtl = [[EditUserViewController alloc] initWithNibName:@"EditUserViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:editUserViewCtl animated:YES];
}

- (IBAction)systemConfig:(id)sender {
    [_cover setHidden:NO];
    _oriFrame = _sysCtl.view.frame;
    CGRect viewFrame = CGRectMake(self.view.frame.size.width-205, 0, 205, _sysCtl.view.frame.size.height);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];
    [_sysCtl.view setFrame:viewFrame];
    [UIView commitAnimations];
    [_sysCtl loadCacheSize];
}

-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event{
    if (_cover.hidden==NO) {
        //当用户点击他处时，收回弹出的选择view
        [_cover setHidden:YES];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3];
        [_sysCtl.view setFrame:_oriFrame];
        [UIView commitAnimations];
    }
}

- (IBAction)getBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)create{
    if (_tag==0) {
        [self createAlbum];
    }else{
        [self createActivity];
    }
}

- (void)createAlbum{
    UserDetailModel *user = [UserDetailModel currentUser];
    AlbumDetailViewController *viewCtl = [[AlbumDetailViewController alloc]initWithNibName:@"AlbumDetailViewController" bundle:[NSBundle mainBundle]];
    viewCtl.ownerUid = user.id;
    viewCtl.nickNameStr = user.nickName;
    viewCtl.userHeaderUrl = user.avatarUrl;
    viewCtl.createDateStr = [self getNowDateStr];
    viewCtl.isNew = YES;
    [self.navigationController pushViewController:viewCtl animated:YES];
    
}

- (void)createActivity{
    CreateActivityController *ctl = [[CreateActivityController alloc] initWithNibName:@"CreateActivityController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:ctl animated:YES];
}

- (NSString*)getNowDateStr{
    NSDate *date = [NSDate date];
    //设置时间输出格式：
    NSDateFormatter *df = [[NSDateFormatter alloc] init ];
    [df setTimeZone:[NSTimeZone localTimeZone]];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString * na = [df stringFromDate:date];
    return na;
}
@end
