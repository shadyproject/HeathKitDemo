//
//  SecondViewController.m
//  HealthKitDemo
//
//  Created by Christopher Martin on 7/1/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "GraphViewController.h"
#import "TextDisplayCell.h"
#import "AppDelegate.h"

@import HealthKit;

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
    
    [self.collectionView registerClass:[TextDisplayCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [self.collectionView registerClass:[TextDisplayCell class]
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
    
    cell.backgroundColor = [UIColor lightGrayColor];
    switch (indexPath.section) {
        case 0:
            //height
            [self configureHeightCell:cell forRow:indexPath.row];
            break;
            
        case 1:
            //weight
            [self configureWeightCell:cell forRow:indexPath.row];
            break;
            
        case 2:
            //bac
            [self configureBacCell:cell forRow:indexPath.row];
            break;
            
        case 3:
            //bp
            [self configureBpCell:cell forRow:indexPath.row];
            break;
            
        case 4:
            //nike fuel
            [self configureFuelCell:cell forRow:indexPath.row];
            break;
            
        default:
            break;
    }
    return cell;
}

- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView
          viewForSupplementaryElementOfKind:(NSString *)kind
                                atIndexPath:(NSIndexPath *)indexPath {
    
    TextDisplayCell *cell = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                         withReuseIdentifier:@"HeaderCell"
                                                                                forIndexPath:indexPath];
    cell.backgroundColor = [UIColor darkGrayColor];
    
    switch (indexPath.section) {
        case 0:
            //height
            [cell setLabelText:@"Height"];
            break;
            
        case 1:
            //weight
            [cell setLabelText:@"Weight"];
            break;
            
        case 2:
            //bac
            [cell setLabelText:@"Blood Alcohol Content"];
            break;
            
        case 3:
            //bp
            [cell setLabelText:@"Blood Pressure"];
            break;
            
        case 4:
            //nike fuel
            [cell setLabelText:@"Fuel Points"];
            break;
        default:
            [cell setLabelText:@"Dunno"];
            break;
    }
    
    return cell;
}

#pragma mark UICollectionViewDatasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

#pragma mark HealthKit Queries
- (void)configureHeightCell:(TextDisplayCell*)cell forRow:(NSInteger)row {
    
    if (row == 0) {
        //show the most recent version
        [self fetchMostRecentDataOfQuantityType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight]
                                 withCompletion:^(HKQuantity *mostRecentQuantity, NSError *error) {
            if (error) {
                [cell setLabelText:[error localizedDescription]];
            } else {
                [cell setLabelText:[NSString stringWithFormat:@"Most Recent Weight: %@", mostRecentQuantity]];
            }
        }];
    } else if (row == 1) {
        //show a graph of all the values
    }
}

- (void)configureWeightCell:(TextDisplayCell*)cell forRow:(NSInteger)row {
     if (row == 0) {
        //show the most recent version
         [self fetchMostRecentDataOfQuantityType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight]
                                  withCompletion:^(HKQuantity *mostRecentQuantity, NSError *error) {
             if (error) {
                 [cell setLabelText:[error localizedDescription]];
             } else {
                 [cell setLabelText:[NSString stringWithFormat:@"Most Recent Height: %@", mostRecentQuantity]];
             }
             }];
    } else if (row == 1) {
        //show a graph of all the values
    }
}

- (void)configureBacCell:(TextDisplayCell*)cell forRow:(NSInteger)row {
        if (row == 0) {
            //show the most recent version
            [self fetchMostRecentDataOfQuantityType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodAlcoholContent]
                                     withCompletion:^(HKQuantity *mostRecentQuantity, NSError *error) {
                if (error) {
                    [cell setLabelText:[error localizedDescription]];
                } else {
                    [cell setLabelText:[NSString stringWithFormat:@"Most Recent Blood Alcohol Content: %@", mostRecentQuantity]];
                }
            }];
    } else if (row == 1) {
        //show a graph of all the values
        HKStatisticsQuery *averageBac
    }
}
- (void)configureBpCell:(TextDisplayCell*)cell forRow:(NSInteger)row {
        if (row == 0) {
        //show the most recent version
            [self fetchMostRecentDataOfQuantityType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureSystolic]
                                     withCompletion:^(HKQuantity *mostRecentQuantity, NSError *error) {
                                         if (error) {
                                             [cell setLabelText:[error localizedDescription]];
                                         } else {
                                             [cell setLabelText:[NSString stringWithFormat:@"Most Recent Systolic: %@", mostRecentQuantity]];
                                         }
                                     }];
    } else if (row == 1) {
        //show a graph of all the values
    }
}
- (void)configureFuelCell:(TextDisplayCell*)cell forRow:(NSInteger)row {
        if (row == 0) {
        //show the most recent version
             [self fetchMostRecentDataOfQuantityType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierNikeFuel]
                                     withCompletion:^(HKQuantity *mostRecentQuantity, NSError *error) {
                                         if (error) {
                                             [cell setLabelText:[error localizedDescription]];
                                         } else {
                                             [cell setLabelText:[NSString stringWithFormat:@"Most Recent Systolic: %@", mostRecentQuantity]];
                                         }
                                     }];       
    } else if (row == 1) {
        //show a graph of all the values
    }
}

// Get the single most recent quantity sample from health store.
- (void)fetchMostRecentDataOfQuantityType:(HKQuantityType *)quantityType withCompletion:(void (^)(HKQuantity *mostRecentQuantity, NSError *error))completion {
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    
    // Since we are interested in retrieving the user's latest sample, we sort the samples in descending order, and set the limit to 1. We are not filtering the data, and so the predicate is set to nil.
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:quantityType predicate:nil limit:1 sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
        if (completion && error) {
            completion(nil, error);
            return;
        }
        
        // If quantity isn't in the database, return nil in the completion block.
        HKQuantitySample *quantitySample = results.firstObject;
        HKQuantity *quantity = quantitySample.quantity;
        
        if (completion) completion(quantity, error);
    }];
    
    [[AppDelegate healthStore] executeQuery:query];
}

- (void)fetchAverageOfDataForQuantityType:(HKQuantityType*)quantityType withCompletion:(void (^)(HKStatisticsQuery *query, HKStatistics *result, NSError *error))completion {
    NSDate *now = [NSDate date];
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:[now dateByAddingTimeInterval:-30] endDate:now options:HKQueryOptionNone];
    HKStatisticsQuery *query = [[HKStatisticsQuery alloc] initWithQuantityType:quantityType quantitySamplePredicate:predicate options:HKStatisticsOptionDiscreteAverage completionHandler:completion];
    [[AppDelegate healthStore] executeQuery:query];
}

- (void)fetchSumOfDataForQuantityType:(HKQuantityType*)quantityType withCompletion:(void (^)(HKStatisticsQuery *query, HKStatistics *results, NSError *error))completion {
    NSDate *now = [NSDate date];
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:[now dateByAddingTimeInterval:-30] endDate:now options:HKQueryOptionNone];
    HKStatisticsQuery *query = [[HKStatisticsQuery alloc] initWithQuantityType:quantityType quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum completionHandler:completion];
    
    [[AppDelegate healthStore] executeQuery:query];
}
@end
