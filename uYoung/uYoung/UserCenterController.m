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
#import "UserLoginViewController.h"

@implementation UserCenterController

- (void)viewDidAppear:(BOOL)animated{
//    _userDetailModel = [UserDetailModel currentUser];
    
    if (_userDetailModel==nil||_userDetailModel.id==0) {
//        ThirdLoginViewController *loginViewCtl = [[ThirdLoginViewController alloc]initWithNibName:@"ThirdLoginViewController" bundle:[NSBundle mainBundle]];
//        loginViewCtl.source = @"usercenter";
//        [self presentViewController:loginViewCtl animated:YES completion:nil];
        UserLoginViewController *ctl = [[UserLoginViewController alloc]initWithNibName:@"UserLoginViewController" bundle:[NSBundle mainBundle]];
        [self presentViewController:ctl animated:YES completion:nil];
    }else{
        [self initViewWithUser];
    }

}

- (void)viewWillDisappear:(BOOL)animated{
    [self cancelCreates];
    [_createAlbumText resignFirstResponder];
}

- (void)viewDidLoad{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshViews:) name:@"usercenter" object:nil];
    //增加键盘事件监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
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
    self.albumTableViewController.tableView.frame = CGRectMake(0, indexY, self.view.frame.size.width, self.view.frame.size.height - indexY);
    [self.albumTableViewController.tableView setBackgroundColor:[UIColor clearColor]];
    self.albumTableViewController.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //加载我的活动列表
    self.activityTableViewController = [[ActivityTableViewController alloc]init];
    self.activityTableViewController.userid = _userDetailModel.id;
    self.activityTableViewController.showHeader = NO;
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
    [_createAlbumView setHidden:YES];
    
    _createAlbumText = [[UITextField alloc]initWithFrame:CGRectMake(10+60+10, mScreenHeight-26-15, mScreenWidth-10*3-60-10-30-10, 26)];
    [_createAlbumText setPlaceholder:@" 请输入相册名称"];
    [_createAlbumText setHidden:YES];
    [_createAlbumText setReturnKeyType:UIReturnKeyDone];
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
    
    //创建确认按钮
    _doCreate = [[UIButton alloc] initWithFrame:CGRectMake(_createAlbumText.frame.origin.x+_createAlbumText.frame.size.width+10, mScreenHeight-26-15, 30, 26)];
    [_doCreate setTitle:@"确认" forState:UIControlStateNormal];
    [_doCreate setTitleColor:UIColorFromRGB(0x4a90e2) forState:UIControlStateNormal];
    _doCreate.titleLabel.font = [UIFont systemFontOfSize:12];
    _doCreate.layer.borderColor = [UIColorFromRGB(0x4a90e2)CGColor];
    _doCreate.layer.borderWidth = 1.0f;
    _doCreate.layer.cornerRadius = 4;
    [_doCreate addTarget:self action:@selector(doCreateAlbum) forControlEvents:UIControlEventTouchUpInside];
    [_doCreate setHidden:YES];
    [self.view addSubview:_doCreate];
    
    //创建活动按钮
    _createAct = [[UIButton alloc] initWithFrame:CGRectMake(10, mScreenHeight-26-15, 60, 26)];
    [_createAct setTitle:@"创建活动" forState:UIControlStateNormal];
    [_createAct setTitleColor:UIColorFromRGB(0x4a90e2) forState:UIControlStateNormal];
    _createAct.titleLabel.font = [UIFont systemFontOfSize:12];
    _createAct.layer.borderColor = [UIColorFromRGB(0x4a90e2)CGColor];
    _createAct.layer.borderWidth = 1.0f;
    _createAct.layer.cornerRadius = 4;
    [_createAct addTarget:self action:@selector(createActivity) forControlEvents:UIControlEventTouchUpInside];
    [_createAct setHidden:YES];
    [self.view addSubview:_createAct];
    
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
        [_createAct setHidden:YES];
        [_createAlbum setHidden:YES];
        [_myAlbumButton setTitle:@"他的相册" forState:UIControlStateNormal];
        [_myActButton setTitle:@"他的活动" forState:UIControlStateNormal];
        _isSelf = NO;
    }else{
        _isSelf = YES;
    }
    
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
//        [self.navigationController pushViewController:editUserViewCtl animated:YES];
    }
    
    NSString *avatarUrl = self.userDetailModel.avatarUrl;
    NSRange range = [avatarUrl rangeOfString:QINIU_DEFAULT_HOST];
    if (range.length) {//说明是七牛云的头像
        long timer = [[NSDate date]timeIntervalSince1970];
        avatarUrl = [NSString stringWithFormat:@"%@-%@?%ld", avatarUrl, @"actdesc200", timer];
    }
    [self.headerImg sd_setImageWithURL:[NSURL URLWithString:avatarUrl] placeholderImage:[UIImage imageNamed:UserDefaultHeader] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        [self.headerBackBlurImg setImageToBlur:image blurRadius:kLBBlurredImageDefaultBlurRadius completionBlock:nil];
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
            if (_isSelf) {
                [_createAlbum setHidden:NO];
                [_createAct setHidden:YES];
            }
        }else if(tag==1){//点击我的活动
            [_myAlbumButton setAlpha:0.3];
            [_myActButton setAlpha:0.65];
            [self.activityTableViewController.view setHidden:NO];
            [self.albumTableViewController.view setHidden:YES];
            if (_isSelf) {
                [_createAlbum setHidden:YES];
                [_createAlbumText setHidden:YES];
                [_cancelCreate setHidden:YES];
                CGPoint origin = _createAlbumView.frame.origin;
                CGSize size = _createAlbumView.frame.size;
                CGRect frame = CGRectMake(0-mScreenWidth, origin.y, size.width, size.height);
                _createAlbumView.frame = frame;
                [_createAct setHidden:NO];
                [_doCreate setHidden:YES];
                [_createAlbumView setHidden:YES];
            }
        }
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

