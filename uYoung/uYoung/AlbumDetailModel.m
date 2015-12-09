//
//  AlbumDetailModel.m
//  uYoung
//
//  Created by 独自天涯 on 15/12/9.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "AlbumDetailModel.h"
#import "PhotoDetailModel.h"

@implementation AlbumDetailModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"albumId" : @"albumId",
             @"oriUserId" : @"oriUserId",
             @"oriUrl" : @"oriUrl",
             @"oriNickName" : @"oriNickName",
             @"createTime" : @"createTime",
             @"photoNum" : @"photoNum",
             @"photoInfoList" : @"photoInfoList"
             };
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    NSArray * a =  [MTLJSONAdapter modelsOfClass:[PhotoDetailModel class] fromJSONArray:self.photoInfoList error:nil];
    if (a&&[a count]>0) {
        self.photos = [[NSArray alloc]initWithArray:a];
    }
    return self;
}

@end
