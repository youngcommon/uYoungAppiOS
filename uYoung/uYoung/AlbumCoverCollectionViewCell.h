//
//  AlbumCoverCollectionViewCell.h
//  uYoung
//
//  Created by CSDN on 16/2/1.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumModel.h"

@interface AlbumCoverCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *albumNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImg;

- (void)fillDataWithAlbumModel:(AlbumModel*)model;

@end
