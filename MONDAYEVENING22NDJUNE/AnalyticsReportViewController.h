//
//  AnalyticsReportViewController.h
//  DSE
//
//  Created by admin on 20/05/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnalyticsReportViewController : UIViewController<UIActionSheetDelegate,UITextFieldDelegate>
{
    UIDatePicker *datePicker; //ui date picker for picking date
    UIActionSheet *actionSheet; // ACtionsheet
}
@property (weak, nonatomic) IBOutlet UIButton *btnFromDate;

@property (weak, nonatomic) IBOutlet UIButton *btnSelectDSE;

@property (weak, nonatomic) IBOutlet UITextField *btnTodate;


- (IBAction)btnFromDate:(id)sender;

- (IBAction)btnSelectDSE:(id)sender;

- (IBAction)btnToDate:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *_firstView;
@property (weak, nonatomic) IBOutlet UIView *_SecondView;


@property (weak, nonatomic) IBOutlet UITextField *txtSelectDSE;

@property (weak, nonatomic) IBOutlet UITextField *txtFromDate;

@property (weak, nonatomic) IBOutlet UITextField *txtTODate;


@property(strong,nonatomic)NSMutableArray *analyticsMonth;
@property(strong,nonatomic)NSMutableArray *analyticsYear;
@property(strong ,nonatomic)NSMutableArray *analyticsSalesStages;

@property (weak, nonatomic) IBOutlet UIButton *searchBTN;



@end
