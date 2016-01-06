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
    return [_enrolls count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EnrollCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [cell updateFrameWithModel:_enrolls[indexPath.row]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(70, 88);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 5, 5);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger selectedUser = [indexPath row];
    NSInteger uid = ((ActivityDetailEnrollsModel*)_enrolls[selectedUser]).uid;
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"gotoEnrollDetail" object:@(uid)];
    [_enrollDelegate getEnrollUserId:uid];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

/*-(UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    
    NSLog(@"%@", self.delegate);
    if ([self pointInside:point withEvent:event]) {
    }
    else {
        return nil;
    }
    for (UIView *subView in self.subviews) {
        if ([subView hitTest:point withEvent:event]!=nil) {
            return subView;
        }
    }
    
    
    return self;
}*/

@end
