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
    
//    _userHeaderButton.layer.borderColor = [UIColorFromRGB(0x85b200) CGColor];
//    _userHeaderButton.layer.borderWidth = 1.;
    
    [_nicknameImage setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_mid" isFront:YES]];
    _nicknameInput.background = [self getScaleBackUIImage:@"uyoung.bundle/input_end_mid" isFront:NO];
    [_genderImage setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_mid" isFront:YES]];
    [_genderBackImage setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_end_mid" isFront:NO]];
    [_locationImage setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_mid" isFront:YES]];
    [_locationBackImage setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_end_mid" isFront:NO]];
    [_companyImage setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_top" isFront:YES]];
    _companyInput.background = [self getScaleBackUIImage:@"uyoung.bundle/input_end_top" isFront:NO];
    [_positionImage setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_bottom" isFront:YES]];
    _positionInput.background = [self getScaleBackUIImage:@"uyoung.bundle/input_end_bottom" isFront:NO];
    [_emailImage setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_top" isFront:YES]];
    _emailInput.background = [self getScaleBackUIImage:@"uyoung.bundle/input_end_top" isFront:NO];
    [_mobileImage setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_bottom" isFront:YES]];
    _mobileInput.background = [self getScaleBackUIImage:@"uyoung.bundle/input_end_bottom" isFront:NO];
    [_equipmentImage setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_mid" isFront:YES]];
    _equipmentInput.background = [self getScaleBackUIImage:@"uyoung.bundle/input_end_mid" isFront:NO];
    
}

- (void)updateConstrains{
    
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

@end
