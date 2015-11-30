//
//  ActivityDescTextView.m
//  uYoung
//
//  Created by 独自天涯 on 15/11/30.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "ActivityDescTextView.h"

@implementation ActivityDescTextView

- (void)viewDidLoad{
    [super viewDidLoad];
    
//    _textView = [[UITextView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
//    _textView.delegate = self;
//        _textView.backgroundColor=[UIColor darkGrayColor];
//    [self.view addSubview:_textView];
    
    self.baseURL = [NSURL URLWithString:@"http://www.zedsaid.com"];
    self.formatHTML = YES;
    self.toolbarItemTintColor = [UIColor greenColor];
    self.toolbarItemSelectedTintColor = [UIColor redColor];

    [self setEditing:YES];

    self.enabledToolbarItems = @[ZSSRichTextEditorToolbarBold, ZSSRichTextEditorToolbarItalic, ZSSRichTextEditorToolbarUnderline, ZSSRichTextEditorToolbarH1, ZSSRichTextEditorToolbarH2, ZSSRichTextEditorToolbarH3, ZSSRichTextEditorToolbarTextColor, ZSSRichTextEditorToolbarInsertImage, ZSSRichTextEditorToolbarInsertLink, ZSSRichTextEditorToolbarRemoveLink, ZSSRichTextEditorToolbarUndo, ZSSRichTextEditorToolbarRedo, ZSSRichTextEditorToolbarAll, ZSSRichTextEditorToolbarNone];

    self.view.backgroundColor = [UIColor darkGrayColor];
}

- (void)insertImage:(NSString *)url alt:(NSString *)alt{
    NSLog(@"##inserImage##%@---%@", url, alt);
}

- (void)insertLink:(NSString *)url title:(NSString *)title{
    NSLog(@"##insertLink##%@---%@", url, title);
}

@end