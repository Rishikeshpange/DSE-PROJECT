


#import "OpportunitySearchResultViewController.h"
#import "manageOpportunity_Cell.h"
#import  "Search_OpportunityList_Var.h"
#import "TBXML.h"
#import "MBProgressHUD.h"
#import "RequestDelegate.h"
@interface OpportunitySearchResultViewController ()
{
    UIAlertView *alert;
}
@end

@implementation OpportunitySearchResultViewController
@synthesize optySearchDetails,optySearchDetails_Comes;
@synthesize txtFromDate,txtSalesStages,txtToDate,txtPPL,txtActivityType,txtActivityStatus;
@synthesize CustomerName;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showAlert];
    [self.tableViewData setHidden:YES];
    
    NSLog(@"Values.... %@ , %@ , %@,%@,%@,%@ ",txtSalesStages,txtFromDate,txtToDate,txtPPL,txtActivityType,txtActivityStatus);
    NSLog(@"\n\n Testing....%@ ",CustomerName);//Abhishek

    
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];//AppDelegate instance
    userDetailsVal_ = [UserDetails_Var sharedmanager]; // usedetails instance
    NSLog(@"Samlp Art Master: %@",userDetailsVal_.ROW_ID);
    
    //optySearchDetails_Comes=[[NSMutableArray alloc] init];
    
    // NSLog(@"Mutable array Comes :%lu",(unsigned long)[optySearchDetails_Comes count]);
    
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
    optySearchDetails=[[NSMutableArray alloc] init];
     appdelegate.OppurtunityList=[[NSMutableArray alloc] init];
    appdelegate.SearchOppurtunityList=[[NSMutableArray alloc] init];
    NSLog(@"Opty Name : %@",searchOppListVar.OPTY_NAME);
    [self CallSearch1];
   // [self CallSearch];
}
-(void)viewWillAppear:(BOOL)animated
{
    if ([appdelegate.fromOPTYDetail isEqualToString:@"CameFromOptyDetail"])
    {
        appdelegate.fromOPTYDetail=@"nil";
        [self showAlert];
        [self CallSearch1];
        
    }
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SearchOpportunities_Found:) name:@"SearchOpportunities_Found" object:nil];//For Sale Satge PPL Dropdown Count
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getCreateContacWithAccountDetails_Connection:) name:@"getCreateContacWithAccountDetails_Connection" object:nil];//For sale SatgeFailed DropDown fail
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SearchOpportunities_Found1:) name:@"SearchOpportunities_Found1" object:nil];
  
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"SearchOpportunities_Found" object:nil];//Gomzy // for Search Opportunities found
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"getCreateContacWithAccountDetails_Connection" object:nil];//Gomzy // for Search Opportunities failed
   [[NSNotificationCenter defaultCenter]removeObserver:self name:@"SearchOpportunities_Found1" object:nil];
}

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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [SearchOpportunityListArray count];
   // return [appdelegate.SearchOppurtunityList count];//count number of row from counting array hear cataGorry is An Array
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    searchOppListVar = nil;
    searchOppListVar = [[Search_OpportunityList_Var alloc]init];
    searchOppListVar = [SearchOpportunityListArray objectAtIndex:indexPath.row];
    NSLog(@"...Print . %@",SearchOpportunityListArray);
    static NSString *MyIdentifier = @"manageopportunitycell";
    //static NSString *CELL_ID2 = @"SOME_STUPID_ID2";
    
    manageOpportunity_Cell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[manageOpportunity_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    //  [cell.isHighlighted:NO];
    cell.backgroundColor=[UIColor clearColor];
    
    [cell.manage_opty_bg_view.layer setBorderColor:[UIColor colorWithRed:(221/255.0) green:(221/255.0) blue:(221/255.0) alpha:1].CGColor];
    [cell.manage_opty_bg_view.layer setBorderWidth:2.0f];
    cell.manage_opty_bg_view.layer.cornerRadius=5;
    
   
    
   // cell.lbl_Prod_Name.text=searchOppListVar.PRODUCT_LINE;
  
    
//    cell.lbl_Prod_Name.text=[[appdelegate.SearchOppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"PRODUCT_NAME1"];
//    cell.lbl_phoneNumber.text=[[appdelegate.SearchOppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"CONTACT_CELL_NUMBER"];
//    cell.lbl_Cust_Name.text=[[appdelegate.SearchOppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"CONTACT_NAME"];
//    cell.lbl_SalesStages_Name.text=[[appdelegate.SearchOppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"SALE_STAGE_NAME"];
//    cell.lbl_OptyCreation_Name.text=[[appdelegate.SearchOppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"OPTY_CREAT_DATE"];
//    cell.lbl_opty_Created_date.text=[[appdelegate.SearchOppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"OPTY_CREATED_DATE"];
//    cell.lbl_LastDone_Name.text=[[appdelegate.SearchOppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"LAST_DONE_ACTIVITY_TYPE"];
//    cell.Account_Name.text=[[appdelegate.SearchOppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"ACCOUNT_NAME"];
    
//    cell.lbl_phn_Name.text=searchOppListVar.CONTACT_CELL_NUMBER;
     cell.lbl_Prod_Name.text=searchOppListVar.PRODUCT_NAME1;
    cell.lbl_phoneNumber.text=searchOppListVar.CONTACT_CELL_NUMBER;
    cell.lbl_Cust_Name.text=searchOppListVar.CONTACT_NAME;
    cell.lbl_SalesStages_Name.text=searchOppListVar.SALE_STAGE_NAME;
//    cell.lbl_OptyCreation_Name.text=searchOppListVar.OPTY_CREAT_DATE;
    cell.lbl_opty_Created_date.text=searchOppListVar.OPTY_CREATED_DATE;
    cell.lbl_LastDone_Name.text=searchOppListVar.LAST_DONE_ACTIVITY_TYPE;
    cell.Account_Name.text=searchOppListVar.CUSTOMER_ACCOUNT_NAME;
    NSLog(@"CUSTOMER_ACCOUNT_NAME:%@",searchOppListVar.CUSTOMER_ACCOUNT_NAME);
    
     NSLog(@"LAST_DONE_ACTIVITY_TYPE:%@",searchOppListVar.LAST_DONE_ACTIVITY_TYPE);
    //cell.Account_Name.text=[[appdelegate.SearchOppurtunityList objectAtIndex:indexPath.row] valueForKey:@"CUSTOMER_ACCOUNT_NAME"];
    NSString *string1=searchOppListVar.CUSTOMER_ACCOUNT_NAME;
    if (string1== nil || string1 == (id)[NSNull null]) {
         cell.Account_Name.text=@"UNAVAILABLE";
        // nil branch
    }
   
    if (searchOppListVar.LAST_DONE_ACTIVITY_TYPE == nil || searchOppListVar.LAST_DONE_ACTIVITY_TYPE == (id)[NSNull null]) {
        cell.lbl_LastDone_Name.text=@"Unavailable";
        // nil branch
    } else
    {
        // category name is set
    }
//    if ( [searchOppListVar.LAST_DONE_ACTIVITY_TYPE isEqualToString:@""]) {
//        // cell.lbl_.text=searchOppListVar.PRODUCT_LINE;
//         cell.lbl_LastDone_Name.text=@"Unavailable";
//    }
//    else
//    {
//    // cell.lbl_Prod_Name.text=searchOppListVar.PRODUCT_LINE;
//    }
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    appdelegate.fromManageOptyview=nil;
    appdelegate.fromSearchOptyview=@"fromSearchOptyview";
    NSLog(@"%@", appdelegate.fromManageOptyview);
    NSLog(@"%@", appdelegate.fromSearchOptyview);
    searchOppListVar = [SearchOpportunityListArray objectAtIndex:indexPath.row ];
    
    appdelegate.optyrow=[indexPath row];

    // manageOpportunity_Cell *cell=(self.)cellForRowAtIndexPath
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)CallSearch
{
   
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
                               @"<fromdate>%@</fromdate>"
                               @"<todate>%@</todate>"
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
                               @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,txtFromDate,txtToDate];
    
    NSString * envelopeText1 = [NSString stringWithFormat:
                                @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                @"<SOAP:Body>"
                                @"<SearchOpptyBasedOnCriteria xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\"preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                @"<positionid>%@</positionid>"
                                @"<fromdate>%@</fromdate>"
                                @"<todate>%@</todate>"
                                @"<salestagename></salestagename>"
                                @"<pplname></pplname>"
                                @"<tehsilname></tehsilname>"
                                @"<tgmname></tgmname>"
                                @"<tkmname></tkmname>"
                                @"<assignname></assignname>"
                                @"<customercellnumber></customercellnumber>"
                                @"<contactfirstname></contactfirstname>"
                                @"<attr1></attr1>"
                                @"<attr2></attr2>"
                                @"<attr3></attr3>"
                                @"</SearchOpptyBasedOnCriteria>"
                                @"</SOAP:Body>"
                                @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,txtFromDate,txtToDate];
    
    
     NSString * envelopeText2 = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
    @"<SOAP:Body>"
    @"<GetOpportunityBasedOnSearchCriteria xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
    @"<positionid>%@</positionid>"
    @"<saleStage></saleStage>"
    @"<PPLName>""</PPLName>"
    @"<fromdate>%@</fromdate>"
    @"<todate>%@</todate>"
    @"<rang1>1</rang1>"
    @"<rang2>5</rang2>"
    @"<attr1></attr1>"
    @"<attr2></attr2>"
    @"<attr3></attr3>"
    @"</GetOpportunityBasedOnSearchCriteria>"
    @"</SOAP:Body>"
    @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,txtFromDate,txtToDate];
    
    
     NSString * envelopeText3 = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
    @"<SOAP:Header xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
    @"<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"
    @"<Logger xmlns=\"http://schemas.cordys.com/General/1.0/\">"
    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/testtool/testtool.caf</DC>"
    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/methodsetsmanager/methodsetexplorer.caf</DC>"
    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/sysresourcemgr/sysresourcemgr.caf</DC>"
    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/com/cordys/cusp/cusp.caf</DC>"
    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"hopCount\">0</DC>"
    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"correlationID\">00215ef7-d846-11e4-e8f3-989b3ff89fd5</DC>"
    @"</Logger>  </header>   </SOAP:Header> <SOAP:Body>"
    @"<SearchSFAOpportunity xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
    @"<fromdate>%@</fromdate>"
    @"<todate>%@</todate>"
    @"<PPL></PPL>"
    @"<salestage</salestage>"
    @"<positionid>1-3BTU4H9</positionid>"
    @"<range1>1</range1>"
    @"<range2>1</range2>"
    @"<accountname></accountname>"
    @"</SearchSFAOpportunity>"
    @"</SOAP:Body></SOAP:Envelope>",txtFromDate,txtToDate];
    
    
    NSString * envelopeText4 = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
    @"<SOAP:Header>"
    @"<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"
    @"<Logger>"
    @"<DC name=\"XForms\">/testtool/testtool.caf</DC>"
    @"<DC name=\"XForms\">/methodsetsmanager/methodsetexplorer.caf</DC>"
    @"<DC name=\"XForms\">/sysresourcemgr/sysresourcemgr.caf</DC>"
    @"<DC name=\"XForms\">/com/cordys/cusp/cusp.caf</DC>"
    @"<DC name=\"hopCount\">0</DC>"
    @"<DC name=\"correlationID\">00215ef7-d846-11e4-e8f3-989b3ff89fd5</DC>"
    @"</Logger>"
    @"</header>"
    @"</SOAP:Header>"
    @"<SOAP:Body>"
    @"<SearchSFAOpportunity xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
    @"<fromdate>%@</fromdate>"
    @"<todate>%@</todate>"
    @"<PPL>%@</PPL>"
    @"<salestage>%@</salestage>"
    @"<positionid>%@</positionid>"
    @"<range1>1</range1>"
     @"<range2>%@</range2>"
    @"<accountname>%@</accountname>"
    @"</SearchSFAOpportunity>"
    @"</SOAP:Body>"
    @"</SOAP:Envelope>",txtFromDate,txtToDate,txtPPL, txtSalesStages, userDetailsVal_.ROW_ID,searchOppListVar.RESULT_COUNT,CustomerName];
    
    NSString * envelopeText5 = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                @"<SOAP:Body>"
                                @"<GetSFAActivityBasedOnSearchCriteria xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                @"<positionid>%@</positionid>"
                                @"<PPLName>%@</PPLName>"
                                @"<fromdate>%@</fromdate>"
                                @"<todate>%@</todate>"
                                @"<activitystatus>%@</activitystatus>"
                                @"<activitytype>%@</activitytype>"
                                @"<rang1>1</rang1>"
                                @"<rang2>%@</rang2>"
                                @"<attr1></attr1>"
                                @"<attr2></attr2>"
                                @"<attr3></attr3>"
                                @"<salestage>%@</salestage>"
                                @"</GetSFAActivityBasedOnSearchCriteria>"
                                @"</SOAP:Body>"
                                @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,txtPPL,txtFromDate,txtToDate,txtActivityStatus,txtActivityType,searchOppListVar.RESULT_COUNT,txtSalesStages];
  
    
    NSLog(@"\n envlopeString Of user details....!!!!%@",envelopeText);
    NSData *envelope = [envelopeText4 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@",theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    
    NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText4 length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"SearchOpportunities_Connection"];
    
}

