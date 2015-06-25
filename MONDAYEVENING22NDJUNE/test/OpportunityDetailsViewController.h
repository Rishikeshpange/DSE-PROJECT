//
//  OpportunityDetailsViewController.h
//  NEEV
//
//  Created by Sachin Sharma on 02/04/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDetails_Var.h"
#import "AppDelegate.h"
#import "CustomIOSAlertView.h"

@interface OpportunityDetailsViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource,UIActionSheetDelegate,UIAlertViewDelegate,CustomIOSAlertViewDelegate>
{
    UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;
    
}
@property(strong,nonatomic)NSMutableArray *optySearchDetails;
@property(strong,nonatomic)NSMutableArray *optySearchDetails_Comes;
@property (weak, nonatomic) IBOutlet UILabel *OPTY_ID;
@property (weak, nonatomic) IBOutlet UILabel *OPTY_CREATE_DATE;
@property (weak, nonatomic) IBOutlet UILabel *SALES_STAGE_NAME;
@property (weak, nonatomic) IBOutlet UILabel *PRODUCT_NAME;

@property (weak, nonatomic) IBOutlet UILabel *CONTACT_NAME;
@property (weak, nonatomic) IBOutlet UILabel *CONTACT_CELL_NUMBER;
@property (weak, nonatomic) IBOutlet UILabel *CONTACT_ADDRESS;

@property (weak, nonatomic) IBOutlet UILabel *CUSTOMER_ACCOUNT_NAME;
@property (weak, nonatomic) IBOutlet UILabel *CUSTOMER_PHONE_NUMBER;

@property (strong, nonatomic) IBOutlet UIActionSheet *actionSheet;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;


@property(strong,nonatomic)NSMutableArray *LinkCampaignList;
@property (strong, nonatomic) IBOutlet NSString *selectedLinkCampaignValue;

@property (weak, nonatomic) IBOutlet UILabel *LastPendingActivityStartDate;
@property (weak, nonatomic) IBOutlet UILabel *LastPendingActivityType;
@property (weak, nonatomic) IBOutlet UILabel *LastPendingActivityDescription;

@property (weak, nonatomic) IBOutlet UIView *OPTYVIEWTOP;
@property (weak, nonatomic) IBOutlet UIView *CONTACTVIEW;
@property (weak, nonatomic) IBOutlet UIView *ACCOUNTVIEW;
@property (weak, nonatomic) IBOutlet UIView *ACTIVITYVIEW;

@property (weak, nonatomic) IBOutlet UILabel *LastDoneActivitystartDate;
@property (weak, nonatomic) IBOutlet UILabel *LastDoneActivityType;
@property (weak, nonatomic) IBOutlet UILabel *LastDoneActivityDescrption;

@property (weak, nonatomic) IBOutlet UIButton *UpdateBtn;
@property (weak, nonatomic) IBOutlet UIButton *PendingActivitiesBtn;
@property (weak, nonatomic) IBOutlet UIButton *LinkCampaignBtn;
@property (weak, nonatomic) IBOutlet UIButton *MarkAsLostBtn;
@property (weak, nonatomic) IBOutlet UIButton *CreateQuoteBtn;
@property (weak, nonatomic) IBOutlet UIButton *NewActivityBtn;

@end
