//
//  SearchOpprtunityViewController.h
//  NEEV
//
//  Created by Sachin Sharma on 20/03/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDetails_Var.h"
#import "AppDelegate.h"
#import "RequestDelegate.h"
#import "UserDetails_Var.h"
@interface SearchOpprtunityViewController : UIViewController <UIActionSheetDelegate,UITextFieldDelegate>
{

UIPickerView *SalestagePickerView;
UIDatePicker *dateSectionView;
UserDetails_Var *userDetailsVal_;
AppDelegate *appdelegate;
UIActionSheet *actionSheet; // ACtionsheet
UIDatePicker *datePicker; //ui date picker for picking date
NSDate *selectedDate;
    
}


@property(strong,nonatomic)NSMutableArray *saleStagePickerArr;
@property(strong,nonatomic)NSMutableArray *saleStagePickerArrHC;
@property(strong,nonatomic)NSMutableArray *pplNamePickerArr;
@property(strong,nonatomic)NSMutableArray *ppl_ID_PickerArr;
@property(strong,nonatomic)NSMutableArray *SalesTaluka_PickerArr;
@property(strong,nonatomic)NSMutableArray *SalesAssignTo_PickerArr;
@property(strong,nonatomic)NSMutableArray *SalesAssignTo_PickerArr_Static;

@property(strong,nonatomic)NSMutableArray *activityType_PickerArr;




/*

- (IBAction)frmDatetext:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *myView;
- (IBAction)todatetext:(id)sender;

- (IBAction)salestext:(id)sender;
- (IBAction)ppltext:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *secondView;
- (IBAction)talukatext:(id)sender;
- (IBAction)dsenametext:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textDate;
@property (weak, nonatomic) IBOutlet UITextField *texttoDate;
@property (weak, nonatomic) IBOutlet UITextField *textsalesstages;
@property (weak, nonatomic) IBOutlet UITextField *textPpl;
@property (weak, nonatomic) IBOutlet UITextField *textTaluka;
@property (weak, nonatomic) IBOutlet UITextField *textDsename;
*/


@property (weak, nonatomic) IBOutlet UIView *viewFirst;

@property (weak, nonatomic) IBOutlet UIView *viewSecond;

@property (weak, nonatomic) IBOutlet UIButton *btnSearch;


@property (weak, nonatomic) IBOutlet UITextField *txtCustomerName;

@property (weak, nonatomic) IBOutlet UITextField *txtCustomerMobile;

@property (weak, nonatomic) IBOutlet UITextField *txtFromDate;

@property (weak, nonatomic) IBOutlet UITextField *txtSalesStage;

@property (weak, nonatomic) IBOutlet UITextField *txtTaluka;

@property (weak, nonatomic) IBOutlet UITextField *txtActivityType;

@property (weak, nonatomic) IBOutlet UITextField *txtToDate;

@property (weak, nonatomic) IBOutlet UITextField *txtPPL;

@property (weak, nonatomic) IBOutlet UITextField *txtActivityStatus;

@property (weak, nonatomic) IBOutlet UITextField *txtAssignTO;








- (IBAction)btnSearch:(id)sender;

- (IBAction)btnsalesstages1:(id)sender;
- (IBAction)btnDsename1:(id)sender;
- (IBAction)btnppl1:(id)sender;
- (IBAction)btnTaluka1:(id)sender;



// button actions

// View's












@end
