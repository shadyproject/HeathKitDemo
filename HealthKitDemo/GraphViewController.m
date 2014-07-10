//
//  SecondViewController.m
//  HealthKitDemo
//
//  Created by Christopher Martin on 7/1/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "GraphViewController.h"

@interface GraphViewController ()

@property (nonatomic, strong) NSArray *colors;

@end

@implementation GraphViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < 12; i++) {
        CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
        CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
        CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
        UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
        [array addObject:color];
    }
    
    self.colors = array;
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [self.collectionView registerClass:[UICollectionViewCell class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:@"HeaderCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UICollectionView stuff
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 360.0;
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    CGSize size = CGSizeMake(width, height);
    
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    
    CGFloat height = 50.0;
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    
    CGSize size = CGSizeMake(width, height);
    
    return size;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    
    cell.backgroundColor = self.colors[indexPath.row];
    switch (indexPath.section) {
        case 0:
            //height
            break;
            
        case 1:
            //weight
            break;
            
        case 2:
            //bac
            break;
            
        case 3:
            //bp
            break;
            
        case 4:
            //nike fuel
            break;
            
        default:
            break;
    }
    return cell;
}

- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView
          viewForSupplementaryElementOfKind:(NSString *)kind
                                atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                         withReuseIdentifier:@"HeaderCell"
                                                                                forIndexPath:indexPath];
    NSString *labelText = nil;
    switch (indexPath.section) {
        case 0:
            //height
            labelText = @"Height";
            break;
            
        case 1:
            //weight
            labelText = @"Weight";
            break;
            
        case 2:
            //bac
            labelText = @"Blood Alcohol Content";
            break;
            
        case 3:
            //bp
            labelText = @"Blood Pressure";
            break;
            
        case 4:
            //nike fuel
            labelText = @"Fuel Points";
            break;
        default:
            labelText = @"Dunno";
            break;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.text = labelText;
    
    UIView *superview = cell.contentView;
    NSDictionary *variables = NSDictionaryOfVariableBindings(label, superview);
    NSArray *constraints = @[[[NSLayoutConstraint constraintsWithVisualFormat:@"V:[superview]-(<=1)-[label]"
                                                                     options: NSLayoutFormatAlignAllCenterX
                                                                     metrics:nil
                                                                       views:variables] firstObject],
                             
                             [[NSLayoutConstraint constraintsWithVisualFormat:@"H:[superview]-(<=1)-[label]"
                                                                     options: NSLayoutFormatAlignAllCenterY
                                                                     metrics:nil
                                                                       views:variables] firstObject]];
    [cell.contentView addSubview:label];
    [cell.contentView addConstraints:constraints];
    
    return cell;
}

#pragma mark UICollectionViewDatasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

@end
