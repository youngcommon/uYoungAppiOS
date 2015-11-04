//
//  EditUserViewController.m
//  uYoung
//
//  Created by 独自天涯 on 15/11/4.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "EditUserViewController.h"

@interface EditUserViewController ()

@end

@implementation EditUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _backCoverImageView.image = [self getScaleUIImage:@"uyoung.bundle/backcover" Height:30];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIImage *)getScaleUIImage:(NSString*)name Height:(CGFloat)height{
    UIImage *bubble = [UIImage imageNamed:name];
    
    CGPoint center = CGPointMake(bubble.size.width / 2.0f, height);
    UIEdgeInsets capInsets = UIEdgeInsetsMake(center.y, 0, center.y+1, 2);
    return [bubble resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
    
}

@end
