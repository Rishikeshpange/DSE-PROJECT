 //
//  OpportunityDetailsViewController.m
//  NEEV
//
//  Created by Sachin Sharma on 02/04/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//
#import "DetailViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "dashboardTodaysActivity_Cell_VC.h"
#import "dasboard_Email_tableCell_VC.h"
#import "Dashboard_Leads_tablecell_VC.h"
#import "Search_OpportunityList_Var.h"
#import "manageOpportunity_Cell.h"
#import "Opportunity_List.h"
#import "OpportunityDetailsViewController.h"
#import "Activity_List.h"
#import "RequestDelegate.h"
#import "TBXML.h"
#import "ActivityPendingList.h"
#import "MBProgressHUD.h"
#import "ActivityDetailsViewController.h"
#import "LinkCampaignListView.h"
#import "LostOptyViewController.h"
#import "CreateQuoteViewViewController.h"
#import "UICustomAlertView.h"
#import "CXAlertView.h"


@interface OpportunityDetailsViewController ()
{
    UIAlertView *alert;
}
@end

@implementation OpportunityDetailsViewController
@synthesize optySearchDetails,optySearchDetails_Comes;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];//AppDelegate instance
    userDetailsVal_ = [UserDetails_Var sharedmanager]; // usedetails instance
    NSLog(@"Samlp Art Master: %@",userDetailsVal_.ROW_ID);
     NSLog(@"Samlp Art Master: %@",userDetailsVal_.Login_Name);
   appdelegate.fromOPTYDetail=@"CameFromOptyDetail";
   
   // self.LinkCampaignList=[[NSMutableArray alloc] init];
    NSLog(@"Mutable array COmes :%@",optySearchDetails_Comes);    // Navigation bar button on right side
    UIButton *btnInfo =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btnInfo setImage:[UIImage imageNamed:@"header_Cicon_3.png"] forState:UIControlStateNormal];
    [btnInfo addTarget:self action:@selector(info_btn) forControlEvents:UIControlEventTouchUpInside];
    [btnInfo setFrame:CGRectMake(-15, -5, 40, 40)];
    
    UIButton *btnLogout =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLogout setImage:[UIImage imageNamed:@"header_Cicon_4.png"] forState:UIControlStateNormal];
    [btnLogout addTarget:self action:@selector(logOut_btn) forControlEvents:UIControlEventTouchUpInside];
    [btnLogout setFrame:CGRectMake(44, -5, 40, 40)];
    
    UIView *rightBarButtonItems = [[UIView alloc] initWithFrame:CGRectMake(10,10,90,40)];
    [rightBarButtonItems addSubview:btnInfo];
    [rightBarButtonItems addSubview:btnLogout];
    
    self.LinkCampaignBtn.layer.cornerRadius = 4;
   self.UpdateBtn.layer.cornerRadius = 4;
    self.PendingActivitiesBtn.layer.cornerRadius = 4;
    self.MarkAsLostBtn.layer.cornerRadius = 4;
    self.CreateQuoteBtn.layer.cornerRadius = 4;
    self.NewActivityBtn.layer.cornerRadius = 4;
