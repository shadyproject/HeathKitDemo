//
//  GraphViewHeader.m
//  HealthKitDemo
//
//  Created by Christopher Martin on 7/9/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "GraphViewHeader.h"

@interface GraphViewHeader ()
//@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation GraphViewHeader

- (void)awakeFromNib {
    // Initialization code
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    [[self.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)setLabelText:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    label.text = text;
    [label setTextColor:[UIColor whiteColor]];
    
    [self.contentView addSubview:label];
}

@end
