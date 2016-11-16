//
//  ViewController.m
//  CollectionView
//
//  Created by xiong on 16/11/15.
//  Copyright © 2016年 xiong. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewLayout.h"
@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic)  UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CollectionViewLayout *layout = [[CollectionViewLayout alloc]init];
    
    layout.itemSize = CGSizeMake(250, 250);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.view addSubview:self.collectionView];
        
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"aaaa"];
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"aaaa" forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    
    return cell;
}

@end
