//
//  PicExifUtil.h
//  uYoung
//
//  Created by CSDN on 16/1/12.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import <ImageIO/ImageIO.h>
#import "PicExif.h"

@interface PicExifUtil : NSObject

+(PicExifUtil *)shareInstance;

-(PicExif*)getWithALAsset:(ALAsset*)asset;

@end
