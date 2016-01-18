//
//  ActivityAlbumModel.m
//  uYoung
//
//  Created by CSDN on 16/1/8.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import "ActivityAlbumModel.h"

@implementation ActivityAlbumModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             
             @"activityId": @"activityId",
             @"albumId": @"albumId",
             @"oriUid":@"oriUid",
             @"oriUrl": @"oriUrl",
             @"firstPhotoUrl": @"firstPhotoUrl",
             @"totalPhotoCount": @"totalPhotoCount",
             @"totalViewCount": @"totalViewCount",
             @"totalLikeCount": @"totalLikeCount",
             @"createTime": @"createTime"
             
             };
}

@end
