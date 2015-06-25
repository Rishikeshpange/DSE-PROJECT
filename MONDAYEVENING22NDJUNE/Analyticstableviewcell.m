//
//  Analyticstableviewcell.m
//  DSE
//
//  Created by Rishikesh on 02/04/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import "Analyticstableviewcell.h"

@implementation Analyticstableviewcell

- (void)awakeFromNib {
    
 
    
    self.StatusImage.clipsToBounds = YES;
    
    self.StatusImage.layer.cornerRadius = 2;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
