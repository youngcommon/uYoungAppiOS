//
//  ActivityTableViewController.h
//  uYoung
//
//  Created by CSDN on 15/9/21.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ActivityTableViewCell.h"
#import "SVPullToRefresh.h"
#import "GlobalConfig.h"


@interface ActivityTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *activityListData;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger status;

- (void)initActivityList: (NSInteger)type;

@end
