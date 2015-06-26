//
//  ActivitySearchViewController.h
//  NEEV
//
//  Created by Sachin Sharma on 27/03/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "UserDetails_Var.h"
#import "AppDelegate.h"
#import "PendulumView.h"
#import "RSLoadingIndicator.h"


@interface ActivitySearchViewController : UIViewController<UIPickerViewDelegate,UIActionSheetDelegate,UITextFieldDelegate,RSLoadingIndicatorDelegate>

{
    UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;
    Search_Activitiesresultpage_variables *search_activitiesresultpage_variables; // use of create singleton objects and use its variables for search activities
    UIPickerView *ActivitiesPickerView;
    UIDatePicker *dateSectionView;
    
    UIActionSheet *actionSheet; // ACtionsheet
    
    
    
    UIDatePicker *datePicker; //ui date picker for picking date
    NSDate *selectedDate; // ui picker select date
    BOOL isTodateSelected,isFromdateSelected; // for checking which date has been selected
    BOOL isPPLNameclicked,isActivitystatusClicked,isActivityTypeClicked;
    long startIndex, endIndex;//


}



@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secondView;


@property (weak, nonatomic) IBOutlet UITextField *textfrmDate;//
@property (weak, nonatomic) IBOutlet UITextField *textDate;//
@property (weak, nonatomic) IBOutlet UITextField *textactivitytype;//
@property (weak, nonatomic) IBOutlet UITextField *textstatus;//
@property (weak, nonatomic) IBOutlet UITextField *textdse;
@property (weak, nonatomic) IBOutlet UITextField *texttaluka;
@property (weak, nonatomic) IBOutlet UITextField *textppl;//


@property (strong, nonatomic) IBOutlet UIView *searchview;


@property(strong,nonatomic)NSMutableArray *activityPPLNamePickerArr;
@property(strong,nonatomic)NSMutableArray *activitypplIDPickerArr;
@property(strong,nonatomic)NSMutableArray *activityType_PickerArr;
@property(strong,nonatomic)NSMutableArray *activityStatus;
@property(strong,nonatomic)NSMutableArray *activityAssignTo;
@property(strong,nonatomic)NSMutableArray *activityPlNamePickerArr;
@property(strong,nonatomic)NSMutableArray *activityTypePlIdPickerArr;

@property(strong,nonatomic)NSMutableArray *activityType_TalArr;
@property(strong,nonatomic)NSMutableArray *activityAssignLOB;

@property (strong, nonatomic) IBOutlet PendulumView *pendulum;

@property (weak, nonatomic) IBOutlet UIButton *SearchBTN;



@end
