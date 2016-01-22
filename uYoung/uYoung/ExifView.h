//
//  ExifView.h
//  uYoung
//
//  Created by CSDN on 16/1/22.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoDetailModel.h"

@interface ExifView : UIView
@property (weak, nonatomic) IBOutlet UILabel *camera;
@property (weak, nonatomic) IBOutlet UILabel *lens;
@property (weak, nonatomic) IBOutlet UILabel *focus;
@property (weak, nonatomic) IBOutlet UILabel *aperture;
@property (weak, nonatomic) IBOutlet UILabel *iso;
@property (weak, nonatomic) IBOutlet UILabel *shutter;

- (void)updateExifInfo:(PhotoDetailModel*)detail;

@end
