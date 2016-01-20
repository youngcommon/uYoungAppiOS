//
//  PlistUtil.h
//  uYoung
//
//  Created by CSDN on 16/1/20.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlistUtil : NSObject

+ (void)writeDictToFile:(NSDictionary*)dict withKey:(NSString*)key;

+ (void)writeArrayToFile:(NSArray*)arr withKey:(NSString*)key;

+ (NSDictionary*)readDictFromFile:(NSString*)key;

+ (NSArray*)readArrayFromFile:(NSString*)key;

+ (NSMutableDictionary*)getRoot;

+ (NSString*)getFileName;

@end
