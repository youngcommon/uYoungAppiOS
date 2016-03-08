//
//  UserCenterV2ViewController.m
//  uYoung
//
//  Created by 独自天涯 on 16/1/28.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import "UserCenterV2ViewController.h"
#import "LoginFilterUtil.h"
#import "EditUserViewController.h"
#import "NSString+StringUtil.h"
#import "EditUserViewController.h"
#import "UIImageView+WebCache.h"
#import "AlbumDetailViewController.h"
#import "CreateActivityController.h"
#import <UIImageView+LBBlurredImage.h>
#import <MobClick.h>

@interface UserCenterV2ViewController ()

@end

@implementation UserCenterV2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self hiddenHeaderViewLables:0];
    
    [self.headerViewBack setImage:[UIImage imageNamed:@"uyoung.bundle/usercenterback"]];
    
    if (_userDetailModel==nil||_userDetailModel.id==0) {
        LoginViewController *ctl = [[LoginFilterUtil shareInstance]getLoginViewController];
        ctl.source = @"usercenter";
        BOOL ani = YES;
        if (mScreenWidth==320) {
            ani = NO;
        }
        [self presentViewController:ctl animated:ani completion:nil];
    }else{
        [self initViewWithUser];
    }
    
    self.headerImg.layer.cornerRadius = self.headerImg.frame.size.height/2;
    self.headerImg.layer.masksToBounds = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshViews:) name:@"usercenter" object:nil];
    //取消登录监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(popLoginView) name:@"popLoginView" object:nil];
    
    CGFloat x = 0;
    CGFloat y = 0;
    //用户相册
    self.albumCtl = [[AlbumCollectionViewController alloc]init];
    self.albumCtl.userId = _userDetailModel.id;
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, 100);
    self.albumCtl.collectionView.frame = frame;
    [self.albumCtl.collectionView setBackgroundColor:[UIColor clearColor]];
    [self addChildViewController:self.albumCtl];
    [self.albumView addSubview:self.albumCtl.view];
    
    y = self.createdActBtn.frame.origin.y + self.createdActBtn.frame.size.height - 1;
    
    [self.createdActBtn setImage:[UIImage imageNamed:@"uyoung.bundle/created_act_bt_h_v2"] forState:UIControlStateHighlighted];
    [self.signedActBtn setImage:[UIImage imageNamed:@"uyoung.bundle/signed_act_bt_h_v2"] forState:UIControlStateHighlighted];

    //用户创建的活动列表
    self.postActCtl = [[ActivityTableViewController alloc]init];
    self.postActCtl.userid = _userDetailModel.id;
    self.postActCtl.showHeader = NO;
    [self addChildViewController:self.postActCtl];
    [self.view addSubview:self.postActCtl.view];
    
    frame = CGRectMake(0, y, self.view.frame.size.width, self.view.frame.size.height-y);
    self.postActCtl.tableView.frame = frame;
    [self.postActCtl.tableView setBackgroundColor:[UIColor clearColor]];
    self.postActCtl.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //用户参与的活动列表
    self.signedActCtl = [[ActivityTableViewController alloc]init];
    self.signedActCtl.userid = _userDetailModel.id;
    self.signedActCtl.showHeader = NO;
    self.signedActCtl.isSigned = YES;
    self.signedActCtl.tableView.frame = frame;
    [self.signedActCtl.tableView setBackgroundColor:[UIColor clearColor]];
    self.signedActCtl.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addChildViewController:self.signedActCtl];
    [self.view addSubview:self.signedActCtl.view];
    [self.signedActCtl.tableView setHidden:YES];
    
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
        [_sysconfigButton setHidden:YES];
        [_createAlbumButton setHidden:YES];
        [_createActButton setHidden:YES];
        [_emailLabel setHidden:YES];
        [_emailTitleLabel setHidden:YES];
        [_mobileLabel setHidden:YES];
        [_mobileTitleLabel setHidden:YES];
        _isSelf = NO;
    }else{
        _isSelf = YES;
    }
    
    [self.view bringSubviewToFront:self.createdActBtn];
    [self.view bringSubviewToFront:self.signedActBtn];
    
    //创建背底
    self.backBlurHeader = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight)];
    self.backBlurHeader.contentMode = UIViewContentModeScaleToFill;
    [self.backBlurHeader setImage:[UIImage imageNamed:@"uyoung.bundle/userback_1920"]];
    self.backBlurHeader.alpha = 0.5;
    [self.view insertSubview:self.backBlurHeader atIndex:0];
}

