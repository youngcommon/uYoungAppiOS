//
//  GlobalConfig.h
//  uYoung
//
//  Created by CSDN on 15/9/23.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#ifndef GlobalConfig_h
#define GlobalConfig_h

#define mScreenWidth          ([UIScreen mainScreen].bounds.size.width)
#define mScreenHeight         ([UIScreen mainScreen].bounds.size.height)

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define lableTextColor ([UIColorFromRGB(0x4A90E2) CGColor])

#define contentTextColor ([UIColorFromRGB(0x85B200) CGColor])

#define uyoung_host @"http://182.92.237.31/"

#define pageSize 15

#define UMengAppKey @"562d94ad67e58ef66e000973"

#define QQAppKey @"1104920700"

#endif /* GlobalConfig_h */
