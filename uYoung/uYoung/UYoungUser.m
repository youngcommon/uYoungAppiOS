//
//  UYoungUser.m
//  uYoung
//
//  Created by CSDN on 15/10/30.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "UYoungUser.h"

@interface UYoungUser()<NSCoding>
@end

@implementation UYoungUser

+ (instancetype)currentUser
{
    static UYoungUser *singletonUser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSData *encodedObject = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentUser"];
        if (encodedObject) {
            singletonUser = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
        } else {
            singletonUser = [[self alloc] init];
        }
    });
    return singletonUser;
}

- (void)save
{
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:self];
    [[NSUserDefaults standardUserDefaults] setObject:archivedData forKey:@"currentUser"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeInteger:self.id forKey:@"id"];
    [aCoder encodeObject:self.realName ?: [NSNull null] forKey:@"realName"];
    [aCoder encodeObject:self.nickName ?: [NSNull null] forKey:@"nickName"];
    [aCoder encodeObject:self.email ?: [NSNull null] forKey:@"email"];
    [aCoder encodeBool:self.gender forKey:@"gender"];
    [aCoder encodeObject:self.avatarUrl ?: [NSNull null] forKey:@"avatarUrl"];
    [aCoder encodeObject:self.phone ?: [NSNull null] forKey:@"phone"];
    [aCoder encodeObject:self.company ?: [NSNull null] forKey:@"company"];
    [aCoder encodeObject:self.position ?: [NSNull null] forKey:@"position"];
    [aCoder encodeObject:self.equipment ?: [NSNull null] forKey:@"equipment"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.id = [aDecoder decodeIntegerForKey:@"id"];
        
        self.realName = [aDecoder decodeObjectForKey:@"realName"];
        if ([self.realName isEqual:[NSNull null]]) {
            self.realName = nil;
        }
        
        self.nickName = [aDecoder decodeObjectForKey:@"nickName"];
        if ([self.nickName isEqual:[NSNull null]]) {
            self.nickName = nil;
        }
        
        self.email = [aDecoder decodeObjectForKey:@"email"];
        if ([self.email isEqual:[NSNull null]]) {
            self.email = nil;
        }
        
        self.gender = [aDecoder decodeBoolForKey:@"gender"];
        
        self.avatarUrl = [aDecoder decodeObjectForKey:@"avatarUrl"];
        if ([self.avatarUrl isEqual:[NSNull null]]) {
            self.avatarUrl = nil;
        }
        
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
        if ([self.phone isEqual:[NSNull null]]) {
            self.phone = nil;
        }
        
        self.company = [aDecoder decodeObjectForKey:@"company"];
        if ([self.company isEqual:[NSNull null]]) {
            self.company = nil;
        }
        
        self.position = [aDecoder decodeObjectForKey:@"position"];
        if ([self.position isEqual:[NSNull null]]) {
            self.position = nil;
        }
        
        self.equipment = [aDecoder decodeObjectForKey:@"equipment"];
        if ([self.equipment isEqual:[NSNull null]]) {
            self.equipment = nil;
        }
        
    }
    return self;
}

@end
