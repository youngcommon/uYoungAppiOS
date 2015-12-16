//
//  AlbumTableViewController.m
//  uYoung
//
//  Created by CSDN on 15/10/15.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "AlbumTableViewController.h"
#import "UserAlbumList.h"
#import "AlbumDetailViewController.h"
#import "AlbumModel.h"

@interface AlbumTableViewController ()

@end

@implementation AlbumTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userAlbumList:) name:@"userAlbumList" object:nil];
    [UserAlbumList getUserAlbumListWithUid:_userId];
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)userAlbumList:(NSNotification*)notification
{
    NSArray *arr = (NSArray*)[notification object];
    NSArray *data = [MTLJSONAdapter modelsOfClass:[AlbumModel class] fromJSONArray:arr error:nil];
    [_albumListData removeAllObjects];
     _albumListData = [[NSMutableArray alloc] initWithArray:data];
    [self.tableView reloadData];
    [self.tableView reloadInputViews];
    NSLog(@"##########userAlbumList==============%d=============", [data count]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.albumListData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AlbumCell";
    
    AlbumCoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"AlbumCoverTableViewCell" owner:self options:nil] objectAtIndex:0];
        UINib *nib = [UINib nibWithNibName:@"AlbumCoverTableViewCell" bundle:[NSBundle mainBundle]];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];//注册cell复用
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell fillDataWithAlbumModel:_albumListData[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(mScreenWidth<375){
        return 200;
    }else if(mScreenWidth==375){
        return 240;
    }else{
        return 280;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AlbumModel *model = (AlbumModel*)_albumListData[indexPath.row];
    
    AlbumDetailViewController *viewCtl = [[AlbumDetailViewController alloc]initWithNibName:@"AlbumDetailViewController" bundle:[NSBundle mainBundle]];
    viewCtl.albumNameStr = model.albumName;
    viewCtl.ownerUid = _userId;
    [self.navigationController pushViewController:viewCtl animated:YES];
}



@end
