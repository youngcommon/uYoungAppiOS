//
//  AlbumUploadViewController.h
//  uYoung
//
//  Created by 独自天涯 on 15/12/16.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLPhotoPickerViewController.h"
#import "AlbumPicCollectionCell.h"
#import "ZLPhotoPickerBrowserViewController.h"
#import "UploadImageUtil.h"
#import <AFHTTPRequestOperationManager+Synchronous.h>

@interface AlbumUploadViewController : UIViewController<ZLPhotoPickerBrowserViewControllerDataSource,ZLPhotoPickerBrowserViewControllerDelegate,ZLPhotoPickerViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *imageCollection;

@property (strong, nonatomic) NSMutableArray *assets;

@property (strong, nonatomic) NSMutableArray *oriImage;//保存原图
@property (strong, nonatomic) NSMutableArray *exifArr;//保存exif信息

@property (assign, nonatomic) long albumid;
@property (assign, nonatomic) long owneruid;

@property (assign, nonatomic) NSInteger state;

@property (strong, nonatomic) NSMutableArray *imgParams;
@property (assign, nonatomic) NSInteger counter;
@property (strong, nonatomic) NSMutableArray *photoDetailModels;

@property (strong, nonatomic) UIView *backcover;

@property (strong, nonatomic) NSString *coverUrl;

- (IBAction)cancel:(id)sender;
- (IBAction)showSysPhoto:(id)sender;
- (IBAction)uploadImages:(id)sender;

@end
