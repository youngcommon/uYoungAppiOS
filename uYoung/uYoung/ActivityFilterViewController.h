//
//  ActivityFilterViewController.h
//  uYoung
//
//  Created by CSDN on 15/12/7.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ActivityFilterDelegate <NSObject>
@optional
-(void)commitWithFilterData:(NSDictionary*)data;
@end

@interface ActivityFilterViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) id<ActivityFilterDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIButton *createTimeButton;
@property (strong, nonatomic) IBOutlet UIButton *actTimeButton;
@property (strong, nonatomic) IBOutlet UIButton *actTypeButton;
@property (strong, nonatomic) IBOutlet UIButton *actStatusButton;
@property (strong, nonatomic) IBOutlet UISwitch *priceSwitch;
@property (strong, nonatomic) IBOutlet UIButton *commitButton;

@property (strong, nonatomic) UIFont *labelFont;
@property (strong, nonatomic) UIFont *smallLabelFont;

@property (assign, nonatomic) BOOL isFree;
@property (assign, nonatomic) NSInteger sortType;
@property (assign, nonatomic) NSInteger actTypeFilter;
@property (assign, nonatomic) NSInteger actStatusFilter;

@property (strong, nonatomic) UITableView *actTypeTable;
@property (strong, nonatomic) NSArray *actTypeData;

@property (strong, nonatomic) UITableView *actStatusTable;
@property (strong, nonatomic) NSArray *actStatusData;

- (IBAction)sort:(UIButton*)sender;

- (IBAction)actTypeFilter:(id)sender;
- (IBAction)actStatusFilter:(id)sender;

- (IBAction)commit:(id)sender;
@end
