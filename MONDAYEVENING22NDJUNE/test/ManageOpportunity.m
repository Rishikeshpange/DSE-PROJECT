//
//  ManageOpportunity.m
//  NEEV
//
//  Created by Sachin Sharma on 20/03/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//



#import "ActivityViewController.h"
#import "ActivityListViewController.h"
#import "LoginViewController.h"
#import "ManageOpportunity.h"
#import "manageOpportunity_Cell.h"
#import "TBXML.h"
#import "RequestDelegate.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "OpportunityDetailsViewController.h"

#import "Opportunity_List.h"


@interface ManageOpportunity ()

{
    UIAlertView *alert;
}
@end

@implementation ManageOpportunity
@synthesize opportunoity_tv,startLoop,endLoop;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showAlert];
    
//     OpportunityDetailsViewController* activityDetailViewController_VC = [self.storyboard instantiateViewControllerWithIdentifier:@" OpportunityDetailsViewController"];
//    [self.navigationController pushViewController:activityDetailViewController_VC animated:YES];
    
   // [self callOpportnityCount];
    
    OpportunityListDisplayArr=[[NSMutableArray alloc]init];
    
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];//AppDelegate instance
    appdelegate.OppurtunityList=[[NSMutableArray alloc]init];
    NSLog(@"Samlp Art Master: %@",appdelegate.artifact);
    // appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];//AppDelegate instance
    userDetailsVal_ = [UserDetails_Var sharedmanager]; // usedetails instance
    NSLog(@"Samlp Art Master: %@",userDetailsVal_.ROW_ID);
    
    //  NSString *startLoop_ = [NSString stringWithFormat:@"%d",(int)startIndex];
    // NSString *endLoop_ = [NSString stringWithFormat:@"%d",(int)endIndex];
    
     [self.opportunoity_tv setHidden:YES];
    self.opportunoity_tv.delegate = self;
    self.opportunoity_tv.dataSource = self;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
  [self.opportunoity_tv setSeparatorInset:UIEdgeInsetsZero];
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header_strip.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header_strip1.png"] forBarMetrics:UIBarMetricsDefault];
    
    // Navigation bar button on right side
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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButtonItems];
    
    
    
    
    [self callOpportnityCount];
    // Do any additional setup after loading the view.
}



-(void)viewWillAppear:(BOOL)animated
{
    [self callOpportnityCount];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(opportunityCountFound:) name:@"opportunityCountFound" object:nil];//Abhishek //For opportunity Count
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(artifactFailed:) name:@"artifactFailed" object:nil];//Abhishek //For Atifact fail //
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(opportunityCountFailed:) name:@"opportunityCountFailed" object:nil];//Abhishek //For Atifact fail //
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SaleAllOpty_Found:) name:@"SaleAllOpty_Found" object:nil];//Abhishek //For Atifact fail //
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SaleAllOpty_Found1:) name:@"SaleAllOpty_Found1" object:nil];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"opportunityCountFound" object:nil];//abhishek // For opportunity Count
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"opportunityCountFailed" object:nil];//abhishek // For opportunity Count
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"artifactFailed" object:nil];//Abhishek // for artifact fail
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"SaleAllOpty_Found" object:nil];//abhishek // For opportunity Count
     [[NSNotificationCenter defaultCenter]removeObserver:self name:@"SaleAllOpty_Found1" object:nil];
    
}




