//
//  ActivityFilterViewController.m
//  uYoung
//
//  Created by CSDN on 15/12/7.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "ActivityFilterViewController.h"
#import "GlobalConfig.h"

@interface ActivityFilterViewController ()

@end

@implementation ActivityFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _labelFont = [UIFont fontWithName:@"HelveticaNeue" size:15];
    _smallLabelFont = [UIFont fontWithName:@"HelveticaNeue" size:13];
    
    _createTimeButton.layer.borderColor = [UIColorFromRGB(0x4a90e2)CGColor];
    _createTimeButton.layer.borderWidth = 1;
    _createTimeButton.layer.cornerRadius = 4;
    _createTimeButton.layer.masksToBounds = YES;
    
    _actTimeButton.layer.borderColor = [UIColorFromRGB(0x4a90e2)CGColor];
    _actTimeButton.layer.borderWidth = 0;
    _actTimeButton.layer.cornerRadius = 4;
    _actTimeButton.layer.masksToBounds = YES;
    
    _commitButton.layer.cornerRadius = 4;
    _commitButton.layer.masksToBounds = YES;
    
    _actTypeButton.layer.borderColor = [UIColorFromRGB(0x4a90e2)CGColor];
    _actTypeButton.layer.borderWidth = 1;
    _actTypeButton.layer.cornerRadius = 4;
    _actTypeButton.layer.masksToBounds = YES;
    
    _actStatusButton.layer.borderColor = [UIColorFromRGB(0x4a90e2)CGColor];
    _actStatusButton.layer.borderWidth = 1;
    _actStatusButton.layer.cornerRadius = 4;
    _actStatusButton.layer.masksToBounds = YES;
    
    _priceSwitch.on = NO;
    _isFree = 0;
    
    //价格选择开关
    [_priceSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    
    //初始化活动类型数据
    NSData *acttypelistdata = [[NSUserDefaults standardUserDefaults]objectForKey:@"acttype"];
    if (acttypelistdata) {
        _actTypeData = [NSKeyedUnarchiver unarchiveObjectWithData:acttypelistdata];
    } else {
        _actTypeData = [[NSArray alloc]init];
    }
    //初始化活动类型筛选列表
    _actTypeTable = [[UITableView alloc]initWithFrame:CGRectMake(_actTypeButton.frame.origin.x, _actTypeButton.frame.origin.y+_actTypeButton.frame.size.height, _actTypeButton.frame.size.width, 0)];
    _actTypeTable.delegate = self;
    _actTypeTable.dataSource = self;
    _actTypeTable.layer.borderColor = [UIColorFromRGB(0x4a90e2)CGColor];
    _actTypeTable.layer.borderWidth = 1;
    _actTypeTable.tag = 2;
    _actTypeTable.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:_actTypeTable];
//    NSLayoutConstraint *actTypeTableLeadingContraint=[NSLayoutConstraint
//                                          constraintWithItem:_actTypeTable
//                                          attribute:NSLayoutAttributeLeading
//                                          relatedBy:NSLayoutRelationEqual
//                                          toItem:_actTypeButton
//                                          attribute:NSLayoutAttributeLeading
//                                          multiplier:1.0f
//                                          constant:0.0];
//    NSLayoutConstraint *actTypeTableTrailingContraint=[NSLayoutConstraint
//                                                      constraintWithItem:_actTypeTable
//                                                      attribute:NSLayoutAttributeTrailing
//                                                      relatedBy:NSLayoutRelationEqual
//                                                      toItem:_actTypeButton
//                                                      attribute:NSLayoutAttributeTrailing
//                                                      multiplier:1.0f
//                                                      constant:0.0];
//    [self.view addConstraints:@[actTypeTableLeadingContraint,actTypeTableTrailingContraint]];
    
    //初始化活动状态类型数据
    NSData *actstatuslistdata = [[NSUserDefaults standardUserDefaults]objectForKey:@"actstatus"];
    if (actstatuslistdata) {
        _actStatusData = [NSKeyedUnarchiver unarchiveObjectWithData:actstatuslistdata];
    } else {
        _actStatusData = [[NSArray alloc]init];
    }
    //初始化活动状态筛选列表
    _actStatusTable = [[UITableView alloc]initWithFrame:CGRectMake(_actStatusButton.frame.origin.x, _actStatusButton.frame.origin.y+_actStatusButton.frame.size.height, _actStatusButton.frame.size.width, 0)];
    _actStatusTable.delegate = self;
    _actStatusTable.dataSource = self;
    _actStatusTable.layer.borderColor = [UIColorFromRGB(0x4a90e2)CGColor];
    _actStatusTable.layer.borderWidth = 1;
    _actStatusTable.tag = 3;
    _actStatusTable.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:_actStatusTable];
    
    _actStatusFilter = -1;
    _actTypeFilter = -1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)sort:(UIButton*)sender {
    //当用户点击他处时，收回弹出的选择view
    if(_actTypeTable.frame.size.height>0){
        [self selectActType:2];
    }
    if (_actStatusTable.frame.size.height>0) {
        [self selectActType:3];
    }
    
    NSInteger tag = sender.tag;
    if (tag==0) {
        _createTimeButton.layer.borderWidth = 1;
        _actTimeButton.layer.borderWidth = 0;
    }else{
        _actTimeButton.layer.borderWidth = 1;
        _createTimeButton.layer.borderWidth = 0;
    }
    _sortType = tag;
}

