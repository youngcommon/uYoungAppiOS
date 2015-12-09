//
//  AlbumPicCollectionCell.m
//  uYoung
//
//  Created by CSDN on 15/12/7.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "AlbumPicCollectionCell.h"
#import "UIImageView+LazyInit.h"

@implementation AlbumPicCollectionCell

- (void)awakeFromNib {
    
    _img.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _img.layer.borderWidth = 1;
    
}

- (void)initCellWithPhotoDetail:(PhotoDetailModel*)photoDetail{
    [_img lazyInitSmallImageWithUrl:photoDetail.photoUrl];
}

@end
