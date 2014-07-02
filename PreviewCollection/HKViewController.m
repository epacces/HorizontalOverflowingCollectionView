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

@property (nonatomic, assign) NSUInteger numberOfPages;
@property (nonatomic, assign) CGFloat pageWidth;

@end

@implementation HKViewController

#pragma mark -
#pragma mark - View Controller Lifecycle 

- (void)awakeFromNib {
    [super awakeFromNib];
    self.numberOfPages = 12;
    self.pageWidth = 290.f;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.hiddenScrollView setContentSize:CGSizeMake(self.pageWidth * self.numberOfPages, CGRectGetHeight(self.view.bounds))];
    [self.collectionView.panGestureRecognizer setEnabled:NO];
    [self.collectionView addGestureRecognizer:self.hiddenScrollView.panGestureRecognizer];
}

#pragma mark -
#pragma mark - Collection View Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.numberOfPages;
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

#pragma mark -
#pragma mark - Scroll View Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.hiddenScrollView) {
        CGPoint contentOffset = scrollView.contentOffset;
        contentOffset.x = contentOffset.x - self.collectionView.contentInset.left;
        self.collectionView.contentOffset = contentOffset;
    }
}

#pragma mark -
#pragma mark - Layout hooks 

- (void)viewWillLayoutSubviews {
    [self.hiddenScrollView setContentSize:CGSizeMake(self.pageWidth * self.numberOfPages, CGRectGetHeight(self.view.bounds))];
}

@end