//    self.LinkCampaignBtn.layer.borderWidth=1.0f;
   
    
    if ([appdelegate.fromManageOptyview isEqualToString:@"fromManageOptyview"])
    {
        NSLog(@"formmanageoptyview");
           NSLog(@"Manageoptyrow:%d",appdelegate.Manageoptyrow);
        
        self.OPTY_ID.text=[[appdelegate.OppurtunityList objectAtIndex:appdelegate.Manageoptyrow] valueForKey:@"OPTY_NAME"];
         appdelegate.opty_idDetailPage=self.OPTY_ID.text;
          NSLog(@"%@",self.OPTY_ID.text);
          NSLog(@"%@",[[appdelegate.OppurtunityList objectAtIndex:appdelegate.Manageoptyrow] valueForKey:@"OPTY_CREAT_DATE"]);
         NSLog(@"CUSTOMER_ACCOUNT_ID:-%@",[[appdelegate.OppurtunityList objectAtIndex:appdelegate.Manageoptyrow] valueForKey:@"CUSTOMER_ACCOUNT_ID"]);
        self.OPTY_CREATE_DATE.text=[[appdelegate.OppurtunityList objectAtIndex:appdelegate.Manageoptyrow] valueForKey:@"OPTY_CREAT_DATE"];
       
        self.SALES_STAGE_NAME.text=[[appdelegate.OppurtunityList objectAtIndex:appdelegate.Manageoptyrow] valueForKey:@"SALE_STAGE_NAME"];
         NSLog(@"%@",self.SALES_STAGE_NAME.text);
        self.PRODUCT_NAME.text=[[appdelegate.OppurtunityList objectAtIndex:appdelegate.Manageoptyrow] valueForKey:@"PRODUCT_NAME1"];
        self.CONTACT_NAME.text=[[appdelegate.OppurtunityList objectAtIndex:appdelegate.Manageoptyrow] valueForKey:@"CONTACT_NAME"];
        self.CONTACT_CELL_NUMBER.text=[[appdelegate.OppurtunityList objectAtIndex:appdelegate.Manageoptyrow] valueForKey:@"CONTACT_CELL_NUMBER"];
        self.CONTACT_ADDRESS.text=[[appdelegate.OppurtunityList objectAtIndex:appdelegate.Manageoptyrow] valueForKey:@"CONTACT_ADDRESS"];
        self.CUSTOMER_ACCOUNT_NAME.text=[[appdelegate.OppurtunityList objectAtIndex:appdelegate.Manageoptyrow] valueForKey:@"CUSTOMER_ACCOUNT_NAME"];
        self.CUSTOMER_PHONE_NUMBER.text=[[appdelegate.OppurtunityList objectAtIndex:appdelegate.Manageoptyrow] valueForKey:@"CUSTOMER_PHONE_NUMBER"];
        
        self.LastPendingActivityStartDate.text=[[appdelegate.OppurtunityList objectAtIndex:appdelegate.Manageoptyrow] valueForKey:@"LAST_PEND_ACTIVIY_START_DATE"];
        self.LastPendingActivityType.text=[[appdelegate.OppurtunityList objectAtIndex:appdelegate.Manageoptyrow] valueForKey:@"LAST_PENDING_ACTIVITY_TYPE"];
        self.LastPendingActivityDescription.text=[[appdelegate.OppurtunityList objectAtIndex:appdelegate.Manageoptyrow] valueForKey:@"LAST_PENDING_ACTIVITY_DESC"];
        
        self.LastDoneActivitystartDate.text=[[appdelegate.OppurtunityList objectAtIndex:appdelegate.Manageoptyrow] valueForKey:@"LAST_DONE_ACTIVITY_DATE"];
        self.LastDoneActivityType.text=[[appdelegate.OppurtunityList objectAtIndex:appdelegate.Manageoptyrow] valueForKey:@"LAST_DONE_ACTIVITY_TYPE"];
        self.LastDoneActivityDescrption.text=[[appdelegate.OppurtunityList objectAtIndex:appdelegate.Manageoptyrow] valueForKey:@"LAST_DONE_ACTIVITY_DESC"];
        
        appdelegate.opty_idDetailPage=self.OPTY_ID.text;
        appdelegate.SALE_STAGE_NAME=self.SALES_STAGE_NAME.text;
        appdelegate.CUSTOMER_ACCOUNT_NAME= self.CUSTOMER_ACCOUNT_NAME.text;
        appdelegate.CUSTOMER_PHONE_NUMBER=self.CUSTOMER_PHONE_NUMBER.text;
        appdelegate.CONTACT_NAME= self.CONTACT_NAME.text;
        appdelegate.CONTACT_CELL_NUMBER=self.CONTACT_CELL_NUMBER.text;
        appdelegate.CUSTOMER_ACCOUNT_ID=[[appdelegate.OppurtunityList objectAtIndex:appdelegate.Manageoptyrow] valueForKey:@"CUSTOMER_ACCOUNT_ID"];
        
        appdelegate.PRODUCT_NAME=[[appdelegate.OppurtunityList objectAtIndex:appdelegate.Manageoptyrow] valueForKey:@"PRODUCT_NAME"];
        appdelegate.PRODUCT_NAME1=[[appdelegate.OppurtunityList objectAtIndex:appdelegate.Manageoptyrow] valueForKey:@"PRODUCT_NAME1"];
        
        appdelegate.CONTACT_ID=[[appdelegate.OppurtunityList objectAtIndex:appdelegate.Manageoptyrow] valueForKey:@"CONTACT_ID"];
        appdelegate.VC=[[appdelegate.OppurtunityList objectAtIndex:appdelegate.Manageoptyrow] valueForKey:@"VC"];

    }
    else if ([appdelegate.fromSearchOptyview isEqualToString:@"fromSearchOptyview"])
    {
        NSLog(@"fromSearchOptyview");
         NSLog(@"optyrow:%d",appdelegate.optyrow);
       
        
       
        
        self.OPTY_ID.text=[[SearchOpportunityListArray objectAtIndex:appdelegate.optyrow] valueForKey:@"OPTY_NAME"];
         appdelegate.opty_idDetailPage=self.OPTY_ID.text;
       
        
        self.OPTY_CREATE_DATE.text=[[SearchOpportunityListArray objectAtIndex:appdelegate.optyrow] valueForKey:@"OPTY_CREATED_DATE"];
        
        self.SALES_STAGE_NAME.text=[[SearchOpportunityListArray objectAtIndex:appdelegate.optyrow] valueForKey:@"SALE_STAGE_NAME"];
         appdelegate.SALE_STAGE_NAME=self.SALES_STAGE_NAME.text;
         NSLog(@"%@",self.SALES_STAGE_NAME.text);
        self.PRODUCT_NAME.text=[[SearchOpportunityListArray objectAtIndex:appdelegate.optyrow] valueForKey:@"PRODUCT_NAME1"];
        self.CONTACT_NAME.text=[[SearchOpportunityListArray objectAtIndex:appdelegate.optyrow] valueForKey:@"CONTACT_NAME"];
        self.CONTACT_CELL_NUMBER.text=[[SearchOpportunityListArray objectAtIndex:appdelegate.optyrow] valueForKey:@"CONTACT_CELL_NUMBER"];
        self.CONTACT_ADDRESS.text=[[SearchOpportunityListArray objectAtIndex:appdelegate.optyrow] valueForKey:@"CONTACT_ADDRESS"];
        self.CUSTOMER_ACCOUNT_NAME.text=[[SearchOpportunityListArray objectAtIndex:appdelegate.optyrow] valueForKey:@"CUSTOMER_ACCOUNT_NAME"];
        appdelegate.CUSTOMER_ACCOUNT_NAME= self.CUSTOMER_ACCOUNT_NAME.text;
        self.CUSTOMER_PHONE_NUMBER.text=[[SearchOpportunityListArray objectAtIndex:appdelegate.optyrow] valueForKey:@"CUSTOMER_PHONE_NUMBER"];
        appdelegate.CUSTOMER_PHONE_NUMBER=self.CUSTOMER_PHONE_NUMBER.text;
        
        self.LastPendingActivityStartDate.text=[[SearchOpportunityListArray objectAtIndex:appdelegate.optyrow] valueForKey:@"LAST_PEND_ACTIVIY_START_DATE"];
        self.LastPendingActivityType.text=[[SearchOpportunityListArray objectAtIndex:appdelegate.optyrow] valueForKey:@"LAST_PENDING_ACTIVITY_TYPE"];
        self.LastPendingActivityDescription.text=[[SearchOpportunityListArray objectAtIndex:appdelegate.optyrow] valueForKey:@"LAST_PENDING_ACTIVITY_DESC"];
        
        self.LastDoneActivitystartDate.text=[[SearchOpportunityListArray objectAtIndex:appdelegate.optyrow] valueForKey:@"LAST_DONE_ACTIVITY_DATE"];
        self.LastDoneActivityType.text=[[SearchOpportunityListArray objectAtIndex:appdelegate.optyrow] valueForKey:@"LAST_DONE_ACTIVITY_TYPE"];
        self.LastDoneActivityDescrption.text=[[SearchOpportunityListArray objectAtIndex:appdelegate.optyrow] valueForKey:@"LAST_DONE_ACTIVITY_DESC"];
        
  
        
        appdelegate.CONTACT_NAME= self.CONTACT_NAME.text;
        appdelegate.CONTACT_CELL_NUMBER=self.CONTACT_CELL_NUMBER.text;
        
        appdelegate.PRODUCT_NAME=[[SearchOpportunityListArray objectAtIndex:appdelegate.optyrow] valueForKey:@"PRODUCT_NAME"];
        appdelegate.PRODUCT_NAME1=[[SearchOpportunityListArray objectAtIndex:appdelegate.optyrow] valueForKey:@"PRODUCT_NAME1"];
        
         appdelegate.CONTACT_ID=[[SearchOpportunityListArray objectAtIndex:appdelegate.optyrow] valueForKey:@"CONTACT_ID"];
        appdelegate.CUSTOMER_ACCOUNT_ID=[[SearchOpportunityListArray objectAtIndex:appdelegate.optyrow] valueForKey:@"CUSTOMER_ACCOUNT_ID"];
         appdelegate.VC=[[SearchOpportunityListArray objectAtIndex:appdelegate.optyrow] valueForKey:@"VC"];

       
//        self.OPTY_ID.text=[[appdelegate.SearchOppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"OPTY_NAME"];
//        
//        self.OPTY_CREATE_DATE.text=[[appdelegate.SearchOppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"OPTY_CREATED_DATE"];
//        
//        self.SALES_STAGE_NAME.text=[[appdelegate.SearchOppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"SALE_STAGE_NAME"];
//        self.PRODUCT_NAME.text=[[appdelegate.SearchOppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"PRODUCT_NAME"];
//        self.CONTACT_NAME.text=[[appdelegate.SearchOppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"CONTACT_NAME"];
//        self.CONTACT_CELL_NUMBER.text=[[appdelegate.SearchOppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"CONTACT_CELL_NUMBER"];
//        self.CONTACT_ADDRESS.text=[[appdelegate.SearchOppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"CONTACT_ADDRESS"];
//        self.CUSTOMER_ACCOUNT_NAME.text=[[appdelegate.SearchOppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"CUSTOMER_ACCOUNT_NAME"];
//        self.CUSTOMER_PHONE_NUMBER.text=[[appdelegate.SearchOppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"CUSTOMER_PHONE_NUMBER"];
        
//        // LostOptyViewController *obj = [[LostOptyViewController alloc] initWithNibName:@"LostOptyViewController"];
//        UIStoryboard *mystoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
//        LostOptyViewController *obj  = [mystoryboard instantiateViewControllerWithIdentifier:@"LostOptyViewController"];
//
//        [obj setAccount_Name:self.CUSTOMER_ACCOUNT_NAME.text];
        
        
        NSLog(@"%@",[[SearchOpportunityListArray objectAtIndex:appdelegate.optyrow] valueForKey:@"PRODUCT_LINE"]);
        NSLog(@"%@",[[SearchOpportunityListArray objectAtIndex:appdelegate.optyrow] valueForKey:@"OPTY_CREATED_DATE"]);
        NSLog(@"%@",[[SearchOpportunityListArray objectAtIndex:appdelegate.optyrow] valueForKey:@"SALE_STAGE_NAME"]);
        NSLog(@"%@",[[SearchOpportunityListArray objectAtIndex:appdelegate.optyrow] valueForKey:@"PRODUCT_NAME"]);
        NSLog(@"%@",[[SearchOpportunityListArray objectAtIndex:appdelegate.optyrow] valueForKey:@"CONTACT_NAME"]);
        NSLog(@"%@",[[SearchOpportunityListArray objectAtIndex:appdelegate.optyrow] valueForKey:@"CONTACT_CELL_NUMBER"]);
        NSLog(@"%@",[[SearchOpportunityListArray objectAtIndex:appdelegate.optyrow] valueForKey:@"CONTACT_ADDRESS"]);
        NSLog(@"%@",[[SearchOpportunityListArray objectAtIndex:appdelegate.optyrow] valueForKey:@"CUSTOMER_ACCOUNT_NAME"]);
        NSLog(@"%@",[[SearchOpportunityListArray objectAtIndex:appdelegate.optyrow] valueForKey:@"CUSTOMER_PHONE_NUMBER"]);

    }
    CGFloat borderWidth = 2.0f;
    
    if ([self.SALES_STAGE_NAME.text isEqualToString:@"Closed Lost at C0"] ||[self.SALES_STAGE_NAME.text isEqualToString:@"Closed Lost at C1"] || [self.SALES_STAGE_NAME.text isEqualToString:@"Closed Lost at C1A"] || [self.SALES_STAGE_NAME.text isEqualToString:@"Closed Lost at C2"] || [self.SALES_STAGE_NAME.text isEqualToString:@"Closed Lost at C3"])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Please Note!" message:@"Your Oppurtunity is Already Marked as Lost.Cannot Perform Any Action" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
         self.UpdateBtn.enabled=NO;
         self.PendingActivitiesBtn.enabled=NO;
         self.LinkCampaignBtn.enabled=NO;
         self.MarkAsLostBtn.enabled=NO;
         self.CreateQuoteBtn.enabled=NO;
         self.NewActivityBtn.enabled=NO;
    }
    
   self.OPTYVIEWTOP.frame = CGRectInset(self.OPTYVIEWTOP.frame, -borderWidth, -borderWidth);
    self.OPTYVIEWTOP.layer.borderColor = [UIColor colorWithRed:(225/255.0) green:(225/255.0) blue:(225/255.0) alpha:1].CGColor;
    self.OPTYVIEWTOP.layer.borderWidth = borderWidth;
    
    self.CONTACTVIEW.frame = CGRectInset(self.CONTACTVIEW.frame, -borderWidth, -borderWidth);
    self.CONTACTVIEW.layer.borderColor = [UIColor colorWithRed:(225/255.0) green:(225/255.0) blue:(225/255.0) alpha:1].CGColor;
    self.CONTACTVIEW.layer.borderWidth = borderWidth;
    
    self.ACCOUNTVIEW.frame = CGRectInset(self.ACCOUNTVIEW.frame, -borderWidth, -borderWidth);
    self.ACCOUNTVIEW.layer.borderColor = [UIColor colorWithRed:(225/255.0) green:(225/255.0) blue:(225/255.0) alpha:1].CGColor;
    self.ACCOUNTVIEW.layer.borderWidth = borderWidth;
    
    
    self.ACTIVITYVIEW.frame = CGRectInset(self.ACTIVITYVIEW.frame, -borderWidth, -borderWidth);
    self.ACTIVITYVIEW.layer.borderColor = [UIColor colorWithRed:(225/255.0) green:(225/255.0) blue:(225/255.0) alpha:1].CGColor;
    self.ACTIVITYVIEW.layer.borderWidth = borderWidth;
    
    if ([self.LastDoneActivityDescrption.text isEqualToString:@""])
    {
        self.LastDoneActivityDescrption.text=@"Unavialable";
    }
   if ([self.LastDoneActivitystartDate.text isEqualToString:@""])
    {
        self.LastDoneActivitystartDate.text=@"Unavialable";
    }
     if ([self.LastDoneActivityType.text isEqualToString:@""])
    {
        self.LastDoneActivityType.text=@"Unavialable";
    }
    if ([self.LastPendingActivityDescription.text isEqualToString:@""])
    {
        self.LastPendingActivityDescription.text=@"Unavialable";
    }
  if ([self.LastPendingActivityStartDate.text isEqualToString:@""])
    {
        self.LastPendingActivityStartDate.text=@"Unavialable";
    }
     if ([self.LastPendingActivityType.text isEqualToString:@""])
    {
        self.LastPendingActivityType.text=@"Unavialable";
    }
    if ([self.CUSTOMER_ACCOUNT_NAME.text isEqualToString:@""])
    {
        self.CUSTOMER_ACCOUNT_NAME.text=@"Unavialable";
    }
    if ([self.CUSTOMER_PHONE_NUMBER.text isEqualToString:@""])
    {
        self.CUSTOMER_PHONE_NUMBER.text=@"Unavialable";
    }

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButtonItems];

    NSLog(@"... Opty Name : %@",searchOppListVar.CONTACT_NAME);
        
    
    
    
    //obj.Account_Name=self.CUSTOMER_ACCOUNT_NAME.text;
    
   
    

   
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    // [self callPendingActivityList];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(PendingActivityListFound:) name:@"PendingActivityListFound" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(LinkCampaignListFound:) name:@"LinkCampaign_Found" object:nil];//For Activity Count
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SelectLinkCampaignListFound:) name:@"SelectLinkCampaign_Found" object:nil];
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ProceedToQuoteCreationFound:) name:@"ProceedToQuoteCreation_Found" object:nil];
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showAlertView) name:@"showAlert" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(UpdateAccountValues) name:@"UpdateAccountValues" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(UpdateOppurtunityValues) name:@"UpdateOppurtunityValues" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(AfterQuoteCreationFound:) name:@"AfterQuoteCreation_Found" object:nil];
    
    
}
-(void)UpdateOppurtunityValues
{
    self.PRODUCT_NAME.text=appdelegate.PPL;
    NSLog(@"%@",self.PRODUCT_NAME.text);
    
}

