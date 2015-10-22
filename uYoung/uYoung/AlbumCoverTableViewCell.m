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
    [_albumViewLabel setText:[NSString stringWithFormat:@"%i", model.totalLikeCount]];
    [_albumPhotoCountLabel setText:[NSString stringWithFormat:@"%i", model.totalPhotoCount]];
    [_albumCreateLabel setText:model.createTime];
    
    NSString *photoUrl = model.firstPhotoUrl;
    photoUrl = @"http://pic1a.nipic.com/2008-09-12/2008912172513848_2.jpg";
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:photoUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [_albumCoverImage setImageWithURLRequest:theRequest placeholderImage:[UIImage imageNamed:@"AppIcon"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
        [_albumCoverImage setImage:image];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){}];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
