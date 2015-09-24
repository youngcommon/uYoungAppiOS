//
//  ActivityModel.h
//  uYoung
//
//  Created by CSDN on 15/9/23.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "mantle.h"

@interface ActivityModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,assign) NSInteger activityId;
@property (nonatomic,strong) NSString *title;       //标题
@property (nonatomic,strong) NSString *actType;     //活动类型
@property (nonatomic,strong) NSNumber *personNum;   //活动人数
@property (nonatomic,strong) NSString *day;         //日期
@property (nonatomic,strong) NSString *month;       //月份
@property (nonatomic,strong) NSString *week;        //星期
@property (nonatomic,strong) NSString *fromTime;    //开始时间
@property (nonatomic,strong) NSString *toTime;      //结束时间
@property (nonatomic,strong) NSString *addr;        //地址
@property (nonatomic,strong) NSString *local;       //活动区域
@property (nonatomic,strong) NSString *headerUrl;   //头像
@property (nonatomic,assign) NSInteger price;
@property (nonatomic,assign) NSInteger status;   //status


@end
