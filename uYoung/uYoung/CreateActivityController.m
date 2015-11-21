//
//  CreateActivityController.m
//  uYoung
//
//  Created by 独自天涯 on 15/11/21.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "CreateActivityController.h"

@interface CreateActivityController ()

@end

@implementation CreateActivityController

- (void)viewDidLoad {
    [super viewDidLoad];
    _backgroundImg.image = [self getScaleUIImage:@"uyoung.bundle/backcover" Height:30];
    
    //活动名称
    
    //活动日期
    //活动时间
    //活动类型
    //参与人数
    //费用
    //活动地点
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

- (UIImage *)getScaleBackUIImage:(NSString*)name isFront:(BOOL)isFront{
    UIImage *bubble = [UIImage imageNamed:name];
    
    UIEdgeInsets capInsets;
    if (isFront) {
        capInsets = UIEdgeInsetsMake(0, 10, 0, 6);
    }else{
        capInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    }
    return [bubble resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
    
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
