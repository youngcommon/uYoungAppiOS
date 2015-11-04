//
//  NSString+StringUtil.m
//  uYoung
//
//  Created by 独自天涯 on 15/11/4.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "NSString+StringUtil.h"

@implementation NSString (StringUtil)

+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isEqualToString:@"Null"]||[string isEqualToString:@"NULL"]||[string isEqualToString:@"null"]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

@end
