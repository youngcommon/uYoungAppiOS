//
//  SystemConfigViewController.m
//  uYoung
//
//  Created by 独自天涯 on 15/12/10.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "SystemConfigViewController.h"
#import "UserDetailModel.h"

@interface SystemConfigViewController ()

@end

@implementation SystemConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_systable setBackgroundColor:[UIColor clearColor]];
    _systable.scrollEnabled = NO;
    
    _logoutButton.layer.cornerRadius = 4;
    _logoutButton.layer.masksToBounds = YES;
    
    _data = [[NSArray alloc]initWithObjects:@"关于有样儿", @"清除缓存", @"意见反馈", nil];
    
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
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

@end
