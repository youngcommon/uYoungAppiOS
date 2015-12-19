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

@property (strong, nonatomic) NSString *albumNameStr;
@property (strong, nonatomic) NSString *nickNameStr;
@property (strong, nonatomic) NSString *createDateStr;
@property (strong, nonatomic) NSString *userHeaderUrl;
@property (assign, nonatomic) NSInteger ownerUid;

@property (strong, nonatomic) NSArray *pics;

- (IBAction)back:(id)sender;
- (IBAction)selectPics:(id)sender;

@end
