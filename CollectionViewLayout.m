//
//  CollectionViewLayout.m
//  CollectionView
//
//  Created by xiong on 16/11/15.
//  Copyright © 2016年 xiong. All rights reserved.
//

#import "CollectionViewLayout.h"


#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define kItem_Width self.itemSize.width
#define kItem_Height self.itemSize.height

#define visibItems  3 // 屏幕上显示的 item 个数

@implementation CollectionViewLayout

- (void)prepareLayout {
    
    self.collectionView.contentInset = UIEdgeInsetsMake(0, (kSCREEN_WIDTH - kItem_Width) / 2, 0, (kSCREEN_WIDTH - kItem_Width) / 2);
}


- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGFloat index = roundf((proposedContentOffset.x +  (kSCREEN_WIDTH - kItem_Width) / 2) / kItem_Width);
    proposedContentOffset.x = kItem_Width * index - (kSCREEN_WIDTH - kItem_Width) / 2;
    return proposedContentOffset;
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return YES;
}


/**
 返回需要改变 frame 的 item 的数组
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    CGFloat centerX = self.collectionView.contentOffset.x + kSCREEN_WIDTH / 2;
    NSInteger index = centerX / kItem_Width;
    NSInteger count = (visibItems - 1) / 2; // 算出除了屏幕中间的 item, 每边的个数
    NSInteger minIndex = MAX(0, (index - count)); // 最左边的 item
    NSInteger maxIndex = MIN((cellCount - 1), (index + count)); // 最右边的 item
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = minIndex; i <= maxIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [array addObject:attributes];
    }
    return array; // 需要改变 frame 的 items
}


/**
 改变后的LayoutAttributes

 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.size = self.itemSize;
    
    CGFloat cX = self.collectionView.contentOffset.x + kSCREEN_WIDTH / 2;
    CGFloat attributesX = kItem_Width * indexPath.row + kItem_Width / 2;
    attributes.zIndex = -ABS(attributesX - cX);
    
    CGFloat delta = cX - attributesX;
    CGFloat ratio =  - delta / (kItem_Width * 2);
    CGFloat scale = 1 - ABS(delta) / (kItem_Width * 6.0) * cos(ratio * M_PI_4);

    attributes.transform = CGAffineTransformMakeScale(scale, scale);
    
    CGFloat centerX = attributesX;
    
    attributes.center = CGPointMake(centerX, CGRectGetHeight(self.collectionView.frame) / 2);
    
    
    return attributes;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake([self.collectionView numberOfItemsInSection:0] * kItem_Width, kSCREEN_HEIGHT);
}
@end
