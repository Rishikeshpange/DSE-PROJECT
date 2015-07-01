//
//  CreateActivityViewController.h
//  NEEV
//
//  Created by admin on 20/03/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UserDetails_Var.h"
#import "ActivityPendingList.h"
#import "LinkCampaignListView.h"
@interface CreateActivityViewController : UIViewController<UIActionSheetDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UITextViewDelegate,UITextViewDelegate>
{
    
    UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;
    UIActionSheet *actionSheet;
    UIPickerView *ActivitiesPickerView;
    UIDatePicker *dateSectionView;
    UIDatePicker *datePicker; //ui date picker for picking date
     CreateContactResult* createcontactresult;
    
}

@property(strong,nonatomic)NSMutableArray *activityType_PickerArr;
@property(strong,nonatomic)NSMutableArray *activityCreate_Arr;


@property (weak, nonatomic) IBOutlet UIView *viewType;

@property (weak, nonatomic) IBOutlet UITextView *descTxt;

@property (weak, nonatomic) IBOutlet UITextField *txtActivityType;

@property (weak, nonatomic) IBOutlet UITextField *txtActivityDate;

@property (weak, nonatomic) IBOutlet UITextField *txtActivityTime;

@property (weak, nonatomic) IBOutlet UIButton *btnSave;

@property (weak, nonatomic) IBOutlet UIButton *btnCancel;

@property (strong, nonatomic) IBOutlet NSString *RequestStringDate;

@property (assign) CGPoint originalCenter;


@property(strong,nonatomic)NSMutableArray *LinkCampaignList;
@property (strong, nonatomic) IBOutlet NSString *selectedLinkCampaignValue;


- (IBAction)btnActivityType:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *_firstView;

@property (weak, nonatomic) IBOutlet UIView *_secondView;

- (IBAction)btnSelectDate:(id)sender;

- (IBAction)btnSelectTime:(id)sender;

- (IBAction)btnSave:(id)sender;

- (IBAction)btnCancelled:(id)sender;

@end
