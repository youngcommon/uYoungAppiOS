//
//  AlbumCoverTableViewCell.h
//  uYoung
//
//  Created by CSDN on 15/10/15.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumModel.h"

@interface AlbumCoverTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *albumCoverImage;
@property (weak, nonatomic) IBOutlet UILabel *albumNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumViewLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumCreateLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumPhotoCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *longVertical;
@property (strong, nonatomic) IBOutlet UILabel *shortVertical;

- (void)fillDataWithAlbumModel:(AlbumModel*)model;

@end
