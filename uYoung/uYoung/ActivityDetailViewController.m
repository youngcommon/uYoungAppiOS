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
    if(self.model.price==1){
        [self.freeSignetImg setHidden:YES];
    }
    
    CGFloat x = 20;
    CGFloat y = 30;
    //根据屏幕宽度，增加label字号，6增一，plus增二
    NSString *fontName = [self.actDate.font fontName];
    UIFont *font;

    CGFloat fontSize;
    if (mScreenWidth==375) {//iPhone 6
        font = [UIFont fontWithName:fontName size:14];
        fontSize = 14.f;
    }else if(mScreenWidth>375){//iPhone 6+
        font = [UIFont fontWithName:fontName size:16];
        fontSize = 16.f;
    }else{
        font = [UIFont fontWithName:fontName size:11];
        fontSize = 11.f;
    }
        
    CGSize actDateTitleSize = [@"活动日期:" sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(mScreenWidth/2, MAXFLOAT) lineBreakMode:NSLineBreakByClipping];
    _actDateTitle = [[UILabel alloc]initWithFrame:CGRectMake(x, y, actDateTitleSize.width, actDateTitleSize.height)];
    [_actDateTitle setText:@"活动日期:"];
    [_actDateTitle setFont:font];
    [_actDateTitle setTextColor:UIColorFromRGB(0x4a90e2)];
    [_actDateTitle setLineBreakMode:NSLineBreakByClipping];
    [_contentView addSubview:_actDateTitle];
    
    CGFloat width = actDateTitleSize.width + 5;
        
    x = x + actDateTitleSize.width + 5;
    NSString *actDateStr = [NSString stringWithFormat:@"%d月%d日", (int)self.model.month, (int)self.model.day];
    CGSize actDateSize = [actDateStr sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByClipping];
    _actDate = [[UILabel alloc]initWithFrame:CGRectMake(x, y, actDateSize.width, actDateSize.height)];
    [_actDate setText:actDateStr];
    [_actDate setFont:font];
    [_actDate setTextColor:UIColorFromRGB(0x85b200)];
    [_actDate setLineBreakMode:NSLineBreakByClipping];
    [_contentView addSubview:_actDate];
        
    x = x + actDateSize.width + 10;
    _actTimeTitle = [[UILabel alloc]initWithFrame:CGRectMake(x, y, actDateTitleSize.width, actDateTitleSize.height)];
    [_actTimeTitle setText:@"活动时长:"];
    [_actTimeTitle setFont:font];
    [_actTimeTitle setTextColor:UIColorFromRGB(0x4a90e2)];
    [_actTimeTitle setLineBreakMode:NSLineBreakByClipping];
    [_contentView addSubview:_actTimeTitle];
    
    CGFloat actTimeSizeLeft = mScreenWidth - 22*2 - 15*2 - actDateTitleSize.width - 5 - (actDateSize.width*2) - 10;
    x = x + actDateTitleSize.width + 5;
    NSString *actTimeStr = [NSString stringWithFormat:@"%@-%@", self.model.fromTime, self.model.toTime];
    CGSize actTimeSize = [actTimeStr sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(actTimeSizeLeft, MAXFLOAT) lineBreakMode:NSLineBreakByClipping];
    _actTime = [[UILabel alloc]initWithFrame:CGRectMake(x, y, actTimeSize.width, actTimeSize.height)];
    [_actTime setText:actTimeStr];
    [_actTime setFont:font];
    [_actTime setTextColor:UIColorFromRGB(0x85b200)];
    [_actTime setLineBreakMode:NSLineBreakByClipping];
    [_contentView addSubview:_actTime];
        
    //第二行标签
    y = y + actDateTitleSize.height + 10;
    x = 20;
    _actTypeTitle = [[UILabel alloc]initWithFrame:CGRectMake(x, y, actDateTitleSize.width, actDateTitleSize.height)];
    [_actTypeTitle setText:@"活动类型:"];
    [_actTypeTitle setFont:font];
    [_actTypeTitle setTextColor:UIColorFromRGB(0x4a90e2)];
    [_actTypeTitle setLineBreakMode:NSLineBreakByClipping];
    [_contentView addSubview:_actTypeTitle];
        
    x = x + actDateTitleSize.width + 5;
    NSString *actTypeStr = [NSString stringWithFormat:@"%@摄影", self.model.actType];
    CGSize actTypeSize = [actTypeStr sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByClipping];
    _actType = [[UILabel alloc]initWithFrame:CGRectMake(x, y, actTypeSize.width, actTypeSize.height)];
    [_actType setText:actTypeStr];
    [_actType setFont:font];
    [_actType setTextColor:UIColorFromRGB(0x85b200)];
    [_actType setLineBreakMode:NSLineBreakByClipping];
    [_contentView addSubview:_actType];
        
    x = _actTimeTitle.frame.origin.x;
    _enrollPersonsTitle = [[UILabel alloc]initWithFrame:CGRectMake(x, y, actDateTitleSize.width, actDateTitleSize.height)];
    [_enrollPersonsTitle setText:@"参与人数:"];
    [_enrollPersonsTitle setFont:font];
    [_enrollPersonsTitle setTextColor:UIColorFromRGB(0x4a90e2)];
    [_enrollPersonsTitle setLineBreakMode:NSLineBreakByClipping];
    [_contentView addSubview:_enrollPersonsTitle];
    
    x = x + actDateTitleSize.width + 5;
    _enrollPersons = [[UILabel alloc]initWithFrame:CGRectMake(x, y, actTimeSize.width, actTimeSize.height)];
    [_enrollPersons setText:@"-- / --"];
    [_enrollPersons setFont:font];
    [_enrollPersons setTextColor:UIColorFromRGB(0x85b200)];
    [_enrollPersons setLineBreakMode:NSLineBreakByClipping];
    [_contentView addSubview:_enrollPersons];
    
    //第三行标签
    x = 20;
    y = y + actDateTitleSize.height + 10;
    _organizerTitle = [[UILabel alloc]initWithFrame:CGRectMake(x, y, actDateTitleSize.width, actDateTitleSize.height)];
    [_organizerTitle setText:@"组织者:"];
    [_organizerTitle setFont:font];
    [_organizerTitle setTextColor:UIColorFromRGB(0x4a90e2)];
    [_organizerTitle setLineBreakMode:NSLineBreakByClipping];
    [_contentView addSubview:_organizerTitle];
        
    width = mScreenWidth - 22*2 - 15*2 - 5 - actDateTitleSize.width;
    x = _actType.frame.origin.x;
    NSString *orgStr = @"abcabcabcabcabcabc";
    CGSize orgStrSize = [orgStr sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByClipping];
    _organizer = [[UILabel alloc]initWithFrame:CGRectMake(x, y, orgStrSize.width, orgStrSize.height)];
    [_organizer setText:orgStr];
    [_organizer setFont:font];
    [_organizer setTextColor:UIColorFromRGB(0x85b200)];
    [_organizer setLineBreakMode:NSLineBreakByClipping];
    [_contentView addSubview:_organizer];
        
    //第四行标签
    x = 20;
    y = y + actDateTitleSize.height + 10;
    _addrTitle = [[UILabel alloc]initWithFrame:CGRectMake(x, y, actDateTitleSize.width, actDateTitleSize.height)];
    [_addrTitle setText:@"活动地点:"];
    [_addrTitle setFont:font];
    [_addrTitle setTextColor:UIColorFromRGB(0x4a90e2)];
    [_addrTitle setLineBreakMode:NSLineBreakByClipping];
    [_contentView addSubview:_addrTitle];
        
    x = _organizer.frame.origin.x;
    NSString *addrStr = self.model.addr;
    CGSize addrStrSize = [addrStr sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByClipping];
    _addr = [[UILabel alloc]initWithFrame:CGRectMake(x, y, addrStrSize.width, addrStrSize.height)];
    [_addr setText:addrStr];
    [_addr setFont:font];
    [_addr setTextColor:UIColorFromRGB(0x85b200)];
    [_addr setLineBreakMode:NSLineBreakByClipping];
    [_addr setNumberOfLines:0];
    [_contentView addSubview:_addr];
    [_sepLineCons setConstant:(y+_addr.frame.size.height+15)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fillActivityDetail:) name:@"fillActivityDetail" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoEnrollDetail:) name:@"gotoEnrollDetail" object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:@"loginSuccess" object:nil];
    
    //获取数据
    [ActivityDetail getActivityDetailWithId:self.model.activityId];
