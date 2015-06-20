//
//  ViewController.m
//  TableViewCellDemo
//
//  Created by Mrugrajsinh Vansadia on 20/06/15.
//  Copyright (c) 2015 MV. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CollectionView Delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *aCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if(indexPath.row%2==0){
        aCell.backgroundColor = [UIColor grayColor];
    }else{
        aCell.backgroundColor = [UIColor lightGrayColor];
    }
    
    return aCell;
}

#pragma mark - Animate

-(void)applyRotation:(UIView*)view factor:(NSInteger)factor{
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0 / -500;
    view.layer.anchorPoint = CGPointMake(0.5, 0);
    float angle = sqrtf((factor*factor))*45.0/50.0;
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, -(angle<=45?angle:45.0)* M_PI / 180.0f, 1.0f, 0.0f, 0.0f);
    view.layer.transform = rotationAndPerspectiveTransform;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
        [self animateToIdentity];
}
-(void)animateToIdentity{
    NSArray *aArray = [_collectionView visibleCells];
    for (UICollectionViewCell *cell in aArray) {
        [UIView beginAnimations:@"float" context:NULL];
        [UIView setAnimationDuration:0.25];
        cell.layer.transform = CATransform3DIdentity;
        [UIView commitAnimations];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float result = round((int)round(scrollView.contentOffset.y * 100000) % (int)round(_collectionView.frame.size.height * 100000) ) / 100000;
    
    if (result == 0) {
        [self animateToIdentity];
    }else{
        NSArray *aArray = [_collectionView visibleCells];
        for (UICollectionViewCell *cell in aArray) {
            [UIView beginAnimations:@"float" context:NULL];
            [UIView setAnimationDuration:0.3];
            [self applyRotation:cell factor:result];
            [UIView commitAnimations];
        }
    }
}
@end