-(void)SearchOpportunities_Found:(NSNotification*)notification
{
    // int i = 0;
    // int i = 0; //for test loop
    SearchOpportunityListArray=[[NSMutableArray alloc] init];
    //Activities_Customer_list=[[NSMutableArray alloc] init];
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    
    NSLog(@"\n Response.. SearchOpportunities ....%@",response);
    if ([response isEqual:@""])
    {
        [self hideAlert];
       
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
    else{
        NSLog(@"Ek..");
        [self hideAlert];
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement *container = [TBXML childElementNamed:@"SearchSFAOpportunityResponse"  parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        
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
                
                TBXMLElement *OPTY_NAME = [TBXML childElementNamed:@"OPTY_NAME" parentElement:table];
                searchOppListVar.OPTY_NAME = [TBXML textForElement:OPTY_NAME];
                NSLog(@"OptyNAme : %@",searchOppListVar.OPTY_NAME);
                
                TBXMLElement *OPTY_ID = [TBXML childElementNamed:@"OPTY_ID" parentElement:table];
                searchOppListVar.OPTY_ID = [TBXML textForElement:OPTY_ID];
                NSLog(@"OptyID Opty Id : %@",searchOppListVar.OPTY_ID);
                
                TBXMLElement *PRODUCT_NAME1 = [TBXML childElementNamed:@"PRODUCT_NAME1" parentElement:table];
                searchOppListVar.PRODUCT_NAME1 = [TBXML textForElement:PRODUCT_NAME1];
                NSLog(@"OptyID Opty Id : %@",searchOppListVar.PRODUCT_NAME1);
                
                TBXMLElement *OPTY_CREATED_DATE = [TBXML childElementNamed:@"OPTY_CREATED_DATE" parentElement:table];
                searchOppListVar.OPTY_CREATED_DATE = [TBXML textForElement:OPTY_CREATED_DATE];
                NSLog(@"OptyNAme : %@",searchOppListVar.OPTY_CREATED_DATE);
                
                TBXMLElement *PRODUCT_ID = [TBXML childElementNamed:@"PRODUCT_ID" parentElement:table];
                searchOppListVar.PRODUCT_ID = [TBXML textForElement:PRODUCT_ID];
                NSLog(@"OptyNAme : %@",searchOppListVar.PRODUCT_ID);
                
                TBXMLElement *VC = [TBXML childElementNamed:@"VC" parentElement:table];
                searchOppListVar.VC = [TBXML textForElement:VC];
                NSLog(@"OptyNAme : %@",searchOppListVar.VC);
                
                TBXMLElement *TGM_TKM_NAME = [TBXML childElementNamed:@"TGM_TKM_NAME" parentElement:table];
                searchOppListVar.TGM_TKM_NAME = [TBXML textForElement:TGM_TKM_NAME];
                NSLog(@"OptyNAme : %@",searchOppListVar.TGM_TKM_NAME);
                
                TBXMLElement *TGM_TKM_PHONE_NUMBER = [TBXML childElementNamed:@"TGM_TKM_PHONE_NUMBER" parentElement:table];
                searchOppListVar.TGM_TKM_PHONE_NUMBER = [TBXML textForElement:TGM_TKM_PHONE_NUMBER];
                NSLog(@"OptyNAme : %@",searchOppListVar.TGM_TKM_PHONE_NUMBER);


                TBXMLElement *ACCOUNT_ID = [TBXML childElementNamed:@"ACCOUNT_ID" parentElement:table];
                searchOppListVar.ACCOUNT_ID = [TBXML textForElement:ACCOUNT_ID];
                NSLog(@"OptyNAme : %@",searchOppListVar.ACCOUNT_ID);
                
                TBXMLElement *ACCOUNT_TYPE = [TBXML childElementNamed:@"ACCOUNT_TYPE" parentElement:table];
                searchOppListVar.ACCOUNT_TYPE = [TBXML textForElement:ACCOUNT_TYPE];
                NSLog(@"OptyNAme : %@",searchOppListVar.ACCOUNT_TYPE);

                TBXMLElement *SALE_STAGE_NAME = [TBXML childElementNamed:@"SALES_STAGE_NAME" parentElement:table];
                searchOppListVar.SALE_STAGE_NAME = [TBXML textForElement:SALE_STAGE_NAME];
                NSLog(@"OptyNAme : %@",searchOppListVar.SALE_STAGE_NAME);
                
                
                TBXMLElement *SALES_STAGE_DATE = [TBXML childElementNamed:@"SALE_STAGE_UPDATED_DATE" parentElement:table];
                searchOppListVar.SALES_STAGE_DATE = [TBXML textForElement:SALES_STAGE_DATE];
                NSLog(@"OptyNAme : %@",searchOppListVar.SALES_STAGE_DATE);
                
                
                
                TBXMLElement *LEAD_ASSIGNED_NAME = [TBXML childElementNamed:@"LEAD_ASSIGNED_NAME" parentElement:table];
                searchOppListVar.LEAD_ASSIGNED_NAME = [TBXML textForElement:LEAD_ASSIGNED_NAME];
                NSLog(@"OptyNAme : %@",searchOppListVar.LEAD_ASSIGNED_NAME);

                TBXMLElement *LEAD_ASSIGNED_CELL_NUMBER = [TBXML childElementNamed:@"LEAD_ASSIGNED_CELL_NUMBER" parentElement:table];
                searchOppListVar.LEAD_ASSIGNED_CELL_NUMBER = [TBXML textForElement:LEAD_ASSIGNED_CELL_NUMBER];
                NSLog(@"OptyNAme : %@",searchOppListVar.LEAD_ASSIGNED_CELL_NUMBER);

                TBXMLElement *LEAD_POSITION = [TBXML childElementNamed:@"LEAD_POSITION" parentElement:table];
                searchOppListVar.LEAD_POSITION = [TBXML textForElement:LEAD_POSITION];
                NSLog(@"OptyNAme : %@",searchOppListVar.LEAD_POSITION);

                TBXMLElement *LEAD_ASSIGNED_POSITION_ID = [TBXML childElementNamed:@"LEAD_ASSIGNED_POSITION_ID" parentElement:table];
                searchOppListVar.LEAD_ASSIGNED_POSITION_ID = [TBXML textForElement:LEAD_ASSIGNED_POSITION_ID];
                NSLog(@"OptyNAme : %@",searchOppListVar.LEAD_ASSIGNED_POSITION_ID);

                
                TBXMLElement *CONTACT_NAME = [TBXML childElementNamed:@"CONTACT_NAME" parentElement:table];
                searchOppListVar.CONTACT_NAME = [TBXML textForElement:CONTACT_NAME];
              NSLog(@"OptyNAme : %@",searchOppListVar.CONTACT_NAME);
                
                TBXMLElement *CONTACT_FIRST_NAME = [TBXML childElementNamed:@"CONTACT_FIRST_NAME" parentElement:table];
                searchOppListVar.CONTACT_FIRST_NAME = [TBXML textForElement:CONTACT_FIRST_NAME];
                NSLog(@"OptyNAme : %@",searchOppListVar.CONTACT_FIRST_NAME);
                
                TBXMLElement *CONTACT_LAST_NAME = [TBXML childElementNamed:@"CONTACT_LAST_NAME" parentElement:table];
                searchOppListVar.CONTACT_LAST_NAME = [TBXML textForElement:CONTACT_LAST_NAME];
                NSLog(@"OptyNAme : %@",searchOppListVar.CONTACT_LAST_NAME);
                
                
                TBXMLElement *CONTACT_ID = [TBXML childElementNamed:@"CONTACT_ID" parentElement:table];
                searchOppListVar.CONTACT_ID = [TBXML textForElement:CONTACT_ID];
                NSLog(@"OptyNAme : %@",searchOppListVar.CONTACT_ID);
                
                TBXMLElement *CONTACT_ADDRESS = [TBXML childElementNamed:@"CONTACT_ADDRESS" parentElement:table];
                searchOppListVar.CONTACT_ADDRESS = [TBXML textForElement:CONTACT_ADDRESS];
                NSLog(@"OptyNAme : %@",searchOppListVar.CONTACT_ADDRESS);
            
                
                TBXMLElement *ADDRESS_ID = [TBXML childElementNamed:@"ADDRESS_ID" parentElement:table];
                searchOppListVar.ADDRESS_ID = [TBXML textForElement:ADDRESS_ID];
                NSLog(@"OptyNAme : %@",searchOppListVar.ADDRESS_ID);
                
                TBXMLElement *CONTACT_CELL_NUMBER = [TBXML childElementNamed:@"CONTACT_CELL_NUMBER" parentElement:table];
                searchOppListVar.CONTACT_CELL_NUMBER = [TBXML textForElement:CONTACT_CELL_NUMBER];
                NSLog(@"OptyNAme : %@",searchOppListVar.CONTACT_CELL_NUMBER);
                
                
                TBXMLElement *LAST_PENDING_ACTIVITY_TYPE = [TBXML childElementNamed:@"LAST_PENDING_ACTIVITY_TYPE" parentElement:table];
                searchOppListVar.LAST_PENDING_ACTIVITY_TYPE = [TBXML textForElement:LAST_PENDING_ACTIVITY_TYPE];
                NSLog(@"OptyNAme : %@",searchOppListVar.LAST_PENDING_ACTIVITY_TYPE);
                
                TBXMLElement *LAST_PENDING_ACTIVITY_ID = [TBXML childElementNamed:@"LAST_PENDING_ACTIVITY_ID" parentElement:table];
                searchOppListVar.LAST_PENDING_ACTIVITY_ID = [TBXML textForElement:LAST_PENDING_ACTIVITY_ID];
                NSLog(@"OptyNAme : %@",searchOppListVar.LAST_PENDING_ACTIVITY_ID);
                
                TBXMLElement *LAST_PENDING_ACTIVITY_STATUS = [TBXML childElementNamed:@"LAST_PENDING_ACTIVITY_STATUS" parentElement:table];
                searchOppListVar.LAST_PENDING_ACTIVITY_STATUS = [TBXML textForElement:LAST_PENDING_ACTIVITY_STATUS];
                NSLog(@"OptyNAme : %@",searchOppListVar.LAST_PENDING_ACTIVITY_STATUS);
                
                TBXMLElement *LAST_PEND_ACTIVIY_START_DATE = [TBXML childElementNamed:@"LAST_PEND_ACTIVIY_START_DATE" parentElement:table];
                searchOppListVar.LAST_PEND_ACTIVIY_START_DATE = [TBXML textForElement:LAST_PEND_ACTIVIY_START_DATE];
                NSLog(@"OptyNAme : %@",searchOppListVar.LAST_PEND_ACTIVIY_START_DATE);
                
                TBXMLElement *LAST_DONE_ACTIVITY_DATE = [TBXML childElementNamed:@"LAST_DONE_ACTIVITY_DATE" parentElement:table];
                searchOppListVar.LAST_DONE_ACTIVITY_DATE = [TBXML textForElement:LAST_DONE_ACTIVITY_DATE];
                NSLog(@"OptyNAme : %@",searchOppListVar.LAST_DONE_ACTIVITY_DATE);
                
                
                TBXMLElement *PRODUCT_NAME = [TBXML childElementNamed:@"PRODUCT_NAME" parentElement:table];
                searchOppListVar.PRODUCT_NAME = [TBXML textForElement:PRODUCT_NAME];
                NSLog(@"OptyNAme : %@",searchOppListVar.PRODUCT_NAME);
                
//                TBXMLElement *PRODUCT_NAME = [TBXML childElementNamed:@"PRODUCT_NAME" parentElement:table];
//                searchOppListVar.PRODUCT_NAME = [TBXML textForElement:PRODUCT_NAME];
//                NSLog(@"OptyNAme : %@",searchOppListVar.PRODUCT_NAME);
                
                
                TBXMLElement *CUSTOMER_ACCOUNT_NAME = [TBXML childElementNamed:@"CUSTOMER_ACCOUNT_NAME" parentElement:table];
                searchOppListVar.CUSTOMER_ACCOUNT_NAME = [TBXML textForElement:CUSTOMER_ACCOUNT_NAME];
                NSLog(@"CUSTOMER_ACCOUNT_NAMEsearch : %@",searchOppListVar.CUSTOMER_ACCOUNT_NAME);
                
                
                
                TBXMLElement *CUSTOMER_ACCOUNT_ID = [TBXML childElementNamed:@"CUSTOMER_ACCOUNT_ID" parentElement:table];
                searchOppListVar.CUSTOMER_ACCOUNT_ID = [TBXML textForElement:CUSTOMER_ACCOUNT_ID];
                NSLog(@"OptyNAme : %@",searchOppListVar.CUSTOMER_ACCOUNT_ID);
                
                
                TBXMLElement *CUSTOMER_ACCOUNT_LOCATION = [TBXML childElementNamed:@"CUSTOMER_ACCOUNT_LOCATION" parentElement:table];
                searchOppListVar.CUSTOMER_ACCOUNT_LOCATION = [TBXML textForElement:CUSTOMER_ACCOUNT_LOCATION];
                NSLog(@"OptyNAme : %@",searchOppListVar.CUSTOMER_ACCOUNT_LOCATION);
                
                
                
                TBXMLElement *CUSTOMER_PHONE_NUMBER = [TBXML childElementNamed:@"CUSTOMER_PHONE_NUMBER" parentElement:table];
                searchOppListVar.CUSTOMER_PHONE_NUMBER = [TBXML textForElement:CUSTOMER_PHONE_NUMBER];
                NSLog(@"OptyNAme : %@",searchOppListVar.CUSTOMER_PHONE_NUMBER);

                
                
                
                
                TBXMLElement *REV_PRODUCT_ID = [TBXML childElementNamed:@"REV_PRODUCT_ID" parentElement:table];
                searchOppListVar.REV_PRODUCT_ID = [TBXML textForElement:REV_PRODUCT_ID];
                NSLog(@"OptyNAme : %@",searchOppListVar.REV_PRODUCT_ID);
                
                
                TBXMLElement *PPL = [TBXML childElementNamed:@"PPL" parentElement:table];
                searchOppListVar.PPL = [TBXML textForElement:PPL];
                NSLog(@"OptyNAme : %@",searchOppListVar.PPL);
                
                TBXMLElement *RESULT_COUNT = [TBXML childElementNamed:@"RESULT_COUNT" parentElement:table];
                searchOppListVar.RESULT_COUNT = [TBXML textForElement:RESULT_COUNT];
                NSLog(@"OptyNAme : %@",searchOppListVar.RESULT_COUNT);
                
                
         
                // NSLog(@"\n result count...... %@",RESULTCOUNT);
                [SearchOpportunityListArray addObject:searchOppListVar];
                [appdelegate.OppurtunityList addObject:searchOppListVar];
                 [appdelegate.SearchOppurtunityList addObject:searchOppListVar];
                NSLog(@"\nOpportunityListDisplayArr...... Print %@",SearchOpportunityListArray);
                
            } while ((tuple = tuple->nextSibling));
            [self.tableViewData reloadData];
            NSLog(@"\nOpportunityListDisplayArr......%d",[SearchOpportunityListArray count]);
            if(SearchOpportunityListArray>=0){
                [self.tableViewData setHidden:NO];
                [self hideAlert];
            }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Server Error!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            // [appdelegate hideAlert];
//              OpportunityDetailsViewController * searchOpportunityResult_VC = [self.storyboard instantiateViewControllerWithIdentifier:@"Search_Opportunity_Result_VCViewController"];
//             searchOpportunityResult_VC.optySearchDetails_Comes=SearchOpportunityListArray;
//             
//             [self.navigationController pushViewController:searchOpportunityResult_VC animated:YES];
            
        }
        else
        {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Server Error!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            // [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"SearchOptyViewController"] animated:NO];
        }
    }
}

