//
//  SearchOpprtunityViewController.m
//  NEEV
//
//  Created by Sachin Sharma on 20/03/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//
#import "ActivityViewController.h"
#import "ActivityListViewController.h"
#import "LoginViewController.h"
#import "ManageOpportunity.h"
#import "SearchOpprtunityViewController.h"
#import "AppDelegate.h"
#import "RequestDelegate.h"
#import "TBXML.h"
#import "OpportunitySearchResultViewController.h"
#import "MBProgressHUD.h"
@interface SearchOpprtunityViewController ()
{
    UIAlertView *alert;
    NSArray *sale_Stage_array;
    NSString *ActiveInActive;
    NSDateFormatter *df;
    int flag;
    NSString *dateString,*MonthDate,*passid;
}
@end

@implementation SearchOpprtunityViewController


@synthesize saleStagePickerArr,pplNamePickerArr,ppl_ID_PickerArr,SalesTaluka_PickerArr,SalesAssignTo_PickerArr,SalesAssignTo_PickerArr_Static,saleStagePickerArrHC;
@synthesize txtFromDate,txtAssignTO,txtSalesStage,txtTaluka,txtToDate,txtPPL,txtCustomerMobile,txtCustomerName;
@synthesize activityType_PickerArr;


-(void)viewWillAppear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SaleStage_PPL_Found:) name:@"SaleStage_PPL_Found" object:nil]; //For Sale Satge PPL Dropdown Count
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saleStage_PPL_Failed:) name:@"saleStage_PPL_Failed" object:nil];//For sale SatgeFailed DropDown fail
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SearchOpportunities_Found:) name:@"SearchOpportunities_Found" object:nil];//For Sale Satge PPL Dropdown Count
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SearchOpportunities_Failed:) name:@"SearchOpportunities_Failed" object:nil];//For sale SatgeFailed DropDown fail
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SaleStageFound:) name:@"SaleStageFound" object:nil];//For Sale Satge PPL Dropdown Count
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SaleTahshilFound:) name:@"SaleTahshilFound" object:nil]; //For Sale Satge PPL Dropdown Count
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ActivityAssignTo_Found:) name:@"ActivityAssignTo_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ActivityType_Found:) name:@"ActivityType_Found" object:nil];
    
  
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"SaleStageFound" object:nil];//Gomzy // For opportunity Count
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"saleSatgeFailed" object:nil];//Gomzy // For opportunity Count
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"SaleStage_PPL_Found" object:nil];//Gomzy // for sale stage fail
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"saleStage_PPL_Failed" object:nil];//Gomzy // for saleStage fail
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"SearchOpportunities_Found" object:nil];//Gomzy // for Search Opportunities found
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"SearchOpportunities_Failed" object:nil];//Gomzy // for Search Opportunities failed
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"SaleTahshilFound" object:nil];//Gomzy // for Search Opportunities failed
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ActivityAssignTo_Found" object:nil];//Gomzy // for Search Opportunities failed
    
     [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ActivityType_Found" object:nil];
    
    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.btnSearch.layer.cornerRadius=4;
    
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
    
     activityType_PickerArr=[[NSMutableArray alloc] init];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButtonItems];
    saleStagePickerArr=[[NSMutableArray alloc] init];
    
    saleStagePickerArrHC=[[NSMutableArray alloc] initWithObjects:@"C0 (Prospecting)",@"C1 (Quote Tendered)",@"C1A (Papers submitted)",@"C2 (Adv. Received)",@"C3 (Vehicle Delivered)",@"Closed Lost at C0",@"Closed Lost at C1",@"Closed Lost at C1A",@"Closed Lost at C2",@"Closed Lost at C3", nil];
    
    pplNamePickerArr=[[NSMutableArray alloc]init];
    SalesTaluka_PickerArr=[[NSMutableArray alloc] init];
    SalesAssignTo_PickerArr=[[NSMutableArray alloc] init];
    SalesAssignTo_PickerArr_Static=[[NSMutableArray alloc]initWithObjects:@"Open",@"Done", nil];
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];//AppDelegate instance
    userDetailsVal_ = [UserDetails_Var sharedmanager]; //usedetails instance
    
    txtFromDate.delegate = self;
    txtToDate.delegate = self;
    txtSalesStage.delegate = self;
    txtPPL.delegate = self;
    
    
    NSDate *date = [NSDate date]; //I'm using this just to show the this is how you convert a date
    df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd-MMM-yyyy"];
    //[df setDateFormat:@"MMM"];
    dateString= [df stringFromDate:date];
    NSLog(@"Date Final Month :%@",dateString);
    txtToDate.text=dateString;
    
    NSDate *sevenDaysAgo = [date dateByAddingTimeInterval:-180*24*60*60];
    NSLog(@"30 days ago: %@", sevenDaysAgo);
    MonthDate=[df stringFromDate:sevenDaysAgo];
    NSLog(@"Month Date : %@",MonthDate);
    txtFromDate.text=MonthDate;
    
    [self callsaleStage];
    [self callSaleStagePPL];
    [self callTahshil];
    [self callAssignTo];
    [self CallActivity_Type];
    
    
}


// Do any additional setup after loading the view.



-(void)info_btn
{
    //  NSLog(@"Home biscuit from Sanfrancisco");
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
        
       
    }
    if (buttonIndex==1) {
       
        LoginViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        //[self.navigationController pushViewController:secondViewController animated:YES];
        [self presentViewController:secondViewController animated:YES completion:nil ];
        //  [self.navigationController popToRootViewControllerAnimated:TRUE];
        // [self dismissViewControllerAnimated:YES completion:nil];
        //  [self.parentViewController.navigationController popToRootViewControllerAnimated:YES];
        //  [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
    
}

