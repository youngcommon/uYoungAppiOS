//
//  ActivityDetailModel.h
//  uYoung
//
//  Created by CSDN on 15/10/16.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "mantle.h"

@interface ActivityDetailModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,assign) NSInteger activityId;
@property (nonatomic,strong) NSString *title;       //标题
@property (nonatomic,strong) NSString *activityTypeDesc;     //活动类型
@property (nonatomic,assign) NSInteger needNum;   //活动人数
@property (nonatomic,assign) NSInteger realNum;   //报名人数
@property (nonatomic,assign) NSInteger day;         //日期
@property (nonatomic,assign) NSInteger month;       //月份
@property (nonatomic,strong) NSString *fromTime;    //开始时间
@property (nonatomic,strong) NSString *toTime;      //结束时间
@property (nonatomic,strong) NSString *address;        //地址
@property (nonatomic,strong) NSString *nickName;   //昵称
@property (nonatomic,strong) NSString *desc;   //描述
@property (nonatomic,strong) NSString *avatarUrl;
@property (nonatomic, assign) NSInteger oriUserId;
@property (nonatomic,assign) NSInteger feeType;

@end
