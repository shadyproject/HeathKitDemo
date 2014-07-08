//
//  FirstViewController.m
//  HealthKitDemo
//
//  Created by Christopher Martin on 7/1/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "DataEntryViewController.h"
#import "AppDelegate.h"

@interface DataEntryViewController ()
@property (weak, nonatomic) IBOutlet UITextField *birthDateField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderPIcker;
@property (weak, nonatomic) IBOutlet UITextField *bloodTypeField;

@property (weak, nonatomic) IBOutlet UITextField *heightField;
@property (weak, nonatomic) IBOutlet UITextField *weightField;
@property (weak, nonatomic) IBOutlet UITextField *fuelPointsField;
@property (weak, nonatomic) IBOutlet UITextField *bacField;
@property (weak, nonatomic) IBOutlet UITextField *bloodPressureField;
@property (weak, nonatomic) IBOutlet UITextField *bloodSugarField;
@property (weak, nonatomic) IBOutlet UITextField *heartRateField;

@property (nonatomic, readonly) NSDateFormatter *formatter;

@end

@implementation DataEntryViewController
- (void)awakeFromNib {
    [super awakeFromNib];
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateStyle:NSDateFormatterShortStyle];
    [_formatter setTimeStyle:NSDateFormatterNoStyle];
}

- (IBAction)saveSampleData:(id)sender {
    [self saveHeight:[self.heightField.text doubleValue]];
    [self saveWeight:[self.weightField.text doubleValue]];
    [self saveFuelPoints:[self.fuelPointsField.text doubleValue]];
    [self saveBloodAlcohol:[self.bacField.text doubleValue]];
    [self saveBloodPressure:self.bloodPressureField.text];
}

- (void)saveHeight:(CGFloat)height {
    HKUnit *inchUnit = [HKUnit inchUnit];
    HKQuantity *heightQuantity = [HKQuantity quantityWithUnit:inchUnit doubleValue:height];

    HKQuantityType *heightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    NSDate *now = [NSDate date];
    
    HKQuantitySample *heightSample = [HKQuantitySample quantitySampleWithType:heightType quantity:heightQuantity startDate:now endDate:now];
    
    [[AppDelegate healthStore] saveObject:heightSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"Could not save height into health store: %@", error);
        }
        //[self updateUsersHeight];
    }];
}

- (void)saveWeight:(CGFloat)weight {
    HKUnit *poundUnit = [HKUnit poundUnit];
    HKQuantity *weightQuantity = [HKQuantity quantityWithUnit:poundUnit doubleValue:weight];
    
    HKQuantityType *weightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    NSDate *now = [NSDate date];
    
    HKQuantitySample *weightSample = [HKQuantitySample quantitySampleWithType:weightType quantity:weightQuantity startDate:now endDate:now];
    
    [[AppDelegate healthStore] saveObject:weightSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"Coudl not save weight into health store: %@", error);
        }
        //[self updateUsersWeight];
    }];
}

- (void)saveFuelPoints:(CGFloat)points {
    HKUnit *fuelPointUnit = [HKUnit countUnit];
    HKQuantity *fuelPointQuantity = [HKQuantity quantityWithUnit:fuelPointUnit doubleValue:points];
    
    HKQuantityType *fuelPointType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierNikeFuel];
    NSDate *now = [NSDate date];
    
    HKQuantitySample *fuelPointSample = [HKQuantitySample quantitySampleWithType:fuelPointType quantity:fuelPointQuantity startDate:now endDate:now];
    
    [[AppDelegate healthStore] saveObject:fuelPointSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"Could not save fuel points into health store: %@", error);
        }
        //[self updateFuelPoints];
    }];
}

- (void)saveBloodAlcohol:(CGFloat)bac {
    HKUnit *bacUnit = [HKUnit percentUnit];
    HKQuantity *bacQuantity = [HKQuantity quantityWithUnit:bacUnit doubleValue:bac];
    
    HKQuantityType *bacType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodAlcoholContent];
    NSDate *now = [NSDate date];
    
    HKQuantitySample *bacSample = [HKQuantitySample quantitySampleWithType:bacType quantity:bacQuantity startDate:now endDate:now];
    
    [[AppDelegate healthStore] saveObject:bacSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"Could not save BAC value into health store: %@", error);
        }
    }];
}

