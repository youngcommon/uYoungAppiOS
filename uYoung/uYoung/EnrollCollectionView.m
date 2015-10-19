//
//  EnrollCollectionView.m
//  uYoung
//
//  Created by CSDN on 15/10/19.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "EnrollCollectionView.h"

@implementation EnrollCollectionView

static NSString * const reuseIdentifier = @"Cell";

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return [_enrolls count];
    return 15;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSArray *subs = [cell.contentView subviews];
    if (subs==nil||[subs count]==0) {//说明第一次初始化
        EnrollCollectionCell *enrollCell = [[[NSBundle mainBundle] loadNibNamed:@"EnrollCollectionCell" owner:self options:nil] lastObject];
//        [enrollCell updateFrameWithModel:_enrolls[indexPath.row]];
        [enrollCell updateFrameWithModel:_enrolls[0]];
        [cell.contentView addSubview:enrollCell];
    }else{
        if ([subs[0] isKindOfClass:[EnrollCollectionCell class]]) {
            EnrollCollectionCell *enrollCell = (EnrollCollectionCell*)subs[0];
//            [enrollCell updateFrameWithModel:_enrolls[indexPath.row]];
            [enrollCell updateFrameWithModel:_enrolls[0]];
        }
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(70, 88);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 5, 5);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
