//
//  JZAlbumViewController.m
//  aoyouHH
//
//  Created by jinzelu on 15/4/27.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "JZAlbumViewController.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "PhotoView.h"
#import "GlobalConfig.h"
#import "PhotoDetailModel.h"
#import "NSString+StringUtil.h"
#import "UserDetailModel.h"
#import "ExifView.h"
#import <MobClick.h>

@interface JZAlbumViewController ()<UIScrollViewDelegate,PhotoViewDelegate>
{
    CGFloat lastScale;
    MBProgressHUD *HUD;
    NSMutableArray *_subViewList;
    
    UIButton *exifButton;
    ExifView *exifView;
    
}

@end

@implementation JZAlbumViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //
        _subViewList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    lastScale = 1.0;
    self.view.backgroundColor = [UIColor blackColor];

    _likeDict = [[NSMutableDictionary alloc]initWithCapacity:0];
    [self initScrollView];
    [self addLabels];
    [self addLikeButton];
    [self addExifInfoView];
    [self setPicCurrentIndex:self.currentIndex];
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 25, 45, 22)];
    [backButton setImage:[UIImage imageNamed:@"uyoung.bundle/back_btn"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)addLikeButton{
    _likeButton = [[UIButton alloc]initWithFrame:CGRectMake(mScreenWidth-70-20, 25, 70, 34)];
    [_likeButton setImage:[UIImage imageNamed:@"uyoung.bundle/no_like"] forState:UIControlStateNormal];//默认都为非选中状态
    [_likeButton addTarget:self action:@selector(likePhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_likeButton];
}

- (void)likePhoto{
    PhotoDetailModel *model = (PhotoDetailModel*)self.imgArr[_currentIndex];
    UserDetailModel *user = [UserDetailModel currentUser];
    if (user!=nil&&model!=nil) {
        [PhotoDownload photoLike:user.id photoId:model.id];
    }
    NSString *key = [NSString stringWithFormat:@"%d", (int)_currentIndex];
    BOOL _isLike = [[_likeDict objectForKey:key]boolValue];
    NSString *likeimg = _isLike ? @"uyoung.bundle/no_like" : @"uyoung.bundle/had_like";
    [_likeButton setImage:[UIImage imageNamed:likeimg] forState:UIControlStateNormal];
    [_likeDict setObject:@(!_isLike) forKey:key];
}

- (void)addExifInfoView{
    UIFont *font = [UIFont systemFontOfSize:14];
    exifButton = [[UIButton alloc]initWithFrame:CGRectMake(10, self.sliderLabel.frame.origin.y, 40, 24)];
    [exifButton.titleLabel setFont:font];
    [exifButton setTitle:@"exif" forState:UIControlStateNormal];
    [exifButton setTitleColor:UIColorFromRGB(0x4A90E2) forState:UIControlStateNormal];
    exifButton.layer.borderColor = lableTextColor;
    exifButton.layer.borderWidth = 1;
    exifButton.layer.cornerRadius = 3;
    exifButton.layer.masksToBounds = YES;
    [exifButton addTarget:self action:@selector(showExif) forControlEvents:UIControlEventTouchUpInside];
    [exifButton setHidden:YES];
    [self.view addSubview:exifButton];
    
    exifView = [[[NSBundle mainBundle]loadNibNamed:@"ExifView" owner:self options:nil]lastObject];
    CGRect newFrame = CGRectMake(exifButton.frame.origin.x, exifButton.frame.origin.y-exifView.frame.size.height, self.view.frame.size.width-exifButton.frame.origin.x*2, exifView.frame.size.height);
//    oriFrame = CGRectMake(exifButton.frame.origin.x, exifButton.frame.origin.y, 0, 0);
    [exifView setFrame:newFrame];
    [exifView setHidden:YES];
    [self.view addSubview:exifView];
    
}

-(void)showExif{
    BOOL state = [exifView isHidden];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.2];
//    [exifView setFrame:frame];
    [UIView commitAnimations];
    [exifView setHidden:!state];
}

-(void)initScrollView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    self.scrollView.contentSize = CGSizeMake(self.imgArr.count*mScreenWidth, mScreenHeight);
    self.scrollView.delegate = self;
    self.scrollView.contentOffset = CGPointMake(0, 0);
    //设置放大缩小的最大，最小倍数
    self.scrollView.minimumZoomScale = 1;
    self.scrollView.maximumZoomScale = 2;
    [self.view addSubview:self.scrollView];
    
    for (int i = 0; i < self.imgArr.count; i++) {
        [_subViewList addObject:[NSNull class]];
    }

}