- (void)saveBloodPressure:(NSString*)bloodPressure {
    NSArray *components = [bloodPressure componentsSeparatedByString:@"/"];
    CGFloat systolic = [components[0] doubleValue];
    CGFloat diastolic = [components[0] doubleValue];
    
    HKUnit *bloodPressureUnit = [HKUnit millimeterOfMercuryUnit];
    
    HKQuantity *systolicQty = [HKQuantity quantityWithUnit:bloodPressureUnit doubleValue:systolic];
    HKQuantity *diastolicQty = [HKQuantity quantityWithUnit:bloodPressureUnit doubleValue:diastolic];
    
    HKQuantityType *systolicType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureSystolic];
    HKQuantityType *diastolicType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureDiastolic];
    NSDate *now = [NSDate date];
    
    HKQuantitySample *systolicSample = [HKQuantitySample quantitySampleWithType:systolicType quantity:systolicQty startDate:now endDate:now];
    HKQuantitySample *diastolicSample = [HKQuantitySample quantitySampleWithType:diastolicType quantity:diastolicQty startDate:now endDate:now];
    
    [[AppDelegate healthStore] saveObjects:@[systolicSample, diastolicSample] withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"Could not save blood pressure data: %@", error);
        }
    }];
}

- (IBAction)saveCategoryData:(UIButton *)sender {
}
            
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self populateCharacteristicData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)populateCharacteristicData {
    NSError *error = nil;
    NSDate *birthdate = [[AppDelegate healthStore] dateOfBirthWithError:&error];
    
    if (!error) {
        self.birthDateField.text = [self.formatter stringFromDate:birthdate];
    } else {
        NSLog(@"Error fetching birth date from health store: %@", error);
    }
    
    error = nil;
    HKBiologicalSexObject *sex = [[AppDelegate healthStore] biologicalSexWithError:&error];
    
    if (!error) {
        switch (sex.biologicalSex) {
            case HKBiologicalSexFemale:
                [self.genderPIcker setSelectedSegmentIndex:1];
                break;
                
            case HKBiologicalSexMale:
                [self.genderPIcker setSelectedSegmentIndex:0];
                break;
                
            default:
                break;
        }
    } else {
        NSLog(@"Error fetching sex from health store: %@", error);
    }
    
    error = nil;
    HKBloodTypeObject *bloodType = [[AppDelegate healthStore] bloodTypeWithError:&error];
    
    if (!error) {
        self.bloodTypeField.text = [self stringForBloodType:bloodType.bloodType];
    } else {
        NSLog(@"Error fetching blood type from health store: %@", error);
    }
}

- (NSString*)stringForBloodType:(HKBloodType)bloodType {
    switch (bloodType) {
        case HKBloodTypeABNegative:
            return @"AB-";
            
        case HKBloodTypeABPositive:
            return @"AB+";
            
        case HKBloodTypeANegative:
            return @"A-";
            
        case HKBloodTypeAPositive:
            return @"A+";
            
        case HKBloodTypeBNegative:
            return @"B-";
            
        case HKBloodTypeBPositive:
            return @"B+";
            
        case HKBloodTypeONegative:
            return @"O-";
            
        case HKBloodTypeOPositive:
            return @"O+";
            
        case HKBloodTypeNotSet:
            return nil;
    }
}
/* Apparently this isn't actualy able to be set from anythign other than the HEalth app
- (HKBloodTypeObject*)bloodTypeForString:(NSString*)string {
    HKObjectType *type = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBloodType];
    NSDate *start = [NSDate date];
    NSDate *end = start;
    HKCategorySample *sample = nil;
    NSString *normalizedTypeString = [string uppercaseString];
    if ([normalizedTypeString isEqualToString:@"AB-"]) {
        sample = [HKCategorySample categorySampleWithType:type value:HKBloodTypeABNegative startDate:start endDate:end];
    } else if ([normalizedTypeString isEqualToString:@"AB+"]) {
        sample = [HKCategorySample categorySampleWithType:type value:HKBloodTypeABPositive startDate:start endDate:end];
    } else if ([normalizedTypeString isEqualToString:@"A-"]) {
        sample = [HKCategorySample categorySampleWithType:type value:HKBloodTypeANegative startDate:start endDate:end];
    } else if ([normalizedTypeString isEqualToString:@"A+"]) {
        sample = [HKCategorySample categorySampleWithType:type value:HKBloodTypeAPositive startDate:start endDate:end];
    } else if ([normalizedTypeString isEqualToString:@"B-"]) {
        sample = [HKCategorySample categorySampleWithType:type value:HKBloodTypeBNegative startDate:start endDate:end];
    } else if ([normalizedTypeString isEqualToString:@"B+"]) {
        sample = [HKCategorySample categorySampleWithType:type value:HKBloodTypeBPositive startDate:start endDate:end];
    } else if ([normalizedTypeString isEqualToString:@"O-"]) {
        sample = [HKCategorySample categorySampleWithType:type value:HKBloodTypeONegative startDate:start endDate:end];
    } else if ([normalizedTypeString isEqualToString:@"O+"]) {
        sample = [HKCategorySample categorySampleWithType:type value:HKBloodTypeANegative startDate:start endDate:end];
    }
    
    return sample;
}
 */
                     
@end
