//
//  PhotoDetailModel.h
//  uYoung
//
//  Created by 独自天涯 on 15/12/9.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "mantle.h"

@interface PhotoDetailModel : MTLModel<MTLJSONSerializing>

@property (assign, nonatomic) long id;
@property (strong, nonatomic) NSString *photoName;
@property (strong, nonatomic) NSString *photoUrl;
@property (assign, nonatomic) long createUserId;
@property (assign, nonatomic) long albumId;
@property (assign, nonatomic) NSInteger viewCount;
@property (assign, nonatomic) NSInteger likeCount;

@end
