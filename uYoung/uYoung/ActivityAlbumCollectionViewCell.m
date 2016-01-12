//
//  ActivityAlbumCollectionViewCell.m
//  uYoung
//
//  Created by 独自天涯 on 15/11/27.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "ActivityAlbumCollectionViewCell.h"
#import "GlobalConfig.h"
#import <UIImageView+AFNetworking.h>
#import "UIImageView+LazyInit.h"

@implementation ActivityAlbumCollectionViewCell

- (void)awakeFromNib {
    _backgroundCover.image = [self getScaleUIImage:_backgroundCover.image Height:30];

    _content.layer.cornerRadius = 4;
    _content.layer.masksToBounds = YES;
    
    _albumInfoView.layer.cornerRadius = 4;
    _albumInfoView.layer.masksToBounds = YES;
    
    [self setFrame:CGRectMake(0, 0, 300, 220)];
}

- (UIImage *)getScaleUIImage:(UIImage*)bubble Height:(CGFloat)height{
    
    CGPoint center = CGPointMake(bubble.size.width / 2.0f, height);
    UIEdgeInsets capInsets = UIEdgeInsetsMake(center.y, 0, center.y+1, 2);
    return [bubble resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
    
}

-(void)initCellData:(ActivityAlbumModel*)model{
    [self lazyInitImg:model.oriUrl img:_userHeaderImg];
    [self lazyInitImg:model.firstPhotoUrl img:_albumCoverImg];
    [_viewLabel setText:[NSString stringWithFormat:@"%d", (int)model.totalViewCount]];
    [_likeLabel setText:[NSString stringWithFormat:@"%d", (int)model.totalLikeCount]];
    [_countLabel setText:[NSString stringWithFormat:@"%d", (int)model.totalPhotoCount]];
    [_dateLabel setText:model.createTime];
}

-(void)lazyInitImg:(NSString*)url img:(UIImageView*)imgView{
    [imgView lazyInitSmallImageWithUrl:url suffix:@"pic621"];
}

@end
