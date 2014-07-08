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
- (IBAction)saveCharacteristicData:(UIButton *)sender {
    NSDate *birthDate = [self.formatter dateFromString:self.birthDateField.text];
    NSString *sex = [self.genderPIcker titleForSegmentAtIndex:self.genderPIcker.selectedSegmentIndex];
    NSString *bloodType = self.bloodTypeField.text;
    
    [self saveBirthDate:birthDate sex:sex andBloodType:bloodType];
}

- (IBAction)saveSampleData:(id)sender {
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

- (void)saveBirthDate:(NSDate*)date sex:(NSString*)sex andBloodType:(NSString*)bloodType {
    HKBloodTypeObject *bto = [self bloodTypeFromString:bloodType]; //Takin' care of business...
    HKBiologicalSexObject *so = [self sexFromString:sex];
    
    HKCharacteristicType *charType = [HKCharacteristicType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:date toDate:[NSDate date] options:NSCalendarWrapComponents];
    CGFloat daysOld = [components day];
    HKQuantity *days = [HKQuantity quantityWithUnit:[HKUnit dayUnit] doubleValue:daysOld];
    
    [[AppDelegate healthStore] saveObjects:@[bto, so, dob] withCompletion:^(BOOL success, NSError *error) {
        NSLog(@"%@ succeed saving data. Error: %@", (success ? @"Did" : @"Did not"), error);
    }];
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
                     
- (HKBloodType)bloodTypeForString:(NSString*)string {
    HKObjectType *type = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBloodType];
    NSDate *start = [NSDate date];
    NSDate *end = start;
    HKCategorySample *sample = nil;
    if ([[string uppercaseString] isEqualToString:@"AB-"]) {
        //stuff
    }
}
                     
@end
