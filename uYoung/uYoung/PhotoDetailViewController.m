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
    
    _scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight)];
    [_scrollview setBackgroundColor:[UIColor clearColor]];
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

- (void)getDownLoadUrl:(NSInteger)atIndex{
    PhotoDetailModel *model = (PhotoDetailModel*)_photoDetails[atIndex];
    //获得下载url
    [PhotoDownload getDownloadUrl:model.id finish:^(NSString *downloadUrl, NSString *exifUrl) {
        if ([NSString isBlankString:downloadUrl]==NO) {
            //图片
//            [PhotoDownload downloadPhoto:downloadUrl delegate:self];
            [self lazyInitImage:downloadUrl];
        }
        if ([NSString isBlankString:exifUrl]) {
            //下载图片
            [PhotoDownload downloadPhotoExif:exifUrl delegate:self];
        }
    }];
}

- (void)lazyInitImage:(NSString*)imageUrl{
    /*if (image!=nil) {
        _imageview=[[UIImageView alloc]initWithImage:image];
        //调用initWithImage:方法，它创建出来的imageview的宽高和图片的宽高一样
        [_scrollview addSubview:_imageview];
        _scrollview.contentSize=image.size;
    }*/
    
    __weak UIImageView *weakImg = _imageview;
    __weak UIScrollView *weakScrl = _scrollview;
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:1000.0];
    [_imageview setImageWithURLRequest:theRequest placeholderImage:[UIImage imageNamed:UserDefaultHeader] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
        [weakImg setImage:image];
        CGSize imgSize = image.size;
        [weakImg setFrame:CGRectMake(0, weakScrl.frame.size.height/2-imgSize.height/2, imgSize.width, imgSize.height)];
        weakScrl.contentSize = image.size;
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
        NSLog(@"=============================");
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
