//
//  AlbumDetailModel.h
//  uYoung
//
//  Created by 独自天涯 on 15/12/9.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "mantle.h"

@interface AlbumDetailModel : MTLModel<MTLJSONSerializing>

@property (assign, nonatomic) long albumId;
@property (strong, nonatomic) NSString *albumDesc;
@property (assign, nonatomic) long oriUserId;
@property (strong, nonatomic) NSString *oriUrl;
@property (strong, nonatomic) NSString *oriNickName;
@property (assign, nonatomic) long createTime;
@property (assign, nonatomic) NSInteger photoNum;
@property (strong, nonatomic) NSArray *photoInfoList;
@property (strong, nonatomic) NSArray *photos;

@end
