//
//  ShareView.h
//  uYoung
//
//  Created by 独自天涯 on 16/1/27.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShareViewDelegate <NSObject>

- (void)cancelShare;

@end

@interface ShareView : UIView

@property (weak, nonatomic) id<ShareViewDelegate> delegate;

@property (assign, nonatomic) long actId;

- (IBAction)shareToWXFriend:(id)sender;
- (IBAction)shareToWX:(id)sender;
- (IBAction)shareToQQ:(id)sender;
- (IBAction)shareToWeibo:(id)sender;
- (IBAction)cancel:(id)sender;

@end
