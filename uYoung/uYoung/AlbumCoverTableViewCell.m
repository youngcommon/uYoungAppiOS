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
    
    [self.albumCoverImage setFrame:CGRectMake(self.albumCoverImage.frame.origin.x, self.albumCoverImage.frame.origin.y, self.albumCoverImage.frame.size.width, height)];
}

- (void)fillDataWithAlbumModel:(AlbumModel*)model{
    [_albumNameLabel setText:model.albumName];
    [_albumViewLabel setText:[NSString stringWithFormat:@"%d", (int)model.totalLikeCount]];
    [_albumPhotoCountLabel setText:[NSString stringWithFormat:@"%d", (int)model.totalPhotoCount]];
    [_albumCreateLabel setText:model.createTime];
    if (model!=nil&&[NSString isBlankString:model.firstPhotoUrl]==NO) {
        [_albumCoverImage lazyInitSmallImageWithUrl:model.firstPhotoUrl suffix:@"pic621" placeholdImg:@"uyoung.bundle/nopic_tip"];
        [_albumCoverImage setImage:[_albumCoverImage.image scaleToSize:_albumCoverImage.frame.size]];
    }else{
        UIImageView *nopic = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"uyoung.bundle/nopic_tip"]];
        NSLog(@"%f===%f===%f===%f", self.frame.size.width, self.frame.size.height, self.frame.origin.x, self.frame.origin.y);
        CGRect frame = CGRectMake((self.frame.size.width-192), (self.frame.size.height-182), 192, 182);
        [nopic setFrame:frame];
        [self addSubview:nopic];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
