//
//  ActivityDetailEnrollsModel.h
//  uYoung
//
//  Created by 独自天涯 on 15/11/15.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "mantle.h"

@interface ActivityDetailEnrollsModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, assign) BOOL confirm;

@end
