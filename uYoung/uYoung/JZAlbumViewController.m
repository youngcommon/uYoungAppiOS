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

@interface JZAlbumViewController ()<UIScrollViewDelegate,PhotoViewDelegate>
{
    CGFloat lastScale;
    MBProgressHUD *HUD;
    NSMutableArray *_subViewList;
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
    [self setPicCurrentIndex:self.currentIndex];
    [self addLikeButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addLikeButton{
    _likeButton = [[UIButton alloc]initWithFrame:CGRectMake(mScreenWidth-70-20, mScreenHeight-40-34-20, 70, 34)];
    [_likeButton setImage:[UIImage imageNamed:@"uyoung.bundle/no_like"] forState:UIControlStateNormal];//默认都为非选中状态
    [_likeButton addTarget:self action:@selector(likePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_likeButton];
}

- (void)likePhoto:(NSInteger)atIndex{
    PhotoDetailModel *model = (PhotoDetailModel*)self.imgArr[atIndex];
    UserDetailModel *user = [UserDetailModel currentUser];
    if (user!=nil&&model!=nil) {
        [PhotoDownload photoLike:user.id photoId:model.id];
    }
//    NSString *likeimg = _isLike ? @"uyoung.bundle/no_like" : @"uyoung.bundle/had_like";
//    [sender setImage:[UIImage imageNamed:likeimg] forState:UIControlStateNormal];
//    _isLike = !_isLike;
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
    self.sliderLabel = [[UILabel alloc] initWithFrame:CGRectMake((mScreenWidth-60)/2, mScreenHeight-30-60, 60, 30)];
    self.sliderLabel.backgroundColor = [UIColor clearColor];
    self.sliderLabel.textColor = [UIColor whiteColor];
    self.sliderLabel.text = [NSString stringWithFormat:@"%ld / %lu", (long)(self.currentIndex+1), (unsigned long)self.imgArr.count];
    [self.view addSubview:self.sliderLabel];
}

-(void)setPicCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    self.scrollView.contentOffset = CGPointMake(mScreenWidth*currentIndex, 0);
    [self getDownLoadUrl:_currentIndex];
    [self getDownLoadUrl:_currentIndex+1];
    [self getDownLoadUrl:_currentIndex-1];
}

-(void)loadPhote:(NSString*)url atIndex:(NSInteger)index{
    if ([NSString isBlankString:url]) {
        return;
    }
    CGRect frame = CGRectMake(index*_scrollView.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
    PhotoView *photoV = [[PhotoView alloc] initWithFrame:frame withPhotoUrl:url];
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
    
    UserDetailModel *user = [UserDetailModel currentUser];
    PhotoDetailModel *model = (PhotoDetailModel*)self.imgArr[atIndex];
    //获得下载url
    [PhotoDownload getDownloadUrl:model.id finish:^(NSString *downloadUrl, NSString *exifUrl) {
        if ([NSString isBlankString:downloadUrl]==NO) {
            //图片
            [self loadPhote:downloadUrl atIndex:atIndex];
        }
        if ([NSString isBlankString:exifUrl]) {
            //下载图片
//            [PhotoDownload downloadPhotoExif:exifUrl delegate:self];
        }
    }];
    
    //获取图片是否like
    [PhotoDownload photoIsLike:user.id photoId:model.id ops:^(BOOL isLike) {
        [_likeDict setObject:@(isLike) forKey:[NSString stringWithFormat:@"%d", (int)atIndex]];
    }];
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
    NSLog(@"scrollViewDidEndDecelerating");
    int i = scrollView.contentOffset.x/mScreenWidth+1;
    [self getDownLoadUrl:i-1];
    self.sliderLabel.text = [NSString stringWithFormat:@"%d/%lu",i,(unsigned long)self.imgArr.count];
}


@end
