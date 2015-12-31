//
//  SystemConfigViewController.h
//  uYoung
//
//  Created by 独自天涯 on 15/12/10.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SystemConfigViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *systable;
@property (strong, nonatomic) IBOutlet UIButton *logoutButton;

@property (strong, nonatomic) NSMutableArray *data;

- (IBAction)logout:(id)sender;
- (void)loadCacheSize;
@end
