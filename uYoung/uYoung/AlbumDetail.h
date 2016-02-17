//
//  AlbumDetail.h
//  uYoung
//
//  Created by 独自天涯 on 15/12/9.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "AlbumDetailModel.h"

@protocol AlbumDetailDelegate <NSObject>

@optional
-(void)successGetAlbumDetail:(AlbumDetailModel*)detail;
@end

@interface AlbumDetail : NSObject

+ (void)getAlbumDetailByAlbumId:(long)id delegate:(id<AlbumDetailDelegate>)delegate;

+ (void)updateAlbumNameByAlbumId:(long)albumId name:(NSString*)name uid:(long)uid success:(void(^)(BOOL success))success;

@end
