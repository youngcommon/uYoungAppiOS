//
//  PicExif.h
//  uYoung
//
//  Created by CSDN on 16/1/12.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import "mantle.h"

@interface PicExif : MTLModel<MTLJSONSerializing>

@property (strong, nonatomic) NSString *iso;//iso
@property (strong, nonatomic) NSString *exposure;//快门
@property (strong, nonatomic) NSString *f;//光圈
@property (strong, nonatomic) NSString *exposureBiasValue;//曝光补偿EV
@property (strong, nonatomic) NSString *focalLength;//焦距
@property (strong, nonatomic) NSString *lensModel;//镜头信息
@property (strong, nonatomic) NSString *cameraModel;//设备

@end
