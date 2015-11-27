//
//  ActivityAlbumViewController.m
//  uYoung
//
//  Created by 独自天涯 on 15/11/26.
//  Copyright © 2015年 uYoungCommon. All rights reserved.
//

#import "ActivityAlbumViewController.h"
#import "ActivityAlbumCollectionViewCell.h"

@interface ActivityAlbumViewController ()

@end

@implementation ActivityAlbumViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _albums.backgroundColor = [UIColor clearColor];
    UINib * nib = [UINib nibWithNibName:@"ActivityAlbumCollectionViewCell" bundle:nil];
    [_albums registerNib:nib forCellWithReuseIdentifier:@"Cell"];
    
    [_actTitle setText:[NSString stringWithFormat:@"%@相册", _actTitleStr]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_actAlbum count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ActivityAlbumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell initCellData:_actAlbum[indexPath.row]];
    return cell;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
