//
//  DetailViewController.h
//  test
//
//  Created by Sebastian Boldt on 07.03.13.
//  Copyright (c) 2013 LetsIDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPieChart.h"
#import "AppDelegate.h"
#import "UserDetails_Var.h"
#import "ActivityListViewController.h"
#import "SearchActivity_List.h"
@interface DetailViewController : UIViewController <UISplitViewControllerDelegate, XYPieChartDataSource, XYPieChartDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
    UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;
    
}
@property (weak, nonatomic) IBOutlet UIView *viewFirst;

@property (weak, nonatomic) IBOutlet UIView *viewSecond;


@property (strong, nonatomic) IBOutlet UITableView *tblview;
@property (weak, nonatomic) IBOutlet UIView *TitleView;
@property (strong, nonatomic) IBOutlet XYPieChart *pieChartLeft;
@property (strong, nonatomic) IBOutlet UILabel *percentageLabel;
@property (strong, nonatomic) IBOutlet XYPieChart *pieChartRight;
@property (strong, nonatomic) IBOutlet UILabel *percentageLabel1;
@property (strong, nonatomic) IBOutlet UILabel *selectedSliceLabel;
@property (strong, nonatomic) IBOutlet UITextField *numOfSlices;
@property (strong, nonatomic) IBOutlet UISegmentedControl *indexOfSlices;
@property (strong, nonatomic) IBOutlet UIButton *downArrow;
@property(nonatomic, strong) NSMutableArray *slices;

@property(nonatomic, strong) NSMutableArray *slices1;

@property(nonatomic, strong) NSArray        *sliceColors;

@property (weak, nonatomic) IBOutlet UIView *middleView;
@property(strong,nonatomic) NSMutableArray *Opty_Arr;

@property (strong, nonatomic) IBOutlet UIView *cautionView;


- (IBAction)btnToggleClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnToggle;




@end