-(void)addLabels{
    self.sliderLabel = [[UILabel alloc] initWithFrame:CGRectMake((mScreenWidth-60)/2, mScreenHeight-30-20, 60, 30)];
    self.sliderLabel.backgroundColor = [UIColor clearColor];
    self.sliderLabel.textColor = [UIColor whiteColor];
    self.sliderLabel.text = [NSString stringWithFormat:@"%ld / %lu", (long)(self.currentIndex+1), (unsigned long)self.imgArr.count];
    [self.view addSubview:self.sliderLabel];
}

-(void)setPicCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    self.scrollView.contentOffset = CGPointMake(mScreenWidth*currentIndex, 0);
    [self getDownLoadUrl:_currentIndex];
}

-(void)loadPhote:(NSString*)url atIndex:(NSInteger)index{
    if ([NSString isBlankString:url]) {
        return;
    }
    UIImage *defaultImg = nil;
    CGRect frame = CGRectMake(index*_scrollView.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
    PhotoView *photoV = [[PhotoView alloc] initWithFrame:frame withPhotoUrl:url defaultImg:defaultImg];
    photoV.delegate = self;
    [self.scrollView insertSubview:photoV atIndex:0];
    [_subViewList replaceObjectAtIndex:index withObject:photoV];
    
}

#pragma mark - PhotoViewDelegate
-(void)TapHiddenPhotoView{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)OnTapView{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)getDownLoadUrl:(NSInteger)atIndex{
    
    if (atIndex<0||atIndex>=self.imgArr.count) {
        return;
    }
    
    _currentIndex = atIndex;
    
    UserDetailModel *user = [UserDetailModel currentUser];
    PhotoDetailModel *model = (PhotoDetailModel*)self.imgArr[atIndex];
    
    [exifView updateExifInfo:model];
    if (model!=nil&&![NSString isBlankString:model.exifCamera]) {
        [exifButton setHidden:NO];
    }else{
        [exifButton setHidden:YES];
    }
    
    //获得下载url
    [PhotoDownload getDownloadUrl:model.id finish:^(NSString *downloadUrl, NSString *exifUrl) {
        if ([NSString isBlankString:downloadUrl]==NO) {
            //图片
            [self loadPhote:downloadUrl atIndex:atIndex];
        }
    }];
    
    NSString *key = [NSString stringWithFormat:@"%d", (int)atIndex];
    BOOL hasKey = [[_likeDict allKeys]containsObject:key];
    if (hasKey) {
        BOOL _isLike = [[_likeDict objectForKey:key]boolValue];
        NSString *likeimg = _isLike ? @"uyoung.bundle/had_like" : @"uyoung.bundle/no_like";
        [_likeButton setImage:[UIImage imageNamed:likeimg] forState:UIControlStateNormal];
    }else{
        //获取图片是否like
        [PhotoDownload photoIsLike:user.id photoId:model.id ops:^(BOOL isLike) {
            [_likeDict setObject:@(isLike) forKey:[NSString stringWithFormat:@"%d", (int)atIndex]];
            NSString *likeimg = isLike ? @"uyoung.bundle/had_like" : @"uyoung.bundle/no_like";
            [_likeButton setImage:[UIImage imageNamed:likeimg] forState:UIControlStateNormal];
        }];
    }
}

//手势
-(void)pinGes:(UIPinchGestureRecognizer *)sender{
    if ([sender state] == UIGestureRecognizerStateBegan) {
        lastScale = 1.0;
    }
    CGFloat scale = 1.0 - (lastScale -[sender scale]);
    lastScale = [sender scale];
    self.scrollView.contentSize = CGSizeMake(self.imgArr.count*mScreenWidth, mScreenHeight*lastScale);
    NSLog(@"scale:%f   lastScale:%f",scale,lastScale);
    CATransform3D newTransform = CATransform3DScale(sender.view.layer.transform, scale, scale, 1);
    
    sender.view.layer.transform = newTransform;
    if ([sender state] == UIGestureRecognizerStateEnded) {
        //
    }
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [exifView setHidden:YES];
    [exifButton setHidden:YES];
    int i = scrollView.contentOffset.x/mScreenWidth+1;
    [self getDownLoadUrl:i-1];
    self.sliderLabel.text = [NSString stringWithFormat:@"%d/%lu",i,(unsigned long)self.imgArr.count];
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"JZAlbumViewController"];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"JZAlbumViewController"];
}

@end
