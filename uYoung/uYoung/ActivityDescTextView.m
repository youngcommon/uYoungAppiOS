//
//  ActivityDescTextView.m
//  uYoung
//
//  Created by 独自天涯 on 15/11/30.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "ActivityDescTextView.h"
#import "GlobalConfig.h"
#import "UserDetailModel.h"

@implementation ActivityDescTextView

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
        
//        [[self topViewController] presentViewController:_camera animated:YES completion:nil];
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
    
    NSInteger uid = [UserDetailModel currentUser].id;
    long times = [[NSDate date]timeIntervalSince1970];
    
    //上传图片至七牛云
    [[UploadImageUtil dispatchOnce]uploadImage:img withKey:[NSString stringWithFormat:@"uy_act_%d_%ld", (int)uid, times] delegate:self];
    
//    [[self topViewController] dismissViewControllerAnimated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];

}

//用户取消回调
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
//    [[self topViewController] dismissViewControllerAnimated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)getImgUrl:(NSString*)url{
    url = [NSString stringWithFormat:@"%@-%@", url, @"actdesc100"];
//    [self insertImage:url alt:@""];
    [self focusTextEditor];
    [self insertHTML:[NSString stringWithFormat:@"<img src=\"%@\" />", url]];
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

- (UIViewController*)topViewController{
    return [self topViewControllerWithRootViewController:self.view.window.rootViewController];
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

@end