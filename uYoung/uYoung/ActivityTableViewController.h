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
#import "ActivityList.h"


@interface ActivityTableViewController : UITableViewController<ActivityListDelegate>

@property (strong, nonatomic) NSMutableArray *activityListData;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) BOOL noMorePage;
@property (nonatomic, assign) long userid;
@property (nonatomic, assign) BOOL showHeader;
@property (nonatomic, assign) BOOL isSigned;//NO：自己发布的活动；YES：参加的活动

@property (strong, nonatomic) UIImageView *nodata;

@property (nonatomic, strong) NSMutableDictionary *params;

- (void)resetActivityList:(NSDictionary*)param;
- (void)getDataFromNet:(BOOL)isTop;

@end
