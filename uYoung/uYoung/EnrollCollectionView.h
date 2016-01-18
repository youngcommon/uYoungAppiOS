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

@interface EnrollCollectionView : UICollectionView<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIActionSheetDelegate>

@property (weak, nonatomic) id<EnrollCollectionViewDelegate> enrollDelegate;
@property (strong, nonatomic) NSMutableArray *enrolls;
@property (assign, nonatomic) long selUid;
@property (assign, nonatomic) long actId;
@property (assign, nonatomic) BOOL canSignup;

@property (assign, nonatomic) UIActionSheet *sheet;

@end
