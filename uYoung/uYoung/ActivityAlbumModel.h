//
//  ActivityAlbumModel.h
//  uYoung
//
//  Created by CSDN on 16/1/8.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import "mantle.h"

@interface ActivityAlbumModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,assign) NSInteger activityId;
@property (nonatomic,assign) NSInteger albumId;
@property (nonatomic,strong) NSString *oriUrl;
@property (nonatomic,strong) NSString *firstPhotoUrl;
@property (nonatomic,assign) NSInteger totalPhotoCount;
@property (nonatomic,assign) NSInteger totalViewCount;
@property (nonatomic,assign) NSInteger totalLikeCount;
@property (nonatomic,strong) NSString *createTime;

@end
