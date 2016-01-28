//
//  ShareView.h
//  uYoung
//
//  Created by 独自天涯 on 16/1/27.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TencentOpenAPI/TencentApiInterface.h>

@protocol ShareViewDelegate <NSObject>

- (void)cancelShare;

@end

@interface ShareView : UIView

@property (weak, nonatomic) id<ShareViewDelegate> delegate;

@property (strong, nonatomic) NSString *actTitle;
@property (strong, nonatomic) NSString *shareUrl;
@property (strong, nonatomic) NSString *shareDesc;

- (IBAction)shareToWX:(UIButton*)sender;
- (IBAction)shareToQQ:(id)sender;
- (IBAction)shareToWeibo:(id)sender;
- (IBAction)cancel:(id)sender;

@end