- (void)hiddenHeaderViewLables:(NSTimeInterval)time{
    self.companyTitleLabel.alpha = 0;
    self.companyLabel.alpha = 0;
    self.positionTitleLabel.alpha = 0;
    self.positionLabel.alpha = 0;
    self.equipTitleLabel.alpha = 0;
    self.equipLabel.alpha = 0;
    self.emailTitleLabel.alpha = 0 ;
    self.emailLabel.alpha = 0;
    self.mobileTitleLabel.alpha = 0;
    self.mobileLabel.alpha = 0;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:time];
    [self.headerViewCons setConstant:76];
    [UIView commitAnimations];
    [self.detailButton setImage:[UIImage imageNamed:@"uyoung.bundle/showdetail"] forState:UIControlStateNormal];
}

- (void)showHeaderViewLables:(NSTimeInterval)time{
    self.companyTitleLabel.alpha = 1;
    self.companyLabel.alpha = 1;
    self.positionTitleLabel.alpha = 1;
    self.positionLabel.alpha = 1;
    self.equipTitleLabel.alpha = 1;
    self.equipLabel.alpha = 1;
    self.emailTitleLabel.alpha = 1;
    self.emailLabel.alpha = 1;
    self.mobileTitleLabel.alpha = 1;
    self.mobileLabel.alpha = 1;
    CGFloat cons = _isSelf?190:140;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:time];
    [self.headerViewCons setConstant:cons];
    [UIView commitAnimations];
    [self.detailButton setImage:[UIImage imageNamed:@"uyoung.bundle/hidedetail"] forState:UIControlStateNormal];
}

- (void)popLoginView{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)refreshViews:(NSNotification*)no{
    _userDetailModel = (UserDetailModel*)[no object];
    if (_userDetailModel&&[_userDetailModel isEqual:[NSNull null]]==NO&&_userDetailModel.id>0) {
        [self initViewWithUser];
        self.albumCtl.userId = _userDetailModel.id;
        [self.albumCtl refreshData];
    }
}

