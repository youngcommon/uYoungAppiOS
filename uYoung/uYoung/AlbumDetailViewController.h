//
//  AlbumDetailViewController.h
//  uYoung
//
//  Created by 独自天涯 on 15/12/5.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *albumName;
@property (strong, nonatomic) IBOutlet UIImageView *userHeader;
@property (strong, nonatomic) IBOutlet UILabel *nickName;
@property (strong, nonatomic) IBOutlet UILabel *createDate;
@property (strong, nonatomic) IBOutlet UILabel *totalPics;
@property (strong, nonatomic) IBOutlet UICollectionView *allPics;
@property (strong, nonatomic) IBOutlet UIButton *uploadPicButton;
@property (strong, nonatomic) IBOutlet UIButton *editButton;

@property (strong, nonatomic) NSString *albumNameStr;
@property (strong, nonatomic) NSString *nickNameStr;
@property (strong, nonatomic) NSString *createDateStr;
@property (strong, nonatomic) NSString *userHeaderUrl;
@property (assign, nonatomic) long ownerUid;
@property (assign, nonatomic) long albumid;

@property (assign, nonatomic) BOOL inEdit;//是否是编辑状态
@property (strong, nonatomic) NSArray *pics;
@property (strong, nonatomic) NSMutableArray *delList;

- (IBAction)back:(id)sender;
- (IBAction)selectPics:(id)sender;
- (IBAction)edit:(id)sender;

@end