-(void)CallSearch1
{
    
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
                               @"<fromdate>%@</fromdate>"
                               @"<todate>%@</todate>"
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
                               @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,txtFromDate,txtToDate];
    
    NSString * envelopeText1 = [NSString stringWithFormat:
                                @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                @"<SOAP:Body>"
                                @"<SearchOpptyBasedOnCriteria xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\"preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                @"<positionid>%@</positionid>"
                                @"<fromdate>%@</fromdate>"
                                @"<todate>%@</todate>"
                                @"<salestagename></salestagename>"
                                @"<pplname></pplname>"
                                @"<tehsilname></tehsilname>"
                                @"<tgmname></tgmname>"
                                @"<tkmname></tkmname>"
                                @"<assignname></assignname>"
                                @"<customercellnumber></customercellnumber>"
                                @"<contactfirstname></contactfirstname>"
                                @"<attr1></attr1>"
                                @"<attr2></attr2>"
                                @"<attr3></attr3>"
                                @"</SearchOpptyBasedOnCriteria>"
                                @"</SOAP:Body>"
                                @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,txtFromDate,txtToDate];
    
    
    NSString * envelopeText2 = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                @"<SOAP:Body>"
                                @"<GetOpportunityBasedOnSearchCriteria xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                @"<positionid>%@</positionid>"
                                @"<saleStage></saleStage>"
                                @"<PPLName>""</PPLName>"
                                @"<fromdate>%@</fromdate>"
                                @"<todate>%@</todate>"
                                @"<rang1>1</rang1>"
                                @"<rang2>5</rang2>"
                                @"<attr1></attr1>"
                                @"<attr2></attr2>"
                                @"<attr3></attr3>"
                                @"</GetOpportunityBasedOnSearchCriteria>"
                                @"</SOAP:Body>"
                                @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,txtFromDate,txtToDate];
    
    
    NSString * envelopeText3 = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                @"<SOAP:Header xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                @"<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                                @"<Logger xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                                @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/testtool/testtool.caf</DC>"
                                @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/methodsetsmanager/methodsetexplorer.caf</DC>"
                                @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/sysresourcemgr/sysresourcemgr.caf</DC>"
                                @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/com/cordys/cusp/cusp.caf</DC>"
                                @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"hopCount\">0</DC>"
                                @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"correlationID\">00215ef7-d846-11e4-e8f3-989b3ff89fd5</DC>"
                                @"</Logger>  </header>   </SOAP:Header> <SOAP:Body>"
                                @"<SearchSFAOpportunity xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                @"<fromdate>%@</fromdate>"
                                @"<todate>%@</todate>"
                                @"<PPL></PPL>"
                                @"<salestage</salestage>"
                                @"<positionid>1-3BTU4H9</positionid>"
                                @"<range1>1</range1>"
                                @"<range2>1</range2>"
                                @"<accountname></accountname>"
                                @"</SearchSFAOpportunity>"
                                @"</SOAP:Body></SOAP:Envelope>",txtFromDate,txtToDate];
    
    