-(void)UpdateAccountValues
{
    self.CUSTOMER_ACCOUNT_NAME.text=appdelegate.accountName;
    self.CUSTOMER_PHONE_NUMBER.text=appdelegate.accountPhoneNumber;
    
}

-(void)showAlertView
{
    UIAlertView *alertView = [UIAlertView new];
    alertView.title = @"Create Quote";
    alertView.delegate=self;
    alertView.tag=2;
    //alertView.dontDisppear=NO;
    
    // Adding Your Buttons
    [alertView addButtonWithTitle:@"Update Account"];
    [alertView addButtonWithTitle:@"Update Opportunity"];
    [alertView addButtonWithTitle:@"Proceed To Quote Creation"];
    [alertView addButtonWithTitle:@"Cancel"];
    
    
    
    // Add a Space for Text View
    alertView.message = @"\n";
    //    alertView.message = [NSString stringWithFormat:@"Oppurtunity Name:%@",[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"OPTY_NAME"]];
//    alertView.message = [NSString stringWithFormat: @"Oppurtunity Name: %@\n\n Product Line: %@ \n\n Contact Name: %@ \n\n Cell Number: %@ \n\n Account Name: %@ \n\n Phone Number: %@", [[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"OPTY_NAME"], [[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"PRODUCT_NAME1"],[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"CONTACT_NAME"],[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"CONTACT_CELL_NUMBER"],[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"CUSTOMER_ACCOUNT_NAME"],[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"CUSTOMER_PHONE_NUMBER"]];
    [alertView show];


}

-(void)viewWillDisappear:(BOOL)animated
{
   // appdelegate.fromManageOptyview=nil;
   // appdelegate.fromSearchOptyview=nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"PendingActivityListFound" object:nil];
     [[NSNotificationCenter defaultCenter]removeObserver:self name:@"LinkCampaign_Found" object:nil];//Abhishek // for artifact fail
    
      [[NSNotificationCenter defaultCenter]removeObserver:self name:@"SelectLinkCampaign_Found" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ProceedToQuoteCreation_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"showAlert"object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"UpdateAccountValues"object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"UpdateOppurtunityValues"object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"AfterQuoteCreation_Found"object:nil];
}
- (IBAction)MarkAsLostViewPush:(id)sender
{
    if([self.SALES_STAGE_NAME.text isEqualToString:@"C0 (Prospecting)"] || [self.SALES_STAGE_NAME.text isEqualToString:@"C1 (Quote Tendered)"] || [self.SALES_STAGE_NAME.text isEqualToString:@"C1A (Papers submitted)"])
            {
                [self performSegueWithIdentifier:@"ShowMarkAsLostOpty" sender:nil];
                
            }
     else
     {
         UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Oppurtunity Cannot be marked as lost for the given Sales Stage" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alert show];
         
     }

//    if([self.SALES_STAGE_NAME.text isEqualToString:@"Closed Lost at C1"])
//    {
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Your Oppurtunity is Already Marked as Lost" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    }
//    else{
//
//    [self performSegueWithIdentifier:@"ShowMarkAsLostOpty" sender:nil];
//    }
}
- (IBAction)NewActivityBtnClicked:(id)sender {
    
    if([self.SALES_STAGE_NAME.text isEqualToString:@"Closed Lost at C1"])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Your Oppurtunity is Already Marked as Lost" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        
//        [self performSegueWithIdentifier:@"ShowNewActivityView" sender:nil];
    }
}

