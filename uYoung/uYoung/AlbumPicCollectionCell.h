//
//  AlbumPicCollectionCell.h
//  uYoung
//
//  Created by CSDN on 15/12/7.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoDetailModel.h"

@interface AlbumPicCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *likeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *likeImg;
@property (strong, nonatomic) IBOutlet UILabel *viewLabel;
@property (strong, nonatomic) IBOutlet UIImageView *viewImg;
@property (strong, nonatomic) UIImage *oriImg;
@property (strong, nonatomic) IBOutlet UIImageView *selImg;

@property (assign, nonatomic) BOOL showLabels;//是否显示like和viewlabel
@property (strong, nonatomic) NSDictionary *picData;

- (void)initCellWithPhotoDetail:(PhotoDetailModel*)photoDetail;
- (void)changeSelectImg:(BOOL)isSel;
- (void)hiddenLabels;

@end
