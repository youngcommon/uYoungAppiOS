//
//  AddPicCollectionViewCell.m
//  uYoung
//
//  Created by CSDN on 15/12/9.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "AddPicCollectionViewCell.h"

@implementation AddPicCollectionViewCell

- (void)awakeFromNib {
    self.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.layer.borderWidth = 1.5;
    
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
}

@end
