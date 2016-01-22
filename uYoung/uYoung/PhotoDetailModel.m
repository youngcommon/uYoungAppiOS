//
//  PhotoDetailModel.m
//  uYoung
//
//  Created by 独自天涯 on 15/12/9.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "PhotoDetailModel.h"

@implementation PhotoDetailModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"id" : @"id",
             @"photoName" : @"photoName",
             @"photoUrl" : @"photoUrl",
             @"createUserId" : @"createUserId",
             @"albumId" : @"albumId",
             @"viewCount" : @"viewCount",
             @"likeCount" : @"likeCount",
             @"exifCamera": @"exifCamera",
             @"exifAperture": @"exifAperture",
             @"exifFacus": @"exifFacus",
             @"exifShutter": @"exifShutter",
             @"exifIso": @"exifIso",
             @"exifOther": @"exifOther"
             };
}

@end
