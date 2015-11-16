//
//  YoungHUDBackgroundView.m
//  uYoung
//
//  Created by 独自天涯 on 15/11/16.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "YoungHUDBackgroundView.h"
#import <QuartzCore/QuartzCore.h>

static YoungHUDBackgroundView *_shareHUDView = nil;
@implementation YoungHUDBackgroundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(YoungHUDBackgroundView *)shareHUDView{
    if (!_shareHUDView) {
        _shareHUDView = [[YoungHUDBackgroundView alloc] init];
        _shareHUDView.alpha = 0;
        _shareHUDView.layer.masksToBounds = YES;
        _shareHUDView.layer.cornerRadius = 5;
        _shareHUDView.barStyle = UIBarStyleBlackTranslucent;
    }
    return _shareHUDView;
}



@end
