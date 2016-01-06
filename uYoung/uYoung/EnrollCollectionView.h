//
//  EnrollCollectionView.h
//  uYoung
//
//  Created by CSDN on 15/10/19.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnrollCollectionCell.h"

@protocol EnrollCollectionViewDelegate <NSObject>

@optional
-(void)getEnrollUserId:(NSInteger)userId;

@end

@interface EnrollCollectionView : UICollectionView<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) id<EnrollCollectionViewDelegate> enrollDelegate;
@property (strong, nonatomic) NSMutableArray *enrolls;

@end
