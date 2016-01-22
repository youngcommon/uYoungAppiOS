//
//  CreateActivityStep2Controller.m
//  uYoung
//
//  Created by 独自天涯 on 15/11/30.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "CreateActivityStep2Controller.h"
#import "GlobalConfig.h"
#import "UserDetailModel.h"
#import "UIWindow+YoungHUD.h"
#import "NSString+StringUtil.h"

@interface CreateActivityStep2Controller ()

@end

@implementation CreateActivityStep2Controller

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.frame = CGRectMake(0, 0, mScreenWidth, 59);
    
    self.title = @"填写活动描述";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"HelveticaNeue-Bold" size:14], NSFontAttributeName, nil]];
    
    [self.navigationItem setHidesBackButton:YES];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"uyoung.bundle/background"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(exportHTML)];
    
    self.baseURL = [NSURL URLWithString:@"http://www.zedsaid.com"];
    
    self.enabledToolbarItems = @[ZSSRichTextEditorToolbarBold, ZSSRichTextEditorToolbarItalic, ZSSRichTextEditorToolbarUnderline, ZSSRichTextEditorToolbarH1, ZSSRichTextEditorToolbarH2, ZSSRichTextEditorToolbarH3, ZSSRichTextEditorToolbarTextColor, ZSSRichTextEditorToolbarInsertImage, ZSSRichTextEditorToolbarInsertLink, ZSSRichTextEditorToolbarRemoveLink, ZSSRichTextEditorToolbarUndo, ZSSRichTextEditorToolbarRedo];
    
    if ([NSString isBlankString:_html]==NO) {
        [self setHTML:_html];
    }
    
}

- (void)showInsertImageAlternatePicker {
    
    [self dismissAlertView];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        _camera = [[UIImagePickerController alloc] init];
        _camera.delegate = self;
        //        _camera.allowsEditing = YES;
        _camera.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //此处设置只能使用相机，禁止使用视频功能
        _camera.mediaTypes = @[(NSString*)kUTTypeImage];
        
        [self presentViewController:_camera animated:YES completion:nil];
    }
    
}

//点击相册中的图片或照相机照完后点击use后触发的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *img;
    if ([info objectForKey:UIImagePickerControllerEditedImage]) {
        img = [info objectForKey:UIImagePickerControllerEditedImage];
    }else{
        img = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    //处理图片，只获得缩略图上传
    //269*88 要显示的大小
    CGSize reSize = CGSizeMake(200, 100);
    //得到最后绘出来的图片大小
    img = [self thumbnailWithImageWithoutScale:img size:reSize];
    
    NSInteger uid = [UserDetailModel currentUser].id;
    long times = [[NSDate date]timeIntervalSince1970];
    
    [self.view.window showHUDWithText:@"正在处理图片" Type:ShowLoading Enabled:YES];
    //上传图片至七牛云
    [[UploadImageUtil dispatchOnce]uploadImage:img withKey:[NSString stringWithFormat:@"uy_act_%d_%ld", (int)uid, times] exif:nil delegate:self];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//用户取消回调
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)getImgKey:(NSString*)key host:(NSString *)host exif:(PicExif *)exif{
    if([NSString isBlankString:key]){
        [self.view.window showHUDWithText:@"图片插入失败" Type:ShowPhotoNo Enabled:YES];
    }else{
        if ([NSString isBlankString:host]) {
            host = QINIU_HOST;
        }
        NSString *url = [[host stringByAppendingString:@"/"]stringByAppendingString:key];
        [self.view.window showHUDWithText:@"图片处理成功" Type:ShowPhotoYes Enabled:YES];
        url = [NSString stringWithFormat:@"%@-%@", url, @"actdesc200"];
        [self focusTextEditor];
        [self insertHTML:[NSString stringWithFormat:@"<img src=\"%@\" />", url]];
    }
}

- (void)exportHTML {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"getHtmlData" object:[self getHTML]];
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = YES;
}

- (UIImage *)getScaleUIImage:(NSString*)name Height:(CGFloat)height{
    UIImage *bubble = [UIImage imageNamed:name];
    CGPoint center = CGPointMake(bubble.size.width / 2.0f, height);
    UIEdgeInsets capInsets = UIEdgeInsetsMake(center.y, 0, center.y+1, 2);
    return [bubble resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
}

#pragma mark 压缩图片
- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGRect rect = CGRectMake(0, 0, asize.width, asize.height);
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.view.window showHUDWithText:@"" Type:ShowDismiss Enabled:YES];
}

@end
