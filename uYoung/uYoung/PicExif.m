//
//  PicExif.m
//  uYoung
//
//  Created by CSDN on 16/1/12.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import "PicExif.h"

@implementation PicExif

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"iso": @"iso",//iso
             @"exposure": @"exposure",//快门
             @"f": @"f",//光圈
             @"focalLength": @"focalLength",//焦距
             @"lensModel": @"lensModel",//镜头信息
             @"cameraModel": @"cameraModel"//设备
             };
}


@end