//    NSString * envelopeText4 = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                                @"<SOAP:Header>"
//                                @"<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"
//                                @"<Logger>"
//                                @"<DC name=\"XForms\">/testtool/testtool.caf</DC>"
//                                @"<DC name=\"XForms\">/methodsetsmanager/methodsetexplorer.caf</DC>"
//                                @"<DC name=\"XForms\">/sysresourcemgr/sysresourcemgr.caf</DC>"
//                                @"<DC name=\"XForms\">/com/cordys/cusp/cusp.caf</DC>"
//                                @"<DC name=\"hopCount\">0</DC>"
//                                @"<DC name=\"correlationID\">00215ef7-d846-11e4-e8f3-989b3ff89fd5</DC>"
//                                @"</Logger>"
//                                @"</header>"
//                                @"</SOAP:Header>"
//                                @"<SOAP:Body>"
//                                @"<SearchSFAOpportunity xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
//                                @"<fromdate>%@</fromdate>"
//                                @"<todate>%@</todate>"
//                                @"<PPL>%@</PPL>"
//                                @"<salestage>%@</salestage>"
//                                @"<positionid>%@</positionid>"
//                                @"<range1>1</range1>"
//                                @"<range2>1</range2>"
//                                @"<accountnamen/>"
//                                @"</SearchSFAOpportunity>"
//                                @"</SOAP:Body>"
//                                @"</SOAP:Envelope>",txtFromDate,txtToDate,txtPPL, txtSalesStages, userDetailsVal_.ROW_ID];
    
    NSString * envelopeText4 = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                @"<SOAP:Body>"
                                @"<SearchSFAOpportunity xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                @"<fromdate>%@</fromdate>"
                                @"<todate>%@</todate>"
                                @"<PPL>%@</PPL>"
                                @"<salestage>%@</salestage>"
                                @"<positionid>%@</positionid>"
                                @"<range1>1</range1>"
                                @"<range2>1</range2>"
                                @"<accountname>%@</accountname>"
                                @"</SearchSFAOpportunity>"
                                @"</SOAP:Body>"
                                @"</SOAP:Envelope>",txtFromDate,txtToDate,txtPPL, txtSalesStages, userDetailsVal_.ROW_ID,CustomerName];
    
    NSString * envelopeText5 = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
    @"<SOAP:Body>"
    @"<GetSFAActivityBasedOnSearchCriteria xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
    @"<positionid>%@</positionid>"
    @"<PPLName>%@</PPLName>"
    @"<fromdate>%@</fromdate>"
    @"<todate>%@</todate>"
    @"<activitystatus>%@</activitystatus>"
    @"<activitytype>%@</activitytype>"
    @"<rang1>1</rang1>"
    @"<rang2>4</rang2>"
    @"<attr1></attr1>"
    @"<attr2></attr2>"
    @"<attr3></attr3>"
    @"<salestage>%@</salestage>"
    @"</GetSFAActivityBasedOnSearchCriteria>"
    @"</SOAP:Body>"
                                @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,txtPPL,txtFromDate,txtToDate,txtActivityStatus,txtActivityType,txtSalesStages];
    
    
    NSLog(@"\n envlopeString Of user details....!!!!%@",envelopeText);
    NSData *envelope = [envelopeText4 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@",theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    
    NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText4 length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"SearchOpportunities_Connection1"];
    
}

