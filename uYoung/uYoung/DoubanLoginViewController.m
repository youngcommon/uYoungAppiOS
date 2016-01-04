//
//  DoubanLoginViewController.m
//  uYoung
//
//  Created by CSDN on 16/1/4.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import "DoubanLoginViewController.h"
#import "GlobalConfig.h"

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

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) NSURL *requestURL;

@end

@implementation DoubanLoginViewController

@synthesize webView = webView_;
@synthesize requestURL = requestURL_;

- (id)initWithRequestURL:(NSURL *)aURL {
    self = [super init];
    if (self) {
        self.requestURL = aURL;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView houldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSURL *urlObj =  [request URL];
    NSString *url = [urlObj absoluteString];
    
    if ([url hasPrefix:DOUBAN_REDIRECT_URL]) {
        
        NSString* query = [urlObj query];
        NSMutableDictionary *parsedQuery = [query explodeToDictionaryInnerGlue:@"="
                                                                    outterGlue:@"&"];
        
        //access_denied
        NSString *error = [parsedQuery objectForKey:@"error"];
        if (error) {
            return NO;
        }
        
    }
    
    return YES;
}


@end
