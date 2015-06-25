//
//  TestDrvieViewController.h
//  test
//
//  Created by admin on 02/03/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ContactViewCell.h"
#import "UserDetails_Var.h"

@interface CreateOpportunityViewController : UIViewController<UISplitViewControllerDelegate,UIActionSheetDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate>
{
    AppDelegate *appdelegate;
    UserDetails_Var *userDetailsVal_;
    CreateContactResult* createcontactresult;
    CreateAccountAginstContact *createaccountaginstcontact;
     PL_ProductID_Product *pl_productid_product;
     CreateOpportunity *createopportunity;
     CreateAccount *createaccount;//For AccountID

}
// Create Opprotunity Fields
@property (weak, nonatomic) IBOutlet UITextField *textfirst;
@property (weak, nonatomic) IBOutlet UITextField *textlast;
@property (weak, nonatomic) IBOutlet UITextField *textnumber;
@property (weak, nonatomic) IBOutlet UITextField *textid;
@property (weak, nonatomic) IBOutlet UITextField *textadd1;
@property (weak, nonatomic) IBOutlet UITextField *textadd2;
@property (weak, nonatomic) IBOutlet UITextField *textCity;
@property (weak, nonatomic) IBOutlet UITextField *textArea;

@property (weak, nonatomic) IBOutlet UITextField *textState;
@property (weak, nonatomic) IBOutlet UITextField *textDistrict;
@property (weak, nonatomic) IBOutlet UITextField *textpostalcode;
@property (weak, nonatomic) IBOutlet UITextField *textTaluka;
@property (weak, nonatomic) IBOutlet UITextField *textPanchayat;
@property (weak, nonatomic) IBOutlet UITextField *Account;


@property (weak, nonatomic) IBOutlet UITableView *contactTableview;
@property(strong,nonatomic) IBOutlet  AppDelegate *appdelegate;





// Create Opprotunity Action 

@property (weak, nonatomic) IBOutlet UIImageView *scroll_icons;

// Opportunity Details Fileds
@property (weak, nonatomic) IBOutlet UITextField *txtfldLob;
@property (weak, nonatomic) IBOutlet UITextField *txtfldpl;
@property (weak, nonatomic) IBOutlet UITextField *txtfldPpl;
@property (weak, nonatomic) IBOutlet UITextField *txtfldApp;
@property (weak, nonatomic) IBOutlet UITextField *txtfldContact;
@property (weak, nonatomic) IBOutlet UITextField *txtFinancer;
@property (weak, nonatomic) IBOutlet UIView *myview;


@property (weak, nonatomic) IBOutlet UITextField *LOB;
@property (weak, nonatomic) IBOutlet UITextField *PPL;
@property (weak, nonatomic) IBOutlet UITextField *PL;
@property (weak, nonatomic) IBOutlet UITextField *APPLICATION;
@property (weak, nonatomic) IBOutlet UITextField *SOURCEOFCONTACT;
@property (weak, nonatomic) IBOutlet UITextField *FINANCIER;
@property (weak, nonatomic) IBOutlet UIView *oppurtunityView;
@property (weak, nonatomic) IBOutlet UIScrollView *OpportunityScrollView;
@property (strong, nonatomic) IBOutlet NSMutableArray *opp_Contact_LOB_PickerArr;
@property (strong, nonatomic) IBOutlet NSMutableArray *PPL_List_PickerArr;
@property (strong, nonatomic) IBOutlet NSMutableArray *PL_List_PickerArr;
@property (strong, nonatomic) IBOutlet NSMutableArray *Application_List_PickerArr;
@property (strong, nonatomic) IBOutlet NSMutableArray *Financier_List_PickerArr;
@property (strong, nonatomic) IBOutlet NSMutableArray *Source_Contact_List_PickerArr;
@property (strong, nonatomic) IBOutlet NSMutableArray *States_List_PickerArr;
@property (strong, nonatomic) IBOutlet NSMutableArray *District_List_PickerArr;
@property (strong, nonatomic) IBOutlet NSMutableArray *City_List_PickerArr;
@property (strong, nonatomic) IBOutlet NSMutableArray *PostalCode_List_PickerArr;
@property (strong, nonatomic) IBOutlet NSMutableArray *Taluka_List_PickerArr;
@property (strong, nonatomic) IBOutlet UIView *CreateOppurtunityView;
@property (weak, nonatomic) IBOutlet UITextField *SearchContact;
@property(nonatomic, strong) IBOutlet NSMutableArray *ContactList;
@property (weak, nonatomic) IBOutlet UIView *contactListView;
@property (weak, nonatomic) IBOutlet UIView *Containerview;


@property (strong, nonatomic) IBOutlet  NSMutableDictionary *dict;
@property (strong, nonatomic) IBOutlet NSString *statestringdecoded;


@property(strong,nonatomic)NSMutableArray *showStates;


// Opportunity Detials Actions: 
- (IBAction)textpl:(id)sender;
- (IBAction)textEdit:(UITextField *)sender;
- (IBAction)textPpl:(id)sender;
- (IBAction)textapp:(id)sender;
- (IBAction)textfinance:(UITextField *)sender;
- (IBAction)textContact:(id)sender;
//Progress bar view
- (IBAction)animateProgress:(id)sender;
- (IBAction)progressChanged:(id)sender;
- (IBAction)indeterminateChanged:(id)sender;
- (IBAction)blurChanged:(id)sender;
- (IBAction)statusPositionChanged:(id)sender;
- (IBAction)maskTypeChanged:(id)sender;
- (IBAction)superviewChanged:(id)sender;
- (IBAction)iconChanged:(id)sender;

-(void)showAlert;
-(void)hideAlert;


@property (weak, nonatomic) IBOutlet UIButton *btn_CreateContact; //
@property (weak, nonatomic) IBOutlet UIButton *btn_CreateAccount;
@property (weak, nonatomic) IBOutlet UIButton *btn_CreateOpty;


@end
