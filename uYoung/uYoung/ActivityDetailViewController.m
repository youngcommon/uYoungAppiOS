        //
//  ActivityDetailViewController.m
//  uYoung
//
//  Created by CSDN on 15/9/25.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import <UIImageView+AFNetworking.h>

@interface ActivityDetailViewController ()

@end

@implementation ActivityDetailViewController

static NSString * const reuseIdentifier = @"Cell";

@synthesize model;

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.headerBackground.image = [self getScaleUIImage:@"uyoung.bundle/backcover" Height:30];
    
    self.userHeader.layer.cornerRadius = self.userHeader.frame.size.height/2;
    self.userHeader.layer.masksToBounds = YES;
    
    self.titleLable.text = self.model.title;
    self.actType.text = [NSString stringWithFormat:@"%@摄影", self.model.actType];
    
    self.actDate.text = [NSString stringWithFormat:@"%d月%d日", self.model.month, self.model.day];
    self.actTime.text = [NSString stringWithFormat:@"%@-%@", self.model.fromTime, self.model.toTime];
    self.addr.text = self.model.addr;
    if(self.model.price==0){
        [self.freeSignetImg setHidden:YES];
    }
    
    //========================活动地址约束调整=========================
    CGFloat addrTitleWidth = self.addrTitle.frame.size.width;
    CGSize addrTitleLabelSize = [self.addrTitle sizeThatFits:CGSizeMake(addrTitleWidth, MAXFLOAT)];
    [self.addrTitleHeight setConstant:addrTitleLabelSize.height];

    CGFloat addrWidth = mScreenWidth - 22 * 2 - 15 * 2 - 5 - addrTitleWidth;
    CGSize addrLabelSize = [self.addr sizeThatFits:CGSizeMake(addrWidth, MAXFLOAT)];
    [self.addrHeight setConstant:addrLabelSize.height];
    //================================================
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fillActivityDetail:) name:@"fillActivityDetail" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoEnrollDetail:) name:@"gotoEnrollDetail" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:@"loginSuccess" object:nil];
    
    //获取数据
    [ActivityDetail getActivityDetailWithId:self.model.activityId];
    [self initLoginUser];
}

- (void)initLoginUser{
    UYoungUser *loginUser = [UYoungUser currentUser];
    self.loginUser = loginUser;
    if (self.loginUser.id>0) {
        NSString *avaterUrl = self.loginUser.avatarUrl;
        NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:avaterUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        [self.userHeader.imageView setImageWithURLRequest:theRequest placeholderImage:[UIImage imageNamed:UserDefaultHeader] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
            [self.userHeader.imageView setImage:image];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
            UIImage *img = [UIImage imageNamed:UserDefaultHeader];
            [self.userHeader.imageView setImage:img];
        }];
    }
}

- (void)fillActivityDetail:(NSNotification*)notification
{
    NSDictionary *dic = (NSDictionary*)[notification object];
    self.detailModel = [MTLJSONAdapter modelOfClass:[ActivityDetailModel class] fromJSONDictionary:dic error:nil];
    
    self.enrollPersons.text = [NSString stringWithFormat:@"%d / %d", self.detailModel.realNum, self.detailModel.needNum];
    self.organizer.text = self.detailModel.nickName;
    NSString *desc = self.detailModel.desc;
    
    CGRect frame = self.descScrollView.frame;
    //设置活动描述
    UITextView *descView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [descView setText:desc];
    [descView setFont:[UIFont systemFontOfSize:18]];
    descView.scrollEnabled = YES;
    descView.editable = NO;
    [self.descScrollView addSubview:descView];
    
    //设置报名详情
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    EnrollCollectionView *enrollView = [[EnrollCollectionView alloc]initWithFrame:CGRectMake(frame.size.width, 0, frame.size.width, frame.size.height) collectionViewLayout:flowLayout];
    
    UINib * nib = [UINib nibWithNibName:@"EnrollCollectionCell" bundle:nil];
    [enrollView registerNib:nib forCellWithReuseIdentifier:@"Cell"];
    enrollView.delegate = enrollView;
    enrollView.dataSource = enrollView;
    enrollView.enrolls = [NSMutableArray arrayWithObject:self.detailModel];
    [enrollView setBackgroundColor:[UIColor clearColor]];
    [self.descScrollView addSubview:enrollView];
    
    [self.descScrollView setContentSize:CGSizeMake(self.descScrollView.frame.size.width*2, self.descScrollView.frame.size.height)];
    
    [self addPageControlNavigation];
    [_pageControl setHidden:YES];
}

