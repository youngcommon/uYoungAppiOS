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
    
    [self updateConstraints];
    
    [_nicknameImage setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_top" isFront:YES]];
    _nicknameInput.background = [self getScaleBackUIImage:@"uyoung.bundle/input_end_top" isFront:NO];
    [_genderImage setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_bottom" isFront:YES]];
    [_genderBackImage setImage:[self getScaleBackUIImage:@"uyoung.bundle/input_end_bottom" isFront:NO]];
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

- (void)updateConstraints{
    CGFloat headerSize;
    CGFloat distance;
    CGFloat tinyImageW;
    CGFloat largeImageW;
    CGFloat top;
    CGFloat sep;
    CGFloat height;
    if (mScreenWidth==375) {//iPhone 6
        headerSize = 74.f;
        distance = 30.f;
        tinyImageW = 82.f;
        largeImageW = 100.f;
        top = 40.f;
        sep = 2.f;
        height = 40.f;
    }else if(mScreenWidth>375){//iPhone 6+
        headerSize = 90.f;
        distance = 38.f;
        tinyImageW = 90.f;
        largeImageW = 110.f;
        top = 50.f;
        sep = 4.f;
        height = 44.f;
    }else if(mScreenWidth<375&&mScreenHeight>480){//iPhone 5
        headerSize = 60.f;
        distance = 18.f;
        tinyImageW = 64.f;
        largeImageW = 80.f;
        top = 26.f;
        sep = 2.f;
        height = 40.f;
    }else{
        return;
    }
    
    UIView *content = [self.view viewWithTag:620];
    NSArray *views = content.subviews;
    if (views&&[views count]>0) {
        for (int i=0; i<[views count]; i++) {
            UIView *view = views[i];
            NSArray *consarr = view.constraints;
            if (consarr&&[consarr count]>0) {
                for (int j=0; j<[consarr count]; j++) {
                    NSLayoutConstraint *cons = consarr[j];
                    if(cons&&[cons.identifier hasPrefix:@"h_"]){
                        [cons setConstant:height];
                    }
                }
            }
        }
    }
    
    [_userHeaderButtonH setConstant:headerSize];
    [_userHeaderButtonW setConstant:headerSize];
    [_nicknameImageW setConstant:tinyImageW];
    [_genderImageW setConstant:tinyImageW];
    [_locationImageW setConstant:largeImageW];
    [_companyImageW setConstant:largeImageW];
    [_positionImageW setConstant:largeImageW];
    [_emailImageW setConstant:largeImageW];
    [_mobileImageW setConstant:largeImageW];
    [_equipmentImageW setConstant:largeImageW];
    
    [_firstDistanceCons setConstant:distance];
    [_secondDistanceCons setConstant:distance];
    [_thirdDistanceCons setConstant:distance];
    [_fourthDistanceCons setConstant:distance];
    
    [_topCons setConstant:top];
    
    [_firstSepCons setConstant:sep];
    [_secondSepCons setConstant:sep];
    [_thirdSepCons setConstant:sep];
    
    [_headerTopCons setConstant:top];
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
