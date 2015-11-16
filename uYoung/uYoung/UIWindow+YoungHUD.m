//
//  UIWindow+YoungHUD.m
//  uYoung
//
//  Created by 独自天涯 on 15/11/16.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "UIWindow+YoungHUD.h"
#import "YoungHUDBackgroundView.h"
#import "YoungHUDImageView.h"
#import "YoungHUDIndicator.h"
#import "YoungHUDLabel.h"

#define YoungHUDBounds CGRectMake(0, 0, 100, 100)
#define YoungHUDCenter CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)
#define YoungHUDBackgroundAlpha 1
#define YoungHUDComeTime 0.15
#define YoungHUDStayTime 1
#define YoungHUDGoTime 0.15
#define YoungHUDFont 17

@implementation UIWindow (YoungHUD)

-(void)showHUDWithText:(NSString *)text Type:(showHUDType)type Enabled:(BOOL)enabled{
    [self showHUDWithText:text Type:type Enabled:(BOOL)enabled Bounds:YoungHUDBounds Center:YoungHUDCenter BackgroundAlpha:YoungHUDBackgroundAlpha ComeTime:YoungHUDComeTime StayTime:YoungHUDStayTime GoTime:YoungHUDGoTime];
}

-(void)showHUDWithText:(NSString *)text Type:(showHUDType)type Enabled:(BOOL)enabled Bounds:(CGRect)bounds Center:(CGPoint)center BackgroundAlpha:(CGFloat)backgroundAlpha ComeTime:(CGFloat)comeTime StayTime:(CGFloat)stayTime GoTime:(CGFloat)goTime{
    static BOOL isShow = YES;
    if (isShow) {
        isShow = NO;
        [self addSubview:[YoungHUDBackgroundView shareHUDView]];
        [self addSubview:[YoungHUDImageView shareHUDView]];
        [self addSubview:[YoungHUDLabel shareHUDView]];
        [self addSubview:[YoungHUDIndicator shareHUDView]];
        
        [YoungHUDBackgroundView shareHUDView].center = center;
        [YoungHUDLabel shareHUDView].center = CGPointMake(center.x, center.y + bounds.size.height/3.5);
        [YoungHUDImageView shareHUDView].center = CGPointMake(center.x, center.y - bounds.size.height/6);
        [YoungHUDIndicator shareHUDView].center = CGPointMake(center.x, center.y - bounds.size.height/6);
        [self goTimeBounds:bounds];
    }
    
    [YoungHUDLabel shareHUDView].bounds = CGRectMake(0, 0, bounds.size.width, bounds.size.height/2 - 10);
    if ([self textLength:text] * YoungHUDFont + 10 >= bounds.size.width) {
        [YoungHUDLabel shareHUDView].font = [UIFont systemFontOfSize:YoungHUDFont - 2];
    }
    
    self.userInteractionEnabled = enabled;
    
    switch (type) {
        case ShowLoading:
            [self showLoadingWithText:(NSString *)text Type:(showHUDType)type Enabled:(BOOL)enabled Bounds:(CGRect)bounds Center:(CGPoint)center BackgroundAlpha:(CGFloat)backgroundAlpha ComeTime:(CGFloat)comeTime StayTime:(CGFloat)stayTime GoTime:(CGFloat)goTime];
            break;
        case ShowPhotoYes:
            [self showPhotoYesWithText:(NSString *)text Type:(showHUDType)type Enabled:(BOOL)enabled Bounds:(CGRect)bounds Center:(CGPoint)center BackgroundAlpha:(CGFloat)backgroundAlpha ComeTime:(CGFloat)comeTime StayTime:(CGFloat)stayTime GoTime:(CGFloat)goTime];
            break;
        case ShowPhotoNo:
            [self showPhotoNoWithText:(NSString *)text Type:(showHUDType)type Enabled:(BOOL)enabled Bounds:(CGRect)bounds Center:(CGPoint)center BackgroundAlpha:(CGFloat)backgroundAlpha ComeTime:(CGFloat)comeTime StayTime:(CGFloat)stayTime GoTime:(CGFloat)goTime];
            break;
        case ShowDismiss:
            [self showDismissWithText:(NSString *)text Type:(showHUDType)type Enabled:(BOOL)enabled Bounds:(CGRect)bounds Center:(CGPoint)center BackgroundAlpha:(CGFloat)backgroundAlpha ComeTime:(CGFloat)comeTime StayTime:(CGFloat)stayTime GoTime:(CGFloat)goTime];
            break;
            
        default:
            break;
    }
}