- (void)gotoEnrollDetail:(NSNotification*)notification{
    NSString *userId = (NSString*)[notification object];
    UserCenterController *userCenter = [[UserCenterController alloc] initWithNibName:@"UserCenterController" bundle:[NSBundle mainBundle]];
    userCenter.userId = [userId integerValue];
    [self.navigationController pushViewController:userCenter animated:YES];
}

//添加分页导航,默认第一页被选中
- (void)addPageControlNavigation{
    CGFloat navWidth = 102.;
    CGFloat navHeight = 22.;
    CGFloat navLabelWidth = 48.;

    CGFloat x = (_descScrollView.frame.size.width / 2) - (navWidth / 2);
    CGFloat y = _descScrollView.frame.size.height - navHeight;
    //添加第一页导航
    //添加活动详情导航
    UIImageView *descImageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, navHeight, navHeight)];
    [descImageView setImage:[UIImage imageNamed:@"uyoung.bundle/act_desc_high"]];
    [_descScrollView addSubview:descImageView];
    x = x + navHeight + 5;
    UILabel *descLabel = [[UILabel alloc]initWithFrame:CGRectMake(x, y , navLabelWidth, navHeight)];
    [descLabel setText:@"活动详情"];
    [descLabel setFont:[UIFont systemFontOfSize:12.]];
    [descLabel setTextColor:UIColorFromRGB(0x027AFF)];
    [_descScrollView addSubview:descLabel];
    x = x + navLabelWidth + 5;
    //添加报名详情导航
    UIImageView *enrollImageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, navHeight, navHeight)];
    [enrollImageView setImage:[UIImage imageNamed:@"uyoung.bundle/join"]];
    [_descScrollView addSubview:enrollImageView];
    
    x = (_descScrollView.frame.size.width / 2) - (navWidth / 2) + _descScrollView.frame.size.width;
    //添加第二页导航
    //添加活动详情导航
    UIImageView *descImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, navHeight, navHeight)];
    [descImageView2 setImage:[UIImage imageNamed:@"uyoung.bundle/act_desc"]];
    [_descScrollView addSubview:descImageView2];
    x = x + navHeight + 5;
    //添加报名详情导航
    UIImageView *enrollImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, navHeight, navHeight)];
    [enrollImageView2 setImage:[UIImage imageNamed:@"uyoung.bundle/join_high"]];
    [_descScrollView addSubview:enrollImageView2];
    x = x + navHeight + 5;
    UILabel *enrollLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(x, y, navLabelWidth, navHeight)];
    [enrollLabel2 setText:@"报名详情"];
    [enrollLabel2 setFont:[UIFont systemFontOfSize:12.]];
    [enrollLabel2 setTextColor:UIColorFromRGB(0x027AFF)];
    [_descScrollView addSubview:enrollLabel2];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //更新UIPageControl的当前页
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    [_pageControl setCurrentPage:offset.x / bounds.size.width];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)backView:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)toUserCenter:(UIButton *)sender {

    if (_loginUser&&_loginUser.id>0) {
        UserCenterController *userCenter = [[UserCenterController alloc] initWithNibName:@"UserCenterController" bundle:[NSBundle mainBundle]];
        userCenter.userId = _loginUser.id;
        [self.navigationController pushViewController:userCenter animated:YES];
    }else{
        LoginViewController *loginViewCtl = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
        [self presentViewController:loginViewCtl animated:YES completion:nil];
    }
    
}

- (void)loginSuccess{
    [self initLoginUser];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)getScaleUIImage:(NSString*)name Height:(CGFloat)height{
    UIImage *bubble = [UIImage imageNamed:name];

    CGPoint center = CGPointMake(bubble.size.width / 2.0f, height);
    UIEdgeInsets capInsets = UIEdgeInsetsMake(center.y, 0, center.y+1, 2);
    return [bubble resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
    
}

@end
