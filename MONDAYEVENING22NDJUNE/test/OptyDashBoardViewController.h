//
//  OptyDashBoardViewController.h
//DSM
//
//  Created by admin on 21/05/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPieChart.h"
#import "AppDelegate.h"
#import "UserDetails_Var.h"
@interface OptyDashBoardViewController : UIViewController<XYPieChartDataSource,XYPieChartDelegate>
{
    
    UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;
    
}
@property(nonatomic, strong) NSMutableArray *slices;
@property(nonatomic, strong) NSArray  *sliceColors;
@property (strong, nonatomic) IBOutlet UIButton *downArrow;
@property (strong, nonatomic) IBOutlet UILabel *selectedSliceLabel;
@property (strong, nonatomic) IBOutlet UITextField *numOfSlices;
@property (strong, nonatomic) IBOutlet UISegmentedControl *indexOfSlices;
@property (strong, nonatomic) IBOutlet XYPieChart *pieChartLeft;
@property (strong, nonatomic) IBOutlet UILabel *percentageLabel;

@property(strong,nonatomic) NSMutableArray *Opty_Arr;

@end
