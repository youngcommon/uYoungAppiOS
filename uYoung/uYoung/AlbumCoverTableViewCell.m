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
    
    [_albumCoverImage lazyInitSmallImageWithUrl:model.firstPhotoUrl];
    /*NSString *photoUrl = model.firstPhotoUrl;
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:photoUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [_albumCoverImage setImageWithURLRequest:theRequest placeholderImage:[UIImage imageNamed:@"uyoung.bundle"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
        [_albumCoverImage setImage:image];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){}];*/
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
