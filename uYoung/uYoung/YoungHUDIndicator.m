//
//  YoungHUDIndicator.h
//  uYoung
//
//  Created by 独自天涯 on 15/11/16.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "YoungHUDIndicator.h"

static YoungHUDIndicator *_shareHUDView = nil;
@implementation YoungHUDIndicator

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(YoungHUDIndicator *)shareHUDView{
    if (!_shareHUDView) {
        _shareHUDView = [[YoungHUDIndicator alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }
    return _shareHUDView;
}

@end