- (IBAction)getPendingActivities:(id)sender
{
//    NSLog(@"%@",[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"OPTY_ID"]);
//     NSLog(@"%@",[[appdelegate.ActivityList objectAtIndex:appdelegate.optyrow] valueForKey:@"OPPTY_ROWID"]);
  
//    NSString * envelopeText = [NSString stringWithFormat:
//                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                               @"<SOAP:Body>"
//                               @"<GetListOfActivityForOpportunity xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
//                               @"<positionid>%@</positionid>"
//                               @"<activitystatus>Open</activitystatus>"
//                               @"</GetListOfActivityForOpportunity>"
//                               @"</SOAP:Body>"
//                               @"</SOAP:Envelope>",[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"OPTY_ID"]];
    if([self.SALES_STAGE_NAME.text isEqualToString:@"Closed Lost at C1"])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Your Oppurtunity is Already Marked as Lost" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
    
    NSString * envelopeText1 = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                @"<SOAP:Header xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                @"<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                                @"<Logger xmlns=\"http://schemas.cordys.com/General/1.0/\" />"
                                @"</header>"
                                @"</SOAP:Header>"
                                @"<SOAP:Body>"
                                @"<GetListOfActivityForOpportunitySFA xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                @"<activitystatus></activitystatus>"
                                @"<optyid>%@</optyid>"
                                @"</GetListOfActivityForOpportunitySFA>"
                                @"</SOAP:Body>"
                                @"</SOAP:Envelope>",appdelegate.opty_idDetailPage];
    
    NSData *envelope = [envelopeText1 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    NSLog(@"URL IS %@",theurl);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText1 length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"PendingActivityDetails_Connection"];
    }
    
}
-(void)PendingActivityListFound:(NSNotification*)notification  // Activity Response
{
    int i = 0; //for test loop
    pendingActivities_ListArr = [[NSMutableArray alloc] init];
    pendingActivities_Customer_list = [[NSMutableArray alloc] init];
    //NSArray  *array_=[[NSArray alloc] init];
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    
    NSLog(@"\n PendingActivityDetails_Connection response... %@ ",response);
    
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    
    TBXMLElement *soapBody = [TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement];
    TBXMLElement *container = [TBXML childElementNamed:@"GetListOfActivityForOpportunitySFAResponse" parentElement:soapBody];
    if(container)
    {
        TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        ///  NSLog(@"Tuple..%@",tuple);
        if (tuple)
        {
            do {
                activityPending_list = nil;
                activityPending_list = [[ActivityPendingList alloc]init];

                TBXMLElement *table  = [TBXML childElementNamed:@"S_OPTY" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                
//                TBXMLElement *X_ACTIVITY_TYPE = [TBXML childElementNamed:@"ACTIVITY_TYPE" parentElement:table];
//                //NSString *str_NAME = [TBXML textForElement:X_ACTIVITY_TYPE];
//                activityPending_list.ACTIVITY_TYPE =[TBXML textForElement:X_ACTIVITY_TYPE];
                
                //NSLog(@"OptyNAmE : %@",str_NAME);
                
                // [Activities_ListArr addObject:str_NAME];
                
                TBXMLElement *X_ACTIVITY_PLAN_START_DT = [TBXML childElementNamed:@"ACTIVITY_PLAN_START_DT" parentElement:table];
                activityPending_list.ACTIVITY_PLAN_START_DT =[TBXML textForElement:X_ACTIVITY_PLAN_START_DT];
                
                TBXMLElement *X_ACTIVITY_STATUS = [TBXML childElementNamed:@"ACTIVITY_STATUS" parentElement:table];
                activityPending_list.ACTIVITY_STATUS =[TBXML textForElement:X_ACTIVITY_STATUS];
                
                TBXMLElement *X_ACTIVITY_DESC = [TBXML childElementNamed:@"ACTIVITY_DESC" parentElement:table];
                activityPending_list.ACTIVITY_DESC =[TBXML textForElement:X_ACTIVITY_DESC];
                
                TBXMLElement *X_ACTIVITY_TYPE = [TBXML childElementNamed:@"ACTIVITY_TYPE" parentElement:table];
                activityPending_list.ACTIVITY_TYPE =[TBXML textForElement:X_ACTIVITY_TYPE];
                
                TBXMLElement *X_ACTIVITY_ID = [TBXML childElementNamed:@"ACTIVITY_ID" parentElement:table];
                activityPending_list.ACTIVITY_ID =[TBXML textForElement:X_ACTIVITY_ID];
                
                TBXMLElement *X_CONTACT_NAME = [TBXML childElementNamed:@"CONTACT_NAME" parentElement:table];
                activityPending_list.CONTACT_NAME =[TBXML textForElement:X_CONTACT_NAME];
                
                TBXMLElement *X_CONTACT_ID = [TBXML childElementNamed:@"CONTACT_ID" parentElement:table];
                activityPending_list.CONTACT_ID =[TBXML textForElement:X_CONTACT_ID];
                
                TBXMLElement *X_CONTACT_ADDRESS = [TBXML childElementNamed:@"CONTACT_ADDRESS" parentElement:table];
                activityPending_list.CONTACT_ADDRESS =[TBXML textForElement:X_CONTACT_ADDRESS];
                
                TBXMLElement *X_CONTACT_CELL_NUMBER = [TBXML childElementNamed:@"CONTACT_CELL_NUMBER" parentElement:table];
                activityPending_list.CONTACT_CELL_NUMBER =[TBXML textForElement:X_CONTACT_CELL_NUMBER];
                
                TBXMLElement *X_OPTY_ID = [TBXML childElementNamed:@"OPTY_ID" parentElement:table];
                //NSString *str_OpTyId = [TBXML textForElement:X_OPTY_ID];
                activityPending_list.OPTY_ID =[TBXML textForElement:X_OPTY_ID];
                
                NSLog(@"OptyID : %@",activityPending_list.OPTY_ID);
                TBXMLElement *X_OPTY_NAME = [TBXML childElementNamed:@"OPTY_NAME" parentElement:table];
                activityPending_list.OPTY_NAME =[TBXML textForElement:X_OPTY_NAME];
                
                TBXMLElement *X_OPTY_CREATED = [TBXML childElementNamed:@"OPTY_CREATED" parentElement:table];
                activityPending_list.OPTY_CREATED =[TBXML textForElement:X_OPTY_CREATED];
                
                TBXMLElement *X_SALES_STAGE_NAME = [TBXML childElementNamed:@"SALES_STAGE_NAME" parentElement:table];
                activityPending_list.SALES_STAGE_NAME =[TBXML textForElement:X_SALES_STAGE_NAME];
                
                TBXMLElement *X_SALE_STAGE_UPDATED_DATE = [TBXML childElementNamed:@"SALE_STAGE_UPDATED_DATE" parentElement:table];
                activityPending_list.SALE_STAGE_UPDATED_DATE =[TBXML textForElement:X_SALE_STAGE_UPDATED_DATE];
                
                TBXMLElement *X_LEAD_ASSIGNED_NAME = [TBXML childElementNamed:@"LEAD_ASSIGNED_NAME" parentElement:table];
                activityPending_list.LEAD_ASSIGNED_NAME =[TBXML textForElement:X_LEAD_ASSIGNED_NAME];
                
                TBXMLElement *X_LEAD_ASSIGNED_CELL_NUMBER = [TBXML childElementNamed:@"LEAD_ASSIGNED_CELL_NUMBER" parentElement:table];
                activityPending_list.LEAD_ASSIGNED_CELL_NUMBER =[TBXML textForElement:X_LEAD_ASSIGNED_CELL_NUMBER];
                
                TBXMLElement *X_LEAD_POSITION = [TBXML childElementNamed:@"LEAD_POSITION" parentElement:table];
                activityPending_list.LEAD_POSITION =[TBXML textForElement:X_LEAD_POSITION];
                
                TBXMLElement *X_LEAD_POSITION_ID = [TBXML childElementNamed:@"LEAD_POSITION_ID" parentElement:table];
                activityPending_list.LEAD_POSITION_ID =[TBXML textForElement:X_LEAD_POSITION_ID];
                
                TBXMLElement *X_PROSPECT_SRC = [TBXML childElementNamed:@"X_PROSPECT_SRC" parentElement:table];
                activityPending_list.X_PROSPECT_SRC =[TBXML textForElement:X_PROSPECT_SRC];

                TBXMLElement *X_RESULT_COUNT = [TBXML childElementNamed:@"RESULT_COUNT" parentElement:table];
                activityPending_list.RESULT_COUNT =[TBXML textForElement:X_RESULT_COUNT];
//
//                
                [pendingActivities_ListArr addObject:activityPending_list];
            } while ((tuple = tuple->nextSibling));
           // [self._tableView reloadData];
        }
        
        
        NSLog(@"Opty Id's 12%@",pendingActivities_ListArr);
        NSLog(@"Counter.. %lu",(unsigned long)[pendingActivities_ListArr count]);
        int counterString1=[pendingActivities_ListArr count];
        if(pendingActivities_ListArr>=0)
        {
            ActivityDetailsViewController* activityDetailViewController_VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ActivityDetailsViewController"];
            [self.navigationController pushViewController:activityDetailViewController_VC animated:YES];
       //     optyCounter.text = [NSString stringWithFormat:@"%d", counterString1];
            [self hideAlert];
            
           
        }
        else
        {
           alert = [[UIAlertView alloc] initWithTitle:@"ALERT"
                                                            message:@"There are no pending Activities"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];

        
        }
    }
    
}

//Abhishek

-(void)LinkCampaignListFound:(NSNotification*)notification  // Activity Response
{
    
    [self hideAlert]; //Abhishek
    
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    
    NSLog(@"\n PendingActivityDetails_Connection response... %@ ",response);
    NSError *err;
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    
    TBXMLElement *soapBody = [TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement];
    TBXMLElement *container = [TBXML childElementNamed:@"GetCampainDetailsForDSMResponse" parentElement:soapBody];
    if(container)
    {
        self.LinkCampaignList=[[NSMutableArray alloc]init];
        TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        ///  NSLog(@"Tuple..%@",tuple);
        if (tuple)
        {
            do {
                activityPending_list = nil;
               LinkCampaignListView *LinkCampaign_list = [[LinkCampaignListView alloc]init];
                
                TBXMLElement *S_SRC  = [TBXML childElementNamed:@"S_SRC" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                
                TBXMLElement *CAM_NAME = [TBXML childElementNamed:@"CAM_NAME" parentElement:S_SRC];
                LinkCampaign_list.CAM_NAME=[TBXML textForElement:CAM_NAME];
                
                TBXMLElement *CAM_ID = [TBXML childElementNamed:@"CAM_ID" parentElement:S_SRC];
                 LinkCampaign_list.CAM_ID=[TBXML textForElement:CAM_ID];
                
                TBXMLElement *CAMPAIGN_DESCRIPTION = [TBXML childElementNamed:@"CAMPAIGN_DESCRIPTION" parentElement:S_SRC];
                  LinkCampaign_list.CAMPAIGN_DESCRIPTION=[TBXML textForElement:CAMPAIGN_DESCRIPTION];
   
                [self.LinkCampaignList addObject:LinkCampaign_list];
            } while ((tuple = tuple->nextSibling));
            // [self._tableView reloadData];
        }
        
        
        NSLog(@"Opty Id's 12%@",self.LinkCampaignList);
        NSLog(@"Counter.. %lu",(unsigned long)[self.LinkCampaignList count]);
        int counterString1=[self.LinkCampaignList count];
        if(counterString1>=0)
        {
           
            
            CGRect toolbarTargetFrame = CGRectMake(200, self.view.bounds.size.height-250-44, 320, 44);
            CGRect datePickerTargetFrame = CGRectMake(200, self.view.bounds.size.height-250, 320, 316);
            
            UIView *darkView = [[UIView alloc] initWithFrame:self.view.bounds];
            darkView.alpha = 0;
            darkView.backgroundColor = [UIColor whiteColor];
            darkView.tag = 9;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDatePicker:)];
            [darkView addGestureRecognizer:tapGesture];
            [self.view addSubview:darkView];
            
            UIPickerView *pickerView=[[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height+44, 0, 216)];
            pickerView.tag = 10;
            pickerView.dataSource = self;
            pickerView.delegate = self;
            pickerView.backgroundColor=[UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:0.8];
            // [pickerView addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
            [self.view addSubview:pickerView];
            UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 44)] ;
            toolBar.tag = 11;
            toolBar.barStyle = UIBarStyleBlackTranslucent;
            
            //     UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithTitle:@"Recent" style:UIBarButtonItemStyleBordered target:self action:@selector(backToRecent)];
            
            
            UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(CancelButtonClicked:)];
            UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] ;
            UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone  target:self action:@selector(DoneButtonClicked:)];
            
            
            [toolBar setItems:[NSArray arrayWithObjects:cancel,spacer, saveButton, nil]];
            [self.view addSubview:toolBar];
            
            
            
            [UIView beginAnimations:@"MoveIn" context:nil];
            toolBar.frame = toolbarTargetFrame;
            // datePicker.frame = datePickerTargetFrame;
            pickerView.frame = datePickerTargetFrame;
            darkView.alpha = 0.5;
            [UIView commitAnimations];
            

        
        }
        else
        {
            alert = [[UIAlertView alloc] initWithTitle:@"ALERT"
                                               message:@"There are no pending Activities"
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil];
            [alert show];
            
            
        }
    }
    
}

