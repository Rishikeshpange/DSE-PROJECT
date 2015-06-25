//
//  AnalyticsViewController.h
//  NEEV
//
//  Created by Sachin Sharma on 31/03/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPieChart.h"
#import "ProductTableviewController.h"
#import "ReportTableViewController.h"
#import "AppDelegate.h"
#import "UserDetails_Var.h"
@interface AnalyticsViewController : UIViewController  <XYPieChartDataSource, XYPieChartDelegate,UIAlertViewDelegate>
{
    UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;
}
@property (weak, nonatomic) IBOutlet XYPieChart *Piechartanalytics;



@property (weak, nonatomic) IBOutlet UIView *TitleView;
@property (strong, nonatomic) IBOutlet UILabel *percentageLabel;

@property (strong, nonatomic) ProductTableviewController *productable;
@property (strong, nonatomic) ReportTableViewController *reportTable;
@property (weak, nonatomic) IBOutlet UIView *DoughnutView;

@property (weak, nonatomic) IBOutlet UITableView *AnalyticsTableview;
@property (weak, nonatomic) IBOutlet UITableView *tblview;

@property long getmonthNo;


@property (strong, nonatomic) IBOutlet UILabel *selectedSliceLabel;
@property (strong, nonatomic) IBOutlet UITextField *numOfSlices;
@property (strong, nonatomic) IBOutlet UISegmentedControl *indexOfSlices;
@property (strong, nonatomic) IBOutlet UIButton *downArrow;
@property(nonatomic, strong) NSMutableArray *slices;
@property(nonatomic, strong) NSArray        *sliceColors;

@property(nonatomic, strong) IBOutlet NSMutableArray *ProductArray;

@property(nonatomic ,strong) IBOutlet NSMutableArray *c0sum;

@property(nonatomic ,strong) IBOutlet NSMutableArray *c1sum;


@property(nonatomic ,strong) IBOutlet NSMutableArray *c2sum;

@property(nonatomic ,strong) IBOutlet NSMutableArray *c3sum;

@property(nonatomic ,strong) IBOutlet NSMutableArray *c1Asum;

@property (weak, nonatomic) IBOutlet UIView *SalesStageTotalView;

@property(nonatomic,strong)NSString *passFromdate;
@property(nonatomic,strong)NSString *passTodate;
@property(nonatomic,strong)NSString *passDSE;
@property(nonatomic, strong) NSString *passdseid;

@property(nonatomic, strong) NSString *passMonth;
@property(nonatomic, strong) NSString *passYear;
@property(nonatomic, strong) NSString *PassSalesStages;

@property (weak, nonatomic) IBOutlet UILabel *C0Total;



@property (weak, nonatomic) IBOutlet UILabel *C1Total;

@property (weak, nonatomic) IBOutlet UILabel *C1ATotal;

@property (weak, nonatomic) IBOutlet UILabel *C2Total;

@property (weak, nonatomic) IBOutlet UILabel *C3Total;

@property (weak, nonatomic) IBOutlet UIImageView *coLegend;

@property (weak, nonatomic) IBOutlet UIImageView *c1Legend;

@property (weak, nonatomic) IBOutlet UIImageView *c1AlEGEND;

@property (weak, nonatomic) IBOutlet UIImageView *C2Legend;


@property (weak, nonatomic) IBOutlet UIImageView *c3Legend;
//@property (weak, nonatomic) UIImageView



@end
