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
@property (nonatomic,assign) NSInteger gender;
@property (nonatomic,strong) NSString *avatarUrl;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *company;
@property (nonatomic,strong) NSString *position;
@property (nonatomic,strong) NSString *equipment;
@property (nonatomic,assign) NSInteger cityId;
@property (nonatomic,assign) NSInteger locationId;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *cityName;
@property (nonatomic,strong) NSString *locationName;

+ (instancetype)currentUser;
- (void)save;
- (void)del;

@end
