//
//  ExifView.m
//  uYoung
//
//  Created by CSDN on 16/1/22.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import "ExifView.h"
#import "NSString+StringUtil.h"

@implementation ExifView

- (void)updateExifInfo:(PhotoDetailModel*)detail{
    if (detail==nil||[detail isEqual:[NSNull null]]) {
        return;
    }
    NSString *cam = detail.exifCamera;
    NSString *lens = detail.exifOther;
    NSString *focus = detail.exifFacus;
    NSString *apt = detail.exifAperture;
    NSString *iso = detail.exifIso;
    NSString *shutter = detail.exifShutter;
    if (![NSString isBlankString:cam]) {
        [_camera setText:cam];
    }
    if (![NSString isBlankString:lens]) {
        [_lens setText:lens];
    }
    if (![NSString isBlankString:focus]) {
        [_focus setText:focus];
    }
    if (![NSString isBlankString:apt]) {
        [_aperture setText:apt];
    }
    if (![NSString isBlankString:iso]) {
        [_iso setText:iso];
    }
    if (![NSString isBlankString:shutter]) {
        [_shutter setText:shutter];
    }
}

@end
