//
//  DoubanLoginViewController.m
//  uYoung
//
//  Created by CSDN on 16/1/4.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import "DoubanLoginViewController.h"
#import "GlobalConfig.h"
#import <AFNetworking.h>
#import "AppDelegate.h"

@interface NSString (ParseCategory)
- (NSMutableDictionary *)explodeToDictionaryInnerGlue:(NSString *)innerGlue
                                           outterGlue:(NSString *)outterGlue;
@end

@implementation NSString (ParseCategory)

- (NSMutableDictionary *)explodeToDictionaryInnerGlue:(NSString *)innerGlue
                                           outterGlue:(NSString *)outterGlue {
    // Explode based on outter glue
    NSArray *firstExplode = [self componentsSeparatedByString:outterGlue];
    NSArray *secondExplode;
    
    // Explode based on inner glue
    NSInteger count = [firstExplode count];
    NSMutableDictionary* returnDictionary = [NSMutableDictionary dictionaryWithCapacity:count];
    for (NSInteger i = 0; i < count; i++) {
        secondExplode =
        [(NSString*)[firstExplode objectAtIndex:i] componentsSeparatedByString:innerGlue];
        if ([secondExplode count] == 2) {
            [returnDictionary setObject:[secondExplode objectAtIndex:1]
                                 forKey:[secondExplode objectAtIndex:0]];
        }
    }
    return returnDictionary;
}

@end

@interface DoubanLoginViewController ()

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSURL *requestURL;
@property (nonatomic, strong) NSString *expire;

@end

@implementation DoubanLoginViewController


- (id)initWithRequestURL:(NSURL *)aURL {
    self = [super init];
    if (self) {
        self.requestURL = aURL;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat topHeight = 70;
    
    UIImageView *backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"uyoung.bundle/background"]];
    [backImage setFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight)];
    [self.view addSubview:backImage];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, topHeight)];
    topView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topView];
    
    UIButton *close = [[UIButton alloc]initWithFrame:CGRectMake(10, (topView.frame.size.height-30)/2, 46, 30)];
    [close setTitle:@"关闭" forState:UIControlStateNormal];
    close.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    close.titleLabel.textColor = [UIColor whiteColor];
    [close addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:close];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, topHeight, self.view.bounds.size.width, self.view.bounds.size.height - topHeight)];
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:self.requestURL];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}

-(void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *url = request.URL.absoluteString;
    NSString *accessTokenUrl = [NSString stringWithFormat:@"%@#access_token=", DOUBAN_REDIRECT_URL];
    NSRange range = [url rangeOfString:accessTokenUrl];//授权成功
    if(range.length){
        NSString *accessToken = [url substringFromIndex:range.location+range.length];
        NSString *expires = @"&expires_in";
        NSRange exRange = [accessToken rangeOfString:expires];
        NSString *token = accessToken;
        if (exRange.length) {
            token = [accessToken substringToIndex:exRange.location];
        }
        [self getUserInfoWithToken:token];
        return NO;
    }
    NSString *errorUrl = [NSString stringWithFormat:@"%@?error=", DOUBAN_REDIRECT_URL];
    range = [url rangeOfString:errorUrl];//授权失败
    if (range.length) {
//        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
        return NO;
    }
    range = [url rangeOfString:DOUBAN_REGISTER_URL];//注册
    if (range.length) {
        [[UIApplication sharedApplication]openURL:request.URL];
        return NO;
    }
    range = [url rangeOfString:DOUBAN_TERMS_URL];//条款
    if (range.length) {
        [[UIApplication sharedApplication]openURL:request.URL];
        return NO;
    }
    return YES;
}

-(void)getUserInfoWithToken:(NSString*)token{
    __weak DoubanLoginViewController *weakself = self;
    
    NSString *url = @"https://api.douban.com/v2/user/~me";
    NSString *auth = [NSString stringWithFormat:@" Bearer %@", token];
        
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    [manager.requestSerializer setValue:auth forHTTPHeaderField:@"Authorization"];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        AppDelegate *delegate = ((AppDelegate *)[[UIApplication sharedApplication] delegate]);
        [delegate doubanSuccessLogin:responseObject withToken:token];
        [weakself dismissViewControllerAnimated:YES completion:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}


@end
