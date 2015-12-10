//
//  UserDetailModel.m
//  uYoung
//
//  Created by CSDN on 15/10/16.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "UserDetailModel.h"
#import "CityModel.h"

@interface UserDetailModel()<NSCoding>

@end

@implementation UserDetailModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"id": @"id",
             @"realName": @"realName",
             @"nickName": @"nickName",
             @"email": @"email",
             @"gender": @"gender",
             @"avatarUrl": @"avatarUrl",
             @"phone": @"phone",
             @"company": @"company",
             @"position": @"position",
             @"equipment": @"equipment",
             @"address": @"address"
             };
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    
    self.avatarUrl = [NSString stringWithFormat:@"%@-actdesc200", self.avatarUrl];
    
    if (self == nil) return nil;
    NSArray *arr = [self.address componentsSeparatedByString:@"-"];
    if (arr&&[arr count]==2) {
        self.cityId = [arr[0] integerValue];
        self.locationId = [arr[1] integerValue];
    }
    NSData *citylistdata = [[NSUserDefaults standardUserDefaults]objectForKey:@"citylist"];
    NSArray *cityarr;
    if (citylistdata) {
        cityarr = [NSKeyedUnarchiver unarchiveObjectWithData:citylistdata];
    } else {
        cityarr = [[NSArray alloc]init];
    }
    
    NSString *cityName;
    for (int i=0; i<[cityarr count]; i++) {
        CityModel *city = cityarr[i];
        if (city.id == _cityId) {
            _cityName = city.cnName;
            NSArray *subs = city.subDictCityList;
            if (subs&&[subs count]>0) {
                for (int j=0; j<[subs count]; j++) {
                    CityModel *location = subs[j];
                    if (location.id == _locationId) {
                        _locationName = location.cnName;
                    }
                }
            }else{
                _locationName = cityName;
            }
        }
    }
    return self;
}

+ (instancetype)currentUser{
    UserDetailModel *singletonUser = nil;
    NSData *encodedObject = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentUser"];
    if (encodedObject) {
        singletonUser = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    } else {
        singletonUser = [[self alloc] init];
    }
    return singletonUser;
}

- (void)save{
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:self];
    [[NSUserDefaults standardUserDefaults] setObject:archivedData forKey:@"currentUser"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)del{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"currentUser"];
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeInteger:self.id forKey:@"id"];
    [aCoder encodeObject:self.realName ?: [NSNull null] forKey:@"realName"];
    [aCoder encodeObject:self.nickName ?: [NSNull null] forKey:@"nickName"];
    [aCoder encodeObject:self.email ?: [NSNull null] forKey:@"email"];
    [aCoder encodeInteger:self.gender forKey:@"gender"];
    [aCoder encodeObject:self.avatarUrl ?: [NSNull null] forKey:@"avatarUrl"];
    [aCoder encodeObject:self.phone ?: [NSNull null] forKey:@"phone"];
    [aCoder encodeObject:self.company ?: [NSNull null] forKey:@"company"];
    [aCoder encodeObject:self.position ?: [NSNull null] forKey:@"position"];
    [aCoder encodeObject:self.equipment ?: [NSNull null] forKey:@"equipment"];
    [aCoder encodeInteger:self.cityId forKey:@"cityId"];
    [aCoder encodeInteger:self.locationId forKey:@"locationId"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.cityName forKey:@"cityName"];
    [aCoder encodeObject:self.locationName forKey:@"locationName"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder{
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
        
        self.gender = [aDecoder decodeIntForKey:@"gender"];
        
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
        
        self.cityId = [aDecoder decodeIntegerForKey:@"cityId"];
        self.locationId = [aDecoder decodeIntegerForKey:@"locationId"];
        
        self.address = [aDecoder decodeObjectForKey:@"address"];
        if ([self.address isEqual:[NSNull null]]) {
            self.address = nil;
        }
        
        self.cityName = [aDecoder decodeObjectForKey:@"cityName"];
        if ([self.cityName isEqual:[NSNull null]]) {
            self.cityName = nil;
        }
        
        self.locationName = [aDecoder decodeObjectForKey:@"locationName"];
        if ([self.locationName isEqual:[NSNull null]]) {
            self.locationName = nil;
        }
        
    }
    return self;
}

@end
