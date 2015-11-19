//
//  CityModel.h
//  uYoung
//
//  Created by 独自天涯 on 15/11/19.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "mantle.h"

@interface CityModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,strong) NSString *cnName;        //
@property (nonatomic,strong) NSString *enName;    //
@property (nonatomic,strong) NSString *lat;      //
@property (nonatomic,strong) NSString *lon;        //
@property (nonatomic,assign) NSInteger id;       //
@property (nonatomic,assign) NSInteger pid;   //

@property (nonatomic,strong) NSArray *subDictCityList;

@end