//    [self initUserAvater];
}

- (void)viewDidAppear:(BOOL)animated{
    [self initUserAvater];
}

- (void)initUserAvater{
    UserDetailModel *loginUser = [UserDetailModel currentUser];
    self.loginUser = [loginUser copy];
    if ([NSString isBlankString:self.loginUser.avatarUrl]==NO) {
        NSString *avaterUrl = self.loginUser.avatarUrl;
        NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:avaterUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        [self.userHeader.imageView setImageWithURLRequest:theRequest placeholderImage:[UIImage imageNamed:UserDefaultHeader] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
            [self.userHeader.imageView setImage:image];
            [_userHeader setBackgroundImage:image forState:UIControlStateNormal];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
            UIImage *img = [UIImage imageNamed:UserDefaultHeader];
            [_userHeader setBackgroundImage:img forState:UIControlStateNormal];
        }];
    }
}

- (void)fillActivityDetail:(NSNotification*)notification
{
    NSDictionary *dic = (NSDictionary*)[notification object];
    self.detailModel = [MTLJSONAdapter modelOfClass:[ActivityDetailModel class] fromJSONDictionary:dic error:nil];
    
    self.enrollPersons.text = [NSString stringWithFormat:@"%d / %d", (int)self.detailModel.realNum, (int)self.detailModel.needNum];
    self.organizer.text = self.detailModel.nickName;
    NSString *desc = self.detailModel.desc;
    
    CGRect frame = self.descScrollView.frame;
    //设置活动描述
    UIWebView *descView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//    [descView setText:desc];
//    [descView setFont:[UIFont systemFontOfSize:18]];
//    descView.scrollEnabled = YES;
//    descView.editable = NO;
    descView.backgroundColor = [UIColor whiteColor];
    NSString *jsString = [NSString stringWithFormat:@"<html>\n<head>\n<style type=\"text/css\">\nbody{font-family: \"%@\";}\n</style>\n</head>\n<body>%@</body>\n</html>", @"Helvetica", desc];
    [descView loadHTMLString:jsString baseURL:nil];
    [self.descScrollView addSubview:descView];
    
    //设置报名详情
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    EnrollCollectionView *enrollView = [[EnrollCollectionView alloc]initWithFrame:CGRectMake(frame.size.width, 0, frame.size.width, frame.size.height) collectionViewLayout:flowLayout];
    
    UINib * nib = [UINib nibWithNibName:@"EnrollCollectionCell" bundle:nil];
    [enrollView registerNib:nib forCellWithReuseIdentifier:@"Cell"];
    enrollView.delegate = enrollView;
    enrollView.dataSource = enrollView;
    enrollView.enrolls = [self.detailModel.enrolls copy];
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
    
    UserCenterController *userCenter = [[UserCenterController alloc] initWithNibName:@"UserCenterController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:userCenter animated:YES];
    
}

/*- (void)loginSuccess{
    [self initUserAvater];
    [self dismissViewControllerAnimated:YES completion:nil];
}*/

- (UIImage *)getScaleUIImage:(NSString*)name Height:(CGFloat)height{
    UIImage *bubble = [UIImage imageNamed:name];
    CGPoint center = CGPointMake(bubble.size.width / 2.0f, height);
    UIEdgeInsets capInsets = UIEdgeInsetsMake(center.y, 0, center.y+1, 2);
    return [bubble resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
}

@end
