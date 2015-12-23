//
//  PhotoDetailViewController.m
//  uYoung
//
//  Created by 独自天涯 on 15/12/22.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import "GlobalConfig.h"
#import "NSString+StringUtil.h"

@interface PhotoDetailViewController ()

@end

@implementation PhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _showExif.layer.borderColor = lableTextColor;
    _showExif.layer.borderWidth = 1;
    _showExif.layer.cornerRadius = 4;
    _showExif.layer.masksToBounds = YES;
    
    [_exifView setHidden:YES];
    
    [self getDownLoadUrl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)getDownLoadUrl{
    //过期时间
    NSDate *now = [NSDate date];
    NSDate *tomorrow = [now initWithTimeIntervalSinceNow:(24*60*60)];
    long exp = [tomorrow timeIntervalSince1970];
    //构建下载url
    NSString *secOriUrl = [NSString stringWithFormat:@"%@?e=%ld", _photoUrl, exp];
    NSString *sign = [secOriUrl hmacSha1:QINIU_SK];
    NSString *encodedSign = [QNUrlSafeBase64 encodeString:sign];
    NSString *token = [NSString stringWithFormat:@"%@:%@", QINIU_AK, encodedSign];
    NSString *downloadUrl = [NSString stringWithFormat:@"%@&token=%@", secOriUrl, token];
    //下载图片
    [PhotoDownload downloadPhotoExif:downloadUrl delegate:self];
}

- (void)downloadImageFinish:(UIImage*)image{
    
}

- (void)downloadExifFinish:(NSDictionary*)dict{
    
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)likeThisPhoto:(UIButton*)sender {
    [sender setImage:[UIImage imageNamed:@"uyoung.bundle/had_like"] forState:UIControlStateNormal];
}

- (IBAction)toggleExif:(id)sender {
    [_exifView setHidden:![_exifView isHidden]];
}
@end
