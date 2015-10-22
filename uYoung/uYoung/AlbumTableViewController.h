//
//  AlbumTableViewController.h
//  uYoung
//
//  Created by CSDN on 15/10/15.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumCoverTableViewCell.h"
#import "GlobalConfig.h"
#import "AlbumModel.h"

@interface AlbumTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *albumListData;

@property (assign, nonatomic) NSInteger userId;

@end