- (IBAction)actTypeFilter:(id)sender {
    if (_actStatusTable.frame.size.height>0) {
        [self selectActType:3];
    }
    [self selectActType:2];
}

- (IBAction)actStatusFilter:(id)sender {
    if (_actTypeTable.frame.size.height>0) {
        [self selectActType:2];
    }
    [self selectActType:3];
}

- (IBAction)commit:(id)sender {
    NSString *sortColumn = _sortType==0?@"createTimeSort":@"beginTimeSort";
    NSDictionary *data = [[NSDictionary alloc]initWithObjectsAndKeys:@(1),sortColumn, @"asc",@"sort", @(_isFree),@"feeType", @(_actTypeFilter),@"activityType", @(_actStatusFilter),@"status", nil];
    [_delegate commitWithFilterData:data];
}

-(void)switchAction:(id)sender{
    UISwitch *switchButton = (UISwitch*)sender;
    _isFree = [switchButton isOn]?1:0;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger tag = tableView.tag;
    if (tag==2) {
        return [_actTypeData count]+1;
    }else{
        return [_actStatusData count]+1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger tag = tableView.tag;
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSString *txt = @"全部";
        cell = [[UITableViewCell alloc]initWithFrame:CGRectZero];
        cell.textLabel.textColor = UIColorFromRGB(0x4a90e2);
        if (tag==2) {
            [[cell textLabel]setFont:_labelFont];
            if (indexPath.row>0) {
                txt = _actTypeData[indexPath.row-1][@"cnDesc"];
            }
            [[cell textLabel]setText:txt];
        }else{
            [[cell textLabel]setFont:_smallLabelFont];
            if (indexPath.row>0) {
                txt = _actStatusData[indexPath.row-1][@"desc"];
            }
            [[cell textLabel]setText:txt];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor lightGrayColor];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 34;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *act;
    NSInteger tag = tableView.tag;
    if (tag==2) {
        if (indexPath.row==0) {
            _actTypeFilter = -1;
            [_actTypeButton setTitle:@"全部" forState:UIControlStateNormal];
        }else{
            act = _actTypeData[indexPath.row-1];
            [_actTypeButton setTitle:act[@"cnDesc"] forState:UIControlStateNormal];
            act = (NSDictionary*)(_actTypeData[indexPath.row-1]);
            _actTypeFilter = [((NSNumber*)[act valueForKey:@"type"])longValue];
        }
    }else{
        if (indexPath.row==0) {
            _actStatusFilter = -1;
            [_actStatusButton setTitle:@"全部" forState:UIControlStateNormal];
        }else{
            act = _actStatusData[indexPath.row-1];
            [_actStatusButton setTitle:act[@"desc"] forState:UIControlStateNormal];
            act = (NSDictionary*)(_actStatusData[indexPath.row-1]);
            _actStatusFilter = [((NSNumber*)[act valueForKey:@"id"])longValue];
        }
    }
    [self selectActType:tag];
}

-(void)selectActType:(NSInteger)tag{
    CGRect frame;
    if (tag==2) {
        frame = _actTypeTable.frame;
    }else{
        frame = _actStatusTable.frame;
    }

    if(frame.size.height==0){
        CGFloat maxHeight;
        CGFloat height;
        if (tag==2) {
            maxHeight = (_commitButton.frame.origin.y+_commitButton.frame.size.height) - (_actTypeButton.frame.origin.y+_actTypeButton.frame.size.height);
            height = [_actTypeData count]*34;
        }else{
            maxHeight = (_commitButton.frame.origin.y+_commitButton.frame.size.height) - (_actStatusButton.frame.origin.y+_actStatusButton.frame.size.height);
            height = [_actStatusData count]*34;
        }
        if (height>maxHeight) {
            height = maxHeight;
        }
        frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, height);
    }else{
        frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 0);
    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.2];
    if (tag==2) {
        [_actTypeTable setFrame:frame];
    }else{
        [_actStatusTable setFrame:frame];
    }
    [UIView commitAnimations];
}

-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event{
    //当用户点击他处时，收回弹出的选择view
    if(_actTypeTable.frame.size.height>0){
        [self selectActType:2];
    }
    if (_actStatusTable.frame.size.height>0) {
        [self selectActType:3];
    }
}

@end
