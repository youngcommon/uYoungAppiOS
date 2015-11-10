//
//  UserDetailModel.h
//  uYoung
//
//  Created by CSDN on 15/10/16.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "mantle.h"

@interface UserDetailModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,assign) NSInteger id;
@property (nonatomic,strong) NSString *realName;
@property (nonatomic,strong) NSString *nickName;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,assign) BOOL gender;
@property (nonatomic,strong) NSString *avatarUrl;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *company;
@property (nonatomic,strong) NSString *position;
@property (nonatomic,strong) NSString *equipment;

+ (instancetype)currentUser;
- (void)save;
- (void)del;

@end
