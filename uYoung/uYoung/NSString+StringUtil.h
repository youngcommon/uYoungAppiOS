//
//  NSString+StringUtil.h
//  uYoung
//
//  Created by 独自天涯 on 15/11/4.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringUtil)

+ (BOOL) isBlankString:(NSString *)string;

- (NSString*)stringToMD5;

- (NSString *) hmacSha1:(NSString*)sk;

- (BOOL)isValidateEmail;

- (BOOL)isValidatePassword;

- (BOOL)isTelephone;

@end
