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
#import "PhotoDetailModel.h"
#import "UIImage+scales.h"
#import "UIWindow+YoungHUD.h"

@interface PhotoDetailViewController ()<UIScrollViewDelegate>{
    UIScrollView *_scrollview;
    UIImageView *_imageview;
}
@end

@implementation PhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _showExif.layer.borderColor = lableTextColor;
    _showExif.layer.borderWidth = 1;
    _showExif.layer.cornerRadius = 4;
    _showExif.layer.masksToBounds = YES;
    
    [_exifView setHidden:YES];
    
    _scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, -40, mScreenWidth, mScreenHeight+40)];
    [_scrollview setBackgroundColor:[UIColor clearColor]];
    _scrollview.showsHorizontalScrollIndicator = NO;
    _scrollview.showsVerticalScrollIndicator = NO;
    [self.view insertSubview:_scrollview atIndex:0];
    
    _imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_scrollview addSubview:_imageview];
    
    //设置实现缩放
    //设置代理scrollview的代理对象
    _scrollview.delegate=self;
    //设置最大伸缩比例
    _scrollview.maximumZoomScale=2.0;
    //设置最小伸缩比例
    _scrollview.minimumZoomScale=0.5;
    
    [self getDownLoadUrl:_index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//告诉scrollview要缩放的是哪个子控件
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageview;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    NSLog(@"##%f==%f==%f==%f##", _imageview.frame.origin.x, _imageview.frame.origin.y, _imageview.frame.size.width, _imageview.frame.size.height);
    NSLog(@"##%f==%f==%f==%f##", _scrollview.frame.origin.x, _scrollview.frame.origin.y, _scrollview.frame.size.width, _scrollview.frame.size.height);
    
    NSLog(@"##%f==%f==%f==%f##", scrollView.frame.origin.x, scrollView.frame.origin.y, scrollView.frame.size.width, scrollView.frame.size.height);
    NSLog(@"##%f==%f==%f==%f##", view.frame.origin.x, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
}

- (void)getDownLoadUrl:(NSInteger)atIndex{
    PhotoDetailModel *model = (PhotoDetailModel*)_photoDetails[atIndex];
    //获得下载url
    [PhotoDownload getDownloadUrl:model.id finish:^(NSString *downloadUrl, NSString *exifUrl) {
        if ([NSString isBlankString:downloadUrl]==NO) {
            //图片
            [self lazyInitImage:downloadUrl];
        }
        if ([NSString isBlankString:exifUrl]) {
            //下载图片
            [PhotoDownload downloadPhotoExif:exifUrl delegate:self];
        }
    }];
}

- (void)lazyInitImage:(NSString*)imageUrl{
    [self.view.window showHUDWithText:@"正在下载图片" Type:ShowLoading Enabled:YES];
    __weak UIView *weakV = self.view;
    __weak UIImageView *weakImg = _imageview;
    __weak UIScrollView *weakScrl = _scrollview;
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:1000.0];
    [_imageview setImageWithURLRequest:theRequest placeholderImage:[UIImage imageNamed:UserDefaultHeader] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
        image = [image scaleToSize:weakScrl.frame.size];
        [weakImg setImage:image];
        CGSize imgSize = image.size;
        [weakImg setFrame:CGRectMake(0, weakScrl.frame.size.height/2-imgSize.height/2, imgSize.width, imgSize.height)];
        weakScrl.contentSize = image.size;
        [weakV.window showHUDWithText:@"" Type:ShowDismiss Enabled:YES];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
        NSLog(@"=============================");
        [weakV.window showHUDWithText:@"" Type:ShowDismiss Enabled:YES];
    }];
}

- (void)downloadExifFinish:(NSDictionary*)dict{
    if (dict!=nil) {
        NSLog(@"###############%@##################", dict);
    }
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
