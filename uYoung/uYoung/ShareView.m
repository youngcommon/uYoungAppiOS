//
//  ShareView.m
//  uYoung
//
//  Created by 独自天涯 on 16/1/27.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import "ShareView.h"
#import "GlobalConfig.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"

@implementation ShareView

- (IBAction)shareToWX:(UIButton*)sender {
    NSInteger tag = sender.tag;
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = _actTitle;
    message.description = _shareDesc;
    //[[self.viewModel titleOfHpDetail] stringByAppendingString:[self.viewModel adressEventDetail]];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"uyoung.bundle/logo" ofType:@"png"];
    NSData *previewData = [NSData dataWithContentsOfFile:imagePath];
    [message setThumbData:previewData];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = self.shareUrl;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    //req.text = @"我发现一个有意思东东，一起来看看吧";
    req.bText = NO;
    req.message = message;
    req.scene = (int)tag;
    
    [WXApi sendReq:req];
    [self cancel:nil];
}

- (IBAction)shareToQQ:(id)sender {
    NSURL *url = [NSURL URLWithString:(self.shareUrl)];
    NSString *title = _actTitle;
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"uyoung.bundle/logo" ofType:@"png"];
    NSData *previewData = [NSData dataWithContentsOfFile:imagePath];
    NSString *description =_shareDesc;
    QQApiNewsObject *newsobj = [QQApiNewsObject objectWithURL:url title:title description:description previewImageData:previewData];
    uint64_t cflag = 1;
    [newsobj setCflag:cflag];
    QQApiObject *objc = newsobj;
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:objc];
    //    将内容分享到qq
    //    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    //    将内容分享到qzone
    QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
//    [self handleSendResult:sent];
    [self cancel:nil];
}

- (IBAction)shareToWeibo:(id)sender {
    WBMessageObject *message = [WBMessageObject message];
    NSString *txt = [_actTitle stringByAppendingString:_shareUrl];
    message.text = txt;
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
    request.userInfo = @{@"ShareMessageFrom": @"分享活动",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
    [self cancel:nil];
}

- (IBAction)cancel:(id)sender {
    [_delegate cancelShare];
}
@end
