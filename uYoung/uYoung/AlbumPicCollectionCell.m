//
//  AlbumPicCollectionCell.m
//  uYoung
//
//  Created by CSDN on 15/12/7.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "AlbumPicCollectionCell.h"
#import "UIImageView+LazyInit.h"
#import "GlobalConfig.h"
#import "NSString+StringUtil.h"

@implementation AlbumPicCollectionCell

- (void)awakeFromNib {
    [_selImg setHidden:YES];
}

- (void)hiddenLabels{
    [_likeLabel setHidden:YES];
    [_viewLabel setHidden:YES];
    [_likeImg setHidden:YES];
    [_viewImg setHidden:YES];
}

- (void)initCellWithPhotoDetail:(PhotoDetailModel*)photoDetail{
    _model = photoDetail;
    NSData *qiniuHostData = [[NSUserDefaults standardUserDefaults]objectForKey:@"qiniu_host"];
    NSString *qiniuHost = [NSKeyedUnarchiver unarchiveObjectWithData:qiniuHostData];
    if ([NSString isBlankString:qiniuHost]) {
        qiniuHost = QINIU_DEFAULT_HOST;
    }
    NSString *photoUrl = [[qiniuHost stringByAppendingString:@"/"]stringByAppendingString:photoDetail.photoUrl];
    [_img lazyInitSmallImageWithUrl:photoUrl suffix:@"pic621"];
    [_viewLabel setText:[NSString stringWithFormat:@"%d", (int)photoDetail.viewCount]];
    [_likeLabel setText:[NSString stringWithFormat:@"%d", (int)photoDetail.likeCount]];
    
}

- (void)changeSelectImg:(BOOL)isSel{
    if (isSel) {
        [_selImg setImage:[UIImage imageNamed:@"ZLPhotoLib.bundle/icon_image_yes"]];
    }else{
        [_selImg setImage:[UIImage imageNamed:@"ZLPhotoLib.bundle/icon_image_no"]];
    }
}


@end
