//
//  AddABunchOfDataViewController.m
//  HealthKitDemo
//
//  Created by Christopher Martin on 7/10/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

@import HealthKit;

#import "AddABunchOfDataViewController.h"
#import "AppDelegate.h"

@interface AddABunchOfDataViewController ()

@end

@implementation AddABunchOfDataViewController
- (IBAction)addABunchOfData:(UIButton *)sender {
    //add about a months worth of data
    NSDate *now = [NSDate date];
    for (int i = 0; i < 30; i++ ) {
        NSDate *dataDate = [now dateByAddingTimeInterval:-(i)];
        [self addHeightDataForDate:dataDate];
        [self addWeightDataForDate:dataDate];
        [self addBacDataForDate:dataDate];
        [self addBloodPressureForDate:dataDate];
        [self addNikeFuelForDate:dataDate];
    }
}

- (void)addHeightDataForDate:(NSDate*)date {
    CGFloat height = (CGFloat)arc4random_uniform(69);
    HKUnit *inchUnit = [HKUnit inchUnit];
    HKQuantity *heightQuantity = [HKQuantity quantityWithUnit:inchUnit doubleValue:height];
    
    HKQuantityType *heightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    
    HKQuantitySample *heightSample = [HKQuantitySample quantitySampleWithType:heightType quantity:heightQuantity startDate:date endDate:date];
    
    [[AppDelegate healthStore] saveObject:heightSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"Could not save height into health store: %@", error);
        }
    }];
}

- (void)addWeightDataForDate:(NSDate*)date {
    CGFloat weight = (CGFloat)arc4random_uniform(200);
    HKUnit *poundUnit = [HKUnit poundUnit];
    HKQuantity *weightQuantity = [HKQuantity quantityWithUnit:poundUnit doubleValue:weight];
    
    HKQuantityType *weightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    
    HKQuantitySample *weightSample = [HKQuantitySample quantitySampleWithType:weightType quantity:weightQuantity startDate:date endDate:date];
    
    [[AppDelegate healthStore] saveObject:weightSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"Coudl not save weight into health store: %@", error);
        }
        //[self updateUsersWeight];
    }];
}

- (void)addBacDataForDate:(NSDate*)date {
    
    CGFloat bac = arc4random_uniform(1);
    HKUnit *bacUnit = [HKUnit percentUnit];
    HKQuantity *bacQuantity = [HKQuantity quantityWithUnit:bacUnit doubleValue:bac];
    
    HKQuantityType *bacType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodAlcoholContent];
    
    HKQuantitySample *bacSample = [HKQuantitySample quantitySampleWithType:bacType quantity:bacQuantity startDate:date endDate:date];
    
    [[AppDelegate healthStore] saveObject:bacSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"Could not save BAC value into health store: %@", error);
        }
    }];
}

- (void)addBloodPressureForDate:(NSDate*)date {
    CGFloat systolic = arc4random_uniform(180);
    CGFloat diastolic = arc4random_uniform(100);
    
    HKUnit *bloodPressureUnit = [HKUnit millimeterOfMercuryUnit];
    
    HKQuantity *systolicQty = [HKQuantity quantityWithUnit:bloodPressureUnit doubleValue:systolic];
    HKQuantity *diastolicQty = [HKQuantity quantityWithUnit:bloodPressureUnit doubleValue:diastolic];
    
    HKQuantityType *systolicType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureSystolic];
    HKQuantityType *diastolicType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureDiastolic];
    
    HKQuantitySample *systolicSample = [HKQuantitySample quantitySampleWithType:systolicType quantity:systolicQty startDate:date endDate:date];
    HKQuantitySample *diastolicSample = [HKQuantitySample quantitySampleWithType:diastolicType quantity:diastolicQty startDate:date endDate:date];
    
    [[AppDelegate healthStore] saveObjects:@[systolicSample, diastolicSample] withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"Could not save blood pressure data: %@", error);
        }
    }];
}

- (void)addNikeFuelForDate:(NSDate*)date {
    CGFloat points = arc4random_uniform(2000);
    HKUnit *fuelPointUnit = [HKUnit countUnit];
    HKQuantity *fuelPointQuantity = [HKQuantity quantityWithUnit:fuelPointUnit doubleValue:points];
    
    HKQuantityType *fuelPointType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierNikeFuel];
    
    HKQuantitySample *fuelPointSample = [HKQuantitySample quantitySampleWithType:fuelPointType quantity:fuelPointQuantity startDate:date endDate:date];
    
    [[AppDelegate healthStore] saveObject:fuelPointSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"Could not save fuel points into health store: %@", error);
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