- (void)initViewWithUser{
    //判断，如果用户资料未填写，则弹出完善资料页面
    UserDetailModel *loginUser = [UserDetailModel currentUser];
    if (loginUser.id==self.userDetailModel.id&&([NSString isBlankString:loginUser.company]||[NSString isBlankString:loginUser.position])) {
        EditUserViewController *editUserViewCtl = [[EditUserViewController alloc] initWithNibName:@"EditUserViewController" bundle:[NSBundle mainBundle]];
        editUserViewCtl.isNew = YES;
        [self.navigationController pushViewController:editUserViewCtl animated:YES];
    }
    
    NSString *avatarUrl = self.userDetailModel.avatarUrl;
    NSRange range = [avatarUrl rangeOfString:QINIU_DEFAULT_HOST];
    if (range.length) {//说明是七牛云的头像
        long timer = [[NSDate date]timeIntervalSince1970];
        avatarUrl = [NSString stringWithFormat:@"%@-%@?%ld", avatarUrl, @"actdesc200", timer];
    }
    [self.headerImg sd_setImageWithURL:[NSURL URLWithString:avatarUrl] placeholderImage:[UIImage imageNamed:UserDefaultHeader] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        [self.headerImg setImage:image];
    }];
    
    NSString *nick = self.userDetailModel.nickName;
    [self.nickLabel setText:[NSString isBlankString:nick]?@"暂无数据":nick];
    NSString *city = self.userDetailModel.cityName;
    NSString *location = self.userDetailModel.locationName;
    NSString *position = [NSString isBlankString:city]?@"暂无数据":([NSString isBlankString:location]?city:[NSString stringWithFormat:@"%@-%@", city, location]);
    [self.locationLabel setText:position];
    NSString *comp = self.userDetailModel.company;
    [self.companyLabel setText:[NSString isBlankString:comp]?@"暂无数据":comp];
    NSString *title = self.userDetailModel.position;
    [self.positionLabel setText:[NSString isBlankString:title]?@"暂无数据":title];
    NSString *equipment = self.userDetailModel.equipment;
    [self.equipLabel setText:[NSString isBlankString:equipment]?@"暂无数据":equipment];
    NSString *email = self.userDetailModel.email;
    [self.emailLabel setText:[NSString isBlankString:email]?@"暂无数据":email];
    NSString *mobile = self.userDetailModel.phone;
    [self.mobileLabel setText:[NSString isBlankString:mobile]?@"暂无数据":mobile];
    [self.genderImg setImage:(self.userDetailModel.gender==1?[UIImage imageNamed:@"uyoung.bundle/man"]:[UIImage imageNamed:@"uyoung.bundle/woman"])];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sysconfig:(id)sender {
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

- (IBAction)editUser:(id)sender {
    EditUserViewController *editUserViewCtl = [[EditUserViewController alloc] initWithNibName:@"EditUserViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:editUserViewCtl animated:YES];
}

- (IBAction)create:(UIButton*)sender {
    NSInteger tag = sender.tag;
    if (tag==0) {
        [self createAlbum];
    }else{
        [self createActivity];
    }
}

- (IBAction)toggleUserDetail:(UIButton *)sender {
    CGFloat cons = self.headerViewCons.constant;
    if (cons==76) {
        [self showHeaderViewLables:0.5];
    }else{
        [self hiddenHeaderViewLables:0.5];
    }
}

- (IBAction)changeActList:(UIButton *)sender {
    NSInteger tag = sender.tag;
    if (tag==9002) {//说明参与的活动按钮被点击
        [self.createdActBtn setBackgroundImage:[self getScaleUIImage:@"uyoung.bundle/created_act_bt_v2"] forState:UIControlStateNormal];
        [self.signedActBtn setBackgroundImage:[self getScaleUIImage:@"uyoung.bundle/signed_act_bt_h_v2"] forState:UIControlStateNormal];
        [self.signedActBtn setImage:[UIImage imageNamed:@"uyoung.bundle/signed_act_bt_h_v2"] forState:UIControlStateHighlighted];
        [self.postActCtl.tableView setHidden:YES];
        [self.signedActCtl.tableView setHidden:NO];
    }else{//说明创建的活动被点击
        [self.createdActBtn setBackgroundImage:[self getScaleUIImage:@"uyoung.bundle/created_act_bt_h_v2"] forState:UIControlStateNormal];
        [self.signedActBtn setBackgroundImage:[self getScaleUIImage:@"uyoung.bundle/signed_act_bt_v2"] forState:UIControlStateNormal];
        [self.createdActBtn setImage:[UIImage imageNamed:@"uyoung.bundle/created_act_bt_h_v2"] forState:UIControlStateHighlighted];
        [self.postActCtl.tableView setHidden:NO];
        [self.signedActCtl.tableView setHidden:YES];
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

- (NSString*)getNowDateStr{
    NSDate *date = [NSDate date];
    //设置时间输出格式：
    NSDateFormatter *df = [[NSDateFormatter alloc] init ];
    [df setTimeZone:[NSTimeZone localTimeZone]];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString * na = [df stringFromDate:date];
    return na;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (UIImage *)getScaleUIImage:(NSString*)name{
    UIImage *bubble = [UIImage imageNamed:name];
    UIEdgeInsets capInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    return [bubble resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
}

- (UIImage *)getScaleImage:(UIImage*)image{
    UIImage *bubble = image;
    UIEdgeInsets capInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    return [bubble resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"EditUserViewController"];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"EditUserViewController"];
}

@end
