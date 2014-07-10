//
//  AppDelegate.h
//  HealthKitDemo
//
//  Created by Christopher Martin on 7/1/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HKHealthStore;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (HKHealthStore*)healthStore;
+ (void)requestHealthStorePermissionsWithCompletion:(void(^)(BOOL success, NSError *error))completion;

@end