-(void)SelectLinkCampaignListFound:(NSNotification*)notification  // Activity Response
{
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    
    NSLog(@"\n Select_link_Campaign_Connection response... %@ ",response);
    
    
   NSError *err;
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
//    
    TBXMLElement *soapBody = [TBXML childElementNamed:@"soapenv:Body" parentElement:tbxml.rootXMLElement];
    TBXMLElement *container = [TBXML childElementNamed:@"ns:SFATMCVContactInsertOrUpdate_Output" parentElement:soapBody];
    if(container)
    {
    
        TBXMLElement *ListOfContactInterface =[TBXML childElementNamed:@"ListOfContactInterface" parentElement:container];
        
        TBXMLElement *Contact  = [TBXML childElementNamed:@"Contact" parentElement:ListOfContactInterface];
        
        TBXMLElement *IntegrationId  = [TBXML childElementNamed:@"IntegrationId" parentElement:Contact];
        
        if ([TBXML textForElement:IntegrationId])
        {
            alert = [[UIAlertView alloc] initWithTitle:@"Campaign has been linked successfully"
                                               message:nil
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil];
            [alert show];
            
        }
    }
}

//- (IBAction)LinkCampaign:(id)sender
//{
//    
//    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self     cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
//    self.actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
//    
//    
//    self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,40, 320, 216)];
//     self.picker .showsSelectionIndicator=YES;
//     self.picker .dataSource = self;
//     self.picker .delegate = self;
//     self.picker .tag=@"SelectedDropDown";
//    [self.actionSheet addSubview: self.picker ];
//    
//    UIToolbar *tools=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0,320,40)];
//    tools.barStyle=UIBarStyleBlackOpaque;
//    [self.actionSheet addSubview:tools];
//   
//    
//    
//    UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(btnActinDoneClicked)];
//    doneButton.imageInsets=UIEdgeInsetsMake(200, 6, 50, 25);
//    UIBarButtonItem *flexSpace= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    
//    NSArray *array = [[NSArray alloc]initWithObjects:flexSpace,doneButton,nil];
//    
//    [tools setItems:array];
//    
//    
//    //picker title
//    UILabel *lblPickerTitle=[[UILabel alloc]initWithFrame:CGRectMake(60,8, 200, 25)];
//    lblPickerTitle.text=@"Campaign List";
//    lblPickerTitle.backgroundColor=[UIColor clearColor];
//    lblPickerTitle.textColor=[UIColor whiteColor];
//    lblPickerTitle.textAlignment=NSTextAlignmentCenter;
//    lblPickerTitle.font=[UIFont boldSystemFontOfSize:15];
//    [tools addSubview:lblPickerTitle];
//    
//    
//    [self.actionSheet showFromRect:CGRectMake(0,480, 320,215) inView:self.view animated:YES];
//   // [self.actionSheet setBounds:CGRectMake(0,0, 320, 411)];
//   
//    
//    
//}
-(void)showAlert
{
[MBProgressHUD showHUDAddedLoading:self.view animated:YES];
            
}
-(void)hideAlert
{
[MBProgressHUD hideHUDForView:self.view animated:YES];
            
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)info_btn
{
    //  NSLog(@"Home biscuit from Sanfrancisco");
}
-(void)logOut_btn
{
    // flag=true;
    alert = [[UIAlertView alloc] initWithTitle:@"DSE"
                                       message:@"Do you want to Log out"
                                      delegate:self
                             cancelButtonTitle:@"No"
                             otherButtonTitles:@"Yes",nil];
    [alert show];
    NSLog(@"Home biscuit from Sanfrancisco");
}
// delegate mehod for uialertView

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button Index =%ld",(long)buttonIndex);
    
    if (alertView.tag==1)
    {
        if (buttonIndex == 0)
        {
            
            NSLog(@"David Miller");
        }
    }
    else{
    if (buttonIndex == 0) {
        
        NSLog(@"David Miller");
    }
    if (buttonIndex==1) {
        NSLog(@"Glen Maxwell");
        LoginViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        //[self.navigationController pushViewController:secondViewController animated:YES];
        [self presentViewController:secondViewController animated:YES completion:nil ];
        //  [self.navigationController popToRootViewControllerAnimated:TRUE];
        //  [self dismissViewControllerAnimated:YES completion:nil];
        //  [self.parentViewController.navigationController popToRootViewControllerAnimated:YES];
        //  [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
    }
}


- (IBAction)linkcampaign:(id)sender {
    
    if([self.SALES_STAGE_NAME.text isEqualToString:@"Closed Lost at C1"])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Your Oppurtunity is Already Marked as Lost" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
   
        [self showAlert];//Abhishek
        
      NSString * envelopeText1 = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
    @"<SOAP:Header xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
    @"<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"
    @"<Logger xmlns=\"http://schemas.cordys.com/General/1.0/\">"
    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/testtool/testtool.caf</DC>"
    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/methodsetsmanager/methodsetexplorer.caf</DC>"
    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/sysresourcemgr/sysresourcemgr.caf</DC>"
    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/com/cordys/cusp/cusp.caf</DC>"
    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"hopCount\">0</DC>"
    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"correlationID\">537eee51-e5ce-11e4-e9d9-0e3a750e9f9e</DC>"
    @"</Logger>"
    @"</header>"
    @"</SOAP:Header>"
    @"<SOAP:Body>"
    @"<GetCampainDetailsForDSM xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
    @"<plname>207</plname>"
     @"</GetCampainDetailsForDSM>"];
    
    NSString * envelopeText2 = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
    @"<SOAP:Body>"
    @"<GetCampainDetailsForDSM xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
    @"<plname>Sumo Victa GX DI</plname>"
    @"</GetCampainDetailsForDSM>"
    @"</SOAP:Body>"
    @"</SOAP:Envelope>"];
    
    
//    <SOAP:Envelope xmlns:SOAP="http://schemas.xmlsoap.org/soap/envelope/">
//    <SOAP:Body>
//    <GetCampainDetailsForDSM xmlns="com.cordys.tatamotors.Dsmsiebelwsapp" preserveSpace="no" qAccess="0" qValues="">
//    <plname>207</plname>
//    </GetCampainDetailsForDSM>
//    </SOAP:Body>
//    </SOAP:Envelope>
//    <data>
//    <GetCampainDetailsForDSMResponse xmlns:SOAP="http://schemas.xmlsoap.org/soap/envelope/" xmlns="com.cordys.tatamotors.Dsmsiebelwsapp" preserveSpace="no" qAccess="0">
//    <tuple xmlns="com.cordys.tatamotors.Dsmsiebelwsapp">
//    <old>
//    <S_SRC xmlns="com.cordys.tatamotors.Dsmsiebelwsapp">
//    <CAM_NAME>AFP CONSTRUCTION</CAM_NAME>
//    <CAM_ID>1-79EPBW3</CAM_ID>
//    <CAMPAIGN_DESCRIPTION null="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:nil="true" />
//    </S_SRC>
//    </old>
//    </tuple>
//    </GetCampainDetailsForDSMResponse>
//    </data>
    
    //[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"PRODUCT_NAME"]
    NSData *envelope = [envelopeText2 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    NSLog(@"URL IS %@",theurl);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText1 length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    [[RequestDelegate alloc]initiateRequest:request name:@"Linkcampaign_Connection"];
  
    }
    
    
}

- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.LinkCampaignList count];
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.LinkCampaignList[row] valueForKey:@"CAM_NAME"];
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
  
   self.selectedLinkCampaignValue= [NSString stringWithFormat:@"%@", [[self.LinkCampaignList objectAtIndex:row] valueForKey:@"CAM_ID"]];
   NSLog(@"%@", self.selectedLinkCampaignValue);
    
    
    
}
- (IBAction)UpdateOppurtunity:(id)sender
{
   if([self.SALES_STAGE_NAME.text isEqualToString:@"Closed Lost at C1"])
   {
       UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Your Oppurtunity is Already Marked as Lost" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
       [alert show];
   }
   else{
    appdelegate.fromCreatequote=nil;
    [self performSegueWithIdentifier:@"UpdateOppurtunity" sender:nil];
   }
}

