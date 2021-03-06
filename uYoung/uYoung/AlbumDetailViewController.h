//
//  AlbumDetailViewController.h
//  uYoung
//
//  Created by 独自天涯 on 15/12/5.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UYoungAlertViewUtil.h"
#import "CreateAlbum.h"
#import "UILoginFilterViewController.h"

@interface AlbumDetailViewController : UILoginFilterViewController<UIAlertViewDelegate, CreateAlbumDelegate>
@property (strong, nonatomic) IBOutlet UILabel *albumName;
@property (strong, nonatomic) IBOutlet UIImageView *userHeader;
@property (strong, nonatomic) IBOutlet UILabel *nickName;
@property (strong, nonatomic) IBOutlet UILabel *createDate;
@property (strong, nonatomic) IBOutlet UILabel *totalPics;
@property (strong, nonatomic) IBOutlet UICollectionView *allPics;
@property (strong, nonatomic) IBOutlet UIButton *uploadPicButton;
@property (strong, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (strong, nonatomic) UIView *cover;
@property (strong, nonatomic) UIButton *deleteAlbumButton;

@property (strong, nonatomic) NSString *albumNameStr;
@property (strong, nonatomic) NSString *nickNameStr;
@property (strong, nonatomic) NSString *createDateStr;
@property (strong, nonatomic) NSString *userHeaderUrl;
@property (assign, nonatomic) long ownerUid;
@property (assign, nonatomic) long albumid;
@property (assign, nonatomic) long actId;

@property (assign, nonatomic) BOOL isNew;//是否是新创建相册
@property (assign, nonatomic) BOOL inEdit;//是否是编辑状态
@property (strong, nonatomic) NSMutableArray *pics;
@property (strong, nonatomic) NSMutableArray *delList;//保存要删除的照片id
@property (strong, nonatomic) NSMutableString *delPhotoList;//保存要删除的照片ID,用逗号分隔

- (IBAction)back:(id)sender;
- (IBAction)selectPics:(id)sender;
- (IBAction)edit:(id)sender;
- (IBAction)cancelEdit:(id)sender;

@end