-(void)info_btn
{
    //  NSLog(@"Home biscuit from Sanfrancisco");
    [self performSegueWithIdentifier:@"infoView" sender:nil];
}
-(void)logOut_btn
{
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
    if (buttonIndex == 0) {
        
        NSLog(@"David Miller");
    }
    if (buttonIndex==1) {
        NSLog(@"Glen Maxwell");
        LoginViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        //[self.navigationController pushViewController:secondViewController animated:YES];
        [self presentViewController:secondViewController animated:YES completion:nil ];
        //  [self.navigationController popToRootViewControllerAnimated:TRUE];
        // [self dismissViewControllerAnimated:YES completion:nil];
        //  [self.parentViewController.navigationController popToRootViewControllerAnimated:YES];
        //  [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [OpportunityListDisplayArr count];    //count number of row from counting array hear cataGorry is An Array
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"manageopportunitycell";
    //static NSString *CELL_ID2 = @"SOME_STUPID_ID2";
    
    manageOpportunity_Cell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    // cell.accessoryType = UITableViewCellAccessoryNone;
    // cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (cell == nil) {
        cell = [[manageOpportunity_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
    cell.backgroundColor=[UIColor clearColor];
    //    [cell.contentView.layer setBorderColor:[UIColor whiteColor].CGColor];
    //    [cell.contentView.layer setBorderWidth:2.0f];
    //  cell.manage_opty_bg_view.backgroundColor = [UIColor clearColor];
    [cell.manage_opty_bg_view.layer setBorderColor:[UIColor colorWithRed:(221/255.0) green:(221/255.0) blue:(221/255.0) alpha:1].CGColor];
    // [cell.manage_opty_bg_view.layer setBorderColor:[[UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor]];
    [cell.manage_opty_bg_view.layer setBorderWidth:2.0f];
    cell.manage_opty_bg_view.layer.cornerRadius=5;
   
    
    cell.Customer_name_R.text=[[OpportunityListDisplayArr objectAtIndex:indexPath.row] valueForKey:@"CONTACT_NAME"];
    cell.product_name_R.text=[[OpportunityListDisplayArr objectAtIndex:indexPath.row] valueForKey:@"PRODUCT_NAME1"];
    cell.lbl_sales_stage_name.text=[[OpportunityListDisplayArr objectAtIndex:indexPath.row] valueForKey:@"SALE_STAGE_NAME"];
    cell.lbl_opty_create_date.text=[[OpportunityListDisplayArr objectAtIndex:indexPath.row] valueForKey:@"OPTY_CREAT_DATE"];
    cell.lbl_last_dobe_activity_R.text=[[OpportunityListDisplayArr objectAtIndex:indexPath.row] valueForKey:@"LAST_DONE_ACTIVITY_DATE"];
    
    NSString *string1= cell.lbl_last_dobe_activity_R.text;
    if ([string1 isEqualToString:@""]) {
       cell.lbl_last_dobe_activity_R.text=@"Unavailable";
        // nil branch
    } else
    {
        // category name is set
    }

    
   // cell.Customer_name_R.text=opportunity_list.CONTACT_NAME;
//    cell.lbl_Product_Name.text=opportunity_list.PRODUCT_NAME;
//    
//    cell.lbl_Cont_Phn_Num.text=opportunity_list.CONTACT_CELL_NUMBER;
//    cell.lbl_OpTy_Created_Date.text=opportunity_list.OPTY_CREAT_DATE;
//    cell.lbl_Sales_Stages.text=opportunity_list.SALE_STAGE_NAME;
//    cell.lbl_LAST_DONE_ACTIVITY_TYPE.text=opportunity_list.LAST_DONE_ACTIVITY_TYPE;
    
    
    
    
    return cell;
    
}





//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *headerView = [[UIView alloc] init];
//    headerView.backgroundColor = [UIColor clearColor];
//    return headerView;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    appdelegate.fromSearchOptyview=nil;
    appdelegate.fromManageOptyview=@"fromManageOptyview";
     NSLog(@"%@",appdelegate.fromSearchOptyview);
     NSLog(@"%@", appdelegate.fromManageOptyview);
    appdelegate.Manageoptyrow=indexPath.row;
    NSLog(@"%i",appdelegate.Manageoptyrow);
    //appdelegate.fromOPTYDetail=nil;
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)callOpportnityCount
{
    
    NSLog(@"inside...this");
  /*  NSString * envelopeText = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<GetListOfOpportunityNeev xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                               @"<positionid>%@</positionid>"
                               @"<position_name></position_name>"
                               @"<businessname></businessname>"
                               @"</GetListOfOpportunityNeev>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",userDetailsVal_.ROW_ID];
    */
    NSString *envelopeText =[NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
    @"  <SOAP:Header xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
    @"<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"
    @"<Logger xmlns=\"http://schemas.cordys.com/General/1.0/\">"
    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/testtool/testtool.caf</DC>"
    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/methodsetsmanager/methodsetexplorer.caf</DC>"
    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/sysresourcemgr/sysresourcemgr.caf</DC>"
    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/com/cordys/cusp/cusp.caf</DC>"
    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"hopCount\">0</DC>"
    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"correlationID\">00215ef7-d846-11e4-e4a1-376f7691964d</DC>"
    @"</Logger>"
    @"</header>"
    @"</SOAP:Header>"
    @"<SOAP:Body>"
    @"<GetListOfOpportunitySFA xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
    @"<positionid>%@</positionid>"
    @" <position_name />"
    @"<businessname />"
    @"<rang1>1</rang1>"
    @"<rang2>15</rang2>"
    @"</GetListOfOpportunitySFA>"
    @"</SOAP:Body>"
    @"</SOAP:Envelope>",userDetailsVal_.ROW_ID];
    



    
    //1-7CE835O    1-70CX8VQ
    NSLog(@"\n envlopeString Of OPP....!!!!%@",envelopeText);
    //NSLog(@"URL : %@",appdelegate.artifact);
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@",theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    
    NSLog(@"Request.... %@",request);
    
    NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"getAllOpprtunity"];
    
}


//-(void)SaleAllOpty_Found:(NSNotification*)notification
//{
//    int i = 0; //for test loop
//    NSError *err;
//    NSString *response=[[notification userInfo]objectForKey:@"response"];
//    NSLog(@"\n opportuntyCount response..... %@ ",response);
//    if ([response isEqual:@""])
//    {
//        [self hideAlert];
//        NSLog(@"Nko re..");
//        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Nothing in Response !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alertView show];
//        
//    }
//    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
//    {
//        [self hideAlert];
//        NSLog(@"Dishkyauuu");
//        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Network Fault String!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alertView show];
//    }
//    else
//    {
//        NSLog(@"Wachnag...");
//        [self hideAlert];
//        
//    }

    ///
    
-(void)SaleAllOpty_Found:(NSNotification*)notification
    {
        int i = 0; //for test loop
        NSError *err;
        NSString *response=[[notification userInfo]objectForKey:@"response"];
        OpportunityListDisplayArr=[[NSMutableArray alloc]init];
         appdelegate.OppurtunityList=[[NSMutableArray alloc]init];
        NSLog(@"\n opportuntyCount response..... %@ ",response);
        if ([response isEqual:@""])
        {
            [self hideAlert];
            NSLog(@"Nko re..");
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Nothing in Response !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
            
        }
        else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
        {
            [self hideAlert];
            NSLog(@"Dishkyauuu");
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Network Fault String!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
       
        else
        {
          
            [self hideAlert];
            TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
            TBXMLElement *container = [TBXML childElementNamed:@"GetListOfOpportunitySFAResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
            if (OpportunityListDisplayArr)
            {
                [ OpportunityListDisplayArr removeAllObjects];
            }
            TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
            if (tuple)
            {
                 [self.opportunoity_tv setHidden:NO];
                do {
                    opportunity_list = nil;
                    opportunity_list = [[Opportunity_List alloc]init];
                    
                    TBXMLElement *table  = [TBXML childElementNamed:@"TABLE" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                    
                    TBXMLElement *OPTY_ID = [TBXML childElementNamed:@"OPTY_ID" parentElement:table];
                    opportunity_list.OPTY_ID = [TBXML textForElement:OPTY_ID];
                    
                    TBXMLElement *OPTY_NAME = [TBXML childElementNamed:@"OPTY_NAME" parentElement:table];
                    opportunity_list.OPTY_NAME = [TBXML textForElement:OPTY_NAME];
                    NSLog(@"OptyID : %@",opportunity_list.OPTY_ID);
                    
                    TBXMLElement *CONTACT_ADDRESS = [TBXML childElementNamed:@"CONTACT_ADDRESS" parentElement:table];
                    opportunity_list.CONTACT_ADDRESS = [TBXML textForElement:CONTACT_ADDRESS];
                    
                    TBXMLElement *ADDRESS_ID = [TBXML childElementNamed:@"ADDRESS_ID" parentElement:table];
                    opportunity_list.ADDRESS_ID = [TBXML textForElement:ADDRESS_ID];
                    
                    
                    TBXMLElement *OPTY_CREAT_DATE = [TBXML childElementNamed:@"OPTY_CREATED_DATE" parentElement:table];
                    opportunity_list.OPTY_CREAT_DATE = [TBXML textForElement:OPTY_CREAT_DATE];
                    NSLog(@"OptyID : %@",opportunity_list.OPTY_CREAT_DATE);
                    
                    
                    TBXMLElement *VC = [TBXML childElementNamed:@"VC" parentElement:table];
                    opportunity_list.VC = [TBXML textForElement:VC];
                    

                    TBXMLElement *ACCOUNT_ID = [TBXML childElementNamed:@"ACCOUNT_ID" parentElement:table];
                    opportunity_list.ACCOUNT_ID = [TBXML textForElement:ACCOUNT_ID];
                    
                    
                    TBXMLElement *SALES_STAGE_DATE = [TBXML childElementNamed:@"SALE_STAGE_UPDATED_DATE" parentElement:table];
                    opportunity_list.SALES_STAGE_DATE = [TBXML textForElement:SALES_STAGE_DATE];
                    
                    
                    TBXMLElement *SALE_STAGE_NAME = [TBXML childElementNamed:@"SALES_STAGE_NAME" parentElement:table];
                    opportunity_list.SALE_STAGE_NAME = [TBXML textForElement:SALE_STAGE_NAME];

                    
                    TBXMLElement *CONTACT_ID = [TBXML childElementNamed:@"CONTACT_ID" parentElement:table];
                    opportunity_list.CONTACT_ID = [TBXML textForElement:CONTACT_ID];
                    
                    
                    TBXMLElement *CONTACT_NAME = [TBXML childElementNamed:@"CONTACT_NAME" parentElement:table];
                    opportunity_list.CONTACT_NAME = [TBXML textForElement:CONTACT_NAME];
                    
                    
                    TBXMLElement *CONTACT_CELL_NUMBER = [TBXML childElementNamed:@"CONTACT_CELL_NUMBER" parentElement:table];
                    opportunity_list.CONTACT_CELL_NUMBER = [TBXML textForElement:CONTACT_CELL_NUMBER];

                    
                    TBXMLElement *ACCOUNT_NAME = [TBXML childElementNamed:@"CUSTOMER_ACCOUNT_NAME" parentElement:table];
                    opportunity_list.ACCOUNT_NAME = [TBXML textForElement:ACCOUNT_NAME];
                    
                    TBXMLElement *RESULT_COUNT = [TBXML childElementNamed:@"RESULT_COUNT" parentElement:table];
                    opportunity_list.RESULT_COUNT = [TBXML textForElement:RESULT_COUNT];
                    self.ResultCount=opportunity_list.RESULT_COUNT;
                    
                    TBXMLElement *RNUM = [TBXML childElementNamed:@"RNUM" parentElement:table];
                    opportunity_list.RNUM = [TBXML textForElement:RNUM];
                    
                    TBXMLElement *PRODUCT_NAME1 = [TBXML childElementNamed:@"PRODUCT_NAME1" parentElement:table];
                    opportunity_list.PRODUCT_NAME1 = [TBXML textForElement:PRODUCT_NAME1];
                    
                    TBXMLElement *PRODUCT_ID = [TBXML childElementNamed:@"PRODUCT_ID" parentElement:table];
                    opportunity_list.PRODUCT_ID = [TBXML textForElement:PRODUCT_ID];
                    
                    
                    
                    TBXMLElement *TGM_TKM_NAME = [TBXML childElementNamed:@"TGM_TKM_NAME" parentElement:table];
                    opportunity_list.TGM_TKM_NAME = [TBXML textForElement:TGM_TKM_NAME];
                    
                    TBXMLElement *TGM_TKM_PHONE_NUMBER = [TBXML childElementNamed:@"TGM_TKM_PHONE_NUMBER" parentElement:table];
                    opportunity_list.TGM_TKM_PHONE_NUMBER = [TBXML textForElement:TGM_TKM_PHONE_NUMBER];
                    
                    
                    TBXMLElement *ACCOUNT_TYPE = [TBXML childElementNamed:@"ACCOUNT_TYPE" parentElement:table];
                    opportunity_list.ACCOUNT_TYPE = [TBXML textForElement:ACCOUNT_TYPE];
                    
                    
                    TBXMLElement *LEAD_ASSIGNED_NAME = [TBXML childElementNamed:@"LEAD_ASSIGNED_NAME" parentElement:table];
                    opportunity_list.LEAD_ASSIGNED_NAME = [TBXML textForElement:LEAD_ASSIGNED_NAME];
                    
                    
                    
                    TBXMLElement *LEAD_ASSIGNED_CELL_NUMBER = [TBXML childElementNamed:@"LEAD_ASSIGNED_CELL_NUMBER" parentElement:table];
                    opportunity_list.LEAD_ASSIGNED_CELL_NUMBER = [TBXML textForElement:LEAD_ASSIGNED_CELL_NUMBER];
                    
                    
                    TBXMLElement *LEAD_POSITION = [TBXML childElementNamed:@"LEAD_POSITION" parentElement:table];
                    opportunity_list.LEAD_POSITION = [TBXML textForElement:LEAD_POSITION];
                    
                    
                    TBXMLElement *LEAD_ASSIGNED_POSITION_ID = [TBXML childElementNamed:@"LEAD_ASSIGNED_POSITION_ID" parentElement:table];
                    opportunity_list.LEAD_ASSIGNED_POSITION_ID = [TBXML textForElement:LEAD_ASSIGNED_POSITION_ID];
                    
                    
                    TBXMLElement *CONTACT_FIRST_NAME = [TBXML childElementNamed:@"CONTACT_FIRST_NAME" parentElement:table];
                    opportunity_list.CONTACT_FIRST_NAME = [TBXML textForElement:CONTACT_FIRST_NAME];
                    
                    
                    
                    TBXMLElement *CONTACT_LAST_NAME = [TBXML childElementNamed:@"CONTACT_LAST_NAME" parentElement:table];
                    opportunity_list.CONTACT_LAST_NAME = [TBXML textForElement:CONTACT_LAST_NAME];
                    
                    
                    
                    
                    
                    TBXMLElement *LAST_PENDING_ACTIVITY_TYPE = [TBXML childElementNamed:@"LAST_PENDING_ACTIVITY_TYPE" parentElement:table];
                    opportunity_list.LAST_PENDING_ACTIVITY_TYPE = [TBXML textForElement:LAST_PENDING_ACTIVITY_TYPE];
                    
                    
                    TBXMLElement *LAST_PENDING_ACTIVITY_ID = [TBXML childElementNamed:@"LAST_PENDING_ACTIVITY_ID" parentElement:table];
                    opportunity_list.LAST_PENDING_ACTIVITY_ID = [TBXML textForElement:LAST_PENDING_ACTIVITY_ID];
                    
                    
                    TBXMLElement *LAST_PENDING_ACTIVITY_STATUS = [TBXML childElementNamed:@"LAST_PENDING_ACTIVITY_STATUS" parentElement:table];
                    opportunity_list.LAST_PENDING_ACTIVITY_STATUS = [TBXML textForElement:LAST_PENDING_ACTIVITY_STATUS];
                    
                    
                    TBXMLElement *LAST_PEND_ACTIVIY_START_DATE = [TBXML childElementNamed:@"LAST_PEND_ACTIVIY_START_DATE" parentElement:table];
                    opportunity_list.LAST_PEND_ACTIVIY_START_DATE = [TBXML textForElement:LAST_PEND_ACTIVIY_START_DATE];
                    
                    
                    
                    TBXMLElement *LAST_PENDING_ACTIVITY_DESC = [TBXML childElementNamed:@"LAST_PENDING_ACTIVITY_DESC" parentElement:table];
                    opportunity_list.LAST_PENDING_ACTIVITY_DESC = [TBXML textForElement:LAST_PENDING_ACTIVITY_DESC];
                    
                    
                    
                    
                    TBXMLElement *PRODUCT_NAME = [TBXML childElementNamed:@"PRODUCT_NAME" parentElement:table];
                    opportunity_list.PRODUCT_NAME = [TBXML textForElement:PRODUCT_NAME];
                    
                    
                    TBXMLElement *CUSTOMER_ACCOUNT_NAME = [TBXML childElementNamed:@"CUSTOMER_ACCOUNT_NAME" parentElement:table];
                    opportunity_list.CUSTOMER_ACCOUNT_NAME = [TBXML textForElement:CUSTOMER_ACCOUNT_NAME];
                    NSLog(@"OptyID : %@",opportunity_list.CUSTOMER_ACCOUNT_NAME);
                    
                    TBXMLElement *CUSTOMER_ACCOUNT_ID = [TBXML childElementNamed:@"CUSTOMER_ACCOUNT_ID" parentElement:table];
                    opportunity_list.CUSTOMER_ACCOUNT_ID = [TBXML textForElement:CUSTOMER_ACCOUNT_ID];
                    
                    
                    TBXMLElement *CUSTOMER_PHONE_NUMBER = [TBXML childElementNamed:@"CUSTOMER_PHONE_NUMBER" parentElement:table];
                    opportunity_list.CUSTOMER_PHONE_NUMBER = [TBXML textForElement:CUSTOMER_PHONE_NUMBER];
                    NSLog(@"OptyID : %@",opportunity_list.CUSTOMER_PHONE_NUMBER);
                    
                    
                    TBXMLElement *CUSTOMER_ACCOUNT_LOCATION = [TBXML childElementNamed:@"CUSTOMER_ACCOUNT_LOCATION" parentElement:table];
                    opportunity_list.CUSTOMER_ACCOUNT_LOCATION = [TBXML textForElement:CUSTOMER_ACCOUNT_LOCATION];
                    
                    TBXMLElement *REV_PRODUCT_ID = [TBXML childElementNamed:@"REV_PRODUCT_ID" parentElement:table];
                    opportunity_list.REV_PRODUCT_ID = [TBXML textForElement:REV_PRODUCT_ID];
                    
                    TBXMLElement *LAST_DONE_ACTIVITY_DATE = [TBXML childElementNamed:@"LAST_DONE_ACTIVITY_DATE" parentElement:table];
                    opportunity_list.LAST_DONE_ACTIVITY_DATE = [TBXML textForElement:LAST_DONE_ACTIVITY_DATE];
                    
                    TBXMLElement *LAST_DONE_ACTIVITY_TYPE = [TBXML childElementNamed:@"LAST_DONE_ACTIVITY_TYPE" parentElement:table];
                    opportunity_list.LAST_DONE_ACTIVITY_TYPE = [TBXML textForElement:LAST_DONE_ACTIVITY_TYPE];
                    
                    TBXMLElement *LAST_DONE_ACTIVITY_DESC = [TBXML childElementNamed:@"LAST_DONE_ACTIVITY_DESC" parentElement:table];
                    opportunity_list.LAST_DONE_ACTIVITY_DESC = [TBXML textForElement:LAST_DONE_ACTIVITY_DESC];
                    
                   
                    
                    i++;
                    
                    NSLog(@"\n test opp.... %d!!!\n",i);
                    
                    [OpportunityListDisplayArr addObject:opportunity_list];
                    [appdelegate.OppurtunityList addObject:opportunity_list];
                    
                } while ((tuple = tuple->nextSibling));
                NSLog(@"\nOpportunityListDisplayArr......%d",[OpportunityListDisplayArr count]);
                //[appdelegate hideAlert];
                
                [self.opportunoity_tv reloadData];
               // [self callOpportnityCount1];
                
            }
            else
            {
                [self.opportunoity_tv setHidden:YES];
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"No Data Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }
    
    
    
    
    
    
    
    


-(void)opportunityCountFailed:(NSNotification*)notification
{
    [self hideAlert];
    
    NSString *errorString=[[notification userInfo]objectForKey:@"error"];
    NSLog(@".$$ %@",errorString);
    if([errorString isEqualToString:@"offline"])
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"The internet connection seems to be offline!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"] animated:NO];
    }
    //  [appdelegate hideAlert];
}
-(void)callOpportnityCount1
{
    
    NSLog(@"inside...this");
    /*  NSString * envelopeText = [NSString stringWithFormat:
     @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
     @"<SOAP:Body>"
     @"<GetListOfOpportunityNeev xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
     @"<positionid>%@</positionid>"
     @"<position_name></position_name>"
     @"<businessname></businessname>"
     @"</GetListOfOpportunityNeev>"
     @"</SOAP:Body>"
     @"</SOAP:Envelope>",userDetailsVal_.ROW_ID];
     */
    NSString *envelopeText =[NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             @"  <SOAP:Header xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             @"<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                             @"<Logger xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                             @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/testtool/testtool.caf</DC>"
                             @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/methodsetsmanager/methodsetexplorer.caf</DC>"
                             @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/sysresourcemgr/sysresourcemgr.caf</DC>"
                             @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/com/cordys/cusp/cusp.caf</DC>"
                             @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"hopCount\">0</DC>"
                             @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"correlationID\">00215ef7-d846-11e4-e4a1-376f7691964d</DC>"
                             @"</Logger>"
                             @"</header>"
                             @"</SOAP:Header>"
                             @"<SOAP:Body>"
                             @"<GetListOfOpportunitySFA xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                             @"<positionid>%@</positionid>"
                             @" <position_name />"
                             @"<businessname />"
                             @"<rang1>1</rang1>"
                             @"<rang2>%@</rang2>"
                             @"</GetListOfOpportunitySFA>"
                             @"</SOAP:Body>"
                             @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,self.ResultCount];
    
    
    
    
    
    //1-7CE835O    1-70CX8VQ
    NSLog(@"\n envlopeString Of OPP....!!!!%@",envelopeText);
    //NSLog(@"URL : %@",appdelegate.artifact);
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@",theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    
    NSLog(@"Request.... %@",request);
    
    NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"getAllOpprtunity"];
    
}
-(void)SaleAllOpty_Found1:(NSNotification*)notification
{
    int i = 0; //for test loop
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n opportuntyCount response..... %@ ",response);
    if ([response isEqual:@""])
    {
        [self hideAlert];
        NSLog(@"Nko re..");
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Nothing in Response !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        [self hideAlert];
        NSLog(@"Dishkyauuu");
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Network Fault String!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    else
    {
        
        [self hideAlert];
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement *container = [TBXML childElementNamed:@"GetListOfOpportunitySFAResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        if (OpportunityListDisplayArr)
        {
            [ OpportunityListDisplayArr removeAllObjects];
        }
        TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple)
        {
            [self.opportunoity_tv setHidden:NO];
            do {
                opportunity_list = nil;
                opportunity_list = [[Opportunity_List alloc]init];
                
                TBXMLElement *table  = [TBXML childElementNamed:@"TABLE" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                
                TBXMLElement *OPTY_ID = [TBXML childElementNamed:@"OPTY_ID" parentElement:table];
                opportunity_list.OPTY_ID = [TBXML textForElement:OPTY_ID];
                
                TBXMLElement *OPTY_NAME = [TBXML childElementNamed:@"OPTY_NAME" parentElement:table];
                opportunity_list.OPTY_NAME = [TBXML textForElement:OPTY_NAME];
                NSLog(@"OptyID : %@",opportunity_list.OPTY_ID);
                
                TBXMLElement *CONTACT_ADDRESS = [TBXML childElementNamed:@"CONTACT_ADDRESS" parentElement:table];
                opportunity_list.CONTACT_ADDRESS = [TBXML textForElement:CONTACT_ADDRESS];
                
                TBXMLElement *ADDRESS_ID = [TBXML childElementNamed:@"ADDRESS_ID" parentElement:table];
                opportunity_list.ADDRESS_ID = [TBXML textForElement:ADDRESS_ID];
                
                
                TBXMLElement *OPTY_CREAT_DATE = [TBXML childElementNamed:@"OPTY_CREATED_DATE" parentElement:table];
                opportunity_list.OPTY_CREAT_DATE = [TBXML textForElement:OPTY_CREAT_DATE];
                NSLog(@"OptyID : %@",opportunity_list.OPTY_CREAT_DATE);
                
                
                TBXMLElement *VC = [TBXML childElementNamed:@"VC" parentElement:table];
                opportunity_list.VC = [TBXML textForElement:VC];
                
                
                TBXMLElement *ACCOUNT_ID = [TBXML childElementNamed:@"ACCOUNT_ID" parentElement:table];
                opportunity_list.ACCOUNT_ID = [TBXML textForElement:ACCOUNT_ID];
                
                
                TBXMLElement *SALES_STAGE_DATE = [TBXML childElementNamed:@"SALE_STAGE_UPDATED_DATE" parentElement:table];
                opportunity_list.SALES_STAGE_DATE = [TBXML textForElement:SALES_STAGE_DATE];
                
                
                TBXMLElement *SALE_STAGE_NAME = [TBXML childElementNamed:@"SALES_STAGE_NAME" parentElement:table];
                opportunity_list.SALE_STAGE_NAME = [TBXML textForElement:SALE_STAGE_NAME];
                
                
                TBXMLElement *CONTACT_ID = [TBXML childElementNamed:@"CONTACT_ID" parentElement:table];
                opportunity_list.CONTACT_ID = [TBXML textForElement:CONTACT_ID];
                
                
                TBXMLElement *CONTACT_NAME = [TBXML childElementNamed:@"CONTACT_NAME" parentElement:table];
                opportunity_list.CONTACT_NAME = [TBXML textForElement:CONTACT_NAME];
                
                
                TBXMLElement *CONTACT_CELL_NUMBER = [TBXML childElementNamed:@"CONTACT_CELL_NUMBER" parentElement:table];
                opportunity_list.CONTACT_CELL_NUMBER = [TBXML textForElement:CONTACT_CELL_NUMBER];
                
                
                TBXMLElement *ACCOUNT_NAME = [TBXML childElementNamed:@"CUSTOMER_ACCOUNT_NAME" parentElement:table];
                opportunity_list.ACCOUNT_NAME = [TBXML textForElement:ACCOUNT_NAME];
                
                TBXMLElement *RESULT_COUNT = [TBXML childElementNamed:@"RESULT_COUNT" parentElement:table];
                opportunity_list.RESULT_COUNT = [TBXML textForElement:RESULT_COUNT];
                self.ResultCount=opportunity_list.RESULT_COUNT;
                
                TBXMLElement *RNUM = [TBXML childElementNamed:@"RNUM" parentElement:table];
                opportunity_list.RNUM = [TBXML textForElement:RNUM];
                
                TBXMLElement *PRODUCT_NAME1 = [TBXML childElementNamed:@"PRODUCT_NAME1" parentElement:table];
                opportunity_list.PRODUCT_NAME1 = [TBXML textForElement:PRODUCT_NAME1];
                
                TBXMLElement *PRODUCT_ID = [TBXML childElementNamed:@"PRODUCT_ID" parentElement:table];
                opportunity_list.PRODUCT_ID = [TBXML textForElement:PRODUCT_ID];
                
                
                
                TBXMLElement *TGM_TKM_NAME = [TBXML childElementNamed:@"TGM_TKM_NAME" parentElement:table];
                opportunity_list.TGM_TKM_NAME = [TBXML textForElement:TGM_TKM_NAME];
                
                TBXMLElement *TGM_TKM_PHONE_NUMBER = [TBXML childElementNamed:@"TGM_TKM_PHONE_NUMBER" parentElement:table];
                opportunity_list.TGM_TKM_PHONE_NUMBER = [TBXML textForElement:TGM_TKM_PHONE_NUMBER];
                
                
                TBXMLElement *ACCOUNT_TYPE = [TBXML childElementNamed:@"ACCOUNT_TYPE" parentElement:table];
                opportunity_list.ACCOUNT_TYPE = [TBXML textForElement:ACCOUNT_TYPE];
                
                
                TBXMLElement *LEAD_ASSIGNED_NAME = [TBXML childElementNamed:@"LEAD_ASSIGNED_NAME" parentElement:table];
                opportunity_list.LEAD_ASSIGNED_NAME = [TBXML textForElement:LEAD_ASSIGNED_NAME];
                
                
                
                TBXMLElement *LEAD_ASSIGNED_CELL_NUMBER = [TBXML childElementNamed:@"LEAD_ASSIGNED_CELL_NUMBER" parentElement:table];
                opportunity_list.LEAD_ASSIGNED_CELL_NUMBER = [TBXML textForElement:LEAD_ASSIGNED_CELL_NUMBER];
                
                
                TBXMLElement *LEAD_POSITION = [TBXML childElementNamed:@"LEAD_POSITION" parentElement:table];
                opportunity_list.LEAD_POSITION = [TBXML textForElement:LEAD_POSITION];
                
                
                TBXMLElement *LEAD_ASSIGNED_POSITION_ID = [TBXML childElementNamed:@"LEAD_ASSIGNED_POSITION_ID" parentElement:table];
                opportunity_list.LEAD_ASSIGNED_POSITION_ID = [TBXML textForElement:LEAD_ASSIGNED_POSITION_ID];
                
                
                TBXMLElement *CONTACT_FIRST_NAME = [TBXML childElementNamed:@"CONTACT_FIRST_NAME" parentElement:table];
                opportunity_list.CONTACT_FIRST_NAME = [TBXML textForElement:CONTACT_FIRST_NAME];
                
                
                
                TBXMLElement *CONTACT_LAST_NAME = [TBXML childElementNamed:@"CONTACT_LAST_NAME" parentElement:table];
                opportunity_list.CONTACT_LAST_NAME = [TBXML textForElement:CONTACT_LAST_NAME];
                
                
                
                
                
                TBXMLElement *LAST_PENDING_ACTIVITY_TYPE = [TBXML childElementNamed:@"LAST_PENDING_ACTIVITY_TYPE" parentElement:table];
                opportunity_list.LAST_PENDING_ACTIVITY_TYPE = [TBXML textForElement:LAST_PENDING_ACTIVITY_TYPE];
                
                
                TBXMLElement *LAST_PENDING_ACTIVITY_ID = [TBXML childElementNamed:@"LAST_PENDING_ACTIVITY_ID" parentElement:table];
                opportunity_list.LAST_PENDING_ACTIVITY_ID = [TBXML textForElement:LAST_PENDING_ACTIVITY_ID];
                
                
                TBXMLElement *LAST_PENDING_ACTIVITY_STATUS = [TBXML childElementNamed:@"LAST_PENDING_ACTIVITY_STATUS" parentElement:table];
                opportunity_list.LAST_PENDING_ACTIVITY_STATUS = [TBXML textForElement:LAST_PENDING_ACTIVITY_STATUS];
                
                
                TBXMLElement *LAST_PEND_ACTIVIY_START_DATE = [TBXML childElementNamed:@"LAST_PEND_ACTIVIY_START_DATE" parentElement:table];
                opportunity_list.LAST_PEND_ACTIVIY_START_DATE = [TBXML textForElement:LAST_PEND_ACTIVIY_START_DATE];
                
                
                
                TBXMLElement *LAST_PENDING_ACTIVITY_DESC = [TBXML childElementNamed:@"LAST_PENDING_ACTIVITY_DESC" parentElement:table];
                opportunity_list.LAST_PENDING_ACTIVITY_DESC = [TBXML textForElement:LAST_PENDING_ACTIVITY_DESC];
                
                
                
                
                TBXMLElement *PRODUCT_NAME = [TBXML childElementNamed:@"PRODUCT_NAME" parentElement:table];
                opportunity_list.PRODUCT_NAME = [TBXML textForElement:PRODUCT_NAME];
                
                
                TBXMLElement *CUSTOMER_ACCOUNT_NAME = [TBXML childElementNamed:@"CUSTOMER_ACCOUNT_NAME" parentElement:table];
                opportunity_list.CUSTOMER_ACCOUNT_NAME = [TBXML textForElement:CUSTOMER_ACCOUNT_NAME];
                NSLog(@"OptyID : %@",opportunity_list.CUSTOMER_ACCOUNT_NAME);
                
                TBXMLElement *CUSTOMER_ACCOUNT_ID = [TBXML childElementNamed:@"CUSTOMER_ACCOUNT_ID" parentElement:table];
                opportunity_list.CUSTOMER_ACCOUNT_ID = [TBXML textForElement:CUSTOMER_ACCOUNT_ID];
                
                
                TBXMLElement *CUSTOMER_PHONE_NUMBER = [TBXML childElementNamed:@"CUSTOMER_PHONE_NUMBER" parentElement:table];
                opportunity_list.CUSTOMER_PHONE_NUMBER = [TBXML textForElement:CUSTOMER_PHONE_NUMBER];
                NSLog(@"OptyID : %@",opportunity_list.CUSTOMER_PHONE_NUMBER);
                
                
                TBXMLElement *CUSTOMER_ACCOUNT_LOCATION = [TBXML childElementNamed:@"CUSTOMER_ACCOUNT_LOCATION" parentElement:table];
                opportunity_list.CUSTOMER_ACCOUNT_LOCATION = [TBXML textForElement:CUSTOMER_ACCOUNT_LOCATION];
                
                TBXMLElement *REV_PRODUCT_ID = [TBXML childElementNamed:@"REV_PRODUCT_ID" parentElement:table];
                opportunity_list.REV_PRODUCT_ID = [TBXML textForElement:REV_PRODUCT_ID];
                
                TBXMLElement *LAST_DONE_ACTIVITY_DATE = [TBXML childElementNamed:@"LAST_DONE_ACTIVITY_DATE" parentElement:table];
                opportunity_list.LAST_DONE_ACTIVITY_DATE = [TBXML textForElement:LAST_DONE_ACTIVITY_DATE];
                
                TBXMLElement *LAST_DONE_ACTIVITY_TYPE = [TBXML childElementNamed:@"LAST_DONE_ACTIVITY_TYPE" parentElement:table];
                opportunity_list.LAST_DONE_ACTIVITY_TYPE = [TBXML textForElement:LAST_DONE_ACTIVITY_TYPE];
                
                TBXMLElement *LAST_DONE_ACTIVITY_DESC = [TBXML childElementNamed:@"LAST_DONE_ACTIVITY_DESC" parentElement:table];
                opportunity_list.LAST_DONE_ACTIVITY_DESC = [TBXML textForElement:LAST_DONE_ACTIVITY_DESC];
                
                
                
                i++;
                
                NSLog(@"\n test opp.... %d!!!\n",i);
                
                [OpportunityListDisplayArr addObject:opportunity_list];
                [appdelegate.OppurtunityList addObject:opportunity_list];
                
            } while ((tuple = tuple->nextSibling));
            NSLog(@"\nOpportunityListDisplayArr......%d",[OpportunityListDisplayArr count]);
            //[appdelegate hideAlert];
            
             [self.opportunoity_tv reloadData];
           // [self callOpportnityCount1];
            
        }
        else
        {
            [self.opportunoity_tv setHidden:YES];
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"No Data Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

-(void)artifactFailed:(NSNotification*)notification
{
    NSString *errorString=[[notification userInfo]objectForKey:@"error"];
    NSLog(@"Error %@",errorString);
    if([errorString isEqualToString:@"offline"])
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"The internet connection seems to be offline!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"] animated:NO];
    }
}


-(void)showAlert
{
    [MBProgressHUD showHUDAddedLoading:self.view animated:YES];
    
}
-(void)hideAlert
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}








@end
