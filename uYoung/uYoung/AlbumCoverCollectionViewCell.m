//
//  AlbumCoverCollectionViewCell.m
//  uYoung
//
//  Created by CSDN on 16/2/1.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import "AlbumCoverCollectionViewCell.h"
#import "NSString+StringUtil.h"
#import "UIImageView+LazyInit.h"

@implementation AlbumCoverCollectionViewCell

- (void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];
    
    _coverImg.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _coverImg.layer.borderWidth = 1;
}


- (void)fillDataWithAlbumModel:(AlbumModel*)model{
    [_albumNameLabel setText:model.albumName];
    if (model!=nil&&[NSString isBlankString:model.firstPhotoUrl]==NO) {
        [_coverImg lazyInitSmallImageWithUrl:model.firstPhotoUrl suffix:@"albumcover128X90" placeholdImg:@"uyoung.bundle/no_album_cover"];
    }else{
        [_coverImg setImage:[UIImage imageNamed:@"uyoung.bundle/no_album_cover"]];
    }
    [_coverImg setContentMode:UIViewContentModeScaleToFill];
}

@end