-(void)CallActivity_Type
{       NSString * envelopeText = [NSString stringWithFormat:
                                   @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                   @"<SOAP:Body>"
                                   @"<GetTMCVActivityType xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\" />"
                                   @"</SOAP:Body>"
                                   @"</SOAP:Envelope>"];
    
    NSString * envelopeText1 = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                @"<SOAP:Body>"
                                @"<getListOfActivityJavaCall xmlns=\"http://schemas.cordys.com/NeevJavaCall\" />"
                                @"</SOAP:Body>"
                                @"</SOAP:Envelope>"];
    
    
    NSLog(@"\n envlopeString Of Activity Type Create....!!!!%@",envelopeText);
    NSData *envelope = [envelopeText1 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@",theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    
    NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText1 length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"getActivityTypeConnection"];
    
}
-(void)ActivityType_Found:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n _ActivityType_Found response... %@ ",response);
    
    if ([response isEqual:@""])
    {
        [self hideAlert];
        NSLog(@"Nko re..");
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Nothing in Response !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        
    }
    else if ([response isEqual:@"SOAP:Fault"])
    {
        [self hideAlert];
        NSLog(@"Dishkyauuu");
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Network Fault String!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else{
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        
        
        TBXMLElement *container = [TBXML childElementNamed:@"getListOfActivityJavaCallResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        TBXMLElement *old = [TBXML childElementNamed:@"old" parentElement:tuple];
        TBXMLElement *getListSaleStageJavaCall = [TBXML childElementNamed:@"getListOfActivityJavaCall" parentElement:old];
        TBXMLElement *getListSaleStageJavaCall2 = [TBXML childElementNamed:@"getListOfActivityJavaCall" parentElement:getListSaleStageJavaCall];
        TBXMLElement *getListSaleStageJavaCall3 = [TBXML childElementNamed:@"getListOfActivityJavaCall" parentElement:getListSaleStageJavaCall2];
        
        TBXMLElement *tuple2 =[TBXML childElementNamed:@"tuple" parentElement:getListSaleStageJavaCall3];
        
        if (tuple2)
        {
            do
            {
                TBXMLElement *S_Lst_Of_Val  = [TBXML childElementNamed:@"S_Lst_Of_Val" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple2]];
                TBXMLElement *NAME = [TBXML childElementNamed:@"NAME" parentElement:S_Lst_Of_Val];
                NSString *str_NAME = [TBXML textForElement:NAME];
                NSLog(@"\n SALE_STAGE_NAME : %@",str_NAME);
                [activityType_PickerArr addObject:str_NAME];
                
            }while ((tuple2 = tuple2->nextSibling));
            NSLog(@"Activty Type: %@",activityType_PickerArr);
        }
    }
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField // Abhishek
{
    NSLog(@"\n Testing.....");
    
    if (textField == self.txtFromDate) {
        NSLog(@"\n Testing.....");
        return YES;
    }
    
    if (textField == self.txtToDate) {
        [textField resignFirstResponder];
        return NO;
    }
    else if (textField == self.txtSalesStage){
        [textField resignFirstResponder];
        return NO;
    }
    else if (textField == self.txtPPL){
        [textField resignFirstResponder];
        return NO;
    }
//    else if (textField == self.textTaluka){
//        [textField resignFirstResponder];
//        return NO;
//    }
//    else if (textField == self.textpostalcode){
//        [textField resignFirstResponder];
//        return NO;
//    }
//    else if (textField == self.LOB ){
//        [textField resignFirstResponder];
//        return NO;
//    }
//    else if (textField == self.PPL){
//        [textField resignFirstResponder];
//        return NO;
//    }
//    else if (textField ==  self.PL){
//        [textField resignFirstResponder];
//        return NO;
//    }
//    else if (textField ==  self.APPLICATION){
//        [textField resignFirstResponder];
//        return NO;
//    }
//    else if (textField == self.SOURCEOFCONTACT){
//        [textField resignFirstResponder];
//        return NO;
//    }
//    else if (textField == self.FINANCIER ){
//        [textField resignFirstResponder];
//        return NO;
//    }
    else
    {
        return YES;
    }
    return YES;
}



- (IBAction)btnSearch:(id)sender {
    
    
    NSLog(@"Test....Btn Search ..");
     OpportunitySearchResultViewController* searchOpportunityResult_VC = [self.storyboard instantiateViewControllerWithIdentifier:@"Search_Opportunity_Result_VCViewController"];
    // searchOpportunityResult_VC.optySearchDetails_Comes=SearchOpportunityListArray;

    searchOpportunityResult_VC.txtSalesStages=txtSalesStage.text;
    searchOpportunityResult_VC.txtFromDate=txtFromDate.text;
    searchOpportunityResult_VC.txtToDate=txtToDate.text;
    
    searchOpportunityResult_VC.txtPPL=txtPPL.text;
    searchOpportunityResult_VC.txtActivityType=txtTaluka.text;//txtTaluka is connected as txtActivityType
    searchOpportunityResult_VC.txtActivityStatus=txtAssignTO.text;
    
    searchOpportunityResult_VC.CustomerName=txtCustomerName.text;
    
    searchOpportunityResult_VC.CustomerName = [txtCustomerName.text uppercaseString];
    NSLog(@"\n\n searchOpportunityResult_VC.CustomerName... %@",searchOpportunityResult_VC.CustomerName);
    

    
    
    
    [self.navigationController pushViewController:searchOpportunityResult_VC animated:YES];
    
    //  [self CallSearch];
}

-(void)callsaleStage
{
    NSString * envelopeText = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<getListSaleStageJavaCall xmlns=\"http://schemas.cordys.com/NeevJavaCall\" />"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>"] ;
    
    NSLog(@"\n envlopeString Of user details....!!!!%@",envelopeText);
    
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@",theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    
    NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"getSaleStageForSearchOpportunityConnection"];
    
}

