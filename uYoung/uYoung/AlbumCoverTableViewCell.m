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
    
    [self.albumCoverImage setFrame:CGRectMake(self.albumCoverImage.frame.origin.x, self.albumCoverImage.frame.origin.y, self.albumCoverImage.frame.size.width, height)];
}

- (void)fillDataWithAlbumModel:(AlbumModel*)model{
    [_albumNameLabel setText:model.albumName];
    [_albumViewLabel setText:[NSString stringWithFormat:@"%d", (int)model.totalLikeCount]];
    [_albumPhotoCountLabel setText:[NSString stringWithFormat:@"%d", (int)model.totalPhotoCount]];
    [_albumCreateLabel setText:model.createTime];
    
    [_albumCoverImage lazyInitSmallImageWithUrl:model.firstPhotoUrl suffix:@"pic621"];
    [_albumCoverImage setImage:[_albumCoverImage.image scaleToSize:_albumCoverImage.frame.size]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
