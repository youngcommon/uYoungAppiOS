//
//  UserAlbumList.h
//  uYoung
//
//  Created by CSDN on 15/10/22.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "GlobalConfig.h"

@interface UserAlbumList : NSObject

+ (void)getUserAlbumListWithUid:(NSInteger)userId;

@end
