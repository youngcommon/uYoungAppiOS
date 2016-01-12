//
//  ActivityAlbumCollectionViewCell.h
//  uYoung
//
//  Created by 独自天涯 on 15/11/27.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityAlbumModel.h"

@interface ActivityAlbumCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *backgroundCover;
@property (strong, nonatomic) IBOutlet UIView *content;
@property (strong, nonatomic) IBOutlet UIImageView *albumCoverImg;
@property (strong, nonatomic) IBOutlet UIView *albumInfoView;
@property (strong, nonatomic) IBOutlet UIImageView *userHeaderImg;
@property (strong, nonatomic) IBOutlet UILabel *likeLabel;
@property (strong, nonatomic) IBOutlet UILabel *viewLabel;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;

@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *scrollImg;

-(void)initCellData:(ActivityAlbumModel*)model;
@end