- (IBAction)createQuote:(id)sender
{
    if([self.SALES_STAGE_NAME.text isEqualToString:@"Closed Lost at C1"])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Your Oppurtunity is Already Marked as Lost" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
    appdelegate.fromCreatequote=@"fromCreatequote";

  UIAlertView *alertView = [UIAlertView new];
    alertView.title = @"Create Quote";
    alertView.delegate=self;
    alertView.tag=1;
    //alertView.dontDisppear=NO;
    
    // Adding Your Buttons
    [alertView addButtonWithTitle:@"Update Account"];
    [alertView addButtonWithTitle:@"Update Opportunity"];
    [alertView addButtonWithTitle:@"Proceed To Quote Creation"];
     [alertView addButtonWithTitle:@"Cancel"];
    
    
    
    // Add a Space for Text View
    alertView.message = @"\n";
    //    alertView.message = [NSString stringWithFormat:@"Oppurtunity Name:%@",[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"OPTY_NAME"]];
//    alertView.message = [NSString stringWithFormat: @"Oppurtunity Name: %@\n\n Product Line: %@ \n\n Contact Name: %@ \n\n Cell Number: %@ \n\n Account Name: %@ \n\n Phone Number: %@", [[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"OPTY_NAME"], [[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"PRODUCT_NAME1"],[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"CONTACT_NAME"],[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"CONTACT_CELL_NUMBER"],[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"CUSTOMER_ACCOUNT_NAME"],[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"CUSTOMER_PHONE_NUMBER"]];
    
    
    
    
    // Set the frame
//    CGRect frame = alertView.frame;
//    frame.origin.y -= 100.0f;
//    alertView.frame = frame;
//    
//    
//    // Adding TextField
//    UITextField* text = [[UITextField alloc] initWithFrame:CGRectMake(20.0, 45.0, 245.0, 25.0)];
//    text.borderStyle = UITextBorderStyleRoundedRect;
//    [alertView addSubview:text];
    [alertView show];


//    UIAlertView *alertView = [UIAlertView new];
//    alertView.title = @"Quote Details";
//    alertView.delegate=self;
//    alertView.tag=1;
//    
//    // Adding Your Buttons
//    [alertView addButtonWithTitle:@"Update Opportunity"];
//    [alertView addButtonWithTitle:@"Update Account"];
//    [alertView addButtonWithTitle:@"Proceed To Quote Creation"];
//    
//    
//    
//    // Add a Space for Text View
//    alertView.message = @"\n\n\n\n";
////    alertView.message = [NSString stringWithFormat:@"Oppurtunity Name:%@",[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"OPTY_NAME"]];
//    alertView.message = [NSString stringWithFormat: @"Oppurtunity Name: %@\n\n Product Line: %@ \n\n Contact Name: %@ \n\n Cell Number: %@ \n\n Account Name: %@ \n\n Phone Number: %@", [[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"OPTY_NAME"], [[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"PRODUCT_NAME1"],[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"CONTACT_NAME"],[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"CONTACT_CELL_NUMBER"],[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"CUSTOMER_ACCOUNT_NAME"],[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"CUSTOMER_PHONE_NUMBER"]];
//
//    
//    
//    
//    // Set the frame
//    CGRect frame = alertView.frame;
//    frame.origin.y -= 100.0f;
//    alertView.frame = frame;
//    
//    
//    // Adding TextField
//    UITextField* text = [[UITextField alloc] initWithFrame:CGRectMake(20.0, 45.0, 245.0, 25.0)];
//    text.borderStyle = UITextBorderStyleRoundedRect;
//    [alertView addSubview:text];
//   [alertView show];
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex

{
    if (alertView.tag==1)
    {
        if (buttonIndex == 0)
            
        {
            [self performSegueWithIdentifier:@"Create Account" sender:nil];
        }
        else if (buttonIndex == 1)
        {
            [self performSegueWithIdentifier:@"UpdateOpty" sender:nil];
        }
        else if (buttonIndex == 2)
        {
            [self proceedToQuoteCreation];
        }
    }
    else if (alertView.tag==2)
    {
        if (buttonIndex == 0)
            
        {
            [self performSegueWithIdentifier:@"Create Account" sender:nil];
            
            
        }
        else if (buttonIndex == 1)
        {
            [self performSegueWithIdentifier:@"UpdateOpty" sender:nil];
        }
        
        else if (buttonIndex == 2)
        {
            [self proceedToQuoteCreation];
        }
    }
    else if (buttonIndex == 1)
    {
//        [self performSegueWithIdentifier:@"UpdateOpty" sender:nil];
    }
    else if (buttonIndex == 2)
    {
        [self proceedToQuoteCreation];
    }
   // }
   
   // }
}

-(void)proceedToQuoteCreation
{
    
    [self showAlert];//Abhishek
    
    
//    
//    "<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//    +"<SOAP:Body>"
//    +"<SFATMCVQuoteInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
//    +"<ListOfQuoteInterface xmlns=\"http://www.siebel.com/xml/Quote%20Interface\">"
//    +"<Quote operation=\"insert\">"
//    +"<IntegrationId>"+date+"</IntegrationId>"
//    +"<ContactId>"+contactId+"</ContactId>"
//    +"<OpportunityId>"+id+"</OpportunityId>"
//    +"<TMParentProductLine>"+ppl+"</TMParentProductLine>"
//    +"<TMProductLine>"+pl+"</TMProductLine>"
//    +"<SalesRepLogin>"+username+"</SalesRepLogin>"
//    +"<SalesRepPosition>"+positionName+"</SalesRepPosition>"
//    +"<SalesRepPositionId>"+positionId+"</SalesRepPositionId>"
//    +"<ListOfRelatedOrganization>"
//    +"<RelatedOrganization IsPrimaryMVG=\"Y\">"
//    +"<Organization>"+orgName+"</Organization>"
//    +"</RelatedOrganization>"
//    +"</ListOfRelatedOrganization>"
//    +"<ListOfLineItems>"
//    +"<LineItems>"
//    +"<ProductType>"+"Vehicle"+"</ProductType>"
//    +"<IntegrationId>"+date+"</IntegrationId>"
//    +"<ProductName>"+name+"</ProductName>"
//    +"<RequestedQuantity>"+1+"</RequestedQuantity>"
//    +"<ProductVCNo>"+name+"</ProductVCNo>"
//    +"</LineItems>"
//    +"</ListOfLineItems>"
//    +"<ListOfQuote_SalesTeam>"
//    +"<Quote_SalesTeam IsPrimaryMVG=\"Y\">"
//    +"<SalesTeam>"+username+"</SalesTeam>"
//    +"<Name>"+positionName+"</Name>"
//    +"</Quote_SalesTeam>"
//    +"</ListOfQuote_SalesTeam>"
//    +"</Quote>"
//    +"</ListOfQuoteInterface>"
//    +"</SFATMCVQuoteInsertOrUpdate_Input>"
//    +"</SOAP:Body>"
//    +"</SOAP:Envelope>"
    
    NSLog(@"%@",userDetailsVal_.Login_Name);
    
   /* NSString * envelopeText1 = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
    "<SOAP:Body>"
    "<SFATMCVQuoteInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
    "<ListOfQuoteInterface xmlns=\"http://www.siebel.com/xml/Quote%%20Interface\">"
    "<Quote operation=\"insert\">"
    "<IntegrationId>%ld</IntegrationId>"
                                
    "<ContactId>%@</ContactId>"
                                
    "<OpportunityId>%@</OpportunityId>"
                                
    "<TMParentProductLine>%@</TMParentProductLine>"
                                
    "<TMProductLine>%@</TMProductLine>"
                                
    "<SalesRepLogin>%@</SalesRepLogin>"
                                
    "<SalesRepPosition>%@</SalesRepPosition>"
                                
    "<SalesRepPositionId>%@</SalesRepPositionId>"
    "<ListOfRelatedOrganization>"
    "<RelatedOrganization IsPrimaryMVG=\"Y\">"
    "<Organization>%@</Organization>"
    "</RelatedOrganization>"
    "</ListOfRelatedOrganization>"
    "<ListOfLineItems>"
    "<LineItems>"
    "<ProductType>Vehicle</ProductType>"
    "<IntegrationId>%ld</IntegrationId>"
    "<ProductName>%@</ProductName>"
    "<RequestedQuantity>1</RequestedQuantity>"
    "<ProductVCNo>%@</ProductVCNo>"
    "</LineItems>"
    "</ListOfLineItems>"
    "<ListOfQuote_SalesTeam>"
    "<Quote_SalesTeam IsPrimaryMVG=\"Y\">"
    "<SalesTeam>%@</SalesTeam>"
    "<Name>%@</Name>"
    "</Quote_SalesTeam>"
    "</ListOfQuote_SalesTeam>"
    "</Quote>"
    "</ListOfQuoteInterface>"
    "</SFATMCVQuoteInsertOrUpdate_Input>"
    "</SOAP:Body>"
                                "</SOAP:Envelope>",(long)[[NSDate date]timeIntervalSince1970],
                                [[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"CONTACT_ID"],
                                [[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"OPTY_ID"],
                                [[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"PRODUCT_NAME"],
                                [[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"PRODUCT_NAME1"],
                                userDetailsVal_.Login_Name,
                                userDetailsVal_.POSITION_NAME,
                                userDetailsVal_.ROW_ID,
                                userDetailsVal_.ORGNAME,
                                (long)[[NSDate date]timeIntervalSince1970],
                                [[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"VC"],
                                [[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"VC"],
                                userDetailsVal_.Login_Name ,
                                userDetailsVal_.POSITION_NAME];*/
 
    
    
    NSString * envelopeText1 = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                "<SOAP:Body>"
                                "<SFATMCVQuoteInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                                "<ListOfQuoteInterface xmlns=\"http://www.siebel.com/xml/Quote%%20Interface\">"
                                "<Quote operation=\"insert\">"
                                "<IntegrationId>%ld</IntegrationId>"
                                
                                "<ContactId>%@</ContactId>"
                                
                                "<OpportunityId>%@</OpportunityId>"
                                
                                "<TMParentProductLine>%@</TMParentProductLine>"
                                
                                "<TMProductLine>%@</TMProductLine>"
                                
                                "<SalesRepLogin>%@</SalesRepLogin>"
                                
                                "<SalesRepPosition>%@</SalesRepPosition>"
                                
                                "<SalesRepPositionId>%@</SalesRepPositionId>"
                                "<ListOfRelatedOrganization>"
                                "<RelatedOrganization IsPrimaryMVG=\"Y\">"
                                "<Organization>%@</Organization>"
                                "</RelatedOrganization>"
                                "</ListOfRelatedOrganization>"
                                "<ListOfLineItems>"
                                "<LineItems>"
                                "<ProductType>Vehicle</ProductType>"
                                "<IntegrationId>%ld</IntegrationId>"
                                "<ProductName>%@</ProductName>"
                                "<RequestedQuantity>1</RequestedQuantity>"
                                "<ProductVCNo>%@</ProductVCNo>"
                                "</LineItems>"
                                "</ListOfLineItems>"
                                "<ListOfQuote_SalesTeam>"
                                "<Quote_SalesTeam IsPrimaryMVG=\"Y\">"
                                "<SalesTeam>%@</SalesTeam>"
                                "<Name>%@</Name>"
                                "</Quote_SalesTeam>"
                                "</ListOfQuote_SalesTeam>"
                                "</Quote>"
                                "</ListOfQuoteInterface>"
                                "</SFATMCVQuoteInsertOrUpdate_Input>"
                                "</SOAP:Body>"
                                "</SOAP:Envelope>",(long)[[NSDate date]timeIntervalSince1970],
                                appdelegate.CONTACT_ID,
                                appdelegate.opty_idDetailPage,
                                appdelegate.PRODUCT_NAME,
                               appdelegate.PRODUCT_NAME1,
                                userDetailsVal_.Login_Name,
                                userDetailsVal_.POSITION_NAME,
                                userDetailsVal_.ROW_ID,
                                userDetailsVal_.ORGNAME,
                                (long)[[NSDate date]timeIntervalSince1970],
                               appdelegate.VC,
                               appdelegate.VC,
                                userDetailsVal_.Login_Name ,
                                userDetailsVal_.POSITION_NAME];

    
    /*  NSString * envelopeText1 = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                @"<SOAP:Body>"
                                @"<SFATMCVQuoteInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                                @"<ListOfQuoteInterface xmlns=\"http://www.siebel.com/xml/Quote%%20Interface\">"
                                @"<Quote operation=\"insert\">"
                                @"<IntegrationId>%ld</IntegrationId>"
                                @"<ContactId>%@</ContactId>"
                                @"<OpportunityId>%@</OpportunityId>"
                                @"<TMParentProductLine>%@</TMParentProductLine>"
                                @"<TMProductLine>%@</TMProductLine>"
                                @"<SalesRepLogin>%@</SalesRepLogin>"
                                @"<SalesRepPosition>%@</SalesRepPosition>"
                                @"<SalesRepPositionId>%@</SalesRepPositionId>"
                                @"<ListOfRelatedOrganization>"
                                @"<RelatedOrganization IsPrimaryMVG=\"Y\">"
                                @"<Organization>%@</Organization>"
                                @"</RelatedOrganization>"
                                @"</ListOfRelatedOrganization>"
                                @"<ListOfLineItems>"
                                @"<LineItems>"
                                @"<ProductType>Vehicle</ProductType>"
                                @"<IntegrationId>%ld</IntegrationId>"
                                @"<ProductName>26526327000R</ProductName>"
                                @"<RequestedQuantity>1</RequestedQuantity>"
                                @"<ProductVCNo>26526327000R</ProductVCNo>"
                                @"</LineItems>"
                                @"</ListOfLineItems>"
                                @"<ListOfQuote_SalesTeam>"
                                @"<Quote_SalesTeam IsPrimaryMVG=\"Y\">"
                                @"<SalesTeam>%@</SalesTeam>"
                                @"<Name>%@</Name>"
                                @"</Quote_SalesTeam>"
                                @"</ListOfQuote_SalesTeam>"
                                @"</Quote>"
                                @"</ListOfQuoteInterface>"
                                @"</SFATMCVQuoteInsertOrUpdate_Input>"
                                @"</SOAP:Body>"
                                @"</SOAP:Envelope>",(long)[[NSDate date]timeIntervalSince1970],[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"CONTACT_ID"],[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"OPTY_ID"],[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"PRODUCT_NAME"],[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"PRODUCT_NAME1"],userDetailsVal_.Login_Name, userDetailsVal_.POSTN, userDetailsVal_.ROW_ID,userDetailsVal_.ORGNAME,(long)[[NSDate date]timeIntervalSince1970],userDetailsVal_.Login_Name ,userDetailsVal_.POSITION_NAME
                                ];*/
 
//    NSString * envelopeText1 = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//    @"<SOAP:Body>"
//    @"<SFATMCVQuoteInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
//    @"<ListOfQuoteInterface xmlns=\"http://www.siebel.com/xml/Quote%%20Interface\">"
//    @"<Quote operation=\"insert\">"
//    @"<IntegrationId>%ld</IntegrationId>"
//    @"<ContactId>%@</ContactId>"
//    @"<OpportunityId>%@</OpportunityId>"
//    @"<TMParentProductLine>%@</TMParentProductLine>"
//    @"<TMProductLine>%@</TMProductLine>"
//    @"<SalesRepLogin>%@</SalesRepLogin>"
//    @"<SalesRepPosition>%@</SalesRepPosition>"
//    @"<SalesRepPositionId>%@</SalesRepPositionId>"
//    @"<ListOfRelatedOrganization>"
//    @"<RelatedOrganization IsPrimaryMVG=\"Y\">"
//    @"<Organization>%@</Organization>"
//    @"</RelatedOrganization>"
//    @"</ListOfRelatedOrganization>"
//    @"<ListOfLineItems>"
//    @"<LineItems>"
//    @"<ProductType>Vehicle</ProductType>"
//    @"<IntegrationId>%ld</IntegrationId>"
//    @"<ProductName>%@</ProductName>"
//    @"<RequestedQuantity>1</RequestedQuantity>"
//    @"<ProductVCNo>%@</ProductVCNo>"
//    @"</LineItems>"
//    @"</ListOfLineItems>"
//    @"<ListOfQuote_SalesTeam>"
//    @"<Quote_SalesTeam IsPrimaryMVG=\"Y\">"
//    @"<SalesTeam>%@</SalesTeam>"
//    @"<Name>%@</Name>"
//    @"</Quote_SalesTeam>"
//    @"</ListOfQuote_SalesTeam>"
//    @"</Quote>"
//    @"</ListOfQuoteInterface>"
//    @"</SFATMCVQuoteInsertOrUpdate_Input>"
//    @"</SOAP:Body>"
//    @"</SOAP:Envelope>",(long)[[NSDate date]timeIntervalSince1970],[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"CONTACT_ID"],[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"OPTY_ID"],[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"PARENT_PROD_LINE"],[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"PRODUCT_LINE"],userDetailsVal_.Login_Name, userDetailsVal_.POSTN, userDetailsVal_.ROW_ID,userDetailsVal_.ORGNAME,(long)[[NSDate date]timeIntervalSince1970],[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"PRODUCT_NAME"],[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"VC"],userDetailsVal_.Login_Name ,userDetailsVal_.POSITION_NAME
//                               ];
//
//
    NSData *envelope = [envelopeText1 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    NSLog(@"URL IS %@",theurl);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText1 length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"ProceedToQuoteCreation_Connection"];



}