-(void)callSaleStagePPL
{
    /*NSString * envelopeText = [NSString stringWithFormat:
     @"<SOAP:Envelope xmlns¸ :SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
     @"<SOAP:Body>"
     @"<GetListOfPPLForNeev xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
     @"<buname>TMCV</buname>"
     @"<attr1></attr1>"
     @"<attr2></attr2>"
     @"</GetListOfPPLForNeev>"
     @"</SOAP:Body>"
     @"</SOAP:Envelope>"] ;*/
    
    
    
    NSString * envelopeText = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<GetListOfPPLForNeev xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                               @"<buname>TMCV</buname>"
                               @"<attr1></attr1>"
                               @"<attr2></attr2>"
                               @"</GetListOfPPLForNeev>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>"] ;
    
    
    
    
    
    
    
    NSLog(@"\n envlopeString Of user details....!!!!%@",envelopeText);
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@",theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    
    NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    // [[RequestDelegate alloc]initiateRequest:request name:@"getActivityPPLConnection"];
    
    
    [[RequestDelegate alloc]initiateRequest:request name:@"getSaleStagePPLForSearchOpportunityConnection"];
    
    
}
-(void)callTahshil
{
    NSLog(@"Distict..and . %@ %@",appdelegate.loginUD,userDetailsVal_.ROW_ID);
    
       
    NSString * envelopeText = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<GetListOfTehsil xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                               @"<poistionid>%@</poistionid>"
                               @"<districtname>%@</districtname>"
                               @"<attr1></attr1>"
                               @"</GetListOfTehsil>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,appdelegate.loginUD];
    
    
    NSString * envelopeText1 = [NSString stringWithFormat:
                                @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                @"<SOAP:Body>"
                                @"<GetListOfPPLForNeev xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                @"<buname>TMCV</buname>"
                                @"<attr1></attr1>"
                                @"<attr2></attr2>"
                                @"</GetListOfPPLForNeev>"
                                @"</SOAP:Body>"
                                @"</SOAP:Envelope>"] ;
    
    NSLog(@"\n envlopeString Of user details....!!!!%@",envelopeText);
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@",theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    
    NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"getTahshilSearchOpportunityConnection"];
    
}

