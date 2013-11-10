//
//  HKViewController.m
//  PreviewCollection
//
//  Created by hepaKKes on 08/11/13.
//  Copyright (c) 2013 hepaKKes. All rights reserved.
//

#import "HKViewController.h"

@interface HKViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UICollectionViewFlowLayout *layout;
@property (nonatomic, weak) IBOutlet UIScrollView *hiddenScrollView;

@end

@implementation HKViewController {
    NSUInteger _numberOfPages;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    _numberOfPages = 12;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self.collectionView setContentInset:UIEdgeInsetsMake(0, (self.view.frame.size.width-pageSize)/2, 0, (self.view.frame.size.width-pageSize)/2)];
    CGFloat pageSize = 290.f;
    [self.hiddenScrollView setContentSize:CGSizeMake(pageSize * _numberOfPages, 568)];
    [self.collectionView.panGestureRecognizer setEnabled:NO];
    [self.collectionView addGestureRecognizer:self.hiddenScrollView.panGestureRecognizer];
   
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _numberOfPages;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"test" forIndexPath:indexPath];
    UILabel *viewLabel = (UILabel *)[cell viewWithTag:101];
    [viewLabel setText:[NSString stringWithFormat:@"%d-th View", indexPath.row]];
    NSUInteger seed = 1882 * (indexPath.row + 12);
    UIColor *randomColor = [UIColor colorWithRed:((seed*17) % 255)/255.f green:((seed*5) % 255)/255.f blue:((seed*11) % 255)/255.f alpha:1.0f];
    [cell setBackgroundColor:randomColor];
    return cell;
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.hiddenScrollView) {
        CGPoint contentOffset = scrollView.contentOffset;
        contentOffset.x = contentOffset.x - self.collectionView.contentInset.left;
        self.collectionView.contentOffset = contentOffset;
    }
}

@end