-(void)ProceedToQuoteCreationFound:(NSNotification*)notification
{

    [self hideAlert];//Abhishek
    
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    
    NSLog(@"\n ProceedTo_Quote_Creation_Connection response... %@ ",response);
    NSError *err;
    
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Something gone wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    else{
    
    TBXMLElement *soapBody = [TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement];
    TBXMLElement *container = [TBXML childElementNamed:@"ns:SFATMCVQuoteInsertOrUpdate_Output" parentElement:soapBody];
    if(container)
    {
        TBXMLElement *ListOfQuoteInterface =[TBXML childElementNamed:@"ListOfQuoteInterface" parentElement:container];
        TBXMLElement *Quote =[TBXML childElementNamed:@"Quote" parentElement:ListOfQuoteInterface];
        if(Quote)
        {
            //container = [TBXML childElementNamed:@"S_USER" parentElement:[TBXML childElementNamed:@"old" parentElement:Contact]];
            TBXMLElement *ListOfPersonalAddress = [TBXML childElementNamed:@"Id" parentElement:Quote];
            TBXMLElement *IntegrationId = [TBXML childElementNamed:@"IntegrationId" parentElement:Quote];
             NSString * IntegrationIdstring = [TBXML textForElement:IntegrationId];
           
            if (IntegrationIdstring)
            {
//                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Done" message:@"Quote Generation has been Successfull" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                [alert show];
                
               NSString * envelopeText1 = [NSString stringWithFormat: @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                 @"<SOAP:Body>"
                 @"<SFATMCVOPTYInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                 @"<ListOfTMOpportunityInterface xmlns=\"http://www.siebel.com/xml/TM%%20Opportunity%%20Interface\">"
                 @"<Opportunity>"
                 @"<Id>%@</Id>"
                 @"<SalesStage>C1 (Quote Tendered)</SalesStage>"
                 @"</Opportunity>"
                 @"</ListOfTMOpportunityInterface>"
                 @"</SFATMCVOPTYInsertOrUpdate_Input>"
                 @"</SOAP:Body>"
                 @"</SOAP:Envelope>",appdelegate.opty_idDetailPage];
                
                
                NSData *envelope = [envelopeText1 dataUsingEncoding:NSUTF8StringEncoding];
                
                NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
                NSLog(@"URL IS %@",theurl);
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
                NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText1 length]];
                [request setHTTPMethod:@"POST"];
                [request setHTTPBody:envelope];
                [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
                [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
                
                [[RequestDelegate alloc]initiateRequest:request name:@"AfterQuoteCreation_Connection"];
            
            }
            else  if (!IntegrationIdstring)
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Quote not Generated" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            
            
        }
        else
        {
            // [appdelegate hideAlert];
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Server Error!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
    }
    else
    {
        // [appdelegate hideAlert];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Server Error!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    }
    
  

}

-(void)AfterQuoteCreationFound:(NSNotification*)notification
{
    
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    
    NSLog(@"\n AfterQuoteCreationFoundConnection response... %@ ",response);
    NSError *err;
    
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Something gone wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    else{
    
    TBXMLElement *soapBody = [TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement];
    TBXMLElement *container = [TBXML childElementNamed:@"ns:SFATMCVOPTYInsertOrUpdate_Output" parentElement:soapBody];
    if(container)
    {
        TBXMLElement *ListOfTMOpportunityInterface =[TBXML childElementNamed:@"ListOfTMOpportunityInterface" parentElement:container];
        TBXMLElement *Opportunity =[TBXML childElementNamed:@"Opportunity" parentElement:ListOfTMOpportunityInterface];
        if(Opportunity)
        {
            TBXMLElement *IntegrationId = [TBXML childElementNamed:@"IntegrationId" parentElement:Opportunity];
            TBXMLElement *Id = [TBXML childElementNamed:@"Id" parentElement:Opportunity];
            NSString * IntegrationIdstring = [TBXML textForElement:IntegrationId];
            
            if (IntegrationIdstring)
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Done" message:@"Quote Generation has been Successfull" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                self.SALES_STAGE_NAME.text=@"C1(Quote Tendered)";
            }

        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Error While Generating Quote" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    }
}
- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    [alertView close];
}

- (UIView *)createDemoView
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 200)];
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    label1.text=@"hello";
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 270, 180)];
    imageView.backgroundColor=[UIColor blueColor];
   // [imageView setImage:[UIImage imageNamed:@"demo"]];
    [demoView addSubview:imageView];
    
    return demoView;
}

