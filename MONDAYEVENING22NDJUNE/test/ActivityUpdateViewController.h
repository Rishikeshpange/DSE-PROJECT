//
//  ActivityUpdateViewController.h
//  NEEV
//
//  Created by admin on 01/04/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UserDetails_Var.h"

@interface ActivityUpdateViewController : UIViewController<UIActionSheetDelegate,UITextFieldDelegate>
{
    
    UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;
    UIActionSheet *actionSheet;
    UIPickerView *ActivitiesPickerView;
    UIDatePicker *dateSectionView;
    UIDatePicker *datePicker; //ui date picker for picking date
    UpdateACtivity *updateActivty;

}


@property (weak, nonatomic) IBOutlet UITextField *txtActivityType;
@property int flagset;
@property (weak, nonatomic) IBOutlet UITextField *txtSelectDate;
@property (weak, nonatomic) IBOutlet UITextField *txtSelectTime;
@property (weak, nonatomic) IBOutlet UITextView *txtDescription;

@property (weak, nonatomic) IBOutlet UIButton *btnUpdate;

@property (weak, nonatomic) IBOutlet UIButton *btnCancel;

@property(strong,nonatomic)NSMutableArray *activityType_PickerArr;

@property (assign) CGPoint originalCenter;


// Filed to be Shown :

@property (weak, nonatomic) IBOutlet UILabel *lblCustomerName;

@property (weak, nonatomic) IBOutlet UILabel *lblAddress;

@property (weak, nonatomic) IBOutlet UILabel *lblMobileNo;

@property (weak, nonatomic) IBOutlet UILabel *lblTGMTKM_Name;

@property (weak, nonatomic) IBOutlet UILabel *lblAccountType;

@property (weak, nonatomic) IBOutlet UILabel *lblTGMTKMNumber;

@property (weak, nonatomic) IBOutlet UILabel *lblOptyId;

@property (weak, nonatomic) IBOutlet UIView *_firstView;

@property (weak, nonatomic) IBOutlet UIView *_secondView;

// button Actions :

- (IBAction)btnActivityType:(id)sender;

- (IBAction)btnToDate:(id)sender;

- (IBAction)btnFromDate:(id)sender;

// Button Update ..
- (IBAction)btnUpdate:(id)sender;

// Button cancel
- (IBAction)btnCancel:(id)sender;


@end
