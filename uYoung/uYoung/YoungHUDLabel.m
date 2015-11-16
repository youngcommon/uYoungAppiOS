//
//  YoungHUDLabel.m
//  uYoung
//
//  Created by 独自天涯 on 15/11/16.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "YoungHUDLabel.h"

static YoungHUDLabel *_shareHUDView = nil;
@implementation YoungHUDLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(YoungHUDLabel *)shareHUDView{
    if (!_shareHUDView) {
        _shareHUDView = [[YoungHUDLabel alloc] init];
        _shareHUDView.numberOfLines = 0;
        _shareHUDView.alpha = 0;
        _shareHUDView.textAlignment = NSTextAlignmentCenter;
        _shareHUDView.backgroundColor = [UIColor clearColor];
        _shareHUDView.textColor = [UIColor whiteColor];

    }
    return _shareHUDView;
}
@end
