//
//  AppDelegate.m
//  HealthKitDemo
//
//  Created by Christopher Martin on 7/1/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

@import HealthKit;

#import "AppDelegate.h"

@interface AppDelegate ()
            

@end

@implementation AppDelegate

+ (void)requestHealthStorePermissionsWithCompletion:(void(^)(BOOL success, NSError *error))completion {
    
    if (![HKHealthStore isHealthDataAvailable]) {
        NSError *error = [NSError errorWithDomain:@"SomeDomainHere" code:42 userInfo:@{@"Message": @"HealthKit not supported on current device"}];
        completion(NO, error);
        return;
    }
    
    //fun fact, we can't actually shared fuel band types, it throws an exception
    //write
    NSSet *shareTypes = [NSSet setWithArray:@[
                                              [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight],
                                              [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass],
                                              [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodAlcoholContent],
                                              [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureDiastolic],
                                              [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureSystolic],
                                              //[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierNikeFuel],
                                              ]];
    
    NSSet *readTypes = [NSSet setWithArray:@[
                                             [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight],
                                             [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass],
                                             [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodAlcoholContent],
                                             [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureDiastolic],
                                             [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureSystolic],
                                             [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierNikeFuel],
                                             ]];
                        
    [[AppDelegate healthStore] requestAuthorizationToShareTypes:shareTypes readTypes:readTypes completion:completion];
}

+(HKHealthStore*)healthStore {
    static HKHealthStore* __store = nil;
    
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        
        //apparently iPad dosn't support health kit?
        if ([HKHealthStore isHealthDataAvailable]) {
            __store = [[HKHealthStore alloc] init];
        }
    });
    
    return __store;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
