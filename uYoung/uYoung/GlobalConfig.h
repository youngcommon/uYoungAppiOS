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

#define SinaWeiboAppKey @"1375588776"

#define WXKey @"wx4fb8f182d2edba22"

#define SinaWeiboRedirectURI @"https://api.weibo.com/oauth2/default.html"

#define UserDefaultHeader @"uyoung.bundle/logo_icon"

#define QINIU_TOKEN @"qiniu_token"

#define QINIU_HOST @"qiniu_host"

#define CITY_LIST @"city_list"

#define QINIU_AK @"tq_GXB57qnS-yuR3Ci8ljH6qhcghtk51S-hkUJuS"

#define QINIU_SK @"1GPL8ts0TUNS1EUM3_AHpAnyws5VKtKhxL8zYTLo"

#define QINIU_DEFAULT_HOST @"http://7xnzko.com1.z0.glb.clouddn.com"

#define DOUBAN_API_KEY @"09cfe41f642337ee1d6fac5e2c69a7ca"
#define DOUBAN_PRIVATE_KEY @"a0065d0702fdafef"
#define DOUBAN_REDIRECT_URL @"http://182.92.237.31/third/douban/callback"
#define DOUBAN_REGISTER_URL @"https://www.douban.com/accounts/register"
#define DOUBAN_TERMS_URL @"https://developers.douban.com/wiki/?title=terms"

#endif /* GlobalConfig_h */
