//
//  UserAlbumList.m
//  uYoung
//
//  Created by CSDN on 15/10/22.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "UserAlbumList.h"

@implementation UserAlbumList

+ (void)getUserAlbumListWithUid:(NSInteger)userId{
    
    NSString *url = [uyoung_host stringByAppendingString:@"album/getByUid"];
    
    NSDictionary *parameters = @{@"uid": [NSString stringWithFormat:@"%i", userId]};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *a = (NSArray*)[responseObject objectForKey:@"dataList"];
            if (a) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"userAlbumList" object:a];
            }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
