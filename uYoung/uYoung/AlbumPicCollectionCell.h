//
//  AlbumPicCollectionCell.h
//  uYoung
//
//  Created by CSDN on 15/12/7.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoDetailModel.h"

@interface AlbumPicCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (strong, nonatomic) NSDictionary *picData;

- (void)initCellWithPhotoDetail:(PhotoDetailModel*)photoDetail;

@end
