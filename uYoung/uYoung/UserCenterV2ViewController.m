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

@interface UserCenterV2ViewController ()

@end

@implementation UserCenterV2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
        _isSelf = NO;
    }else{
        _isSelf = YES;
    }
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
    [self.currentTitleLabel setText:[NSString isBlankString:title]?@"暂无数据":title];
    NSString *equipment = self.userDetailModel.equipment;
    [self.cameraLabel setText:[NSString isBlankString:equipment]?@"暂无数据":equipment];
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

@end
