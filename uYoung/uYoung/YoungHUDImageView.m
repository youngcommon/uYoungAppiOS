//
//  YoungHUDImageView.m
//  uYoung
//
//  Created by 独自天涯 on 15/11/16.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "YoungHUDImageView.h"

static YzdHUDImageView *_shareHUDView = nil;
@implementation YoungHUDImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(YoungHUDImageView *)shareHUDView{
    if (!_shareHUDView) {
        _shareHUDView = [[YoungHUDImageView alloc] init];
        _shareHUDView.alpha = 0;
    }
    return _shareHUDView;
}


@end