-(void)SaleStageFound:(NSNotification*)notification
{
    
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n SaleStageFound Activity Type response... %@ ",response);
    
    if (saleStagePickerArr)
    {
        [saleStagePickerArr removeAllObjects];
    }
    
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    
    
    TBXMLElement *container = [TBXML childElementNamed:@"getListSaleStageJavaCallResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
    TBXMLElement *old = [TBXML childElementNamed:@"old" parentElement:tuple];
    TBXMLElement *getListSaleStageJavaCall = [TBXML childElementNamed:@"getListSaleStageJavaCall" parentElement:old];
    TBXMLElement *getListSaleStageJavaCall2 = [TBXML childElementNamed:@"getListSaleStageJavaCall" parentElement:getListSaleStageJavaCall];
    TBXMLElement *getListSaleStageJavaCall3 = [TBXML childElementNamed:@"getListSaleStageJavaCall" parentElement:getListSaleStageJavaCall2];
    
    TBXMLElement *tuple2 =[TBXML childElementNamed:@"tuple" parentElement:getListSaleStageJavaCall3];
    
    if (tuple2)
    {
        do
        {
            TBXMLElement *SALES_STAGE_NAME  = [TBXML childElementNamed:@"SALES_STAGE_NAME" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple2]];
            NSString *SALE_STAGE_NAME = [TBXML textForElement:SALES_STAGE_NAME];
            NSLog(@"\n SALE_STAGE_NAME : %@",SALE_STAGE_NAME);
            [saleStagePickerArr addObject:SALE_STAGE_NAME];
            
        }while ((tuple2 = tuple2->nextSibling));
        NSLog(@"Sales Stages : %@",saleStagePickerArr);
    }
    if ((saleStagePickerArr.count) > 0)
    {
        //  [appdelegate hideAlert];
    }
}
-(void)SaleTahshilFound:(NSNotification*)notification
{
    
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n SaleTaluka response... %@ ",response);
    if([response isEqual:@""]){
        
        NSLog(@"Data....nhi ahe ");
    }
    else{
        if (SalesTaluka_PickerArr)
        {
            [SalesTaluka_PickerArr removeAllObjects];
        }
        
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        
        NSLog(@"Which..");
        TBXMLElement *container = [TBXML childElementNamed:@"GetListOfTehsilResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        // TBXMLElement *old = [TBXML childElementNamed:@"old" parentElement:tuple];
        // TBXMLElement *getListSaleStageJavaCall = [TBXML childElementNamed:@"GetListOfTehsil" parentElement:old];
        // TBXMLElement *getListSaleStageJavaCall2 = [TBXML childElementNamed:@"GetListOfTehsil" parentElement:getListSaleStageJavaCall];
        //  TBXMLElement *getListSaleStageJavaCall3 = [TBXML childElementNamed:@"GetListOfTehsil" parentElement:getListSaleStageJavaCall2];
        
        //  TBXMLElement *tuple2 =[TBXML childElementNamed:@"tuple" parentElement:getListSaleStageJavaCall3];
        
        if (tuple)
        {
            
            do
            {
                TBXMLElement *S_Lst_Of_Val  = [TBXML childElementNamed:@"CX_DISTRICT_MAS" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement *NAME = [TBXML childElementNamed:@"X_TALUKA" parentElement:S_Lst_Of_Val];
                NSString *str_NAME = [TBXML textForElement:NAME];
                NSLog(@"\n str_S_Lst_Of_Val : %@",str_NAME);
                [SalesTaluka_PickerArr addObject:str_NAME];
                
            }while ((tuple = tuple->nextSibling));
            /* do
             {
             TBXMLElement *SALES_STAGE_NAME  = [TBXML childElementNamed:@"CX_DISTRICT_MAS" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple2]];
             NSString *SALE_STAGE_NAME = [TBXML textForElement:SALES_STAGE_NAME];
             NSLog(@"\n SALE_STAGE_NAME : %@",SALE_STAGE_NAME);
             [SalesTaluka_PickerArr addObject:SALE_STAGE_NAME];
             
             }while ((tuple2 = tuple2->nextSibling));*/
            NSLog(@"Sales Stages : %@",SalesTaluka_PickerArr);
        }
        if ((SalesTaluka_PickerArr.count) > 0)
        {
            //  [appdelegate hideAlert];
        }
    }
}

-(void)callAssignTo
{    NSLog(@"Distict %@ %@",appdelegate.loginUD,userDetailsVal_.ROW_ID);
    
    
    NSString * envelopeText = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Header xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                               @"<Logger xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                               @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/testtool/testtool.caf</DC>"
                               @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/methodsetsmanager/methodsetexplorer.caf</DC>"
                               @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/sysresourcemgr/sysresourcemgr.caf</DC>"
                               @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/com/cordys/cusp/cusp.caf</DC>"
                               @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"hopCount\">0</DC>"
                               @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"correlationID\">00215ef7-d846-11e4-e875-98c59ce1dde9</DC>"
                               @"</Logger>"
                               @"</header>"
                               @"</SOAP:Header>"
                               @"<SOAP:Body>"
                               @"<GetListOfNseOrDseForDSM xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                               @"<positionid>%@</positionid>"
                               @"</GetListOfNseOrDseForDSM>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope> ",userDetailsVal_.ROW_ID];
    
    
    NSString * envelopeText11 = [NSString stringWithFormat:
                                 @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                 @"<SOAP:Body>"
                                 @"<GetListOfTehsil xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                 @"<poistionid>%@</poistionid>"
                                 @"<districtname>%@</districtname>"
                                 @"<attr1></attr1>"
                                 @"</GetListOfTehsil>"
                                 @"</SOAP:Body>"
                                 @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,appdelegate.loginUD];
    
    
    NSString * envelopeText1 = [NSString stringWithFormat:
                                @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                @"<SOAP:Body>"
                                @"<GetListOfPPLForNeev xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                @"<buname>TMCV</buname>"
                                @"<attr1></attr1>"
                                @"<attr2></attr2>"
                                @"</GetListOfPPLForNeev>"
                                @"</SOAP:Body>"
                                @"</SOAP:Envelope>"] ;
    
    NSLog(@"\n envlopeString Of Assign TO....!!!!%@",envelopeText);
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@",theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    
    NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"getActivityAssignTo"];
    
}
-(void)ActivityAssignTo_Found:(NSNotification*)notification
{
    
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n Opty Assign TO response... %@ ",response);
    
    /*
     <SOAP:Envelope xmlns:SOAP="http://schemas.xmlsoap.org/soap/envelope/">
     <SOAP:Header xmlns:SOAP="http://schemas.xmlsoap.org/soap/envelope/">
     <header xmlns:SOAP="http://schemas.xmlsoap.org/soap/envelope/" xmlns="http://schemas.cordys.com/General/1.0/">
     <sender>
     <reply-to>cn=MobileApps Siebel WsApps Second Service Container,cn=MobileApps Siebel WsApps Second Service Group,cn=soap nodes,o=MobileApps,cn=cordys,cn=cbop,o=tatamotors.com</reply-to>
     <organizationalContext>o=MobileApps,cn=cordys,cn=cbop,o=tatamotors.com</organizationalContext>
     <component>cn=MobileApps Siebel WsApps Second Service Group,cn=soap nodes,o=MobileApps,cn=cordys,cn=cbop,o=tatamotors.com</component>
     </sender>
     <receiver>
     <component>cn=webgateway@tmairbopqa01,cn=cordys,cn=cbop,o=tatamotors.com</component>
     <sent-to xmlns="http://schemas.cordys.com/General/1.0/">socket://tmairbopqa01:12375/</sent-to>
     </receiver>
     <msg-id>00215ef7-d846-11e4-fce9-6108bec916f0</msg-id>
     <license>License has expired since 1303 day(s)</license>
     </header>
     </SOAP:Header>
     <SOAP:Body>
     <GetListOfNseOrDseForDSMResponse xmlns:SOAP="http://schemas.xmlsoap.org/soap/envelope/" xmlns="com.cordys.tatamotors.Dsmsiebelwsapp" preserveSpace="no" qAccess="0">
     <tuple xmlns="com.cordys.tatamotors.Dsmsiebelwsapp">
     <old>
     <S_PARTY xmlns="com.cordys.tatamotors.Dsmsiebelwsapp">
     <POSTION_ID>1-8RH323</POSTION_ID>
     <POSTION_NAME>TMCV-Sal-S-TN3-1004150-Coimbatore-ACE-DSE-C</POSTION_NAME>
     <NSE_LOBDSE_NAME>RAMANADEEPHAN M</NSE_LOBDSE_NAME>
     <POSITION_PH_NUM>9999999999</POSITION_PH_NUM>
     <LOBNAME>Pickups</LOBNAME>
     <POSITION_TYPE>DSE</POSITION_TYPE>
     </S_PARTY>
     </old>
     </tuple>
     <tuple xmlns="com.cordys.tatamotors.Dsmsiebelwsapp">
     <old>
     <S_PARTY xmlns="com.cordys.tatamotors.Dsmsiebelwsapp">
     <POSTION_ID>1-8RH32E</POSTION_ID>
     <POSTION_NAME>TMCV-Sal-S-TN3-1004150-Coimbatore-ACE-DSE-01</POSTION_NAME>
     <NSE_LOBDSE_NAME>GANESH V</NSE_LOBDSE_NAME>
     <POSITION_PH_NUM>9994017752</POSITION_PH_NUM>
     <LOBNAME>Pickups</LOBNAME>
     <POSITION_TYPE>DSE</POSITION_TYPE>
     </S_PARTY>
     </old>
     </tuple>
    </GetListOfNseOrDseForDSMResponse>
     </SOAP:Body>
     </SOAP:Envelope>

     */
    
    if([response isEqual:@""]){
        
        NSLog(@"Data....nhi ahe ");
    }
    else{
        if (SalesAssignTo_PickerArr)
        {
            [SalesAssignTo_PickerArr removeAllObjects];
        }
        
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        
        NSLog(@"Which..");
        TBXMLElement *container = [TBXML childElementNamed:@"GetListOfNseOrDseForDSMResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple)
        {
            NSLog(@"in");
            do
            {
                NSLog(@"Out in ");
                
                TBXMLElement *S_Lst_Of_Val  = [TBXML childElementNamed:@"S_PARTY" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement *NAME = [TBXML childElementNamed:@"NSE_LOBDSE_NAME" parentElement:S_Lst_Of_Val];
                NSString *str_NAME = [TBXML textForElement:NAME];
                NSLog(@"\n str_NSE : %@",str_NAME);
                [SalesAssignTo_PickerArr addObject:str_NAME];
                /*
                TBXMLElement *POSITION_ID = [TBXML childElementNamed:@"POSITION_ID" parentElement:S_Lst_Of_Val];
                NSString *str_Position = [TBXML textForElement:POSITION_ID];
                NSLog(@"\n str_NSE : %@",str_Position);
                // [SalesAssignTo_PickerArr addObject:str_Position];*/
                
            }while ((tuple = tuple->nextSibling));
            
            NSLog(@"Sales Stages : %@",SalesAssignTo_PickerArr);
        }
        if ((SalesAssignTo_PickerArr.count) > 0)
        {
            //  [appdelegate hideAlert];
        }
    }
    [self hideAlert];
}

-(void)saleSatgeFailed:(NSNotification*)notification
{
    
}
-(void)SaleStage_PPL_Found:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n SaleStage_PPL_Found response... %@ ",response);
    
    if (ppl_ID_PickerArr || pplNamePickerArr)
    {
        [ppl_ID_PickerArr removeAllObjects];
        [pplNamePickerArr removeAllObjects];
    }
    
    
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    
    TBXMLElement *container = [TBXML childElementNamed:@"GetListOfPPLForNeevResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
    
    if (tuple)
    {
        do
        {
            TBXMLElement *S_PROD_LN  = [TBXML childElementNamed:@"S_PROD_LN" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
            TBXMLElement *PPL_ID = [TBXML childElementNamed:@"PPL_ID" parentElement:S_PROD_LN];
            NSString *PPL_ID_ = [TBXML textForElement:PPL_ID];
            NSLog(@"\n PPL_ID_ : %@",PPL_ID_);
            [ppl_ID_PickerArr addObject:PPL_ID_];
            
            TBXMLElement *PPL_NAME = [TBXML childElementNamed:@"PPL_NAME" parentElement:S_PROD_LN];
            NSString *PPL_NAME_ = [TBXML textForElement:PPL_NAME];
            NSLog(@"\n SALE_STAGE_NAME : %@",PPL_NAME_);
            [pplNamePickerArr addObject:PPL_NAME_];
            
        }while ((tuple = tuple->nextSibling));
        
    }
    if ((pplNamePickerArr.count) > 0){
        //  [appdelegate hideAlert];
    }
}
-(void)saleStage_PPL_Failed:(NSNotification*)notification
{
    NSLog(@"PPL failed");
}
/*

-(void)CallSearch
{
    //    NSString * envelopeText5 = [NSString stringWithFormat:
    //                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
    //                               @"<SOAP:Body>"
    //                               @"<SearchOpptyBasedOnCriteria xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\"preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
    //                               @"<positionid></positionid>"
    //                               @"<fromdate>10-Mar-2014</fromdate>"
    //                               @"<todate>30-Apr-2015</todate>"
    //                               @"<salestagename></salestagename>"
    //                               @"<pplname></pplname>"
    //                               @"<tehsilname></tehsilname>"
    //                               @"<tgmname></tgmname>"
    //                               @"<tkmname></tkmname>"
    //                               @"<assignname></assignname>"
    //                               @"<customercellnumber></customercellnumber>"
    //                               @"<contactfirstname></contactfirstname>"
    //                               @"<attr1></attr1>"
    //                               @"<attr2></attr2>"
    //                               @"<attr3></attr3>"
    //                               @"</SearchOpptyBasedOnCriteria>"
    //                               @"</SOAP:Body>"
    //                               @"</SOAP:Envelope>"];
    
    
    
    NSString * envelopeText = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Header xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                               @"<Logger xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                               @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/testtool/testtool.caf</DC>"
                               @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/methodsetsmanager/methodsetexplorer.caf</DC>"
                               @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/sysresourcemgr/sysresourcemgr.caf</DC>"
                               @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/com/cordys/cusp/cusp.caf</DC>"
                               @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"hopCount\">0</DC>"
                               @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"correlationID\">00215ef7-d846-11e4-e713-b975c14add47</DC>"
                               @"</Logger>"
                               @"</header>"
                               @"</SOAP:Header>"
                               @"<SOAP:Body>"
                               @"<SearchOpptyBasedOnCriteriaForDsm xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                               @"<positionid>%@</positionid>"
                               @"<fromdate>18-Apr-2014</fromdate>"
                               @"<todate>21-Apr-2015</todate>"
                               @"<salestagename></salestagename>"
                               @"<pplname></pplname>"
                               @"<tehsilname></tehsilname>"
                               @"<assignname/>"
                               @"<customercellnumber></customercellnumber>"
                               @"<contactfirstname></contactfirstname>"
                               @"<attr1></attr1>"
                               @"<attr2></attr2>"
                               @"<attr3></attr3>"
                               @"<dsepositionid></dsepositionid>"
                               @"<contactlastname></contactlastname>"
                               @"</SearchOpptyBasedOnCriteriaForDsm>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",userDetailsVal_.ROW_ID];
    
    
    
    NSString * envelopeText1 = [NSString stringWithFormat:
                                @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                @"<SOAP:Body>"
                                @"<SearchOpptyBasedOnCriteria xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\"preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                @"<positionid></positionid>"
                                @"<fromdate>10-Nov-2014</fromdate>"
                                @"<todate>30-Apr-2015</todate>"
                                @"<salestagename>%@</salestagename>"
                                @"<pplname>%@</pplname>"
                                @"<tehsilname>%@</tehsilname>"
                                @"<tgmname>%@</tgmname>"
                                @"<tkmname></tkmname>"
                                @"<assignname>%@</assignname>"
                                @"<customercellnumber>%@</customercellnumber>"
                                @"<contactfirstname>%@</contactfirstname>"
                                @"<attr1></attr1>"
                                @"<attr2></attr2>"
                                @"<attr3></attr3>"
                                @"</SearchOpptyBasedOnCriteria>"
                                @"</SOAP:Body>"
                                @"</SOAP:Envelope>",txtSalesStage.text,txtPPL.text,txtTaluka.text,ActiveInActive,txtAssignTO.text,txtCustomerMobile.text,txtCustomerName.text];
    
    /*
     NSString * envelopeText = [NSString stringWithFormat:
     @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
     @"<SOAP:Body>"
     @"<GetOpportunityBasedOnSearchCriteria xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
     @"<positionid>%@</positionid>"
     @"<saleStage>%@</saleStage>"
     @"<PPLName>%@</PPLName>"
     @"<fromdate>%@</fromdate>"
     @"<todate>%@</todate>"
     @"<rang1>%d</rang1>"
     @"<rang2>%d</rang2>"
     @"<attr1></attr1>"
     @"<attr2></attr2>"
     @"<attr3></attr3>"
     @"</GetOpportunityBasedOnSearchCriteria>"
     @"</SOAP:Body>"
     @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,txt_saleStage.text,txt_pplName.text,txt_fromDate.text,txr_toDate.text,startRange,endRange] ;
    //please change range make dynamic insted of
    
    //  searchOpportunityResultPage_Variables_.saleStage_ = txt_saleStage.text; // use of instance variable is ,which we can use in next class/// for search and pagination purpose
    //   searchOpportunityResultPage_Variables_.pplName_ = txt_pplName.text; // use of instance variable is ,which we can use in next class/// for search and pagination purpose
    //  searchOpportunityResultPage_Variables_.fromDate_ = txt_fromDate.text; // use of instance variable is ,which we can use in next class/// for search and pagination purpose
    //   searchOpportunityResultPage_Variables_.todate_ = txr_toDate.text; // use of instance variable is ,which we can use in next class/// for search and pagination purpose
    
    NSLog(@"\n envlopeString Of user details....!!!!%@",envelopeText);
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@",theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    
    NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"SearchOpportunities_Connection"];
    
}

-(void)SearchOpportunities_Found:(NSNotification*)notification
{
    int i = 0;
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    
    NSLog(@"\n Response.. SearchOpportunities ....%@",response);
    
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    TBXMLElement *container = [TBXML childElementNamed:@"SearchOpptyBasedOnCriteriaForDsmResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    /*
     if (SearchOpportunityListArray)
     {
     [ SearchOpportunityListArray removeAllObjects];
     }
     
     TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
     if (tuple)
     {
     
     do {
     
     searchOppListVar = nil;
     searchOppListVar = [[Search_OpportunityList_Var alloc]init];
     
     TBXMLElement *table  = [TBXML childElementNamed:@"TABLE" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
     
     TBXMLElement *OPTY_ID = [TBXML childElementNamed:@"OPTY_ID" parentElement:table];
     searchOppListVar.OPTY_ID = [TBXML textForElement:OPTY_ID];
     NSLog(@"OptyID : %@",searchOppListVar.OPTY_ID);
     
     
     TBXMLElement *CONTACT_ADDRESS = [TBXML childElementNamed:@"CONTACT_ADDRESS" parentElement:table];
     searchOppListVar.CONTACT_ADDRESS = [TBXML textForElement:CONTACT_ADDRESS];
     
     
     TBXMLElement *ADDRESS_ID = [TBXML childElementNamed:@"ADDRESS_ID" parentElement:table];
     searchOppListVar.ADDRESS_ID = [TBXML textForElement:ADDRESS_ID];
     
     
     
     TBXMLElement *OPTY_NAME = [TBXML childElementNamed:@"OPTY_NAME" parentElement:table];
     searchOppListVar.OPTY_NAME = [TBXML textForElement:OPTY_NAME];
     
     
     
     TBXMLElement *PRODUCT_LINE = [TBXML childElementNamed:@"PRODUCT_LINE" parentElement:table];
     searchOppListVar.PRODUCT_LINE = [TBXML textForElement:PRODUCT_LINE];
     
     
     
     TBXMLElement *PARENT_PROD_LINE = [TBXML childElementNamed:@"PARENT_PROD_LINE" parentElement:table];
     searchOppListVar.PARENT_PROD_LINE = [TBXML textForElement:PARENT_PROD_LINE];
     
     
     TBXMLElement *VC = [TBXML childElementNamed:@"VC" parentElement:table];
     searchOppListVar.VC = [TBXML textForElement:VC];
     
     
     TBXMLElement *SALES_STAGE_DATE = [TBXML childElementNamed:@"SALES_STAGE_DATE" parentElement:table];
     searchOppListVar.SALES_STAGE_DATE = [TBXML textForElement:SALES_STAGE_DATE];
     
     
     TBXMLElement *SALE_STAGE_NAME = [TBXML childElementNamed:@"SALE_STAGE_NAME" parentElement:table];
     searchOppListVar.SALE_STAGE_NAME = [TBXML textForElement:SALE_STAGE_NAME];
     
     
     
     TBXMLElement *OPTY_CREAT_DATE = [TBXML childElementNamed:@"OPTY_CREAT_DATE" parentElement:table];
     searchOppListVar.OPTY_CREAT_DATE = [TBXML textForElement:OPTY_CREAT_DATE];
     
     
     TBXMLElement *CONTACT_ID = [TBXML childElementNamed:@"CONTACT_ID" parentElement:table];
     searchOppListVar.CONTACT_ID = [TBXML textForElement:CONTACT_ID];
     
     
     TBXMLElement *CONTACT_NAME = [TBXML childElementNamed:@"CONTACT_NAME" parentElement:table];
     searchOppListVar.CONTACT_NAME = [TBXML textForElement:CONTACT_NAME];
     
     
     TBXMLElement *CONTACT_CELL_NUMBER = [TBXML childElementNamed:@"CONTACT_CELL_NUMBER" parentElement:table];
     searchOppListVar.CONTACT_CELL_NUMBER = [TBXML textForElement:CONTACT_CELL_NUMBER];
     
     
     TBXMLElement *ACCOUNT_PHONE_NUMBER = [TBXML childElementNamed:@"ACCOUNT_PHONE_NUMBER" parentElement:table];
     searchOppListVar.ACCOUNT_PHONE_NUMBER = [TBXML textForElement:ACCOUNT_PHONE_NUMBER];
     
     
     TBXMLElement *ACCOUNT_ID = [TBXML childElementNamed:@"ACCOUNT_ID" parentElement:table];
     searchOppListVar.ACCOUNT_ID = [TBXML textForElement:ACCOUNT_ID];
     
     
     TBXMLElement *ACCOUNT_NAME = [TBXML childElementNamed:@"ACCOUNT_NAME" parentElement:table];
     searchOppListVar.ACCOUNT_NAME = [TBXML textForElement:ACCOUNT_NAME];
     
     
     TBXMLElement *ACCOUNT_LOCATION = [TBXML childElementNamed:@"ACCOUNT_LOCATION" parentElement:table];
     searchOppListVar.ACCOUNT_LOCATION = [TBXML textForElement:ACCOUNT_LOCATION];
     
     
     TBXMLElement *MAKE_LOST_TO = [TBXML childElementNamed:@"MAKE_LOST_TO" parentElement:table];
     searchOppListVar.MAKE_LOST_TO = [TBXML textForElement:MAKE_LOST_TO];
     
     TBXMLElement *MODEL_LOST_TO = [TBXML childElementNamed:@"MODEL_LOST_TO" parentElement:table];
     searchOppListVar.MODEL_LOST_TO = [TBXML textForElement:MODEL_LOST_TO];
     
     
     TBXMLElement *CLOSURE_SUMMARY = [TBXML childElementNamed:@"CLOSURE_SUMMARY" parentElement:table];
     searchOppListVar.CLOSURE_SUMMARY = [TBXML textForElement:CLOSURE_SUMMARY];
     
     
     TBXMLElement *REASON_LOST = [TBXML childElementNamed:@"REASON_LOST" parentElement:table];
     searchOppListVar.REASON_LOST = [TBXML textForElement:REASON_LOST];
     
     
     TBXMLElement *RNUM = [TBXML childElementNamed:@"RNUM" parentElement:table];
     searchOppListVar.RNUM = [TBXML textForElement:RNUM];
     
     
     TBXMLElement *RESULT_COUNT = [TBXML childElementNamed:@"RESULT_COUNT" parentElement:table];
     searchOppListVar.RESULT_COUNT = [TBXML textForElement:RESULT_COUNT];
     RESULTCOUNT = searchOppListVar.RESULT_COUNT;
     
     i++;
     
     NSLog(@"\n test opp.... %d!!!\n",i);
     NSLog(@"\n result count...... %@",RESULTCOUNT);
     [SearchOpportunityListArray addObject:searchOppListVar];
     
     
     } while ((tuple = tuple->nextSibling));
     
     NSLog(@"\nOpportunityListDisplayArr......%d",[SearchOpportunityListArray count]);
     [appdelegate hideAlert];
     Search_Opportunity_Result_VCViewController * searchOpportunityResult_VC = [self.storyboard instantiateViewControllerWithIdentifier:@"Search_Opportunity_Result_VCViewController"];
     [self.navigationController pushViewController:searchOpportunityResult_VC animated:YES];
     
     }
     else
     {
     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Server Error!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
     [alert show];
     [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"SearchOptyViewController"] animated:NO];
     
     }
 
}
}
*/

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(void)showAlert
{
    [MBProgressHUD showHUDAddedLoading:self.view animated:YES];
    
}
-(void)hideAlert
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}

///////////////////////////////


- (IBAction)frm1datebegin:(id)sender {
    
    
    
    
    if ([self.view viewWithTag:9]) {
        return;
    }
//    CGRect toolbarTargetFrame = CGRectMake(200, self.view.bounds.size.height-500-44, 320, 44);
//    CGRect datePickerTargetFrame = CGRectMake(200, self.view.bounds.size.height-500, 320, 216);
//    
//    UIView *darkView = [[UIView alloc] initWithFrame:self.view.bounds];
//    darkView.alpha = 0;
//    darkView.backgroundColor = [UIColor blackColor];
//    darkView.tag = 9;
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDatePicker:)];
//    [darkView addGestureRecognizer:tapGesture];
//    [self.view addSubview:darkView];
    
    CGRect toolbarTargetFrame = CGRectMake(200, self.view.bounds.size.height-250-44, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(200, self.view.bounds.size.height-250, 320, 216);
    
    UIView *darkView = [[UIView alloc] initWithFrame:self.view.bounds];
    darkView.alpha = 0;
    darkView.backgroundColor = [UIColor whiteColor];
    darkView.tag = 9;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDatePicker:)];
    [darkView addGestureRecognizer:tapGesture];
    [self.view addSubview:darkView];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height+44, 320, 216)];
    datePicker.tag = 10;
    
    [datePicker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
    //datePicker.backgroundColor=[UIColor colorWithRed:(2/255.0) green:(18/255.0) blue:(40/255.0) alpha:1];
    datePicker.backgroundColor=[UIColor whiteColor];
//    datePicker.layer.borderColor = [UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
//    datePicker.layer.borderWidth = 2;
    datePicker.datePickerMode = UIDatePickerModeDate;

    [[UILabel appearanceWhenContainedIn:[UIDatePicker class], nil]
     setTextColor:[UIColor whiteColor]];
    
    [self.view addSubview:datePicker];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 44)] ;
    toolBar.tag = 11;
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] ;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissDatePicker:)];
    [toolBar setItems:[NSArray arrayWithObjects:spacer, doneButton, nil]];
