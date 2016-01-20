//
//  PlistUtil.m
//  uYoung
//
//  Created by CSDN on 16/1/20.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import "PlistUtil.h"
#import "NSString+StringUtil.h"

@implementation PlistUtil

+ (void)writeDictToFile:(NSDictionary*)dict withKey:(NSString*)key{
    if(dict!=nil&&![dict isEqual:[NSNull null]]&&[dict count]>0){
        [dict writeToFile:[self getFileName] atomically:YES];
    }
}

+ (void)writeArrayToFile:(NSArray*)arr withKey:(NSString*)key{
    if(arr!=nil&&![arr isEqual:[NSNull null]]&&[arr count]>0){
        [arr writeToFile:[self getFileName] atomically:YES];
    }
}

+ (NSDictionary*)readDictFromFile:(NSString*)key{
    if (![NSString isBlankString:key]) {
        NSMutableDictionary *root = [self getRoot];
        id obj = [root objectForKey:key];
        if (obj!=nil) {
            return obj;
        }
    }
    
    return nil;
}

+ (NSArray*)readArrayFromFile:(NSString*)key{
    if (![NSString isBlankString:key]) {
        NSMutableDictionary *root = [self getRoot];
        id obj = [root objectForKey:key];
        if (obj!=nil) {
            return obj;
        }
    }
    
    return nil;
}

+ (NSMutableDictionary*)getRoot{
    NSString *filename = [self getFileName];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    return data;
}

+ (NSString*)getFileName{
    NSArray *arrPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *strDocBase = ([arrPaths count] > 0) ? [arrPaths objectAtIndex:0] : nil;
    NSString *filename=[strDocBase stringByAppendingPathComponent:@"global_config.plist"];
    return filename;
}

@end