-(void)showLoadingWithText:(NSString *)text Type:(showHUDType)type Enabled:(BOOL)enabled Bounds:(CGRect)bounds Center:(CGPoint)center BackgroundAlpha:(CGFloat)backgroundAlpha ComeTime:(CGFloat)comeTime StayTime:(CGFloat)stayTime GoTime:(CGFloat)goTime{
    if ([YoungHUDBackgroundView shareHUDView].alpha != 0) {
        return;
    }
  
    [YoungHUDLabel shareHUDView].text = text;
    [[YoungHUDIndicator shareHUDView] stopAnimating];
    [YoungHUDImageView shareHUDView].alpha = 0;

    [UIView animateWithDuration:comeTime animations:^{
        [self comeTimeBounds:bounds];
        [self comeTimeAlpha:backgroundAlpha withImage:NO];
        [[YoungHUDIndicator shareHUDView] startAnimating];
    } completion:^(BOOL finished) {

    }];
}

-(void)showPhotoYesWithText:(NSString *)text Type:(showHUDType)type Enabled:(BOOL)enabled Bounds:(CGRect)bounds Center:(CGPoint)center BackgroundAlpha:(CGFloat)backgroundAlpha ComeTime:(CGFloat)comeTime StayTime:(CGFloat)stayTime GoTime:(CGFloat)goTime{
    if ([[YoungHUDIndicator shareHUDView] isAnimating]) {
        [[YoungHUDIndicator shareHUDView] stopAnimating];
        
        [YoungHUDImageView shareHUDView].bounds =
        CGRectMake(0, 0, (bounds.size.width/2.5 - 5) * 2, (bounds.size.height/2.5 - 5) * 2);
    }else{
        if ([YoungHUDBackgroundView shareHUDView].alpha != 0) {
            return;
        }
        [self goTimeBounds:bounds];
        [self goTimeInit];
    }
    
    [YoungHUDLabel shareHUDView].text = text;
    [YoungHUDImageView shareHUDView].image = [UIImage imageNamed:@"uyoung.bundle/HUD_YES"];
    [UIView animateWithDuration:comeTime animations:^{
        [self comeTimeBounds:bounds];
        [self comeTimeAlpha:backgroundAlpha withImage:YES];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:stayTime animations:^{
            [self stayTimeAlpha:backgroundAlpha];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:goTime animations:^{
                [self goTimeBounds:bounds];
                [self goTimeInit];;
            } completion:^(BOOL finished) {
                //Nothing
            }];
        }];
    }];
}