//    toolBar.layer.borderColor = [UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
//    toolBar.layer.borderWidth = 2;
    [self.view addSubview:toolBar];
    
    [UIView beginAnimations:@"MoveIn" context:nil];
    toolBar.frame = toolbarTargetFrame;
    datePicker.frame = datePickerTargetFrame;
    darkView.alpha = 0.8;
    [UIView commitAnimations];
    
}
- (void)changeDate:(UIDatePicker *)sender {
    NSLog(@"New Date: %@", sender.date);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MMM-yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:sender.date];
    NSLog(@"Date..Set  From : : %@",stringFromDate);
    txtFromDate.text=stringFromDate;
}

- (void)removeViews:(id)object {
    [[self.view viewWithTag:9] removeFromSuperview];
    [[self.view viewWithTag:10] removeFromSuperview];
    [[self.view viewWithTag:11] removeFromSuperview];
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



- (IBAction)todate1begin:(id)sender {
    
    
    
    if ([self.view viewWithTag:9]) {
        return;
    }
//    CGRect toolbarTargetFrame = CGRectMake(200, self.view.bounds.size.height-500-44, 320, 44);
//    CGRect datePickerTargetFrame = CGRectMake(200, self.view.bounds.size.height-500, 320, 216);
//    
//    UIView *darkView = [[UIView alloc] initWithFrame:self.view.bounds];
//    darkView.alpha = 0;
//    darkView.backgroundColor = [UIColor blackColor];
//    darkView.tag = 9;
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDatePicker:)];
//    [darkView addGestureRecognizer:tapGesture];
//    [self.view addSubview:darkView];

    
    CGRect toolbarTargetFrame = CGRectMake(200, self.view.bounds.size.height-250-44, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(200, self.view.bounds.size.height-250, 320, 216);
    
    UIView *darkView = [[UIView alloc] initWithFrame:self.view.bounds];
    darkView.alpha = 0;
    darkView.backgroundColor = [UIColor whiteColor];
    darkView.tag = 9;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDatePicker:)];
    [darkView addGestureRecognizer:tapGesture];
    [self.view addSubview:darkView];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height+44, 320, 216)];
    datePicker.tag = 10;
    
    [datePicker addTarget:self action:@selector(changeDate_:) forControlEvents:UIControlEventValueChanged];
    //datePicker.backgroundColor=[UIColor colorWithRed:(2/255.0) green:(18/255.0) blue:(40/255.0) alpha:1];
    datePicker.backgroundColor=[UIColor whiteColor];
