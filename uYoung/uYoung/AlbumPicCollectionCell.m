//
//  AlbumPicCollectionCell.m
//  uYoung
//
//  Created by CSDN on 15/12/7.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "AlbumPicCollectionCell.h"

@implementation AlbumPicCollectionCell

- (void)awakeFromNib {
    
    _img.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _img.layer.borderWidth = 1;
    
    if (_isAlbum==NO) {
        [_shortLine setHidden:YES];
        [_longLine setHidden:YES];
    }
}

- (void)initCellWithDict:(NSDictionary*)dict{
    
}

@end