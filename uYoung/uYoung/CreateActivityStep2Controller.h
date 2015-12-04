//
//  CreateActivityStep2Controller.h
//  uYoung
//
//  Created by 独自天涯 on 15/11/30.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSSRichTextEditor.h"
#import "UploadImageUtil.h"

@interface CreateActivityStep2Controller : ZSSRichTextEditor<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UploadImgDelegate>

@property (strong, nonatomic) UIImagePickerController *camera;
@property (strong, nonatomic) NSString *html;

@end