//    datePicker.layer.borderColor = [UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
//    datePicker.layer.borderWidth = 2;
    datePicker.datePickerMode = UIDatePickerModeDate;

    [[UILabel appearanceWhenContainedIn:[UIDatePicker class], nil]
     setTextColor:[UIColor whiteColor]];
    
    [self.view addSubview:datePicker];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 44)] ;
    toolBar.tag = 11;
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] ;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissDatePicker:)];
    [toolBar setItems:[NSArray arrayWithObjects:spacer, doneButton, nil]];
//    toolBar.layer.borderColor = [UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
//    toolBar.layer.borderWidth = 2;
    [self.view addSubview:toolBar];
    
    [UIView beginAnimations:@"MoveIn" context:nil];
    toolBar.frame = toolbarTargetFrame;
    datePicker.frame = datePickerTargetFrame;
    darkView.alpha = 0.8;
    [UIView commitAnimations];
}
- (void)changeDate_:(UIDatePicker *)sender {
    NSLog(@"New Date: %@", sender.date);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MMM-yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:sender.date];
    NSLog(@"Date..Set  To: : %@",stringFromDate);
    txtToDate.text=stringFromDate;
}


- (IBAction)btnsalesstages1:(id)sender {
    
    [self.txtSalesStage resignFirstResponder];
    
    NSLog(@"Activity...Data %@",saleStagePickerArrHC);
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:self
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    // ObjC Fast Enumeration
//    [actionSheet addButtonWithTitle:@"Closed Lost at C1A"];
//    [actionSheet addButtonWithTitle:@"Closed Lost at C2A"];
    for (NSString *title in saleStagePickerArrHC) {
        [actionSheet addButtonWithTitle:title];
    }
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        [actionSheet showFromRect:[(UITextField *)sender frame] inView:self.viewFirst animated:YES];
        actionSheet.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
    }
    else{
        [actionSheet showInView:self.view];
    }
    actionSheet.tag = 1;
    
    
}