-(void)SearchOpportunities_Found1:(NSNotification*)notification
{
    // int i = 0;
    // int i = 0; //for test loop
    SearchOpportunityListArray=[[NSMutableArray alloc] init];
    //Activities_Customer_list=[[NSMutableArray alloc] init];
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    
    NSLog(@"\n Response.. SearchOpportunities ....%@",response);
    if ([response isEqual:@""])
    {
        [self hideAlert];
        
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Nothing in Response !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        [self hideAlert];
      
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Network Fault String!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else{
       
        [self hideAlert];
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement *container = [TBXML childElementNamed:@"SearchSFAOpportunityResponse"  parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        if (!container) {
            
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"No Records Found With Selected Values" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];

            
        }
        else
        {
        
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
                
                TBXMLElement *OPTY_NAME = [TBXML childElementNamed:@"OPTY_NAME" parentElement:table];
                searchOppListVar.OPTY_NAME = [TBXML textForElement:OPTY_NAME];
                NSLog(@"OptyNAme : %@",searchOppListVar.OPTY_NAME);
                
                TBXMLElement *OPTY_ID = [TBXML childElementNamed:@"OPTY_ID" parentElement:table];
                searchOppListVar.OPTY_ID = [TBXML textForElement:OPTY_ID];
                NSLog(@"OptyID Opty Id : %@",searchOppListVar.OPTY_ID);
                
                TBXMLElement *PRODUCT_NAME1 = [TBXML childElementNamed:@"PRODUCT_NAME1" parentElement:table];
                searchOppListVar.PRODUCT_NAME1 = [TBXML textForElement:PRODUCT_NAME1];
                NSLog(@"OptyID Opty Id : %@",searchOppListVar.PRODUCT_NAME1);
                
                TBXMLElement *OPTY_CREATED_DATE = [TBXML childElementNamed:@"OPTY_CREATED_DATE" parentElement:table];
                searchOppListVar.OPTY_CREATED_DATE = [TBXML textForElement:OPTY_CREATED_DATE];
                NSLog(@"OptyNAme : %@",searchOppListVar.OPTY_CREATED_DATE);
                
                TBXMLElement *PRODUCT_ID = [TBXML childElementNamed:@"PRODUCT_ID" parentElement:table];
                searchOppListVar.PRODUCT_ID = [TBXML textForElement:PRODUCT_ID];
                NSLog(@"OptyNAme : %@",searchOppListVar.PRODUCT_ID);
                
                TBXMLElement *VC = [TBXML childElementNamed:@"VC" parentElement:table];
                searchOppListVar.VC = [TBXML textForElement:VC];
                NSLog(@"OptyNAme : %@",searchOppListVar.VC);
                
                TBXMLElement *TGM_TKM_NAME = [TBXML childElementNamed:@"TGM_TKM_NAME" parentElement:table];
                searchOppListVar.TGM_TKM_NAME = [TBXML textForElement:TGM_TKM_NAME];
                NSLog(@"OptyNAme : %@",searchOppListVar.TGM_TKM_NAME);
                
                TBXMLElement *TGM_TKM_PHONE_NUMBER = [TBXML childElementNamed:@"TGM_TKM_PHONE_NUMBER" parentElement:table];
                searchOppListVar.TGM_TKM_PHONE_NUMBER = [TBXML textForElement:TGM_TKM_PHONE_NUMBER];
                NSLog(@"OptyNAme : %@",searchOppListVar.TGM_TKM_PHONE_NUMBER);
                
                
                TBXMLElement *ACCOUNT_ID = [TBXML childElementNamed:@"ACCOUNT_ID" parentElement:table];
                searchOppListVar.ACCOUNT_ID = [TBXML textForElement:ACCOUNT_ID];
                NSLog(@"OptyNAme : %@",searchOppListVar.ACCOUNT_ID);
                
                TBXMLElement *ACCOUNT_TYPE = [TBXML childElementNamed:@"ACCOUNT_TYPE" parentElement:table];
                searchOppListVar.ACCOUNT_TYPE = [TBXML textForElement:ACCOUNT_TYPE];
                NSLog(@"OptyNAme : %@",searchOppListVar.ACCOUNT_TYPE);
                
                TBXMLElement *SALE_STAGE_NAME = [TBXML childElementNamed:@"SALES_STAGE_NAME" parentElement:table];
                searchOppListVar.SALE_STAGE_NAME = [TBXML textForElement:SALE_STAGE_NAME];
                NSLog(@"OptyNAme : %@",searchOppListVar.SALE_STAGE_NAME);
                
                
                TBXMLElement *SALES_STAGE_DATE = [TBXML childElementNamed:@"SALE_STAGE_UPDATED_DATE" parentElement:table];
                searchOppListVar.SALES_STAGE_DATE = [TBXML textForElement:SALES_STAGE_DATE];
                NSLog(@"OptyNAme : %@",searchOppListVar.SALES_STAGE_DATE);
                
                
                
                TBXMLElement *LEAD_ASSIGNED_NAME = [TBXML childElementNamed:@"LEAD_ASSIGNED_NAME" parentElement:table];
                searchOppListVar.LEAD_ASSIGNED_NAME = [TBXML textForElement:LEAD_ASSIGNED_NAME];
                NSLog(@"OptyNAme : %@",searchOppListVar.LEAD_ASSIGNED_NAME);
                
                TBXMLElement *LEAD_ASSIGNED_CELL_NUMBER = [TBXML childElementNamed:@"LEAD_ASSIGNED_CELL_NUMBER" parentElement:table];
                searchOppListVar.LEAD_ASSIGNED_CELL_NUMBER = [TBXML textForElement:LEAD_ASSIGNED_CELL_NUMBER];
                NSLog(@"OptyNAme : %@",searchOppListVar.LEAD_ASSIGNED_CELL_NUMBER);
                
                TBXMLElement *LEAD_POSITION = [TBXML childElementNamed:@"LEAD_POSITION" parentElement:table];
                searchOppListVar.LEAD_POSITION = [TBXML textForElement:LEAD_POSITION];
                NSLog(@"OptyNAme : %@",searchOppListVar.LEAD_POSITION);
                
                TBXMLElement *LEAD_ASSIGNED_POSITION_ID = [TBXML childElementNamed:@"LEAD_ASSIGNED_POSITION_ID" parentElement:table];
                searchOppListVar.LEAD_ASSIGNED_POSITION_ID = [TBXML textForElement:LEAD_ASSIGNED_POSITION_ID];
                NSLog(@"OptyNAme : %@",searchOppListVar.LEAD_ASSIGNED_POSITION_ID);
                
                
                TBXMLElement *CONTACT_NAME = [TBXML childElementNamed:@"CONTACT_NAME" parentElement:table];
                searchOppListVar.CONTACT_NAME = [TBXML textForElement:CONTACT_NAME];
                NSLog(@"OptyNAme : %@",searchOppListVar.CONTACT_NAME);
                
                TBXMLElement *CONTACT_FIRST_NAME = [TBXML childElementNamed:@"CONTACT_FIRST_NAME" parentElement:table];
                searchOppListVar.CONTACT_FIRST_NAME = [TBXML textForElement:CONTACT_FIRST_NAME];
                NSLog(@"OptyNAme : %@",searchOppListVar.CONTACT_FIRST_NAME);
                
                TBXMLElement *CONTACT_LAST_NAME = [TBXML childElementNamed:@"CONTACT_LAST_NAME" parentElement:table];
                searchOppListVar.CONTACT_LAST_NAME = [TBXML textForElement:CONTACT_LAST_NAME];
                NSLog(@"OptyNAme : %@",searchOppListVar.CONTACT_LAST_NAME);
                
                
                TBXMLElement *CONTACT_ID = [TBXML childElementNamed:@"CONTACT_ID" parentElement:table];
                searchOppListVar.CONTACT_ID = [TBXML textForElement:CONTACT_ID];
                NSLog(@"OptyNAme : %@",searchOppListVar.CONTACT_ID);
                
                TBXMLElement *CONTACT_ADDRESS = [TBXML childElementNamed:@"CONTACT_ADDRESS" parentElement:table];
                searchOppListVar.CONTACT_ADDRESS = [TBXML textForElement:CONTACT_ADDRESS];
                NSLog(@"OptyNAme : %@",searchOppListVar.CONTACT_ADDRESS);
                
                
                TBXMLElement *ADDRESS_ID = [TBXML childElementNamed:@"ADDRESS_ID" parentElement:table];
                searchOppListVar.ADDRESS_ID = [TBXML textForElement:ADDRESS_ID];
                NSLog(@"OptyNAme : %@",searchOppListVar.ADDRESS_ID);
                
                TBXMLElement *CONTACT_CELL_NUMBER = [TBXML childElementNamed:@"CONTACT_CELL_NUMBER" parentElement:table];
                searchOppListVar.CONTACT_CELL_NUMBER = [TBXML textForElement:CONTACT_CELL_NUMBER];
                NSLog(@"OptyNAme : %@",searchOppListVar.CONTACT_CELL_NUMBER);
                
                
                TBXMLElement *LAST_PENDING_ACTIVITY_TYPE = [TBXML childElementNamed:@"LAST_PENDING_ACTIVITY_TYPE" parentElement:table];
                searchOppListVar.LAST_PENDING_ACTIVITY_TYPE = [TBXML textForElement:LAST_PENDING_ACTIVITY_TYPE];
                NSLog(@"OptyNAme : %@",searchOppListVar.LAST_PENDING_ACTIVITY_TYPE);
                
                TBXMLElement *LAST_PENDING_ACTIVITY_ID = [TBXML childElementNamed:@"LAST_PENDING_ACTIVITY_ID" parentElement:table];
                searchOppListVar.LAST_PENDING_ACTIVITY_ID = [TBXML textForElement:LAST_PENDING_ACTIVITY_ID];
                NSLog(@"OptyNAme : %@",searchOppListVar.LAST_PENDING_ACTIVITY_ID);
                
                TBXMLElement *LAST_PENDING_ACTIVITY_STATUS = [TBXML childElementNamed:@"LAST_PENDING_ACTIVITY_STATUS" parentElement:table];
                searchOppListVar.LAST_PENDING_ACTIVITY_STATUS = [TBXML textForElement:LAST_PENDING_ACTIVITY_STATUS];
                NSLog(@"OptyNAme : %@",searchOppListVar.LAST_PENDING_ACTIVITY_STATUS);
                
                TBXMLElement *LAST_PEND_ACTIVIY_START_DATE = [TBXML childElementNamed:@"LAST_PEND_ACTIVIY_START_DATE" parentElement:table];
                searchOppListVar.LAST_PEND_ACTIVIY_START_DATE = [TBXML textForElement:LAST_PEND_ACTIVIY_START_DATE];
                NSLog(@"OptyNAme : %@",searchOppListVar.LAST_PEND_ACTIVIY_START_DATE);
                
                TBXMLElement *LAST_DONE_ACTIVITY_DATE = [TBXML childElementNamed:@"LAST_DONE_ACTIVITY_DATE" parentElement:table];
                searchOppListVar.LAST_DONE_ACTIVITY_DATE = [TBXML textForElement:LAST_DONE_ACTIVITY_DATE];
                NSLog(@"OptyNAme : %@",searchOppListVar.LAST_DONE_ACTIVITY_DATE);
                
                
                TBXMLElement *PRODUCT_NAME = [TBXML childElementNamed:@"PRODUCT_NAME" parentElement:table];
                searchOppListVar.PRODUCT_NAME = [TBXML textForElement:PRODUCT_NAME];
                NSLog(@"OptyNAme : %@",searchOppListVar.PRODUCT_NAME);
                
                //                TBXMLElement *PRODUCT_NAME = [TBXML childElementNamed:@"PRODUCT_NAME" parentElement:table];
                //                searchOppListVar.PRODUCT_NAME = [TBXML textForElement:PRODUCT_NAME];
                //                NSLog(@"OptyNAme : %@",searchOppListVar.PRODUCT_NAME);
                
                
                TBXMLElement *CUSTOMER_ACCOUNT_NAME = [TBXML childElementNamed:@"CUSTOMER_ACCOUNT_NAME" parentElement:table];
                searchOppListVar.CUSTOMER_ACCOUNT_NAME = [TBXML textForElement:CUSTOMER_ACCOUNT_NAME];
                NSLog(@"OptyNAme : %@",searchOppListVar.CUSTOMER_ACCOUNT_NAME);
                
                
                
                TBXMLElement *CUSTOMER_ACCOUNT_ID = [TBXML childElementNamed:@"CUSTOMER_ACCOUNT_ID" parentElement:table];
                searchOppListVar.CUSTOMER_ACCOUNT_ID = [TBXML textForElement:CUSTOMER_ACCOUNT_ID];
                NSLog(@"OptyNAme : %@",searchOppListVar.CUSTOMER_ACCOUNT_ID);
                
                
                TBXMLElement *CUSTOMER_ACCOUNT_LOCATION = [TBXML childElementNamed:@"CUSTOMER_ACCOUNT_LOCATION" parentElement:table];
                searchOppListVar.CUSTOMER_ACCOUNT_LOCATION = [TBXML textForElement:CUSTOMER_ACCOUNT_LOCATION];
                NSLog(@"OptyNAme : %@",searchOppListVar.CUSTOMER_ACCOUNT_LOCATION);
                
                
                
                TBXMLElement *CUSTOMER_PHONE_NUMBER = [TBXML childElementNamed:@"CUSTOMER_PHONE_NUMBER" parentElement:table];
                searchOppListVar.CUSTOMER_PHONE_NUMBER = [TBXML textForElement:CUSTOMER_PHONE_NUMBER];
                NSLog(@"OptyNAme : %@",searchOppListVar.CUSTOMER_PHONE_NUMBER);
                
                
                
                
                
                TBXMLElement *REV_PRODUCT_ID = [TBXML childElementNamed:@"REV_PRODUCT_ID" parentElement:table];
                searchOppListVar.REV_PRODUCT_ID = [TBXML textForElement:REV_PRODUCT_ID];
                NSLog(@"OptyNAme : %@",searchOppListVar.REV_PRODUCT_ID);
                
                
                TBXMLElement *PPL = [TBXML childElementNamed:@"PPL" parentElement:table];
                searchOppListVar.PPL = [TBXML textForElement:PPL];
                NSLog(@"OptyNAme : %@",searchOppListVar.PPL);
                
                TBXMLElement *RESULT_COUNT = [TBXML childElementNamed:@"RESULT_COUNT" parentElement:table];
                searchOppListVar.RESULT_COUNT = [TBXML textForElement:RESULT_COUNT];
                NSLog(@"OptyNAme : %@",searchOppListVar.RESULT_COUNT);

                
                
                
                // NSLog(@"\n result count...... %@",RESULTCOUNT);
                [SearchOpportunityListArray addObject:searchOppListVar];
                [appdelegate.OppurtunityList addObject:searchOppListVar];
                 [appdelegate.SearchOppurtunityList addObject:searchOppListVar];
                NSLog(@"\nOpportunityListDisplayArr...... Print %@",SearchOpportunityListArray);
                
            } while ((tuple = tuple->nextSibling));
           // [self.tableViewData reloadData];
            [self CallSearch];
            NSLog(@"\nOpportunityListDisplayArr......%d",[SearchOpportunityListArray count]);
//            if(SearchOpportunityListArray>=0){
//                [self.tableViewData setHidden:NO];
//                [self hideAlert];
//            }
//            else
//            {
//                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Server Error!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                [alert show];
//            }
//            // [appdelegate hideAlert];
//            //              OpportunityDetailsViewController * searchOpportunityResult_VC = [self.storyboard instantiateViewControllerWithIdentifier:@"Search_Opportunity_Result_VCViewController"];
//            //             searchOpportunityResult_VC.optySearchDetails_Comes=SearchOpportunityListArray;
//            //             
//            //             [self.navigationController pushViewController:searchOpportunityResult_VC animated:YES];
            
        }
        else
        {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Server Error!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            // [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"SearchOptyViewController"] animated:NO];
        }
        }
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
