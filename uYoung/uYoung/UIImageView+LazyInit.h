//
//  UIImageView+LazyInit.h
//  uYoung
//
//  Created by CSDN on 15/12/7.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (LazyInit)

- (void)lazyInitSmallImageWithUrl:(NSString*)url suffix:(NSString*)suffix;

@end
