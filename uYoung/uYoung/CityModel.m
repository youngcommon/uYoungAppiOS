//
//  CityModel.m
//  uYoung
//
//  Created by 独自天涯 on 15/11/19.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "CityModel.h"

@interface CityModel()<NSCoding>

@end

@implementation CityModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"cnName": @"cnName",
             @"enName": @"enName",
             @"lat": @"lat",
             @"lon": @"lon",
             @"id": @"id",
             @"pid": @"pid",
             @"subDictCityList": @"subDictCityList"
             };
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    NSArray * a =  [MTLJSONAdapter modelsOfClass:[CityModel class] fromJSONArray:self.subDictCityList error:nil];
    if (a&&[a count]>0) {
        self.subDictCityList = [[NSArray alloc]initWithArray:a];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeInteger:self.id forKey:@"id"];
    [aCoder encodeInteger:self.pid forKey:@"pid"];
    [aCoder encodeObject:self.cnName ?: [NSNull null] forKey:@"cnName"];
    [aCoder encodeObject:self.enName ?: [NSNull null] forKey:@"enName"];
    [aCoder encodeObject:self.lat ?: [NSNull null] forKey:@"lat"];
    [aCoder encodeObject:self.lon ?: [NSNull null] forKey:@"lon"];
    [aCoder encodeObject:self.subDictCityList ?: [NSNull null] forKey:@"subDictCityList"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.id = [aDecoder decodeIntegerForKey:@"id"];
        
        self.pid = [aDecoder decodeIntegerForKey:@"pid"];
        
        self.cnName = [aDecoder decodeObjectForKey:@"cnName"];
        if ([self.cnName isEqual:[NSNull null]]) {
            self.cnName = nil;
        }
        
        self.enName = [aDecoder decodeObjectForKey:@"enName"];
        if ([self.enName isEqual:[NSNull null]]) {
            self.enName = nil;
        }
        
        self.lat = [aDecoder decodeObjectForKey:@"lat"];
        if ([self.lat isEqual:[NSNull null]]) {
            self.lat = nil;
        }
        
        self.lon = [aDecoder decodeObjectForKey:@"lon"];
        if ([self.lon isEqual:[NSNull null]]) {
            self.lon = nil;
        }
        
        self.subDictCityList = [aDecoder decodeObjectForKey:@"subDictCityList"];
        if ([self.subDictCityList isEqual:[NSNull null]]) {
            self.subDictCityList = nil;
        }
        
    }
    return self;
}

@end
