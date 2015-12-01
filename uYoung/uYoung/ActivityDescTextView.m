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
    
    self.baseURL = [NSURL URLWithString:@"http://www.zedsaid.com"];
    self.formatHTML = YES;
    self.toolbarItemTintColor = [UIColor greenColor];
    self.toolbarItemSelectedTintColor = [UIColor redColor];
    [self setEditing:YES];

    self.enabledToolbarItems = @[ZSSRichTextEditorToolbarBold, ZSSRichTextEditorToolbarItalic, ZSSRichTextEditorToolbarUnderline, ZSSRichTextEditorToolbarH1, ZSSRichTextEditorToolbarH2, ZSSRichTextEditorToolbarH3, ZSSRichTextEditorToolbarTextColor, ZSSRichTextEditorToolbarInsertImage, ZSSRichTextEditorToolbarInsertLink, ZSSRichTextEditorToolbarRemoveLink, ZSSRichTextEditorToolbarUndo, ZSSRichTextEditorToolbarRedo];

}

- (void)insertImage:(NSString *)url alt:(NSString *)alt{
    NSLog(@"##inserImage##%@---%@", url, alt);
}

- (void)insertLink:(NSString *)url title:(NSString *)title{
    NSLog(@"##insertLink##%@---%@", url, title);
}

@end