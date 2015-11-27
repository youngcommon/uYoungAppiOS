//
//  ActivityAlbumViewController.h
//  uYoung
//
//  Created by 独自天涯 on 15/11/26.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityAlbumViewController : UIViewController

@property (strong, nonatomic) NSString *actTitleStr;

@property (strong, nonatomic) IBOutlet UILabel *actTitle;

@property (strong, nonatomic) NSArray *actAlbum;
@property (strong, nonatomic) IBOutlet UICollectionView *albums;
- (IBAction)back:(id)sender;

@end
