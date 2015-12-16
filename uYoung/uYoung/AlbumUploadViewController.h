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

@interface AlbumUploadViewController : UIViewController<ZLPhotoPickerBrowserViewControllerDataSource,ZLPhotoPickerBrowserViewControllerDelegate,ZLPhotoPickerViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *imageCollection;

@property (strong, nonatomic) NSMutableArray *assets;

- (IBAction)cancel:(id)sender;
- (IBAction)showSysPhoto:(id)sender;
- (IBAction)uploadImages:(id)sender;

@end