- (IBAction)btnDsename1:(id)sender {
    
    [self.txtAssignTO resignFirstResponder];
    
    NSLog(@"Activity...Data %@",SalesAssignTo_PickerArr_Static);
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:self
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    // ObjC Fast Enumeration
    for (NSString *title in SalesAssignTo_PickerArr_Static) {
        [actionSheet addButtonWithTitle:title];
    }
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        [actionSheet showFromRect:[(UITextField *)sender frame] inView:self.viewSecond
                         animated:YES];
        actionSheet.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
    }
    else{
        [actionSheet showInView:self.view];
    }
    actionSheet.tag = 4;
    
}

- (IBAction)btnppl1:(id)sender{
    
    [self.txtPPL resignFirstResponder];
    
    
    NSLog(@"Activity...Data %@",pplNamePickerArr);
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:self
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    // ObjC Fast Enumeration
    for (NSString *title in pplNamePickerArr) {
        [actionSheet addButtonWithTitle:title];
    }
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        [actionSheet showFromRect:[(UITextField *)sender frame] inView:self.viewSecond animated:YES];
        actionSheet.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
    }
    else{
        [actionSheet showInView:self.view];
    }
    actionSheet.tag = 2;
}

- (IBAction)btnTaluka1:(id)sender {
    
    [self.txtTaluka resignFirstResponder];
    
    NSLog(@"Activity...Data %@",activityType_PickerArr);
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:self
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    // ObjC Fast Enumeration
    for (NSString *title in activityType_PickerArr) {
        [actionSheet addButtonWithTitle:title];
    }
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        [actionSheet showFromRect:[(UITextField *)sender frame] inView:self.viewFirst animated:YES];
        actionSheet.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
    }
    else{
        [actionSheet showInView:self.view];
    }
    actionSheet.tag = 3;
}


- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSLog(@"button click ....%ld",(long)buttonIndex);
    if(txtSalesStage){
        NSLog(@"... in");
        switch (popup.tag) {
                NSLog(@"... in");
            case 1:
                if(buttonIndex == actionSheet.cancelButtonIndex)
                {
                    NSLog(@"ek..");
                    return;
                }else{
                    NSLog(@"Button index %ld",(long)buttonIndex);
                    self.txtSalesStage.text = NSLocalizedString([saleStagePickerArrHC objectAtIndex:buttonIndex],@"");
                    
                }
                
        }
    }
    if(txtPPL){
        switch (popup.tag) {
            case 2:
                if(buttonIndex == actionSheet.cancelButtonIndex)
                {    return;
                }else{
                    NSLog(@"Button index %ld",(long)buttonIndex);
                    txtPPL.text = NSLocalizedString([pplNamePickerArr objectAtIndex:buttonIndex],@"");
                }
                
        }
    }//if
    if(txtTaluka){
        switch (popup.tag) {
            case 3:
                if(buttonIndex == actionSheet.cancelButtonIndex)
                {    return;
                }else{
                    NSLog(@"Button index %ld",(long)buttonIndex);
                    txtTaluka.text = NSLocalizedString([activityType_PickerArr objectAtIndex:buttonIndex],@"");
                }
                
        }
    }//if
    if(txtAssignTO){
        switch (popup.tag) {
            case 4:
                if(buttonIndex == actionSheet.cancelButtonIndex)
                {    return;
                }else{
                    NSLog(@"Button index %ld",(long)buttonIndex);
                    txtAssignTO.text = NSLocalizedString([SalesAssignTo_PickerArr_Static objectAtIndex:buttonIndex],@"");
                }
        }
    }//if
}








@end



