//
//  Des3Encrypt.h
//  uYoung
//
//  Created by 独自天涯 on 16/1/23.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kChosenDigestLength CC_SHA1_DIGEST_LENGTH

@interface Des3Encrypt : NSObject

+(NSString*)TripleDES:(NSString*)plainText withRandom:(NSString*)random;

@end
