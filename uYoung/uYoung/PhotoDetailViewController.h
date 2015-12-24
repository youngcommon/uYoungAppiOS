//
//  PhotoDetailViewController.h
//  uYoung
//
//  Created by 独自天涯 on 15/12/22.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QiniuSDK.h>
#import "PhotoDownload.h"

@interface PhotoDetailViewController : UIViewController<PhotoDownloadDelegate>

@property (strong, nonatomic) NSString *photoUrl;
@property (strong, nonatomic) IBOutlet UIButton *showExif;
@property (strong, nonatomic) IBOutlet UIView *exifView;

@property (strong, nonatomic) NSArray *photoDetails;
@property (assign, nonatomic) NSInteger index;

- (IBAction)back:(id)sender;
- (IBAction)likeThisPhoto:(UIButton*)sender;
- (IBAction)toggleExif:(id)sender;

@end
