//
//  ActivityDescTextView.h
//  uYoung
//
//  Created by 独自天涯 on 15/11/30.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSSRichTextEditor.h"
#import "UploadImageUtil.h"


@interface ActivityDescTextView : ZSSRichTextEditor<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UploadImgDelegate>

@property (strong, nonatomic) UIImagePickerController *camera;

@end
