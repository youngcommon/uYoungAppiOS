//
//  ActivityAlbumViewController.h
//  uYoung
//
//  Created by 独自天涯 on 15/11/26.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumDetail.h"
#import "CreateAlbum.h"
#import "UILoginFilterViewController.h"

@interface ActivityAlbumViewController : UILoginFilterViewController<AlbumDetailDelegate, CreateAlbumDelegate>

@property (strong, nonatomic) NSString *actTitleStr;
@property (assign, nonatomic) long actId;
@property (assign, nonatomic) long ownerUid;
@property (strong, nonatomic) UIImageView *nodata;
@property (strong, nonatomic) IBOutlet UILabel *actTitle;
@property (weak, nonatomic) IBOutlet UIView *uploadAlbumView;

@property (strong, nonatomic) NSArray *actAlbum;
@property (strong, nonatomic) IBOutlet UICollectionView *albums;

@property (assign, nonatomic) BOOL hadSigned;//当前用户是否签到过
@property (assign, nonatomic) BOOL hadAlbum;//当前用户是否已经上传了相册
- (IBAction)back:(id)sender;
- (IBAction)uploadMyActAlbum:(id)sender;

@end