- (void)createAlbums{
    [_createAlbumView setHidden:NO];
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
    [_doCreate setHidden:NO];
}

- (void)cancelCreates{
    [_cancelCreate setHidden:YES];
    [_createAlbumText setHidden:YES];
    [_createAlbum setHidden:NO];
    [_doCreate setHidden:YES];
    [_createAlbumText setText:@""];
    CGPoint origin = _createAlbumView.frame.origin;
    CGSize size = _createAlbumView.frame.size;
    CGRect frame = CGRectMake(0-mScreenWidth, origin.y, size.width, size.height);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.1];
    [_createAlbumView setFrame:frame];
    [UIView commitAnimations];
    [_createAlbumView setHidden:YES];
}

- (void)doCreateAlbum{
    [_createAlbumView setHidden:YES];
    NSString *albumName = _createAlbumText.text;
    if ([NSString isBlankString:albumName]==NO) {
        UserDetailModel *user = [UserDetailModel currentUser];
        if (user!=nil&&user!=NULL) {
            [self.view.window showHUDWithText:@"正在创建相册" Type:ShowLoading Enabled:YES];
            NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:@(user.id),@"createUserId",
            albumName,@"albumName",albumName,@"title",@(0),@"totalLikeCount",@(0),@"totalPhotoCount", nil];
            [CreateAlbum createAlbum:dict delegate:self];
        }
    }
}

- (void)successCreateAlbum:(AlbumModel*)detail{
    if (detail!=nil) {
        UserDetailModel *user = [UserDetailModel currentUser];
        [self.view.window showHUDWithText:@"创建成功" Type:ShowPhotoYes Enabled:YES];
        AlbumDetailViewController *viewCtl = [[AlbumDetailViewController alloc]initWithNibName:@"AlbumDetailViewController" bundle:[NSBundle mainBundle]];
        viewCtl.albumNameStr = _createAlbumText.text;
        viewCtl.albumid = detail.id;
        viewCtl.ownerUid = user.id;
        viewCtl.nickNameStr = user.nickName;
        viewCtl.userHeaderUrl = user.avatarUrl;
        viewCtl.createDateStr = [self getNowDateStr];
        detail.createTime = [self getNowDateStr];
        [self.albumTableViewController.albumListData addObject:detail];
        [self.albumTableViewController.tableView reloadData];
        [self.albumTableViewController.tableView reloadInputViews];
        [self.navigationController pushViewController:viewCtl animated:YES];
    }else{
        [self.view.window showHUDWithText:@"创建失败" Type:ShowPhotoNo Enabled:YES];
    }
    
}

- (void)createActivity{
    CreateActivityController *ctl = [[CreateActivityController alloc] initWithNibName:@"CreateActivityController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:ctl animated:YES];
}

#pragma mark - 键盘、输入框相关接口方法
//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)keyboardWillShow:(NSNotification *)notify {
    //sv为弹出键盘的视图，UITextField
    CGFloat kbHeight = [[notify.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;//获取键盘高度。
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //    CGFloat screenHeight = self.view.bounds.size.height;
    CGFloat screenHeight = self.view.frame.size.height;
    CGFloat viewBottom = _createAlbumText.frame.origin.y + _createAlbumText.frame.size.height;
    
    if (viewBottom + kbHeight < screenHeight) return;//若键盘没有遮挡住视图则不进行整个视图上移
    
    // 键盘会盖住输入框, 要移动整个view了
    _delta = viewBottom + kbHeight - screenHeight + 5;
    
    CGRect viewFrame = CGRectMake(0, 0-_delta, self.view.frame.size.width, self.view.frame.size.height);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:duration];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
}

- (void)keyboardWillHidden:(NSNotification *)notify {//键盘消失
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect viewFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:duration];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
    _delta = 0.0f;
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
