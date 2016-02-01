//
//  AlbumCollectionViewController.h
//  uYoung
//
//  Created by CSDN on 16/2/1.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConfig.h"
#import "AlbumModel.h"
#import "AlbumDetail.h"
#import "AlbumCoverCollectionViewCell.h"

@interface AlbumCollectionViewController : UICollectionViewController<AlbumDetailDelegate>

@property (strong, nonatomic) NSMutableArray *albumListData;

@property (assign, nonatomic) NSInteger userId;

@property (strong, nonatomic) UIImageView *nodata;

- (void)refreshData;

@end
