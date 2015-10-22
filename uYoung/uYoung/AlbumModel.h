//
//  AlbumModel.h
//  uYoung
//
//  Created by CSDN on 15/10/22.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "mantle.h"

@interface AlbumModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSString *albumName;
@property (nonatomic, assign) NSInteger totalLikeCount;
@property (nonatomic, assign) NSInteger totalPhotoCount;
@property (nonatomic, strong) NSString *firstPhotoUrl;
@property (nonatomic, strong) NSString *createTime;

@end
