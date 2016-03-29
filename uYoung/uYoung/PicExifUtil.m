//
//  PicExifUtil.m
//  uYoung
//
//  Created by CSDN on 16/1/12.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import "PicExifUtil.h"

@implementation PicExifUtil

+(PicExifUtil *)shareInstance{
    static dispatch_once_t pred;
    static PicExifUtil *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[PicExifUtil alloc] init];
    });
    return shared;
}

-(PicExif*)getNilALAsset{
    NSDictionary *info = [[NSDictionary alloc]initWithObjectsAndKeys:@"",@"iso", @"",@"exposure", @"",@"f", @"",@"focalLength", @"",@"lensModel", @"",@"cameraModel", @"",@"exposureBiasValue", nil];
    PicExif *exif = [MTLJSONAdapter modelOfClass:[PicExif class] fromJSONDictionary:info error:nil];
    return exif;
}

-(PicExif*)getWithALAsset:(ALAsset*)asset{
    NSDictionary *imageData = [[NSMutableDictionary alloc]initWithDictionary:asset.defaultRepresentation.metadata];
    NSDictionary *exifData = [imageData objectForKey:(NSString *)kCGImagePropertyExifDictionary];
    NSDictionary *tiffData = [imageData objectForKey:(NSString *)kCGImagePropertyTIFFDictionary];
    NSArray *isoArr = (NSArray*)exifData[(NSString *)kCGImagePropertyExifISOSpeedRatings];//iso
    NSString *iso = @"200";
    if (isoArr&&[isoArr count]>0) {
        iso = [isoArr[0] stringValue];
    }
    NSString *exposure;//快门
    NSString *exT = exifData[(NSString *)kCGImagePropertyExifExposureTime];
    float num = [exT floatValue];
    if (num>1) {
        exposure = [NSString stringWithFormat:@"%.0f s", num];
    }else{
        exposure =  [NSString stringWithFormat:@"1/%.0f s", 1.0/[exifData[(NSString *)kCGImagePropertyExifExposureTime]floatValue]];
    }
    NSString *f = [NSString stringWithFormat:@"F%@", exifData[(NSString *)kCGImagePropertyExifFNumber]];//光圈
    NSString *exposureBiasValue = [exifData[(NSString *)kCGImagePropertyExifExposureBiasValue] stringValue];//曝光补偿EV
    NSString *focalLength = [NSString stringWithFormat:@"%.1f mm", [exifData[(NSString *)kCGImagePropertyExifFocalLength]floatValue]];//焦距
    NSString *lensModel = exifData[(NSString *)kCGImagePropertyExifLensModel];//镜头信息
    NSString *cameraModel = tiffData[(NSString *)kCGImagePropertyTIFFModel];//设备
    
    NSDictionary *info = [[NSDictionary alloc]initWithObjectsAndKeys:iso,@"iso", exposure,@"exposure", f,@"f", focalLength,@"focalLength", lensModel,@"lensModel", cameraModel,@"cameraModel", exposureBiasValue,@"exposureBiasValue", nil];
    PicExif *exif = [MTLJSONAdapter modelOfClass:[PicExif class] fromJSONDictionary:info error:nil];
    return exif;
}

@end
