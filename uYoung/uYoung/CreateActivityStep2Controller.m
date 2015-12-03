//
//  CreateActivityStep2Controller.m
//  uYoung
//
//  Created by 独自天涯 on 15/11/30.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "CreateActivityStep2Controller.h"
#import "GlobalConfig.h"

@interface CreateActivityStep2Controller ()

@end

@implementation CreateActivityStep2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _backgroundImg.image = [self getScaleUIImage:@"uyoung.bundle/backcover" Height:30];
    
    ActivityDescTextView *descView = [[ActivityDescTextView alloc]init];
    [descView.view setFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight)];
    [self addChildViewController:descView];
    [self.view addSubview:descView.view];
    
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
