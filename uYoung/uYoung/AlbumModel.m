//
//  AlbumModel.m
//  uYoung
//
//  Created by CSDN on 15/10/22.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "AlbumModel.h"

@implementation AlbumModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"id": @"id",
             @"albumName": @"albumName",
             @"totalLikeCount": @"totalLikeCount",
             @"totalPhotoCount": @"totalPhotoCount",
             @"firstPhotoUrl": @"firstPhotoUrl",
             @"createTime": @"createTime"
             };
}


@end
