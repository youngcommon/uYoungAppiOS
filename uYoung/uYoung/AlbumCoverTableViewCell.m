//
//  AlbumCoverTableViewCell.m
//  uYoung
//
//  Created by CSDN on 15/10/15.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "AlbumCoverTableViewCell.h"
#import <UIImageView+AFNetworking.h>
#import "GlobalConfig.h"
#import "UIImageView+LazyInit.h"
#import "UIImage+scales.h"
#import "NSString+StringUtil.h"

@implementation AlbumCoverTableViewCell

- (void)awakeFromNib {
    CGFloat height = 200;
    if(mScreenWidth<375){
        height = 200;
    }else if(mScreenWidth==375){
        height = 240;
    }else{
        height = 280;
    }
    
    self.backgroundColor = [UIColor clearColor];
    
    _albumCoverImage.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _albumCoverImage.layer.borderWidth = 1;
    
//    [self.albumCoverImage setFrame:CGRectMake(self.albumCoverImage.frame.origin.x, self.albumCoverImage.frame.origin.y, self.albumCoverImage.frame.size.width, height)];
}

- (void)fillDataWithAlbumModel:(AlbumModel*)model{
    [_albumNameLabel setText:model.albumName];
    [_albumViewLabel setText:[NSString stringWithFormat:@"%d", (int)model.totalLikeCount]];
    [_albumPhotoCountLabel setText:[NSString stringWithFormat:@"%d", (int)model.totalPhotoCount]];
    [_albumCreateLabel setText:model.createTime];
    if (model!=nil&&[NSString isBlankString:model.firstPhotoUrl]==NO) {
        [_albumCoverImage lazyInitSmallImageWithUrl:model.firstPhotoUrl suffix:@"pic621" placeholdImg:@"uyoung.bundle/no_cover"];
    }else{
        [_albumCoverImage setImage:[UIImage imageNamed:@"uyoung.bundle/no_cover"]];
    }
    [_albumCoverImage setContentMode:UIViewContentModeScaleToFill];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
