//
//  ActivityDescTextView.m
//  uYoung
//
//  Created by 独自天涯 on 15/11/30.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "ActivityDescTextView.h"
#import "GlobalConfig.h"

@implementation ActivityDescTextView

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.frame = CGRectMake(0, 0, mScreenWidth, 59);
    
    self.title = @"填写活动描述";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"HelveticaNeue-Bold" size:14], NSFontAttributeName, nil]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"uyoung.bundle/back_btn.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back)
     forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 13, 22);
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = menuButton;
    [self.navigationItem.leftBarButtonItem setWidth:20];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"uyoung.bundle/background"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(exportHTML)];
    
    self.baseURL = [NSURL URLWithString:@"http://www.zedsaid.com"];

    self.enabledToolbarItems = @[ZSSRichTextEditorToolbarBold, ZSSRichTextEditorToolbarItalic, ZSSRichTextEditorToolbarUnderline, ZSSRichTextEditorToolbarH1, ZSSRichTextEditorToolbarH2, ZSSRichTextEditorToolbarH3, ZSSRichTextEditorToolbarTextColor, ZSSRichTextEditorToolbarInsertImage, ZSSRichTextEditorToolbarInsertLink, ZSSRichTextEditorToolbarRemoveLink, ZSSRichTextEditorToolbarUndo, ZSSRichTextEditorToolbarRedo];

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)insertImage:(NSString *)url alt:(NSString *)alt{
    NSLog(@"##inserImage##%@---%@", url, alt);
}

- (void)insertLink:(NSString *)url title:(NSString *)title{
    NSLog(@"##insertLink##%@---%@", url, title);
}

- (void)exportHTML {
    NSLog(@"%@", [self getHTML]);
    [[NSNotificationCenter defaultCenter]postNotificationName:@"getHtmlData" object:[self getHTML]];
}

- (UIImage *)getScaleUIImage:(NSString*)name Height:(CGFloat)height{
    UIImage *bubble = [UIImage imageNamed:name];
    
    CGPoint center = CGPointMake(bubble.size.width / 2.0f, height);
    UIEdgeInsets capInsets = UIEdgeInsetsMake(center.y, 0, center.y+1, 2);
    return [bubble resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
    
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end