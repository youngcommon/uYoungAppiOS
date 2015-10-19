//
//  EnrollCollectionView.h
//  uYoung
//
//  Created by CSDN on 15/10/19.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnrollCollectionCell.h"

@interface EnrollCollectionView : UICollectionView<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSMutableArray *enrolls;

@end
