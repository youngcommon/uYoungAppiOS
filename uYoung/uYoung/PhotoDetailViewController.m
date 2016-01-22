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
#import "UserDetailModel.h"

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
    
    _isLike = NO;
    
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
    _scrollview.minimumZoomScale=1;
    
    [self initIsLike:_index];
    [self getDownLoadUrl:_index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//告诉scrollview要缩放的是哪个子控件
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageview;
}

// 让UIImageView在UIScrollView缩放后居中显示
- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    _imageview.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                            scrollView.contentSize.height * 0.5 + offsetY);
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
        CGRect rect = [PhotoDetailViewController fitToImageView:image size:weakScrl.frame.size];
        [weakImg setImage:image];
        [weakImg setFrame:rect];
        weakScrl.contentSize = image.size;
        [weakV.window showHUDWithText:@"" Type:ShowDismiss Enabled:YES];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
        [weakV.window showHUDWithText:@"下载失败" Type:ShowPhotoNo Enabled:YES];
    }];
}

- (void)downloadExifFinish:(NSDictionary*)dict{
    if (dict!=nil) {
        NSLog(@"###############%@##################", dict);
    }
}

- (void)initIsLike:(NSInteger)atIndex{
    PhotoDetailModel *model = (PhotoDetailModel*)_photoDetails[atIndex];
    UserDetailModel *user = [UserDetailModel currentUser];
    if (user!=nil&&model!=nil) {
        [PhotoDownload photoIsLike:user.id photoId:model.id ops:^(BOOL isLike) {
            _isLike = isLike;
            NSString *likeimg = isLike ? @"uyoung.bundle/had_like" : @"uyoung.bundle/no_like";
            [_likeButton setImage:[UIImage imageNamed:likeimg] forState:UIControlStateNormal];
        }];
    }
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)likeThisPhoto:(UIButton*)sender {
    PhotoDetailModel *model = (PhotoDetailModel*)_photoDetails[_index];
    UserDetailModel *user = [UserDetailModel currentUser];
    if (user!=nil&&model!=nil) {
        [PhotoDownload photoLike:user.id photoId:model.id];
    }
    NSString *likeimg = _isLike ? @"uyoung.bundle/no_like" : @"uyoung.bundle/had_like";
    [sender setImage:[UIImage imageNamed:likeimg] forState:UIControlStateNormal];
    _isLike = !_isLike;
}

- (IBAction)toggleExif:(id)sender {
    [_exifView setHidden:![_exifView isHidden]];
}

+ (CGRect)fitToImageView:(UIImage*)img size:(CGSize)viewsize{
    CGSize imgSize = img.size;
    CGFloat scalex = viewsize.width / imgSize.width;
    CGFloat scaley = viewsize.height / imgSize.height;
    CGFloat scale = MIN(scalex, scaley);
    CGFloat width = imgSize.width * scale;
    CGFloat height = imgSize.height * scale;
    float dwidth = ((viewsize.width - width) / 2.0f);
    float dheight = ((viewsize.height - height) / 2.0f);
    CGRect rect = CGRectMake(dwidth, dheight, imgSize.width * scale, imgSize.height * scale);
    return rect;
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.view.window showHUDWithText:@"" Type:ShowDismiss Enabled:YES];
}

@end
