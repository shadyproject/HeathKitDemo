//
//  GraphViewHeader.m
//  HealthKitDemo
//
//  Created by Christopher Martin on 7/9/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "GraphViewHeader.h"

@interface GraphViewHeader ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation GraphViewHeader

- (void)awakeFromNib {
    // Initialization code
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.label.text = nil;
}

- (void)setLabelText:(NSString *)text {
    [self.label setText:text];
}

@end
