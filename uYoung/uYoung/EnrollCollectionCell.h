//
//  EnrollCollectionCell.h
//  uYoung
//
//  Created by CSDN on 15/10/18.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDetailModel.h"
#import "GlobalConfig.h"

@interface EnrollCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *enrollUserHeader;
@property (weak, nonatomic) IBOutlet UILabel *enrollUserNick;
@property (strong, nonatomic) UserDetailModel *enrollUser;

- (void)updateFrameWithModel:(UserDetailModel*)model;

@end
