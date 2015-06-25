//
//  dashboardTodaysActivity_Cell_VC.m
//  test
//
//  Created by Admin on 04/03/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import "dashboardTodaysActivity_Cell_VC.h"

@implementation dashboardTodaysActivity_Cell_VC

@synthesize lbl_customer,
            lbl_CustomerName,
            lbl_opty,
            lbl_OptyId,
optyCounter;


- (void)awakeFromNib {
    // Initialization code
    
   // NSLog(@"testing label..123");
    [lbl_customer sizeToFit];
    [lbl_CustomerName sizeToFit];
    [lbl_opty sizeToFit];
    [lbl_OptyId sizeToFit];
    [optyCounter sizeToFit];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end