-(void)showPhotoNoWithText:(NSString *)text Type:(showHUDType)type Enabled:(BOOL)enabled Bounds:(CGRect)bounds Center:(CGPoint)center BackgroundAlpha:(CGFloat)backgroundAlpha ComeTime:(CGFloat)comeTime StayTime:(CGFloat)stayTime GoTime:(CGFloat)goTime{
    if ([[YoungHUDIndicator shareHUDView] isAnimating]) {
        [[YoungHUDIndicator shareHUDView] stopAnimating];
        
        [YoungHUDImageView shareHUDView].bounds =
        CGRectMake(0, 0, (bounds.size.width/2.5 - 5) * 2, (bounds.size.height/2.5 - 5) * 2);
    }else{
        if ([YoungHUDBackgroundView shareHUDView].alpha != 0) {
            return;
        }
        [self goTimeBounds:bounds];
        [self goTimeInit];
    }
    
    [YoungHUDLabel shareHUDView].text = text;
    [YoungHUDImageView shareHUDView].image = [UIImage imageNamed:@"uyoung.bundle/HUD_NO"];
    [UIView animateWithDuration:comeTime animations:^{
        [self comeTimeBounds:bounds];
        [self comeTimeAlpha:backgroundAlpha withImage:YES];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:stayTime animations:^{
            [self stayTimeAlpha:backgroundAlpha];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:goTime animations:^{
                [self goTimeBounds:bounds];
                [self goTimeInit];;
            } completion:^(BOOL finished) {
                //Nothing
            }];
        }];
    }];
}

-(void)showDismissWithText:(NSString *)text Type:(showHUDType)type Enabled:(BOOL)enabled Bounds:(CGRect)bounds Center:(CGPoint)center BackgroundAlpha:(CGFloat)backgroundAlpha ComeTime:(CGFloat)comeTime StayTime:(CGFloat)stayTime GoTime:(CGFloat)goTime{
    if ([[YoungHUDIndicator shareHUDView] isAnimating]) {
        [[YoungHUDIndicator shareHUDView] stopAnimating];
    }
    
    [YoungHUDLabel shareHUDView].text = nil;
    [YoungHUDImageView shareHUDView].image = nil;
    [UIView animateWithDuration:goTime animations:^{
        [YoungHUDImageView shareHUDView].bounds =
        CGRectMake(0, 0, (bounds.size.width/2.5 - 5) * 2, (bounds.size.height/2.5 - 5) * 2);
        [self goTimeBounds:bounds];
        [self goTimeInit];
    } completion:^(BOOL finished) {
        //Nothing
    }];
}

#pragma mark 状态
-(void)goTimeBounds:(CGRect)bounds{
    [YoungHUDBackgroundView shareHUDView].bounds =
    CGRectMake(0, 0, bounds.size.width * 1.5, bounds.size.height * 1.5);
    [YoungHUDImageView shareHUDView].bounds =
    CGRectMake(0, 0, (bounds.size.width/2.5 - 5) * 2, (bounds.size.height/2.5 - 5) * 2);
}

-(void)goTimeInit{
    [YoungHUDBackgroundView shareHUDView].alpha = 0;
    [YoungHUDImageView shareHUDView].alpha = 0;
    [YoungHUDLabel shareHUDView].alpha = 0;
    [[YoungHUDIndicator shareHUDView] stopAnimating];
}

-(void)stayTimeAlpha:(CGFloat)alpha{
    [YoungHUDBackgroundView shareHUDView].alpha = alpha - 0.01;
}

-(void)comeTimeBounds:(CGRect)bounds{
    [YoungHUDBackgroundView shareHUDView].bounds =
    CGRectMake(0, 0, bounds.size.width, bounds.size.height);
    [YoungHUDImageView shareHUDView].bounds =
    CGRectMake(0, 0, bounds.size.width/2.5 - 5, bounds.size.height/2.5 - 5);
}

-(void)comeTimeAlpha:(CGFloat)alpha withImage:(BOOL)isImage{
    [YoungHUDBackgroundView shareHUDView].alpha = alpha;
    [YoungHUDLabel shareHUDView].alpha = 1;
    if (isImage) {
        [YoungHUDImageView shareHUDView].alpha = 1;
    }
}

#pragma mark - 计算字符串长度
- (int)textLength:(NSString *)text{
    float number = 0.0;
    for (int index = 0; index < [text length]; index++)
    {
        NSString *character = [text substringWithRange:NSMakeRange(index, 1)];
        
        if ([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 3)
        {
            number++;
        }
        else
        {
            number = number + 0.5;
        }
    }
    return ceil(number);
}


@end
