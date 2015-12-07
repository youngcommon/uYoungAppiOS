//
//  AlbumPicCollectionCell.h
//  uYoung
//
//  Created by CSDN on 15/12/7.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumPicCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (assign, nonatomic) BOOL isAlbum;
@property (weak, nonatomic) IBOutlet UILabel *shortLine;
@property (weak, nonatomic) IBOutlet UILabel *longLine;

@property (strong, nonatomic) NSDictionary *picData;

- (void)initCellWithDict:(NSDictionary*)dict;

@end
