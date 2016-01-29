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
    
    //设置当前城市
    NSData *cities = [[NSUserDefaults standardUserDefaults]objectForKey:@"citylist"];
    if (cities!=nil) {
        _allCity = [NSKeyedUnarchiver unarchiveObjectWithData:cities];
    }
    NSData *current = [[NSUserDefaults standardUserDefaults]objectForKey:@"currentcity"];
    if (current!=nil) {
        _cityId = [[NSKeyedUnarchiver unarchiveObjectWithData:current]integerValue];
    }
    if (_cityId==0) {//使用默认cityId
        _cityId = 382;//默认北京
        _cityName = @"北京";
        NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:@(382)];
        [[NSUserDefaults standardUserDefaults] setObject:archivedData forKey:@"currentcity"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        if (_allCity!=nil&&[_allCity count]>0) {
            for (int i=0; i<[_allCity count]; i++) {
                CityModel *model = _allCity[i];
                if (model.id==_cityId) {
                    _cityName = model.cnName;
                    break;
                }
            }
        }
    }
    [_cityButton setTitle:_cityName forState:UIControlStateNormal];
    
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
    [self initPicker];
    
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

- (void)viewDidDisappear:(BOOL)animated{
    [self cancelPressed:nil];
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
    [self cancelPressed:nil];
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

- (IBAction)changeCity:(id)sender {
    [_selectedButton setHidden:NO];
    [_cancelButton setHidden:NO];
    [_citySelector setHidden:NO];
//    [_cover setHidden:NO];
}

-(void)commitWithFilterData:(NSDictionary*)data{
    [self.view.window showHUDWithText:@"加载中..." Type:ShowLoading Enabled:YES];
    [self.activityTabViewController resetActivityList:data];
    [self showFilter:nil];
}

-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event{
    if (_isFilter) {
        [self showFilter:nil];
    }
}

- (void)initPicker{
    _citySelector = [[UIPickerView alloc] initWithFrame:CGRectMake(0, mScreenHeight/2, mScreenWidth, mScreenHeight/2-60)];
    // 显示选中框
    _citySelector.showsSelectionIndicator=YES;
    _citySelector.dataSource = self;
    _citySelector.delegate = self;
    _citySelector.backgroundColor = UIColorFromRGB(0x85b200);
    [self.view addSubview:_citySelector];
    [_citySelector setHidden:YES];
    
    //创建选择按钮
    _selectedButton = [[UIButton alloc]initWithFrame:CGRectMake(0, mScreenHeight-60, mScreenWidth/2, 60)];
    _selectedButton.backgroundColor = UIColorFromRGB(0x85b200);
    [_selectedButton setTitle:@"确 定" forState:UIControlStateNormal];
    [_selectedButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_selectedButton];
    [_selectedButton setHidden:YES];
    //创建取消按钮
    _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(mScreenWidth/2, mScreenHeight-60, mScreenWidth/2, 60)];
    _cancelButton.backgroundColor = UIColorFromRGB(0x85b200);
    [_cancelButton setTitle:@"取 消" forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(cancelPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelButton];
    [_cancelButton setHidden:YES];
}

-(void) buttonPressed:(id)sender{
    NSInteger selectedCityIndex = [_citySelector selectedRowInComponent:0];
    CityModel *city = [_allCity objectAtIndex:selectedCityIndex];
    _cityName = city.cnName;
    _cityId = city.id;
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:@(_cityId)];
    [[NSUserDefaults standardUserDefaults] setObject:archivedData forKey:@"currentcity"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [_cityButton setTitle:_cityName forState:UIControlStateNormal];
    [self cancelPressed:nil];
    
    //刷新列表
    [self.view.window showHUDWithText:@"加载中..." Type:ShowLoading Enabled:YES];
    [self.activityTabViewController resetActivityList:[[NSDictionary alloc]init]];
}
    
-(void) cancelPressed:(id)sender{
    [_selectedButton setHidden:YES];
    [_cancelButton setHidden:YES];
    [_citySelector setHidden:YES];
//    [_cover setHidden:YES];
}

#pragma mark UIPickerView回调
//确定picker的轮子个数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

//确定picker的每个轮子的item数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [_allCity count];
}

//确定每个轮子的每一项显示什么内容
#pragma mark 实现协议UIPickerViewDelegate方法
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    CityModel *city = [_allCity objectAtIndex:row];
    return city.cnName;
}

@end








