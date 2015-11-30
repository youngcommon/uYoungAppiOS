//
//  CreateActivityStep2Controller.m
//  uYoung
//
//  Created by 独自天涯 on 15/11/30.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "CreateActivityStep2Controller.h"

@interface CreateActivityStep2Controller ()

@end

@implementation CreateActivityStep2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _backgroundImg.image = [self getScaleUIImage:@"uyoung.bundle/backcover" Height:30];
    
    CGFloat x = 30;
    CGFloat y = 30;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(x, y, _contentView.frame.size.width-30*2, _contentView.frame.origin.x+_contentView.frame.size.height-30-25-8-30*2)];
    view.backgroundColor = [UIColor blueColor];
    
    ActivityDescTextView *descView = [[ActivityDescTextView alloc]init];
    [descView.view setFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    [self addChildViewController:descView];
    [view addSubview:descView.view];
    
    [self.contentView addSubview:view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)createActivity:(id)sender {
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIImage *)getScaleUIImage:(NSString*)name Height:(CGFloat)height{
    UIImage *bubble = [UIImage imageNamed:name];
    
    CGPoint center = CGPointMake(bubble.size.width / 2.0f, height);
    UIEdgeInsets capInsets = UIEdgeInsetsMake(center.y, 0, center.y+1, 2);
    return [bubble resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
    
}
@end
