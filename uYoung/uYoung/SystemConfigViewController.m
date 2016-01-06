//
//  SystemConfigViewController.m
//  uYoung
//
//  Created by 独自天涯 on 15/12/10.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "SystemConfigViewController.h"
#import "UserDetailModel.h"
#import "UIImageView+WebCache.h"
#import "GlobalConfig.h"
#import "FeedbackViewController.h"

@interface SystemConfigViewController ()

@end

@implementation SystemConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_systable setBackgroundColor:[UIColor clearColor]];
    _systable.scrollEnabled = NO;
    
    _logoutButton.layer.cornerRadius = 4;
    _logoutButton.layer.masksToBounds = YES;
    
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    [_versionLabel setText:[NSString stringWithFormat:@"v %@.%@", app_version, app_build]];
    
    _data = [[NSMutableArray alloc]initWithObjects:@"关于有样儿", @"", @"意见反馈", nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)logout:(id)sender {
    UserDetailModel *user = [UserDetailModel currentUser];
    if(user!=nil&&user!=NULL){
        [user del];
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.textLabel setText:_data[indexPath.row]];
    [cell setBackgroundColor:[UIColor clearColor]];
//    if (indexPath.row==2) {
//        [self loadCacheSize];
//    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.row;
    switch (index) {
        case 0://关于
            break;
        case 1://清除缓存
        {
            [[SDImageCache sharedImageCache] clearDisk];
            [[SDImageCache sharedImageCache] clearMemory];
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell.textLabel setText:@"清理缓存(0.0K)"];
            break;
        }
        case 2:{//反馈
            FeedbackViewController *feedback = [[FeedbackViewController alloc]initWithNibName:@"FeedbackViewController" bundle:[NSBundle mainBundle]];
            [self.navigationController pushViewController:feedback animated:YES];
            break;
        }
    }
}

- (void)loadCacheSize{
    UITableViewCell *cell = [_systable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    NSUInteger tmpSize = [[SDImageCache sharedImageCache]getSize];
//    NSLog(@"###################%ld###############", tmpSize);
    float size = tmpSize / 1024;
    NSString *clearCacheName =
    size<=1024 ?
    [NSString stringWithFormat:@"清理缓存(%.2fK)",size] :
    (size/1024<=1024?[NSString stringWithFormat:@"清理缓存(%.2fM)",size / 1024]:@"清理缓存(1G+)")
    ;
    [cell.textLabel setText:clearCacheName];
}

@end