- (void)CancelButtonClicked:(id)sender {
     self.LinkCampaignList=nil;
    CGRect toolbarTargetFrame = CGRectMake(0, self.view.bounds.size.height, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height+44, 320, 216);
    [UIView beginAnimations:@"MoveOut" context:nil];
    [self.view viewWithTag:9].alpha = 0;
    [self.view viewWithTag:10].frame = datePickerTargetFrame;
    [self.view viewWithTag:11].frame = toolbarTargetFrame;
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeViews:)];
    [UIView commitAnimations];
}

- (void)DoneButtonClicked:(id)sender {
    
    if ([self.selectedLinkCampaignValue isEqualToString:@" "]) {
        
    }
    else
    {
  /*  NSString * envelopeText1 = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:asi=\"http://siebel.com/asi/\" xmlns:con=\"http://www.siebel.com/xml/Contact%20Interface\">"
    @"<soapenv:Header/>"
    @"<soapenv:Body>"
    @"<asi:SFATMCVContactInsertOrUpdate_Input>"
    @"<con:ListOfContactInterface>"
    @"<con:Contact operation=\"?\">"
    @"<con:Id>%@</con:Id>"
    @"<con:ListOfOpportunity>"
    @"<con:Opportunity operation=\"?\">"
    @"<con:Id>%@</con:Id>"
    @"<con:ListOfOpportunityRelatedCampaigns>"
    @"<con:OpportunityRelatedCampaigns operation=\"Insert\">"
    @"<con:Id>%@</con:Id>"
    @"</con:OpportunityRelatedCampaigns>"
    @"</con:ListOfOpportunityRelatedCampaigns>"
    @"</con:Opportunity>"
    @"</con:ListOfOpportunity>"
    @"</con:Contact>"
    @"</con:ListOfContactInterface>"
    @"<asi:StatusObject>?</asi:StatusObject>"
    @"</asi:SFATMCVContactInsertOrUpdate_Input>"
    @"</soapenv:Body>"
                                @"</soapenv:Envelope>",[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"CONTACT_ID"],[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"OPTY_ID"],self.selectedLinkCampaignValue];*/
        
        NSString * envelopeText1 = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:asi=\"http://siebel.com/asi/\" xmlns:con=\"http://www.siebel.com/xml/Contact%20Interface\">"
                                    @"<soapenv:Header/>"
                                    @"<soapenv:Body>"
                                    @"<asi:SFATMCVContactInsertOrUpdate_Input>"
                                    @"<con:ListOfContactInterface>"
                                    @"<con:Contact operation=\"?\">"
                                    @"<con:Id>%@</con:Id>"
                                    @"<con:ListOfOpportunity>"
                                    @"<con:Opportunity operation=\"?\">"
                                    @"<con:Id>%@</con:Id>"
                                    @"<con:ListOfOpportunityRelatedCampaigns>"
                                    @"<con:OpportunityRelatedCampaigns operation=\"Insert\">"
                                    @"<con:Id>%@</con:Id>"
                                    @"</con:OpportunityRelatedCampaigns>"
                                    @"</con:ListOfOpportunityRelatedCampaigns>"
                                    @"</con:Opportunity>"
                                    @"</con:ListOfOpportunity>"
                                    @"</con:Contact>"
                                    @"</con:ListOfContactInterface>"
                                    @"<asi:StatusObject>?</asi:StatusObject>"
                                    @"</asi:SFATMCVContactInsertOrUpdate_Input>"
                                    @"</soapenv:Body>"
                                    @"</soapenv:Envelope>",appdelegate.CONTACT_ID,appdelegate.opty_idDetailPage,self.selectedLinkCampaignValue];
    
    
    NSData *envelope = [envelopeText1 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    NSLog(@"URL IS %@",theurl);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText1 length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"Linkcampaign_select_request"];
     self.LinkCampaignList=nil;
    CGRect toolbarTargetFrame = CGRectMake(0, self.view.bounds.size.height, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height+44, 320, 216);
    [UIView beginAnimations:@"MoveOut" context:nil];
    [self.view viewWithTag:9].alpha = 0;
    [self.view viewWithTag:10].frame = datePickerTargetFrame;
    [self.view viewWithTag:11].frame = toolbarTargetFrame;
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeViews:)];
    [UIView commitAnimations];
    }
}
- (void)removeViews:(id)object {
    [[self.view viewWithTag:9] removeFromSuperview];
    [[self.view viewWithTag:10] removeFromSuperview];
    [[self.view viewWithTag:11] removeFromSuperview];
}


/*
 @interface OpportunityDetailsViewController ()
 {
 UIAlertView *alert;
 }
 @end
 
 @implementation OpportunityDetailsViewController
 @synthesize optySearchDetails,optySearchDetails_Comes;
 - (void)viewDidLoad {
 [super viewDidLoad];
 
 appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];//AppDelegate instance
 userDetailsVal_ = [UserDetails_Var sharedmanager]; // usedetails instance
 NSLog(@"Samlp Art Master: %@",userDetailsVal_.ROW_ID);
 
 NSLog(@"Mutable array COmes :%@",optySearchDetails_Comes);

- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.pickerData[row];
}



- (void)dismissDatePicker:(id)sender {
    CGRect toolbarTargetFrame = CGRectMake(0, self.view.bounds.size.height, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height+44, 320, 216);
    [UIView beginAnimations:@"MoveOut" context:nil];
    [self.view viewWithTag:9].alpha = 0;
    [self.view viewWithTag:10].frame = datePickerTargetFrame;
    [self.view viewWithTag:11].frame = toolbarTargetFrame;
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeViews:)];
    [UIView commitAnimations];
}

*/

@end
