//
//  DetailViewController.m
//  test
//
//  Created by Sebastian Boldt on 07.03.13.
//  Copyright (c) 2013 LetsIDev. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "dashboardTodaysActivity_Cell_VC.h"
#import "dasboard_Email_tableCell_VC.h"
#import "Dashboard_Leads_tablecell_VC.h"
#import "Activity_List.h"
#import "RequestDelegate.h"
#import "TBXML.h"
#import "dashBoardActivity.h"
#import "dashBoardActivity_Cell.h"
#import "SearchActivity_List.h"


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


NSString* RESULTCOUNT;

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@end

@implementation DetailViewController
{
    UIAlertView *alert;
    NSString *FromDate,*ToDate,*mainDate,*MonthDate,*getStaus;
    NSString *CO_QTY_STR,*C1_QTY_STR,*C1A_QTY_STR,*C2_QTY_STR,*C3_QTY_STR;
    NSMutableArray *OpenStatus_Arr,*DoneStatus_Arr;
    NSNumber *openAdd,*doneAdd;
    int x,y,z,a,b,counter;
}
@synthesize pieChartLeft = _pieChartCopy;
@synthesize percentageLabel = _percentageLabel;
@synthesize Opty_Arr;
bool isShown = false;
#pragma mark - Managing the detail item

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    OpenStatus_Arr=[[NSMutableArray alloc] init];
    DoneStatus_Arr=[[NSMutableArray alloc] init];
    Opty_Arr=[[NSMutableArray alloc] init];
    
    /*
     <CO_QTY>117</CO_QTY>
     <C1_QTY>47</C1_QTY>
     <C1A_QTY>0</C1A_QTY>
     <C2_QTY>3</C2_QTY>
     <C3_QTY>0</C3_QTY>
     */
    
    
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];//AppDelegate instance
    userDetailsVal_ = [UserDetails_Var sharedmanager]; // usedetails instance
    
    self.viewFirst.layer.borderWidth=2.0f;
    
    self.viewSecond.layer.borderWidth=2.0f;
    
    self.middleView.layer.borderColor=[UIColor colorWithRed:(1/255.0) green:(47/255.0) blue:(97/255.0) alpha:1].CGColor;
    
    
    self.viewFirst.layer.borderColor=[UIColor colorWithRed:(1/255.0) green:(47/255.0) blue:(97/255.0) alpha:1].CGColor;
    
    self.viewSecond.layer.borderColor=[UIColor colorWithRed:(1/255.0) green:(47/255.0) blue:(97/255.0) alpha:1].CGColor;
    
//    self.pieChartLeft.backgroundColor=[UIColor whiteColor];
//     self.pieChartRight.backgroundColor=[UIColor whiteColor];
//    self.view.layer.borderColor =  [UIColor colorWithRed:(4/255.0) green:(41/255.0) blue:(82/255.0) alpha:1].CGColor;
//    self.view.layer.borderWidth = 3.0f;
    
 //   [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header_strip.png"] forBarMetrics:UIBarMetricsDefault];
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
    // Do any additional setup after loading the view.
    
    
    
    
    
    if (SYSTEM_VERSION_LESS_THAN(@"8.0"))
    {
        UILabel *timelabel=[[UILabel alloc]initWithFrame:CGRectMake(533, 455, 66, 21)];
        timelabel.backgroundColor=[UIColor clearColor];
        timelabel.text=@"TIME";
        timelabel.font=[UIFont boldSystemFontOfSize:17];
        timelabel.textColor=[UIColor blackColor];
        [self.view addSubview:timelabel];
        UILabel *timelabel1=[[UILabel alloc]initWithFrame:CGRectMake(180, 455, 66, 21)];
        timelabel1.backgroundColor=[UIColor clearColor];
        timelabel1.text=@"NAME";
        timelabel1.font=[UIFont boldSystemFontOfSize:17];
        timelabel1.textColor=[UIColor blackColor];
        [self.view addSubview:timelabel1];
        
        UILabel *timelabel2=[[UILabel alloc]initWithFrame:CGRectMake(362, 455, 66, 21)];
        timelabel2.backgroundColor=[UIColor clearColor];
        timelabel2.text=@"TYPE";
        timelabel2.font=[UIFont boldSystemFontOfSize:17];
        timelabel2.textColor=[UIColor blackColor];
        [self.view addSubview:timelabel2];
        
        UILabel *timelabel3=[[UILabel alloc]initWithFrame:CGRectMake(40, 455, 66, 21)];
        timelabel3.backgroundColor=[UIColor clearColor];
        timelabel3.text=@"STATUS";
        timelabel3.font=[UIFont boldSystemFontOfSize:17];
        timelabel3.textColor=[UIColor blackColor];
        [self.view bringSubviewToFront:timelabel];
        [self.view addSubview:timelabel3];
        
        [self.view bringSubviewToFront:timelabel];
        [self.view bringSubviewToFront:timelabel1];
        [self.view bringSubviewToFront:timelabel2];
        [self.view bringSubviewToFront:timelabel3];
        
    }
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        UILabel *timelabel=[[UILabel alloc]initWithFrame:CGRectMake(600, 455, 66, 21)];
        timelabel.backgroundColor=[UIColor clearColor];
        timelabel.text=@"TIME";
        timelabel.font=[UIFont boldSystemFontOfSize:17];
        timelabel.textColor=[UIColor blackColor];
        [self.view addSubview:timelabel];
        UILabel *timelabel1=[[UILabel alloc]initWithFrame:CGRectMake(195, 455, 66, 21)];
        timelabel1.backgroundColor=[UIColor clearColor];
        timelabel1.text=@"NAME";
        timelabel1.font=[UIFont boldSystemFontOfSize:17];
        timelabel1.textColor=[UIColor blackColor];
        [self.view addSubview:timelabel1];
        UILabel *timelabel2=[[UILabel alloc]initWithFrame:CGRectMake(410, 455, 66, 21)];
        timelabel2.backgroundColor=[UIColor clearColor];
        timelabel2.text=@"TYPE";
        timelabel2.font=[UIFont boldSystemFontOfSize:17];
        timelabel2.textColor=[UIColor blackColor];
        [self.view addSubview:timelabel2];
        UILabel *timelabel3=[[UILabel alloc]initWithFrame:CGRectMake(50, 455, 66, 21)];
        timelabel3.backgroundColor=[UIColor clearColor];
        timelabel3.text=@"STATUS";
        timelabel3.font=[UIFont boldSystemFontOfSize:17];
        timelabel3.textColor=[UIColor blackColor];
        [self.view bringSubviewToFront:timelabel];
        [self.view addSubview:timelabel3];
        
        [self.view bringSubviewToFront:timelabel];
        [self.view bringSubviewToFront:timelabel1];
        [self.view bringSubviewToFront:timelabel2];
        [self.view bringSubviewToFront:timelabel3];
        
    }
    
    self.TitleView.layer.borderWidth=2.0f;
//    self.TitleView.layer.borderColor=[UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    
    self.TitleView.layer.borderColor=   [UIColor colorWithRed:(218/255.0) green:(218/255.0) blue:(218/255.0) alpha:1].CGColor;
//    self.view.layer.borderColor =  [UIColor colorWithRed:(4/255.0) green:(41/255.0) blue:(82/255.0) alpha:1].CGColor;
//    self.view.layer.borderWidth = 3.0f;
    
    // Current Date :
    
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    
    [dateformate setDateFormat:@"dd-MMM-yy"];
    
    FromDate=[dateformate stringFromDate:[NSDate date]];
    ToDate=FromDate;
    NSLog(@"Current Date : %@",FromDate);
    NSDate *now = [NSDate date];
    NSLog(@"Current Date : %@",now);
    NSDate *sevenDaysAgo = [now dateByAddingTimeInterval:-30*24*60*60];
    NSLog(@"30 days ago: %@", sevenDaysAgo);
    MonthDate=[dateformate stringFromDate:sevenDaysAgo];
    NSLog(@"Month Date : %@",MonthDate);
    
    
    
//    [self CallSearch];
     [self CallSearch1];
    [self CallSearchActivityMonth1];
    [self CallOptyDetailsDashBoard];
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"..... will ");
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getactivitiesForDashborad_Connection:) name:@"getactivitiesForMonth_Connection" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(searchActivitiesDashboard_Found:) name:@"searchActivitiesDashboard_Found" object:nil];//Gautam //for search activites after pressing search button
    //OpportunitiesDashBoard_Found
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SearchActivitiesMonth_Connection1:) name:@"SearchActivitiesMonth_Connection" object:nil];//Gautam //for search activites after pressing search button
    
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(searchActivities_Found:) name:@"searchActivities_Found" object:nil];
    
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(searchActivities_Found2:) name:@"searchActivities_Found2" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(OpportunitiesDashBoard_Found:) name:@"OpportunitiesDashBoard_Found" object:nil];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    
    NSLog(@"did appear");
    
    [super viewDidAppear:animated];
    
    [self.pieChartLeft reloadData];
    
    [self.pieChartRight reloadData];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    
    NSLog(@" Will Appear");
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"searchActivitiesDashboard_Found" object:nil];//abhishek // For searchActivities_Found Countx
    //OpportunitiesDashBoard_Found
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"SearchActivitiesMonth_Connection" object:nil];//abhishek // For searchActivities_Found Countx
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"OpportunitiesDashBoard_Found" object:nil];//abhishek // For searchActivities_Found Countx
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"searchActivities_Found" object:nil];
     [[NSNotificationCenter defaultCenter]removeObserver:self name:@"searchActivities_Found2" object:nil];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"Null");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)info_btn
{
//    [UIView animateWithDuration:0.25 animations:^{
//        _cautionView.frame =  CGRectMake(130, 30, 0, 0);
//    }];
    [self performSegueWithIdentifier:@"infoView" sender:self];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"%lu",(unsigned long)[dashboardActivities_ListArr count]);
    return [dashboardActivities_ListArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    /*
     static NSString *MyIdentifier = @"MyIdentifier";
     
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
     
     if (cell == nil)
     {
     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
     reuseIdentifier:MyIdentifier];
     }
     return cell;
     */
    
    dashboardActivity_list = nil;
    dashboardActivity_list = [[dashBoardActivity alloc]init];
    dashboardActivity_list = [dashboardActivities_ListArr objectAtIndex:indexPath.row ];
    
    dashBoardActivity_Cell *cell;
    if (tableView == self.tblview) {
        static NSString *MyIdentifier = @"MyIdentifier";
        
        cell = [self.tblview dequeueReusableCellWithIdentifier:MyIdentifier];
        
        if (cell == nil)
        {
            cell = [[dashBoardActivity_Cell alloc] initWithStyle:UITableViewCellStyleDefault
                                                 reuseIdentifier:MyIdentifier];
        }
        
        cell.layer.borderColor =  [UIColor colorWithRed:(218/255.0) green:(218/255.0) blue:(218/255.0) alpha:1].CGColor;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        NSLog(@".dashboardActivity_list. %@",dashboardActivity_list.ACTIVITY_STATUS);
        
        cell.lbl_status.text=dashboardActivity_list.ACTIVITY_STATUS;
        NSLog(@"dashboardActivity_list.CONTACT_NAME%@",dashboardActivity_list.CONTACT_NAME);
        cell.lbl_Name.text=dashboardActivity_list.CONTACT_NAME;
         NSLog(@"dashboardActivity_list.ACTIVITY_PENDING_TYPE%@",dashboardActivity_list.ACTIVITY_TYPE);
        cell.lbl_Type.text=dashboardActivity_list.ACTIVITY_TYPE;
        cell.lbl_Time.text=dashboardActivity_list.ACTIVITY_CREATED_DATE;
        NSLog(@"dashboardActivity_list.ACTIVITY_PENDING_TYPE%@",dashboardActivity_list.ACTIVITY_CREATED_DATE);
        NSDateFormatter *dateFormatter=[NSDateFormatter new];
        [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
        NSDate *date=[dateFormatter dateFromString:dashboardActivity_list.ACTIVITY_CREATED_DATE];
        
        if([dashboardActivity_list.ACTIVITY_STATUS isEqual:@""])
        {
            NSLog(@"Empty");
            cell.lbl_Name.text=@"Not Available";
        }
        if([dashboardActivity_list.ACTIVITY_TYPE isEqual:@""])
        {
            NSLog(@"Empty");
            cell.lbl_Type.text=@"Not Available";
        }
        return cell;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.; // you can have your own choice, of course
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    tableView.separatorColor =[UIColor colorWithRed:(1/255.0) green:(45/255.0) blue:(96/255.0) alpha:1];
    [tableView setContentOffset:tableView.contentOffset animated:NO];
    
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0 || indexPath.row == ([indexPath length]-1))
    {
        cell.layer.cornerRadius = 10;
        
        
    }
    cell.layer.cornerRadius = 05;
    cell.layer.borderWidth=2.0f;
//    cell.layer.borderColor=[UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    cell.layer.borderColor =  [UIColor colorWithRed:(218/255.0) green:(218/255.0) blue:(218/255.0) alpha:1].CGColor;
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    /*
     UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 320, 3)];/// change size as you need.
     separatorLineView.backgroundColor = [UIColor redColor];// you can also put image here
     [cell.contentView addSubview:separatorLineView];*/
    
    
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:(178/255.0) green:(183/255.0) blue:(63/255.0) alpha:1]];
    bgColorView.layer.cornerRadius = 10;
    // [cell setSelectedBackgroundView:bgColorView];
    // [bgColorView release];
    
    cell.backgroundColor = [UIColor colorWithRed:(1/255.0) green:(31/255.0) blue:(65/255.0) alpha:1] ;
    cell.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1] ;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    cell.textLabel.textColor=[UIColor colorWithRed:(216/255.0) green:(218/255.0) blue:(221/255.0) alpha:1];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds] ;
    //cell.selectedBackgroundView=bgColorView;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"... Enter %ld",(long)indexPath.row);
}

/*
 
 <SOAP:Envelope xmlns:SOAP="http://schemas.xmlsoap.org/soap/envelope/">
 <SOAP:Header xmlns:SOAP="http://schemas.xmlsoap.org/soap/envelope/">
 <header xmlns="http://schemas.cordys.com/General/1.0/">
 <Logger xmlns="http://schemas.cordys.com/General/1.0/">
 <DC xmlns="http://schemas.cordys.com/General/1.0/" name="XForms">/testtool/testtool.caf</DC>
 <DC xmlns="http://schemas.cordys.com/General/1.0/" name="XForms">/methodsetsmanager/methodsetexplorer.caf</DC>
 <DC xmlns="http://schemas.cordys.com/General/1.0/" name="XForms">/sysresourcemgr/sysresourcemgr.caf</DC>
 <DC xmlns="http://schemas.cordys.com/General/1.0/" name="XForms">/com/cordys/cusp/cusp.caf</DC>
 <DC xmlns="http://schemas.cordys.com/General/1.0/" name="hopCount">0</DC>
 <DC xmlns="http://schemas.cordys.com/General/1.0/" name="correlationID">00215ef7-d846-11e4-fef3-7bea670b9d46</DC>
 </Logger>
 </header>
 </SOAP:Header>
 <SOAP:Body>
 <GetTMCVOptyStageDetails xmlns="com.cordys.tatamotors.Neevsiebelwsapp" preserveSpace="no" qAccess="0" qValues="">
 <PositionId>1-70CX8VQ</PositionId>
 </GetTMCVOptyStageDetails>
 </SOAP:Body>
 </SOAP:Envelope>
 */

-(void)CallOptyDetailsDashBoard
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
                               @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"correlationID\">00215ef7-d846-11e4-fef3-7bea670b9d46</DC>"
                               @"</Logger>"
                               @"</header>"
                               @"</SOAP:Header>"
                               @"<SOAP:Body>"
                               @"<GetTMCVOptyStageDetails xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                               @"<PositionId>%@</PositionId>"
                               @"</GetTMCVOptyStageDetails>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",userDetailsVal_.ROW_ID];
    
    
    
    
    NSLog(@"\n envlopeString Search Activity....!!!!%@",envelopeText);
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    
    NSLog(@"URL IS %@",theurl);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    
    NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"Opty_Connection_dashBoard"];
    
}//OpportunitiesDashBoard_Found

-(void)OpportunitiesDashBoard_Found:(NSNotification*)notification
{
    NSError *err;
    
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n DashBoard Opty response.....Data %@ ",response);
    
    if ([response isEqual:@""])
    {
        //  [self hideAlert];
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Nothing in Response !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        //  [self hideAlert];
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Network Fault String!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([@"SearchOpptyBasedOnCriteriaResponse" isEqual:@""]){
    }
    else
    {
        
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement *container = [TBXML childElementNamed:@"GetTMCVOptyStageDetailsResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        
        if (Opty_Arr)
        {
            [ Opty_Arr removeAllObjects];
        }
        TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple)
        {
            
            TBXMLElement *table  = [TBXML childElementNamed:@"TABLE" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
            
            TBXMLElement *CO_QTY = [TBXML childElementNamed:@"CO_QTY" parentElement:table];
            CO_QTY_STR=[TBXML textForElement:CO_QTY];
            NSLog(@"OptyID Opty Id : %@",CO_QTY_STR);
            x = [CO_QTY_STR intValue];
            
            TBXMLElement *C1_QTY = [TBXML childElementNamed:@"C1_QTY" parentElement:table];
            C1_QTY_STR=[TBXML textForElement:C1_QTY];
            y = [C1_QTY_STR intValue];
            
            
            TBXMLElement *C1A_QTY = [TBXML childElementNamed:@"C1A_QTY" parentElement:table];
            C1A_QTY_STR=[TBXML textForElement:C1A_QTY];
            z = [C1A_QTY_STR intValue];
            
            
            TBXMLElement *C2_QTY = [TBXML childElementNamed:@"C2_QTY" parentElement:table];
            C2_QTY_STR=[TBXML textForElement:C2_QTY];
            a = [C2_QTY_STR intValue];
            
            
            TBXMLElement *C3_QTY = [TBXML childElementNamed:@"C3_QTY" parentElement:table];
            C3_QTY_STR=[TBXML textForElement:C3_QTY];
            b = [C3_QTY_STR intValue];
            counter=x+y+z+a+b;
        }
        else
        {
            
        }
        NSLog(@"Count : For Opty %d",counter);
        if (counter>0) {
            
            self.slices1 = [NSMutableArray arrayWithCapacity:4];
            
            NSNumber * blah1 = [NSNumber numberWithInt:20];
            NSNumber * blah2 = [NSNumber numberWithInt:80];
            NSNumber * bla3 = [NSNumber numberWithInt:20];
            NSNumber * blah4 = [NSNumber numberWithInt:80];
            
            //
            _slices1= [NSMutableArray arrayWithObjects:blah1,blah2,bla3,blah4, nil];
            
            
            [self.pieChartLeft setDataSource:self];
            [self.pieChartLeft setStartPieAngle:M_PI_2];
            [self.pieChartLeft setAnimationSpeed:1.0];
            [self.pieChartLeft setLabelFont:[UIFont fontWithName:@"DBLCDTempBlack" size:24]];
            // [self.pieChartLeft setLabelRadius:160];
            [self.pieChartLeft setShowPercentage:YES];
            //[self.pieChartLeft setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
            [self.pieChartLeft setPieBackgroundColor:[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1]];
            [self.pieChartLeft setPieCenter:CGPointMake(120, 110)];
            [self.pieChartLeft setUserInteractionEnabled:NO];
            [self.pieChartLeft setLabelShadowColor:[UIColor blackColor]];
            [self.pieChartLeft setLabelRadius:0];
            
            [[self.percentageLabel layer] setCornerRadius:61.0f];
            [[self.percentageLabel layer] setMasksToBounds:YES];
            self.sliceColors =[NSArray arrayWithObjects:
                               [UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
                               [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
                               [UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],
                               [UIColor colorWithRed:229/255.0 green:66/255.0 blue:115/255.0 alpha:1],
                               [UIColor colorWithRed:148/255.0 green:141/255.0 blue:139/255.0 alpha:1],nil];
            
            self.downArrow.transform = CGAffineTransformMakeRotation(M_PI);
            
            /*
             [self.pieChartRight setDataSource:self];
             [self.pieChartRight setStartPieAngle:M_PI_2];
             [self.pieChartRight setAnimationSpeed:1.0];
             [self.pieChartRight setLabelFont:[UIFont fontWithName:@"DBLCDTempBlack" size:24]];
             // [self.pieChartLeft setLabelRadius:160];
             [self.pieChartRight setShowPercentage:YES];
             //[self.pieChartLeft setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
             [self.pieChartRight setPieBackgroundColor:[UIColor blackColor]];
             [self.pieChartRight setPieCenter:CGPointMake(120, 110)];
             [self.pieChartRight setUserInteractionEnabled:NO];
             [self.pieChartRight setLabelShadowColor:[UIColor blackColor]];
             [self.pieChartRight setLabelRadius:0];
             
             [[self.percentageLabel1 layer] setCornerRadius:61.0f];
             [[self.percentageLabel1 layer] setMasksToBounds:YES];
             self.sliceColors =[NSArray arrayWithObjects:
             [UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
             [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
             [UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],
             [UIColor colorWithRed:229/255.0 green:66/255.0 blue:115/255.0 alpha:1],
             [UIColor colorWithRed:148/255.0 green:141/255.0 blue:139/255.0 alpha:1],nil];
             
             self.downArrow.transform = CGAffineTransformMakeRotation(M_PI);*/
            [self viewDidAppear:YES];
            
            //  super.viewDidAppear();
        }
        _percentageLabel.text=[NSString stringWithFormat:@"%d",counter];
    }
}


-(void)CallSearch1
{
    
    NSString * envelopeText1 =[NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<GetSFAActivityBasedOnSearchCriteria xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                               @"<positionid>%@</positionid>"
                               @"<PPLName></PPLName>"
                               @"<fromdate>%@</fromdate>"
                               @"<todate>%@</todate>"
                               @"<activitystatus></activitystatus>"
                               @"<activitytype></activitytype>"
                               @"<rang1>1</rang1>"
                               @"<rang2>1</rang2>"
                               @"<attr1></attr1>"
                               @"<attr2></attr2>"
                               @"<attr3></attr3>"
                               @"<salestage></salestage>"
                               @"</GetSFAActivityBasedOnSearchCriteria>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,FromDate,ToDate];
    
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
    
    [[RequestDelegate alloc]initiateRequest:request name:@"SearchActivities_Connection"];

    
}

-(void)searchActivities_Found:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n _ActivityType_Found response... %@ ",response);
    dashboardActivities_ListArr=[[NSMutableArray alloc] init];
    
    if (DisplaySearchActivitiesDetailsArray) {
        [DisplaySearchActivitiesDetailsArray removeAllObjects];
    }
    if (appdelegate.ActivityList) {
        [appdelegate.ActivityList removeAllObjects];
    }
    
    
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    
    TBXMLElement *container = [TBXML childElementNamed:@"GetSFAActivityBasedOnSearchCriteriaResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    
    
    TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
    
    
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Server Error !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if(!tuple  )
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Empty Response!" message:@"No Activities For Today " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else
    {
    TBXMLElement *container = [TBXML childElementNamed:@"GetSFAActivityBasedOnSearchCriteriaResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    
    
    TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        
        
         TBXMLElement *old =[TBXML childElementNamed:@"old" parentElement:tuple];
    TBXMLElement *TABLE =[TBXML childElementNamed:@"TABLE" parentElement:old];
    if (TABLE)
    {
        
        do {
            
            searchActivity_list = nil;
            searchActivity_list = [[SearchActivity_List alloc]init];
            
            // TBXMLElement *table  = [TBXML childElementNamed:@"S_OPTY_POSTN" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
            
            TBXMLElement *OPTY_NAME = [TBXML childElementNamed:@"OPPTY_NAME" parentElement:TABLE];
            
            searchActivity_list.OPPTY_NAME = [TBXML textForElement:OPTY_NAME];
            // NSLog(@"X_PROSPECT_SRC : %@",searchActivity_list.OPTY_NAME);
            
            
            
            
            TBXMLElement *OPPTY_ROWID = [TBXML childElementNamed:@"OPPTY_ROWID" parentElement:TABLE];
            searchActivity_list.OPPTY_ROWID = [TBXML textForElement:OPPTY_ROWID];
            //   NSLog(@"searchActivity_list.OPTY_ID: %@",searchActivity_list.OPTY_ID);
            
            //            TBXMLElement *PRODUCT_NAME = [TBXML childElementNamed:@"PRODUCT_NAME" parentElement:TABLE];
            //            searchActivity_list.PRODUCT_NAME = [TBXML textForElement:PRODUCT_NAME];
            
            TBXMLElement *PARENT_PRODUCT_NAME = [TBXML childElementNamed:@"PARENT_PRODUCT_NAME" parentElement:TABLE];
            searchActivity_list.PARENT_PRODUCT_NAME = [TBXML textForElement:PARENT_PRODUCT_NAME];
            
            
            TBXMLElement *OPTY_CREAT_DATE = [TBXML childElementNamed:@"OPTY_CREAT_DATE" parentElement:TABLE];
            searchActivity_list.OPTY_CREAT_DATE = [TBXML textForElement:OPTY_CREAT_DATE];
            
            TBXMLElement *ACCOUNT_NAME = [TBXML childElementNamed:@"ACCOUNT_NAME" parentElement:TABLE];
            searchActivity_list.ACCOUNT_NAME = [TBXML textForElement:ACCOUNT_NAME];
            
            TBXMLElement *ACCOUNT_PHONE_NUMBER = [TBXML childElementNamed:@"ACCOUNT_PHONE_NUMBER" parentElement:TABLE];
            searchActivity_list.ACCOUNT_PHONE_NUMBER = [TBXML textForElement:ACCOUNT_PHONE_NUMBER];
            
            
            TBXMLElement *ACCOUNT_ID = [TBXML childElementNamed:@"ACCOUNT_ID" parentElement:TABLE];
            searchActivity_list.ACCOUNT_ID = [TBXML textForElement:ACCOUNT_ID];
            
            TBXMLElement *SALE_STAGE = [TBXML childElementNamed:@"SALE_STAGE" parentElement:TABLE];
            searchActivity_list.SALE_STAGE = [TBXML textForElement:SALE_STAGE];
            
            TBXMLElement *SALES_STAGE_DATE = [TBXML childElementNamed:@"SALES_STAGE_DATE" parentElement:TABLE];
            searchActivity_list.SALES_STAGE_DATE = [TBXML textForElement:SALES_STAGE_DATE];
            
            
            //            TBXMLElement *LEAD_ASSIGNED_NAME = [TBXML childElementNamed:@"LEAD_ASSIGNED_NAME" parentElement:TABLE];
            //            searchActivity_list.LEAD_ASSIGNED_NAME = [TBXML textForElement:LEAD_ASSIGNED_NAME];
            //
            //            TBXMLElement *LEAD_ASSIGNED_CELL_NUMBER = [TBXML childElementNamed:@"LEAD_ASSIGNED_CELL_NUMBER" parentElement:TABLE];
            //            searchActivity_list.LEAD_ASSIGNED_CELL_NUMBER = [TBXML textForElement:LEAD_ASSIGNED_CELL_NUMBER];
            //
            //
            //            TBXMLElement *LEAD_ASSIGNED_POSITION_NAME = [TBXML childElementNamed:@"LEAD_ASSIGNED_POSITION_NAME" parentElement:TABLE];
            //            searchActivity_list.LEAD_ASSIGNED_POSITION_NAME = [TBXML textForElement:LEAD_ASSIGNED_POSITION_NAME];
            //
            //            TBXMLElement *LEAD_ASSIGNED_POSITION_ID = [TBXML childElementNamed:@"LEAD_ASSIGNED_POSITION_ID" parentElement:TABLE];
            //            searchActivity_list.LEAD_ASSIGNED_POSITION_ID = [TBXML textForElement:LEAD_ASSIGNED_POSITION_ID];
            
            
            
            //            TBXMLElement *POSTN_TYPE_CD = [TBXML childElementNamed:@"POSTN_TYPE_CD" parentElement:TABLE];
            //            searchActivity_list.POSTN_TYPE_CD = [TBXML textForElement:POSTN_TYPE_CD];
            
            
            
            TBXMLElement *CONTACT_ID = [TBXML childElementNamed:@"CONTACT_ID" parentElement:TABLE];
            searchActivity_list.CONTACT_ID = [TBXML textForElement:CONTACT_ID];
            
            TBXMLElement *CONTACT_NAME = [TBXML childElementNamed:@"CONTACT_NAME" parentElement:TABLE];
            searchActivity_list.CONTACT_NAME = [TBXML textForElement:CONTACT_NAME];
            
            TBXMLElement *CONTACT_CELL_NUM = [TBXML childElementNamed:@"CONTACT_CELL_NUM" parentElement:TABLE];
            searchActivity_list.CONTACT_CELL_NUM = [TBXML textForElement:CONTACT_CELL_NUM];
            
            TBXMLElement *CONTACT_ADDRESS = [TBXML childElementNamed:@"CONTACT_ADDRESS" parentElement:TABLE];
            searchActivity_list.CONTACT_ADDRESS = [TBXML textForElement:CONTACT_ADDRESS];
            
            TBXMLElement *ADDRESS_ID = [TBXML childElementNamed:@"ADDRESS_ID" parentElement:TABLE];
            searchActivity_list.ADDRESS_ID = [TBXML textForElement:ADDRESS_ID];
            
            //            TBXMLElement *ACTIVITY_PENDING_TYPE = [TBXML childElementNamed:@"ACTIVITY_PENDING_TYPE" parentElement:TABLE];
            //            searchActivity_list.ACTIVITY_PENDING_TYPE = [TBXML textForElement:ACTIVITY_PENDING_TYPE];
            
            
            TBXMLElement *ACTIVITY_ID = [TBXML childElementNamed:@"ACTIVITY_ROW_ID" parentElement:TABLE];
            searchActivity_list.ACTIVITY_ROW_ID = [TBXML textForElement:ACTIVITY_ID];
            
            TBXMLElement *PLANNED_START_DATE = [TBXML childElementNamed:@"ACTIVITY_PLAN_START_DATE" parentElement:TABLE];
            searchActivity_list.ACTIVITY_PLAN_START_DATE = [TBXML textForElement:PLANNED_START_DATE];
            
            
            TBXMLElement *ACTIVITY_CREATED_DATE = [TBXML childElementNamed:@"ACTIVITY_CREATED_DATE" parentElement:TABLE];
            searchActivity_list.ACTIVITY_CREATED_DATE = [TBXML textForElement:ACTIVITY_CREATED_DATE];
            
            
            
            
            TBXMLElement *ACTIVITY_DESCRIPTION = [TBXML childElementNamed:@"DESCRIPTION" parentElement:TABLE];
            searchActivity_list.DESCRIPTION = [TBXML textForElement:ACTIVITY_DESCRIPTION];
            
            TBXMLElement *ACTIVITY_STATUS = [TBXML childElementNamed:@"ACTIVITY_STATUS" parentElement:TABLE];
            searchActivity_list.ACTIVITY_STATUS = [TBXML textForElement:ACTIVITY_STATUS];
            
            //            TBXMLElement *X_TALUKA = [TBXML childElementNamed:@"X_TALUKA" parentElement:TABLE];
            //            searchActivity_list.X_TALUKA = [TBXML textForElement:X_TALUKA];
            
            
            TBXMLElement *X_PROSPECT_SRC = [TBXML childElementNamed:@"X_PROSPECT_SRC" parentElement:TABLE];
            searchActivity_list.X_PROSPECT_SRC = [TBXML textForElement:X_PROSPECT_SRC];
            
            
            TBXMLElement *ACCOUNT_LOCATION = [TBXML childElementNamed:@"ACCOUNT_LOCATION" parentElement:TABLE];
            searchActivity_list.ACCOUNT_LOCATION = [TBXML textForElement:ACCOUNT_LOCATION];
            
            TBXMLElement *ACTIVITY_TYPE = [TBXML childElementNamed:@"ACTIVITY_TYPE" parentElement:TABLE];
            searchActivity_list.ACTIVITY_TYPE = [TBXML textForElement:ACTIVITY_TYPE];
            NSLog(@"%@",searchActivity_list.ACTIVITY_TYPE);
            //            TBXMLElement *ACTIVITY_CREATED_DATE = [TBXML childElementNamed:@"ACTIVITY_CREATED_DATE" parentElement:TABLE];
            //            searchActivity_list.activity_c= [TBXML textForElement:ACTIVITY_CREATED_DATE];
            
            TBXMLElement *ACTIVITY_COMPLETION_DATE = [TBXML childElementNamed:@"ACTIVITY_COMPLETION_DATE" parentElement:TABLE];
            searchActivity_list.ACTIVITY_COMPLETION_DATE = [TBXML textForElement:ACTIVITY_COMPLETION_DATE];
            
            TBXMLElement *PRODUCT_LINE = [TBXML childElementNamed:@"PRODUCT_LINE" parentElement:TABLE];
            searchActivity_list.PRODUCT_LINE = [TBXML textForElement:PRODUCT_LINE];
            TBXMLElement *VC = [TBXML childElementNamed:@"VC" parentElement:TABLE];
            searchActivity_list.VC = [TBXML textForElement:VC];
            
            TBXMLElement *RESULT_COUNT = [TBXML childElementNamed:@"RESULT_COUNT" parentElement:TABLE];
            searchActivity_list.RESULT_COUNT = [TBXML textForElement:RESULT_COUNT];
            
            
            
            RESULTCOUNT = searchActivity_list.RESULT_COUNT;
            
            [DisplaySearchActivitiesDetailsArray addObject:searchActivity_list];
             [dashboardActivities_ListArr addObject:searchActivity_list];
            [appdelegate.ActivityList addObject:searchActivity_list];
            
            
        }while ((tuple = tuple->nextSibling));
    }
   //  [self.tblview reloadData];
        
        [self CallSearch2];
//    ActivityListViewController* activityListViewController_VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ActivityListViewController"];
//    // searchOpportunityResult_VC.optySearchDetails_Comes=SearchOpportunityListArray;
//    
//    //    activityListViewController_VC. =txtSalesStage.text;
//    //    searchOpportunityResult_VC.txtFromDate=txtFromDate.text;
//    //    searchOpportunityResult_VC.txtToDate=txtToDate.text;
//    
//    [self.navigationController pushViewController:activityListViewController_VC animated:YES];
    
   // NSLog(@"\n\nshow result...... resultcount....%@",RESULTCOUNT);
    NSLog(@"\n\nappdelegate.ActivityList....%@",[[appdelegate.ActivityList objectAtIndex:0] valueForKey:@"OPPTY_ROWID"]);
    NSLog(@"\n resultcount...... %u ",(unsigned)DisplaySearchActivitiesDetailsArray.count);
    // [appdelegate hideAlert];
    //ActivitiesResult_VC *activitiesResult_VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ActivitiesResult_VC"];
    }  //[self.navigationController pushViewController:activitiesResult_VC animated:YES];
  
}

- (void)btnToggleClick{
    if (!isShown) {
        _cautionView.frame =  CGRectMake(130, 20, 0, 0);
        [UIView animateWithDuration:0.25 animations:^{
            _cautionView.frame =  CGRectMake(130, 30, 100, 200);
        }];
        isShown = true;
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            _cautionView.frame =  CGRectMake(130, 30, 0, 0);
        }];
        isShown = false;
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
    if (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation==UIInterfaceOrientationLandscapeRight)
        return YES;
    
    //return NO;
}

-(void)CallSearch2
{
    NSLog(@"resulcount:%@",RESULTCOUNT);
    NSString * envelopeText1 =[NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<GetSFAActivityBasedOnSearchCriteria xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                               @"<positionid>%@</positionid>"
                               @"<PPLName></PPLName>"
                               @"<fromdate>%@</fromdate>"
                               @"<todate>%@</todate>"
                               @"<activitystatus></activitystatus>"
                               @"<activitytype></activitytype>"
                               @"<rang1>1</rang1>"
                               @"<rang2>%@</rang2>"
                               @"<attr1></attr1>"
                               @"<attr2></attr2>"
                               @"<attr3></attr3>"
                               @"<salestage></salestage>"
                               @"</GetSFAActivityBasedOnSearchCriteria>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,FromDate,ToDate,RESULTCOUNT];
    
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
    
    [[RequestDelegate alloc]initiateRequest:request name:@"SearchActivities_Connection2"];
    
    
}

-(void)searchActivities_Found2:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n _ActivityType_Found2 response... %@ ",response);
    dashboardActivities_ListArr=[[NSMutableArray alloc] init];
    
    if (DisplaySearchActivitiesDetailsArray) {
        [DisplaySearchActivitiesDetailsArray removeAllObjects];
    }
    if (appdelegate.ActivityList) {
        [appdelegate.ActivityList removeAllObjects];
    }
    
    
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    
    TBXMLElement *container = [TBXML childElementNamed:@"GetSFAActivityBasedOnSearchCriteriaResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    
    
    TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
    
    
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Server Error !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if(!tuple  )
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Empty Response!" message:@"No Activities For Today " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else
    {
        TBXMLElement *container = [TBXML childElementNamed:@"GetSFAActivityBasedOnSearchCriteriaResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        
        
        TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        
        
        TBXMLElement *old =[TBXML childElementNamed:@"old" parentElement:tuple];
        TBXMLElement *TABLE =[TBXML childElementNamed:@"TABLE" parentElement:old];
        if (TABLE)
        {
            
            do {
                
                searchActivity_list = nil;
                searchActivity_list = [[SearchActivity_List alloc]init];
                
                // TBXMLElement *table  = [TBXML childElementNamed:@"S_OPTY_POSTN" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                
                TBXMLElement *OPTY_NAME = [TBXML childElementNamed:@"OPPTY_NAME" parentElement:TABLE];
                
                searchActivity_list.OPPTY_NAME = [TBXML textForElement:OPTY_NAME];
                // NSLog(@"X_PROSPECT_SRC : %@",searchActivity_list.OPTY_NAME);
                
                
                
                
                TBXMLElement *OPPTY_ROWID = [TBXML childElementNamed:@"OPPTY_ROWID" parentElement:TABLE];
                searchActivity_list.OPPTY_ROWID = [TBXML textForElement:OPPTY_ROWID];
                //   NSLog(@"searchActivity_list.OPTY_ID: %@",searchActivity_list.OPTY_ID);
                
                //            TBXMLElement *PRODUCT_NAME = [TBXML childElementNamed:@"PRODUCT_NAME" parentElement:TABLE];
                //            searchActivity_list.PRODUCT_NAME = [TBXML textForElement:PRODUCT_NAME];
                
                TBXMLElement *PARENT_PRODUCT_NAME = [TBXML childElementNamed:@"PARENT_PRODUCT_NAME" parentElement:TABLE];
                searchActivity_list.PARENT_PRODUCT_NAME = [TBXML textForElement:PARENT_PRODUCT_NAME];
                
                
                TBXMLElement *OPTY_CREAT_DATE = [TBXML childElementNamed:@"OPTY_CREAT_DATE" parentElement:TABLE];
                searchActivity_list.OPTY_CREAT_DATE = [TBXML textForElement:OPTY_CREAT_DATE];
                
                TBXMLElement *ACCOUNT_NAME = [TBXML childElementNamed:@"ACCOUNT_NAME" parentElement:TABLE];
                searchActivity_list.ACCOUNT_NAME = [TBXML textForElement:ACCOUNT_NAME];
                
                TBXMLElement *ACCOUNT_PHONE_NUMBER = [TBXML childElementNamed:@"ACCOUNT_PHONE_NUMBER" parentElement:TABLE];
                searchActivity_list.ACCOUNT_PHONE_NUMBER = [TBXML textForElement:ACCOUNT_PHONE_NUMBER];
                
                
                TBXMLElement *ACCOUNT_ID = [TBXML childElementNamed:@"ACCOUNT_ID" parentElement:TABLE];
                searchActivity_list.ACCOUNT_ID = [TBXML textForElement:ACCOUNT_ID];
                
                TBXMLElement *SALE_STAGE = [TBXML childElementNamed:@"SALE_STAGE" parentElement:TABLE];
                searchActivity_list.SALE_STAGE = [TBXML textForElement:SALE_STAGE];
                
                TBXMLElement *SALES_STAGE_DATE = [TBXML childElementNamed:@"SALES_STAGE_DATE" parentElement:TABLE];
                searchActivity_list.SALES_STAGE_DATE = [TBXML textForElement:SALES_STAGE_DATE];
                
                
                //            TBXMLElement *LEAD_ASSIGNED_NAME = [TBXML childElementNamed:@"LEAD_ASSIGNED_NAME" parentElement:TABLE];
                //            searchActivity_list.LEAD_ASSIGNED_NAME = [TBXML textForElement:LEAD_ASSIGNED_NAME];
                //
                //            TBXMLElement *LEAD_ASSIGNED_CELL_NUMBER = [TBXML childElementNamed:@"LEAD_ASSIGNED_CELL_NUMBER" parentElement:TABLE];
                //            searchActivity_list.LEAD_ASSIGNED_CELL_NUMBER = [TBXML textForElement:LEAD_ASSIGNED_CELL_NUMBER];
                //
                //
                //            TBXMLElement *LEAD_ASSIGNED_POSITION_NAME = [TBXML childElementNamed:@"LEAD_ASSIGNED_POSITION_NAME" parentElement:TABLE];
                //            searchActivity_list.LEAD_ASSIGNED_POSITION_NAME = [TBXML textForElement:LEAD_ASSIGNED_POSITION_NAME];
                //
                //            TBXMLElement *LEAD_ASSIGNED_POSITION_ID = [TBXML childElementNamed:@"LEAD_ASSIGNED_POSITION_ID" parentElement:TABLE];
                //            searchActivity_list.LEAD_ASSIGNED_POSITION_ID = [TBXML textForElement:LEAD_ASSIGNED_POSITION_ID];
                
                
                
                //            TBXMLElement *POSTN_TYPE_CD = [TBXML childElementNamed:@"POSTN_TYPE_CD" parentElement:TABLE];
                //            searchActivity_list.POSTN_TYPE_CD = [TBXML textForElement:POSTN_TYPE_CD];
                
                
                
                TBXMLElement *CONTACT_ID = [TBXML childElementNamed:@"CONTACT_ID" parentElement:TABLE];
                searchActivity_list.CONTACT_ID = [TBXML textForElement:CONTACT_ID];
                
                TBXMLElement *CONTACT_NAME = [TBXML childElementNamed:@"CONTACT_NAME" parentElement:TABLE];
                searchActivity_list.CONTACT_NAME = [TBXML textForElement:CONTACT_NAME];
                
                TBXMLElement *CONTACT_CELL_NUM = [TBXML childElementNamed:@"CONTACT_CELL_NUM" parentElement:TABLE];
                searchActivity_list.CONTACT_CELL_NUM = [TBXML textForElement:CONTACT_CELL_NUM];
                
                TBXMLElement *CONTACT_ADDRESS = [TBXML childElementNamed:@"CONTACT_ADDRESS" parentElement:TABLE];
                searchActivity_list.CONTACT_ADDRESS = [TBXML textForElement:CONTACT_ADDRESS];
                
                TBXMLElement *ADDRESS_ID = [TBXML childElementNamed:@"ADDRESS_ID" parentElement:TABLE];
                searchActivity_list.ADDRESS_ID = [TBXML textForElement:ADDRESS_ID];
                
                //            TBXMLElement *ACTIVITY_PENDING_TYPE = [TBXML childElementNamed:@"ACTIVITY_PENDING_TYPE" parentElement:TABLE];
                //            searchActivity_list.ACTIVITY_PENDING_TYPE = [TBXML textForElement:ACTIVITY_PENDING_TYPE];
                
                
                TBXMLElement *ACTIVITY_ID = [TBXML childElementNamed:@"ACTIVITY_ROW_ID" parentElement:TABLE];
                searchActivity_list.ACTIVITY_ROW_ID = [TBXML textForElement:ACTIVITY_ID];
                
                TBXMLElement *PLANNED_START_DATE = [TBXML childElementNamed:@"ACTIVITY_PLAN_START_DATE" parentElement:TABLE];
                searchActivity_list.ACTIVITY_PLAN_START_DATE = [TBXML textForElement:PLANNED_START_DATE];
                
                
                TBXMLElement *ACTIVITY_CREATED_DATE = [TBXML childElementNamed:@"ACTIVITY_CREATED_DATE" parentElement:TABLE];
                searchActivity_list.ACTIVITY_CREATED_DATE = [TBXML textForElement:ACTIVITY_CREATED_DATE];
                
                
                
                
                TBXMLElement *ACTIVITY_DESCRIPTION = [TBXML childElementNamed:@"DESCRIPTION" parentElement:TABLE];
                searchActivity_list.DESCRIPTION = [TBXML textForElement:ACTIVITY_DESCRIPTION];
                
                TBXMLElement *ACTIVITY_STATUS = [TBXML childElementNamed:@"ACTIVITY_STATUS" parentElement:TABLE];
                searchActivity_list.ACTIVITY_STATUS = [TBXML textForElement:ACTIVITY_STATUS];
                
                //            TBXMLElement *X_TALUKA = [TBXML childElementNamed:@"X_TALUKA" parentElement:TABLE];
                //            searchActivity_list.X_TALUKA = [TBXML textForElement:X_TALUKA];
                
                
                TBXMLElement *X_PROSPECT_SRC = [TBXML childElementNamed:@"X_PROSPECT_SRC" parentElement:TABLE];
                searchActivity_list.X_PROSPECT_SRC = [TBXML textForElement:X_PROSPECT_SRC];
                
                
                TBXMLElement *ACCOUNT_LOCATION = [TBXML childElementNamed:@"ACCOUNT_LOCATION" parentElement:TABLE];
                searchActivity_list.ACCOUNT_LOCATION = [TBXML textForElement:ACCOUNT_LOCATION];
                
                TBXMLElement *ACTIVITY_TYPE = [TBXML childElementNamed:@"ACTIVITY_TYPE" parentElement:TABLE];
                searchActivity_list.ACTIVITY_TYPE = [TBXML textForElement:ACTIVITY_TYPE];
                NSLog(@"%@",searchActivity_list.ACTIVITY_TYPE);
                //            TBXMLElement *ACTIVITY_CREATED_DATE = [TBXML childElementNamed:@"ACTIVITY_CREATED_DATE" parentElement:TABLE];
                //            searchActivity_list.activity_c= [TBXML textForElement:ACTIVITY_CREATED_DATE];
                
                TBXMLElement *ACTIVITY_COMPLETION_DATE = [TBXML childElementNamed:@"ACTIVITY_COMPLETION_DATE" parentElement:TABLE];
                searchActivity_list.ACTIVITY_COMPLETION_DATE = [TBXML textForElement:ACTIVITY_COMPLETION_DATE];
                
                TBXMLElement *PRODUCT_LINE = [TBXML childElementNamed:@"PRODUCT_LINE" parentElement:TABLE];
                searchActivity_list.PRODUCT_LINE = [TBXML textForElement:PRODUCT_LINE];
                TBXMLElement *VC = [TBXML childElementNamed:@"VC" parentElement:TABLE];
                searchActivity_list.VC = [TBXML textForElement:VC];
                
                TBXMLElement *RESULT_COUNT = [TBXML childElementNamed:@"RESULT_COUNT" parentElement:TABLE];
                searchActivity_list.RESULT_COUNT = [TBXML textForElement:RESULT_COUNT];
                
                
                
                RESULTCOUNT = searchActivity_list.RESULT_COUNT;
                
                [DisplaySearchActivitiesDetailsArray addObject:searchActivity_list];
                [dashboardActivities_ListArr addObject:searchActivity_list];
                [appdelegate.ActivityList addObject:searchActivity_list];
                
                
            }while ((tuple = tuple->nextSibling));
        }
         [self.tblview reloadData];
        
        
        //    ActivityListViewController* activityListViewController_VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ActivityListViewController"];
        //    // searchOpportunityResult_VC.optySearchDetails_Comes=SearchOpportunityListArray;
        //
        //    //    activityListViewController_VC. =txtSalesStage.text;
        //    //    searchOpportunityResult_VC.txtFromDate=txtFromDate.text;
        //    //    searchOpportunityResult_VC.txtToDate=txtToDate.text;
        //    
        //    [self.navigationController pushViewController:activityListViewController_VC animated:YES];
        
        // NSLog(@"\n\nshow result...... resultcount....%@",RESULTCOUNT);
        NSLog(@"\n\nappdelegate.ActivityList....%@",[[appdelegate.ActivityList objectAtIndex:0] valueForKey:@"OPPTY_ROWID"]);
        NSLog(@"\n resultcount...... %u ",(unsigned)DisplaySearchActivitiesDetailsArray.count);
        // [appdelegate hideAlert];
        //ActivitiesResult_VC *activitiesResult_VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ActivitiesResult_VC"];
    }  //[self.navigationController pushViewController:activitiesResult_VC animated:YES];
    
}



-(void)CallSearch
{
    
    //[self showAlert];
    //NSLog(@"Passed Data : %@ %@ %@ %@ %@ %@ %@ %@ %@ ",userDetailsVal_.ROW_ID,ActiveInActive,assignTO,ActivityType,ppl,Status,FromDate,taluka,Todate);
    
    
    
    
    NSString * envelopeText = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<GetActivityBasedOnSearchCriteria xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                               @"<positionid>%@</positionid>"
                               @"<fromdate>%@</fromdate>"
                               @"<todate>%@</todate>"
                               @"<activitytype></activitytype>"
                               @"<activitystatus>Open</activitystatus>"
                               @"<assignedperson></assignedperson>"
                               @"<tehsilname></tehsilname>"
                               @"<pplname></pplname>"
                               @"<tgmname>TGM</tgmname>"
                               @"<tkmname></tkmname>"
                               @"</GetActivityBasedOnSearchCriteria>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,FromDate,ToDate];
    
    //,userDetailsVal_.ROW_ID,
    
    NSString * envelopeText1 = [NSString stringWithFormat:
                                @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                @"<SOAP:Body>"
                                @"<GetActivityBasedOnSearchCriteria xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                @"<positionid>%@</positionid>"
                                @"<fromdate>10-Jun-2014</fromdate>"
                                @"<todate>10-Apr-2015</todate>"
                                @"<activitytype></activitytype>"
                                @"<activitystatus></activitystatus>"
                                @"<assignedperson></assignedperson>"
                                @"<tehsilname></tehsilname>"
                                @"<pplname></pplname>"
                                @"<tgmname></tgmname>"
                                @"<tkmname></tkmname>"
                                @"</GetActivityBasedOnSearchCriteria>"
                                @"</SOAP:Body>"
                                @"</SOAP:Envelope>",userDetailsVal_.ROW_ID] ;
    /*
     NSString * envelopeText = [NSString stringWithFormat:
     @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
     @"<SOAP:Body>"
     @"<GetSFAActivityBasedOnSearchCriteria xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
     @"<positionid>%@</positionid>"
     @"<PPLName>%@</PPLName>"
     @"<fromdate>%@</fromdate>"
     @"<todate>%@</todate>"
     @"<activitystatus>%@</activitystatus>"
     @"<activitytype>%@</activitytype>"
     @"<rang1>%ld</rang1>"
     @"<rang2>%ld</rang2>"
     @"<attr1></attr1>"
     @"<attr2></attr2>"
     @"<attr3></attr3>"
     @"</GetSFAActivityBasedOnSearchCriteria>"
     @"</SOAP:Body>"
     @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,txtSelectPPL.text,txtFromDate.text,txtTODate.text,txtSelectStatus.text,txtActivityType.text,startIndex,endIndex] ;
     */
    //please change range make dynamic insted of
    /*
     search_activitiesresultpage_variables.pplName_ = txtSelectTal.text; // use of instance variable is ,which we can use in next class/// for search and pagination purpose
     search_activitiesresultpage_variables.fromDate_ = txtFromDate.text; // use of instance variable is ,which we can use in next class/// for search and pagination purpose
     search_activitiesresultpage_variables.todate_ = txtTODate.text; // use of instance variable is ,which we can use in next class/// for search and pagination purpose
     search_activitiesresultpage_variables.activityStatus_ = txtSelectAssTo.text; // use of instance variable is ,which we can use in next class/// for search and pagination purpose
     search_activitiesresultpage_variables.activityType_ = txtActivityType.text;// use of instance variable is ,which we can use in next class/// for search and pagination purpose
     */
    
    NSLog(@"\n envlopeString Search Activity....!!!!%@",envelopeText);
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    
    NSLog(@"URL IS %@",theurl);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    
    NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"SearchActivities_Connection_dashBoard"];
    

    
}


-(void)searchActivitiesDashboard_Found:(NSNotification*)notification
{
    dashboardActivities_ListArr=[[NSMutableArray alloc] init];
    dashboardActivities_Customer_list=[[NSMutableArray alloc] init];
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n _ActivitySearch_Found response.....Data %@ ",response);
    
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Server Error !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        NSLog(@"Ek....");
        
        TBXMLElement *soapBody = [TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement];
        TBXMLElement *container = [TBXML childElementNamed:@"GetActivityBasedOnSearchCriteriaResponse" parentElement:soapBody];
        if(container)
        {
            NSLog(@"inner");
            TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
            if (tuple)
            {
                do {
                    NSLog(@"Inside..");
                    dashboardActivity_list = nil;
                    dashboardActivity_list = [[dashBoardActivity alloc]init];

                    
                    TBXMLElement *table  = [TBXML childElementNamed:@"S_OPTY_POSTN" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                    TBXMLElement *X_OPTY_NAME = [TBXML childElementNamed:@"OPTY_NAME" parentElement:table];
                    dashboardActivity_list.OPPTY_NAME =[TBXML textForElement:X_OPTY_NAME];
                    NSLog(@"OptyNAmE : %@",dashboardActivity_list.OPPTY_NAME);
                    
                    TBXMLElement *X_OPTY_ID = [TBXML childElementNamed:@"OPTY_ID" parentElement:table];
                    dashboardActivity_list.OPPTY_ROWID =[TBXML textForElement:X_OPTY_ID];
                    NSLog(@"OptyID : %@",dashboardActivity_list.OPPTY_ROWID);
                    
                    TBXMLElement *X_PRODUCT_NAME1 = [TBXML childElementNamed:@"PARENT_PRODUCT_NAME" parentElement:table];
                    dashboardActivity_list.PRODUCT_NAME1 =[TBXML textForElement:X_PRODUCT_NAME1];
                    
                    TBXMLElement *X_OPTY_CREATED = [TBXML childElementNamed:@"OPTY_CREATED" parentElement:table];
                    dashboardActivity_list.OPTY_CREAT_DATE =[TBXML textForElement:X_OPTY_CREATED];
                    
                    
                    TBXMLElement *X_TGM_TKM_NAME = [TBXML childElementNamed:@"TGM_TKM_NAME" parentElement:table];
                    dashboardActivity_list.TGM_TKM_NAME =[TBXML textForElement:X_TGM_TKM_NAME];
                    
                    
                    TBXMLElement *X_TGM_TKM_PHONE_NUMBER = [TBXML childElementNamed:@"TGM_TKM_PHONE_NUMBER" parentElement:table];
                    dashboardActivity_list.TGM_TKM_PHONE_NUMBER =[TBXML textForElement:X_TGM_TKM_PHONE_NUMBER];
                    
                    
                    TBXMLElement *X_ACCOUNT_TYPE = [TBXML childElementNamed:@"ACCOUNT_TYPE" parentElement:table];
                    dashboardActivity_list.ACCOUNT_TYPE =[TBXML textForElement:X_ACCOUNT_TYPE];
                    
                    TBXMLElement *X_ACCOUNT_ID = [TBXML childElementNamed:@"ACCOUNT_ID" parentElement:table];
                    dashboardActivity_list.ACCOUNT_ID =[TBXML textForElement:X_ACCOUNT_ID];
                    
                    TBXMLElement *X_SALES_STAGE_NAME = [TBXML childElementNamed:@"SALES_STAGE_NAME" parentElement:table];
                    dashboardActivity_list.SALES_STAGE_NAME =[TBXML textForElement:X_SALES_STAGE_NAME];
                    
                    TBXMLElement *X_SALE_STAGE_UPDATED_DATE = [TBXML childElementNamed:@"SALE_STAGE_UPDATED_DATE" parentElement:table];
                    dashboardActivity_list.SALES_STAGE_DATE =[TBXML textForElement:X_SALE_STAGE_UPDATED_DATE];
                    
                    TBXMLElement *X_LEAD_ASSIGNED_NAME = [TBXML childElementNamed:@"LEAD_ASSIGNED_NAME" parentElement:table];
                    dashboardActivity_list.LEAD_ASSIGNED_NAME =[TBXML textForElement:X_LEAD_ASSIGNED_NAME];
                    
                    TBXMLElement *X_LEAD_ASSIGNED_CELL_NUMBER = [TBXML childElementNamed:@"LEAD_ASSIGNED_CELL_NUMBER" parentElement:table];
                    dashboardActivity_list.LEAD_ASSIGNED_CELL_NUMBER =[TBXML textForElement:X_LEAD_ASSIGNED_CELL_NUMBER];
                    
                    TBXMLElement *X_LEAD_ASSIGNED_POSITION_ID = [TBXML childElementNamed:@"LEAD_ASSIGNED_POSITION_ID" parentElement:table];
                    dashboardActivity_list.LEAD_ASSIGNED_POSITION_ID =[TBXML textForElement:X_LEAD_ASSIGNED_POSITION_ID];
                    
                    TBXMLElement *X_CONTACT_NAME = [TBXML childElementNamed:@"CONTACT_NAME" parentElement:table];
                    dashboardActivity_list.CONTACT_NAME =[TBXML textForElement:X_CONTACT_NAME];
                    
                    TBXMLElement *X_CONTACT_ID = [TBXML childElementNamed:@"CONTACT_ID" parentElement:table];
                    dashboardActivity_list.CONTACT_ID =[TBXML textForElement:X_CONTACT_ID];
                    
                    TBXMLElement *X_ADDRESS_ID = [TBXML childElementNamed:@"ADDRESS_ID" parentElement:table];
                    dashboardActivity_list.ADDRESS_ID =[TBXML textForElement:X_ADDRESS_ID];
                    
                    TBXMLElement *X_CONTACT_ADDRESS = [TBXML childElementNamed:@"CONTACT_ADDRESS" parentElement:table];
                    dashboardActivity_list.CONTACT_ADDRESS =[TBXML textForElement:X_CONTACT_ADDRESS];
                    
                    TBXMLElement *X_CONTACT_CELL_NUMBER = [TBXML childElementNamed:@"CONTACT_CELL_NUMBER" parentElement:table];
                    dashboardActivity_list.CONTACT_CELL_NUM =[TBXML textForElement:X_CONTACT_CELL_NUMBER];
                    
                    TBXMLElement *X_ACTIVITY_PENDING_TYPE = [TBXML childElementNamed:@"ACTIVITY_PENDING_TYPE" parentElement:table];
                    dashboardActivity_list.ACTIVITY_PENDING_TYPE =[TBXML textForElement:X_ACTIVITY_PENDING_TYPE];
                    
                    TBXMLElement *X_ACTIVITY_ID = [TBXML childElementNamed:@"ACTIVITY_ID" parentElement:table];
                    dashboardActivity_list.ACTIVITY_ROW_ID =[TBXML textForElement:X_ACTIVITY_ID];
                    
                    TBXMLElement *X_PLANNED_START_DATE = [TBXML childElementNamed:@"PLANNED_START_DATE" parentElement:table];
                    dashboardActivity_list.ACTIVITY_PLAN_START_DATE =[TBXML textForElement:X_PLANNED_START_DATE];
                    
                    TBXMLElement *X_ACTIVITY_DESCRIPTION = [TBXML childElementNamed:@"ACTIVITY_DESCRIPTION" parentElement:table];
                    dashboardActivity_list.DESCRIPTION =[TBXML textForElement:X_ACTIVITY_DESCRIPTION];
                    
                    TBXMLElement *X_ACTIVITY_STATUS = [TBXML childElementNamed:@"ACTIVITY_STATUS" parentElement:table];
                    dashboardActivity_list.ACTIVITY_STATUS =[TBXML textForElement:X_ACTIVITY_STATUS];
                    
                    TBXMLElement *X_PRODUCT_NAME = [TBXML childElementNamed:@"PRODUCT_NAME" parentElement:table];
                    dashboardActivity_list.PRODUCT_LINE =[TBXML textForElement:X_PRODUCT_NAME];
                    
                    
                    [dashboardActivities_ListArr addObject:dashboardActivity_list];
                } while ((tuple = tuple->nextSibling));
                [self.tblview reloadData];
                NSLog(@"Counter.. %lu",(unsigned long)[dashboardActivities_ListArr count]);
                if(dashboardActivities_ListArr>=0){
                    [self.TitleView setHidden:NO];
                    
                    
                    //[self hideAlert];
                }
                else
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Server Error!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
                
            }
        }
    }
}
-(void)CallSearchActivityMonth1
{
    NSString * envelopeText1 =[NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<GetSFAActivityBasedOnSearchCriteria xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                               @"<positionid>%@</positionid>"
                               @"<PPLName></PPLName>"
                               @"<fromdate>%@</fromdate>"
                               @"<todate>%@</todate>"
                               @"<activitystatus></activitystatus>"
                               @"<activitytype></activitytype>"
                               @"<rang1>1</rang1>"
                               @"<rang2>51</rang2>"
                               @"<attr1></attr1>"
                               @"<attr2></attr2>"
                               @"<attr3></attr3>"
                               @"<salestage></salestage>"
                               @"</GetSFAActivityBasedOnSearchCriteria>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,MonthDate,FromDate];
    
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
    
    [[RequestDelegate alloc]initiateRequest:request name:@"SearchActivitiesMonth_Connection"];
    

    
}
-(void)SearchActivitiesMonth_Connection1:(NSNotification*)notification
{
    
    dashboardActivities_Month_Arr=[[NSMutableArray alloc] init];
    
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n _ActivitySearch_Found response...Month %@ ",response);
    
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Server Error !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        NSLog(@"Ek....");
        
        TBXMLElement *soapBody = [TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement];
        TBXMLElement *container = [TBXML childElementNamed:@"GetSFAActivityBasedOnSearchCriteriaResponse" parentElement:soapBody];
        if(container)
        {
            NSLog(@"inner");
            TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
             TBXMLElement *old =[TBXML childElementNamed:@"old" parentElement:tuple];
             TBXMLElement *TABLE =[TBXML childElementNamed:@"TABLE" parentElement:old];
            if (TABLE)
            {
                do {
                    NSLog(@"Inside..");
                    dashboardActivityMonth_list = nil;
                    dashboardActivityMonth_list = [[dashBoardActivity alloc]init];
                  
                    
//                    
//                    TBXMLElement *table  = [TBXML childElementNamed:@"S_OPTY_POSTN" parentElement:[TBXML childElementNamed:@"old" parentElement:TABLE]];
//                    TBXMLElement *OPTY_NAME = [TBXML childElementNamed:@"OPPTY_NAME" parentElement:TABLE];
//                    
//                    dashboardActivityMonth_list.OPPTY_NAME = [TBXML textForElement:OPTY_NAME];
//                    // NSLog(@"X_PROSPECT_SRC : %@",searchActivity_list.OPTY_NAME);
                    
                    
                    
                    
                    TBXMLElement *OPPTY_ROWID = [TBXML childElementNamed:@"OPPTY_ROWID" parentElement:TABLE];
                    dashboardActivityMonth_list.OPPTY_ROWID = [TBXML textForElement:OPPTY_ROWID];
                    //   NSLog(@"searchActivity_list.OPTY_ID: %@",searchActivity_list.OPTY_ID);
                    
                    //            TBXMLElement *PRODUCT_NAME = [TBXML childElementNamed:@"PRODUCT_NAME" parentElement:TABLE];
                    //            searchActivity_list.PRODUCT_NAME = [TBXML textForElement:PRODUCT_NAME];
                    
                    TBXMLElement *PARENT_PRODUCT_NAME = [TBXML childElementNamed:@"PARENT_PRODUCT_NAME" parentElement:TABLE];
                    dashboardActivityMonth_list.PARENT_PRODUCT_NAME = [TBXML textForElement:PARENT_PRODUCT_NAME];
                    
                    
                    TBXMLElement *OPTY_CREAT_DATE = [TBXML childElementNamed:@"OPTY_CREAT_DATE" parentElement:TABLE];
                    dashboardActivityMonth_list.OPTY_CREAT_DATE = [TBXML textForElement:OPTY_CREAT_DATE];
                    
                    TBXMLElement *ACCOUNT_NAME = [TBXML childElementNamed:@"ACCOUNT_NAME" parentElement:TABLE];
                    dashboardActivityMonth_list.ACCOUNT_NAME = [TBXML textForElement:ACCOUNT_NAME];
                    
                    TBXMLElement *ACCOUNT_PHONE_NUMBER = [TBXML childElementNamed:@"ACCOUNT_PHONE_NUMBER" parentElement:TABLE];
                    dashboardActivityMonth_list.ACCOUNT_PHONE_NUMBER = [TBXML textForElement:ACCOUNT_PHONE_NUMBER];
                    
                    
                    TBXMLElement *ACCOUNT_ID = [TBXML childElementNamed:@"ACCOUNT_ID" parentElement:TABLE];
                    dashboardActivityMonth_list.ACCOUNT_ID = [TBXML textForElement:ACCOUNT_ID];
                    
                    TBXMLElement *SALE_STAGE = [TBXML childElementNamed:@"SALE_STAGE" parentElement:TABLE];
                    dashboardActivityMonth_list.SALE_STAGE = [TBXML textForElement:SALE_STAGE];
                    
                    TBXMLElement *SALES_STAGE_DATE = [TBXML childElementNamed:@"SALES_STAGE_DATE" parentElement:TABLE];
                    dashboardActivityMonth_list.SALES_STAGE_DATE = [TBXML textForElement:SALES_STAGE_DATE];
                    
                    
                    //            TBXMLElement *LEAD_ASSIGNED_NAME = [TBXML childElementNamed:@"LEAD_ASSIGNED_NAME" parentElement:TABLE];
                    //            searchActivity_list.LEAD_ASSIGNED_NAME = [TBXML textForElement:LEAD_ASSIGNED_NAME];
                    //
                    //            TBXMLElement *LEAD_ASSIGNED_CELL_NUMBER = [TBXML childElementNamed:@"LEAD_ASSIGNED_CELL_NUMBER" parentElement:TABLE];
                    //            searchActivity_list.LEAD_ASSIGNED_CELL_NUMBER = [TBXML textForElement:LEAD_ASSIGNED_CELL_NUMBER];
                    //
                    //
                    //            TBXMLElement *LEAD_ASSIGNED_POSITION_NAME = [TBXML childElementNamed:@"LEAD_ASSIGNED_POSITION_NAME" parentElement:TABLE];
                    //            searchActivity_list.LEAD_ASSIGNED_POSITION_NAME = [TBXML textForElement:LEAD_ASSIGNED_POSITION_NAME];
                    //
                    //            TBXMLElement *LEAD_ASSIGNED_POSITION_ID = [TBXML childElementNamed:@"LEAD_ASSIGNED_POSITION_ID" parentElement:TABLE];
                    //            searchActivity_list.LEAD_ASSIGNED_POSITION_ID = [TBXML textForElement:LEAD_ASSIGNED_POSITION_ID];
                    
                    
                    
                    //            TBXMLElement *POSTN_TYPE_CD = [TBXML childElementNamed:@"POSTN_TYPE_CD" parentElement:TABLE];
                    //            searchActivity_list.POSTN_TYPE_CD = [TBXML textForElement:POSTN_TYPE_CD];
                    
                    
                    
                    TBXMLElement *CONTACT_ID = [TBXML childElementNamed:@"CONTACT_ID" parentElement:TABLE];
                    dashboardActivityMonth_list.CONTACT_ID = [TBXML textForElement:CONTACT_ID];
                    
                    TBXMLElement *CONTACT_NAME = [TBXML childElementNamed:@"CONTACT_NAME" parentElement:TABLE];
                    dashboardActivityMonth_list.CONTACT_NAME = [TBXML textForElement:CONTACT_NAME];
                    
                    TBXMLElement *CONTACT_CELL_NUM = [TBXML childElementNamed:@"CONTACT_CELL_NUM" parentElement:TABLE];
                    dashboardActivityMonth_list.CONTACT_CELL_NUM = [TBXML textForElement:CONTACT_CELL_NUM];
                    
                    TBXMLElement *CONTACT_ADDRESS = [TBXML childElementNamed:@"CONTACT_ADDRESS" parentElement:TABLE];
                    dashboardActivityMonth_list.CONTACT_ADDRESS = [TBXML textForElement:CONTACT_ADDRESS];
                    
                    TBXMLElement *ADDRESS_ID = [TBXML childElementNamed:@"ADDRESS_ID" parentElement:TABLE];
                    dashboardActivityMonth_list.ADDRESS_ID = [TBXML textForElement:ADDRESS_ID];
                    
                    //            TBXMLElement *ACTIVITY_PENDING_TYPE = [TBXML childElementNamed:@"ACTIVITY_PENDING_TYPE" parentElement:TABLE];
                    //            searchActivity_list.ACTIVITY_PENDING_TYPE = [TBXML textForElement:ACTIVITY_PENDING_TYPE];
                    
                    
                    TBXMLElement *ACTIVITY_ID = [TBXML childElementNamed:@"ACTIVITY_ROW_ID" parentElement:TABLE];
                    dashboardActivityMonth_list.ACTIVITY_ROW_ID = [TBXML textForElement:ACTIVITY_ID];
                    
                    TBXMLElement *PLANNED_START_DATE = [TBXML childElementNamed:@"ACTIVITY_PLAN_START_DATE" parentElement:TABLE];
                    dashboardActivityMonth_list.ACTIVITY_PLAN_START_DATE = [TBXML textForElement:PLANNED_START_DATE];
                    
                    
                    TBXMLElement *ACTIVITY_CREATED_DATE = [TBXML childElementNamed:@"ACTIVITY_CREATED_DATE" parentElement:TABLE];
                    dashboardActivityMonth_list.ACTIVITY_CREATED_DATE = [TBXML textForElement:ACTIVITY_CREATED_DATE];
                    
                    
                    
                    
                    TBXMLElement *ACTIVITY_DESCRIPTION = [TBXML childElementNamed:@"DESCRIPTION" parentElement:TABLE];
                    dashboardActivityMonth_list.DESCRIPTION = [TBXML textForElement:ACTIVITY_DESCRIPTION];
                    
                    TBXMLElement *ACTIVITY_STATUS = [TBXML childElementNamed:@"ACTIVITY_STATUS" parentElement:TABLE];
                    dashboardActivityMonth_list.ACTIVITY_STATUS = [TBXML textForElement:ACTIVITY_STATUS];
                    
                    //            TBXMLElement *X_TALUKA = [TBXML childElementNamed:@"X_TALUKA" parentElement:TABLE];
                    //            searchActivity_list.X_TALUKA = [TBXML textForElement:X_TALUKA];
                    
                    
                    TBXMLElement *X_PROSPECT_SRC = [TBXML childElementNamed:@"X_PROSPECT_SRC" parentElement:TABLE];
                    dashboardActivityMonth_list.X_PROSPECT_SRC = [TBXML textForElement:X_PROSPECT_SRC];
                    
                    
                    TBXMLElement *ACCOUNT_LOCATION = [TBXML childElementNamed:@"ACCOUNT_LOCATION" parentElement:TABLE];
                    dashboardActivityMonth_list.ACCOUNT_LOCATION = [TBXML textForElement:ACCOUNT_LOCATION];
                    
                    TBXMLElement *ACTIVITY_TYPE = [TBXML childElementNamed:@"ACTIVITY_TYPE" parentElement:TABLE];
                    dashboardActivityMonth_list.ACTIVITY_TYPE = [TBXML textForElement:ACTIVITY_TYPE];
                    NSLog(@"%@",searchActivity_list.ACTIVITY_TYPE);
                    //            TBXMLElement *ACTIVITY_CREATED_DATE = [TBXML childElementNamed:@"ACTIVITY_CREATED_DATE" parentElement:TABLE];
                    //            searchActivity_list.activity_c= [TBXML textForElement:ACTIVITY_CREATED_DATE];
                    
                    TBXMLElement *ACTIVITY_COMPLETION_DATE = [TBXML childElementNamed:@"ACTIVITY_COMPLETION_DATE" parentElement:TABLE];
                    dashboardActivityMonth_list.ACTIVITY_COMPLETION_DATE = [TBXML textForElement:ACTIVITY_COMPLETION_DATE];
                    
                    TBXMLElement *PRODUCT_LINE = [TBXML childElementNamed:@"PRODUCT_LINE" parentElement:TABLE];
                    dashboardActivityMonth_list.PRODUCT_LINE = [TBXML textForElement:PRODUCT_LINE];
                    TBXMLElement *VC = [TBXML childElementNamed:@"VC" parentElement:TABLE];
                    dashboardActivityMonth_list.VC = [TBXML textForElement:VC];
                    
                    TBXMLElement *RESULT_COUNT = [TBXML childElementNamed:@"RESULT_COUNT" parentElement:TABLE];
                    dashboardActivityMonth_list.RESULT_COUNT = [TBXML textForElement:RESULT_COUNT];
                    
                    
                    //                    RESULTCOUNT = searchActivity_list.RESULT_COUNT;

                    
                      RESULTCOUNT = dashboardActivityMonth_list.RESULT_COUNT;

                    
                    TBXMLElement *X_ACTIVITY_STATUS = [TBXML childElementNamed:@"ACTIVITY_STATUS" parentElement:TABLE];
                    dashboardActivityMonth_list.ACTIVITY_STATUS =[TBXML textForElement:X_ACTIVITY_STATUS];
                    
                    getStaus=[TBXML textForElement:X_ACTIVITY_STATUS];
                /*    NSLog(@"Status check..%@",getStaus);
                    if ([getStaus isEqualToString:@"Open"]) {
                        NSLog(@"Status is Open");
                        [OpenStatus_Arr addObject:getStaus];
                    } else if([getStaus isEqualToString:@"Done"]){
                        NSLog(@"status Done");
                        [DoneStatus_Arr addObject:getStaus];
                    }else
                    {
                        NSLog(@"Diffrent ");
                    }
                    */
                    
                    
                    TBXMLElement *X_PRODUCT_NAME = [TBXML childElementNamed:@"PRODUCT_LINE" parentElement:TABLE];
                    dashboardActivityMonth_list.PRODUCT_LINE =[TBXML textForElement:X_PRODUCT_NAME];
                    
                    [dashboardActivities_Month_Arr addObject:dashboardActivityMonth_list];
                } while ((tuple = tuple->nextSibling));
                NSLog(@"Counter.. %lu",(unsigned long)[dashboardActivities_Month_Arr count]);
                NSLog(@"Counter: Open %lu",(unsigned long)[OpenStatus_Arr count]);
                NSLog(@"Counter: Done %lu",(unsigned long)[DoneStatus_Arr count]);
                [self getactivitiesForDashborad];
   /*            if([OpenStatus_Arr count]==0)
                {
                    
                    NSLog(@"Open 0");
                    self.slices = [NSMutableArray arrayWithCapacity:1];
                    NSNumber * blah1 = [NSNumber numberWithInt:100];
                    _slices= [NSMutableArray arrayWithObjects: blah1,nil];
                    
                }else if ([DoneStatus_Arr count]==0)
                {
                    NSLog(@"Done 0");
                    self.slices = [NSMutableArray arrayWithCapacity:1];
                    NSNumber * blah1 = [NSNumber numberWithInt:100];
                    _slices= [NSMutableArray arrayWithObjects: blah1,nil];
                }else
                {
                    NSLog(@"Extra");
                }
                
                
                
                [self.pieChartRight setDataSource:self];
                [self.pieChartRight setStartPieAngle:M_PI_2];
                [self.pieChartRight setAnimationSpeed:1.0];
                [self.pieChartRight setLabelFont:[UIFont fontWithName:@"DBLCDTempBlack" size:24]];
                // [self.pieChartLeft setLabelRadius:160];
                [self.pieChartRight setShowPercentage:YES];
                //[self.pieChartLeft setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
                 [self.pieChartLeft setPieBackgroundColor:[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1]];
                [self.pieChartRight setPieCenter:CGPointMake(120, 110)];
                [self.pieChartRight setUserInteractionEnabled:NO];
                [self.pieChartRight setLabelShadowColor:[UIColor blackColor]];
                [self.pieChartRight setLabelRadius:0];
                
                [[self.percentageLabel1 layer] setCornerRadius:61.0f];
                [[self.percentageLabel1 layer] setMasksToBounds:YES];
                self.sliceColors =[NSArray arrayWithObjects:
                                   [UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
                                   [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
                                   [UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],
                                   [UIColor colorWithRed:229/255.0 green:66/255.0 blue:115/255.0 alpha:1],
                                   [UIColor colorWithRed:148/255.0 green:141/255.0 blue:139/255.0 alpha:1],nil];
                
                self.downArrow.transform = CGAffineTransformMakeRotation(M_PI);
                [self viewDidAppear:YES];
                
                
                _percentageLabel1.text=[NSString stringWithFormat:@"%d", [dashboardActivities_Month_Arr count]];*/
                if(dashboardActivities_ListArr>=0){
                }
                else
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Server Error!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
                
            }
        }
    }
}
-(void)getactivitiesForDashborad
{
    NSString * envelopeText1 =[NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<GetSFAActivityBasedOnSearchCriteria xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                               @"<positionid>%@</positionid>"
                               @"<PPLName></PPLName>"
                               @"<fromdate>%@</fromdate>"
                               @"<todate>%@</todate>"
                               @"<activitystatus></activitystatus>"
                               @"<activitytype></activitytype>"
                               @"<rang1>1</rang1>"
                               @"<rang2>%@</rang2>"
                               @"<attr1></attr1>"
                               @"<attr2></attr2>"
                               @"<attr3></attr3>"
                               @"<salestage></salestage>"
                               @"</GetSFAActivityBasedOnSearchCriteria>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,MonthDate,FromDate,RESULTCOUNT];
    
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
    
    [[RequestDelegate alloc]initiateRequest:request name:@"getactivitiesForDashborad_Connection"];
    
    



}

-(void)getactivitiesForDashborad_Connection:(NSNotification*)notification
{
    
    dashboardActivities_Month_Arr=[[NSMutableArray alloc] init];
    
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n _ActivitySearch_Found response...Month %@ ",response);
    
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Server Error !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        NSLog(@"Ek....");
        
        TBXMLElement *soapBody = [TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement];
        TBXMLElement *container = [TBXML childElementNamed:@"GetSFAActivityBasedOnSearchCriteriaResponse" parentElement:soapBody];
        if(container)
        {
            NSLog(@"inner");
            TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
//            TBXMLElement *old =[TBXML childElementNamed:@"old" parentElement:tuple];
//            TBXMLElement *TABLE =[TBXML childElementNamed:@"TABLE" parentElement:old];
            if (tuple)
            {
                do {
                    NSLog(@"Inside..");
                    dashboardActivityMonth_list = nil;
                    dashboardActivityMonth_list = [[dashBoardActivity alloc]init];
                    TBXMLElement *old =[TBXML childElementNamed:@"old" parentElement:tuple];
                    TBXMLElement *TABLE =[TBXML childElementNamed:@"TABLE" parentElement:old];
                    
                    //
                    //                    TBXMLElement *table  = [TBXML childElementNamed:@"S_OPTY_POSTN" parentElement:[TBXML childElementNamed:@"old" parentElement:TABLE]];
                    //                    TBXMLElement *OPTY_NAME = [TBXML childElementNamed:@"OPPTY_NAME" parentElement:TABLE];
                    //
                    //                    dashboardActivityMonth_list.OPPTY_NAME = [TBXML textForElement:OPTY_NAME];
                    //                    // NSLog(@"X_PROSPECT_SRC : %@",searchActivity_list.OPTY_NAME);
                    
                    
                    
                    
                    TBXMLElement *OPPTY_ROWID = [TBXML childElementNamed:@"OPPTY_ROWID" parentElement:TABLE];
                    dashboardActivityMonth_list.OPPTY_ROWID = [TBXML textForElement:OPPTY_ROWID];
                    //   NSLog(@"searchActivity_list.OPTY_ID: %@",searchActivity_list.OPTY_ID);
                    
                    //            TBXMLElement *PRODUCT_NAME = [TBXML childElementNamed:@"PRODUCT_NAME" parentElement:TABLE];
                    //            searchActivity_list.PRODUCT_NAME = [TBXML textForElement:PRODUCT_NAME];
                    
                    TBXMLElement *PARENT_PRODUCT_NAME = [TBXML childElementNamed:@"PARENT_PRODUCT_NAME" parentElement:TABLE];
                    dashboardActivityMonth_list.PARENT_PRODUCT_NAME = [TBXML textForElement:PARENT_PRODUCT_NAME];
                    
                    
                    TBXMLElement *OPTY_CREAT_DATE = [TBXML childElementNamed:@"OPTY_CREAT_DATE" parentElement:TABLE];
                    dashboardActivityMonth_list.OPTY_CREAT_DATE = [TBXML textForElement:OPTY_CREAT_DATE];
                    
                    TBXMLElement *ACCOUNT_NAME = [TBXML childElementNamed:@"ACCOUNT_NAME" parentElement:TABLE];
                    dashboardActivityMonth_list.ACCOUNT_NAME = [TBXML textForElement:ACCOUNT_NAME];
                    
                    TBXMLElement *ACCOUNT_PHONE_NUMBER = [TBXML childElementNamed:@"ACCOUNT_PHONE_NUMBER" parentElement:TABLE];
                    dashboardActivityMonth_list.ACCOUNT_PHONE_NUMBER = [TBXML textForElement:ACCOUNT_PHONE_NUMBER];
                    
                    
                    TBXMLElement *ACCOUNT_ID = [TBXML childElementNamed:@"ACCOUNT_ID" parentElement:TABLE];
                    dashboardActivityMonth_list.ACCOUNT_ID = [TBXML textForElement:ACCOUNT_ID];
                    
                    TBXMLElement *SALE_STAGE = [TBXML childElementNamed:@"SALE_STAGE" parentElement:TABLE];
                    dashboardActivityMonth_list.SALE_STAGE = [TBXML textForElement:SALE_STAGE];
                    
                    TBXMLElement *SALES_STAGE_DATE = [TBXML childElementNamed:@"SALES_STAGE_DATE" parentElement:TABLE];
                    dashboardActivityMonth_list.SALES_STAGE_DATE = [TBXML textForElement:SALES_STAGE_DATE];
                    
                    
                    //            TBXMLElement *LEAD_ASSIGNED_NAME = [TBXML childElementNamed:@"LEAD_ASSIGNED_NAME" parentElement:TABLE];
                    //            searchActivity_list.LEAD_ASSIGNED_NAME = [TBXML textForElement:LEAD_ASSIGNED_NAME];
                    //
                    //            TBXMLElement *LEAD_ASSIGNED_CELL_NUMBER = [TBXML childElementNamed:@"LEAD_ASSIGNED_CELL_NUMBER" parentElement:TABLE];
                    //            searchActivity_list.LEAD_ASSIGNED_CELL_NUMBER = [TBXML textForElement:LEAD_ASSIGNED_CELL_NUMBER];
                    //
                    //
                    //            TBXMLElement *LEAD_ASSIGNED_POSITION_NAME = [TBXML childElementNamed:@"LEAD_ASSIGNED_POSITION_NAME" parentElement:TABLE];
                    //            searchActivity_list.LEAD_ASSIGNED_POSITION_NAME = [TBXML textForElement:LEAD_ASSIGNED_POSITION_NAME];
                    //
                    //            TBXMLElement *LEAD_ASSIGNED_POSITION_ID = [TBXML childElementNamed:@"LEAD_ASSIGNED_POSITION_ID" parentElement:TABLE];
                    //            searchActivity_list.LEAD_ASSIGNED_POSITION_ID = [TBXML textForElement:LEAD_ASSIGNED_POSITION_ID];
                    
                    
                    
                    //            TBXMLElement *POSTN_TYPE_CD = [TBXML childElementNamed:@"POSTN_TYPE_CD" parentElement:TABLE];
                    //            searchActivity_list.POSTN_TYPE_CD = [TBXML textForElement:POSTN_TYPE_CD];
                    
                    
                    
                    TBXMLElement *CONTACT_ID = [TBXML childElementNamed:@"CONTACT_ID" parentElement:TABLE];
                    dashboardActivityMonth_list.CONTACT_ID = [TBXML textForElement:CONTACT_ID];
                    
                    TBXMLElement *CONTACT_NAME = [TBXML childElementNamed:@"CONTACT_NAME" parentElement:TABLE];
                    dashboardActivityMonth_list.CONTACT_NAME = [TBXML textForElement:CONTACT_NAME];
                    
                    TBXMLElement *CONTACT_CELL_NUM = [TBXML childElementNamed:@"CONTACT_CELL_NUM" parentElement:TABLE];
                    dashboardActivityMonth_list.CONTACT_CELL_NUM = [TBXML textForElement:CONTACT_CELL_NUM];
                    
                    TBXMLElement *CONTACT_ADDRESS = [TBXML childElementNamed:@"CONTACT_ADDRESS" parentElement:TABLE];
                    dashboardActivityMonth_list.CONTACT_ADDRESS = [TBXML textForElement:CONTACT_ADDRESS];
                    
                    TBXMLElement *ADDRESS_ID = [TBXML childElementNamed:@"ADDRESS_ID" parentElement:TABLE];
                    dashboardActivityMonth_list.ADDRESS_ID = [TBXML textForElement:ADDRESS_ID];
                    
                    //            TBXMLElement *ACTIVITY_PENDING_TYPE = [TBXML childElementNamed:@"ACTIVITY_PENDING_TYPE" parentElement:TABLE];
                    //            searchActivity_list.ACTIVITY_PENDING_TYPE = [TBXML textForElement:ACTIVITY_PENDING_TYPE];
                    
                    
                    TBXMLElement *ACTIVITY_ID = [TBXML childElementNamed:@"ACTIVITY_ROW_ID" parentElement:TABLE];
                    dashboardActivityMonth_list.ACTIVITY_ROW_ID = [TBXML textForElement:ACTIVITY_ID];
                    
                    TBXMLElement *PLANNED_START_DATE = [TBXML childElementNamed:@"ACTIVITY_PLAN_START_DATE" parentElement:TABLE];
                    dashboardActivityMonth_list.ACTIVITY_PLAN_START_DATE = [TBXML textForElement:PLANNED_START_DATE];
                    
                    
                    TBXMLElement *ACTIVITY_CREATED_DATE = [TBXML childElementNamed:@"ACTIVITY_CREATED_DATE" parentElement:TABLE];
                    dashboardActivityMonth_list.ACTIVITY_CREATED_DATE = [TBXML textForElement:ACTIVITY_CREATED_DATE];
                    
                    
                    
                    
                    TBXMLElement *ACTIVITY_DESCRIPTION = [TBXML childElementNamed:@"DESCRIPTION" parentElement:TABLE];
                    dashboardActivityMonth_list.DESCRIPTION = [TBXML textForElement:ACTIVITY_DESCRIPTION];
                    
                    TBXMLElement *ACTIVITY_STATUS = [TBXML childElementNamed:@"ACTIVITY_STATUS" parentElement:TABLE];
                    dashboardActivityMonth_list.ACTIVITY_STATUS = [TBXML textForElement:ACTIVITY_STATUS];
                    
                    //            TBXMLElement *X_TALUKA = [TBXML childElementNamed:@"X_TALUKA" parentElement:TABLE];
                    //            searchActivity_list.X_TALUKA = [TBXML textForElement:X_TALUKA];
                    
                    
                    TBXMLElement *X_PROSPECT_SRC = [TBXML childElementNamed:@"X_PROSPECT_SRC" parentElement:TABLE];
                    dashboardActivityMonth_list.X_PROSPECT_SRC = [TBXML textForElement:X_PROSPECT_SRC];
                    
                    
                    TBXMLElement *ACCOUNT_LOCATION = [TBXML childElementNamed:@"ACCOUNT_LOCATION" parentElement:TABLE];
                    dashboardActivityMonth_list.ACCOUNT_LOCATION = [TBXML textForElement:ACCOUNT_LOCATION];
                    
                    TBXMLElement *ACTIVITY_TYPE = [TBXML childElementNamed:@"ACTIVITY_TYPE" parentElement:TABLE];
                    dashboardActivityMonth_list.ACTIVITY_TYPE = [TBXML textForElement:ACTIVITY_TYPE];
                    NSLog(@"%@",searchActivity_list.ACTIVITY_TYPE);
                    //            TBXMLElement *ACTIVITY_CREATED_DATE = [TBXML childElementNamed:@"ACTIVITY_CREATED_DATE" parentElement:TABLE];
                    //            searchActivity_list.activity_c= [TBXML textForElement:ACTIVITY_CREATED_DATE];
                    
                    TBXMLElement *ACTIVITY_COMPLETION_DATE = [TBXML childElementNamed:@"ACTIVITY_COMPLETION_DATE" parentElement:TABLE];
                    dashboardActivityMonth_list.ACTIVITY_COMPLETION_DATE = [TBXML textForElement:ACTIVITY_COMPLETION_DATE];
                    
                    TBXMLElement *PRODUCT_LINE = [TBXML childElementNamed:@"PRODUCT_LINE" parentElement:TABLE];
                    dashboardActivityMonth_list.PRODUCT_LINE = [TBXML textForElement:PRODUCT_LINE];
                    TBXMLElement *VC = [TBXML childElementNamed:@"VC" parentElement:TABLE];
                    dashboardActivityMonth_list.VC = [TBXML textForElement:VC];
                    
                    TBXMLElement *RESULT_COUNT = [TBXML childElementNamed:@"RESULT_COUNT" parentElement:TABLE];
                    dashboardActivityMonth_list.RESULT_COUNT = [TBXML textForElement:RESULT_COUNT];
                    
                    
                    
                    RESULTCOUNT = searchActivity_list.RESULT_COUNT;
                    
                    
                    TBXMLElement *X_ACTIVITY_STATUS = [TBXML childElementNamed:@"ACTIVITY_STATUS" parentElement:TABLE];
                    dashboardActivityMonth_list.ACTIVITY_STATUS =[TBXML textForElement:X_ACTIVITY_STATUS];
                    
                    getStaus=[TBXML textForElement:X_ACTIVITY_STATUS];
                    
                   
                    NSLog(@"Status check..%@",getStaus);
                    NSLog(@"Activity_row_id..1-7EEZKFM%@",dashboardActivityMonth_list.ACTIVITY_ROW_ID);
                    
                    if ([getStaus isEqualToString:@"Open"])
                    {
                        NSLog(@"Status is Open");
                        [OpenStatus_Arr addObject:getStaus];
                    }
                    else if([getStaus isEqualToString:@"Done"])
                    {
                        NSLog(@"status Done");
                        [DoneStatus_Arr addObject:getStaus];
                    }else
                    {
                        NSLog(@"Diffrent ");
                    }
                    
                    
                    
                    TBXMLElement *X_PRODUCT_NAME = [TBXML childElementNamed:@"PRODUCT_LINE" parentElement:TABLE];
                    dashboardActivityMonth_list.PRODUCT_LINE =[TBXML textForElement:X_PRODUCT_NAME];
                    
                    [dashboardActivities_Month_Arr addObject:dashboardActivityMonth_list];
                } while ((tuple = tuple->nextSibling));
                NSLog(@"Counter.. %lu",(unsigned long)[dashboardActivities_Month_Arr count]);
                NSLog(@"Counter: Open %lu",(unsigned long)[OpenStatus_Arr count]);
                NSLog(@"Counter: Done %lu",(unsigned long)[DoneStatus_Arr count]);
               // [self getactivitiesForDashborad];
             /*   if([OpenStatus_Arr count]==0)
                {
                    
                    NSLog(@"Open 0");
                    self.slices = [NSMutableArray arrayWithCapacity:1];
                    NSNumber * blah1 = [NSNumber numberWithInt:100];
                    _slices= [NSMutableArray arrayWithObjects: blah1,nil];
                    
                }else if ([DoneStatus_Arr count]==0)
                {
                    NSLog(@"Done 0");
                    self.slices = [NSMutableArray arrayWithCapacity:1];
                    NSNumber * blah1 = [NSNumber numberWithInt:100];
                    _slices= [NSMutableArray arrayWithObjects: blah1,nil];
                }else
                {
                    NSLog(@"Extra");
                }
                */
                float opencount = [OpenStatus_Arr count];
                float donecount = [DoneStatus_Arr count];
                
                NSLog(@"open status array %f",opencount);
                
                float total = opencount+donecount;
                
                float devidesum=0;
                
                devidesum = (float)opencount/total;
                NSLog(@".... %f",devidesum);
                
                float opencountprcnt=devidesum*100.0f;
                
                NSLog(@"percent calculation opencount %f",opencountprcnt);
                
                
                devidesum = (float)donecount/total;
                NSLog(@".... %f",devidesum);
                
                float donecountprcnt=devidesum*100.0f;
                
                NSLog(@"percent calculation donecount %f",donecountprcnt);
                
                
                
                
                self.slices = [NSMutableArray arrayWithCapacity:2];
                
                NSNumber * c0count =[NSNumber numberWithFloat:opencountprcnt];
                
                NSNumber * c1count =[NSNumber numberWithFloat:donecountprcnt];
                
                
                _slices= [NSMutableArray arrayWithObjects: c0count,c1count,nil];
                
                [self.pieChartRight setDataSource:self];
                [self.pieChartRight setStartPieAngle:M_PI_2];
                [self.pieChartRight setAnimationSpeed:1.0];
                [self.pieChartRight setLabelFont:[UIFont fontWithName:@"DBLCDTempBlack" size:24]];
                // [self.pieChartLeft setLabelRadius:160];
                [self.pieChartRight setShowPercentage:YES];
                //[self.pieChartLeft setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
                [self.pieChartLeft setPieBackgroundColor:[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1]];
                [self.pieChartRight setPieCenter:CGPointMake(120, 110)];
                [self.pieChartRight setUserInteractionEnabled:NO];
                [self.pieChartRight setLabelShadowColor:[UIColor blackColor]];
                [self.pieChartRight setLabelRadius:0];
                
                [[self.percentageLabel1 layer] setCornerRadius:61.0f];
                [[self.percentageLabel1 layer] setMasksToBounds:YES];
                self.sliceColors =[NSArray arrayWithObjects:
                                   [UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
                                   [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
                                   [UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],
                                   [UIColor colorWithRed:229/255.0 green:66/255.0 blue:115/255.0 alpha:1],
                                   [UIColor colorWithRed:148/255.0 green:141/255.0 blue:139/255.0 alpha:1],nil];
                
                self.downArrow.transform = CGAffineTransformMakeRotation(M_PI);
                [self viewDidAppear:YES];
                
                
                _percentageLabel1.text=[NSString stringWithFormat:@"%d", [dashboardActivities_Month_Arr count]];
                if(dashboardActivities_ListArr>=0){
                }
                else
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Server Error!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
                
            }
        }
    }
}

-(void)CallSearchActivityMonth
{
//    NSString * envelopeText1 =[NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                               @"<SOAP:Body>"
//                               @"<GetSFAActivityBasedOnSearchCriteria xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
//                               @"<positionid>%@</positionid>"
//                               @"<PPLName></PPLName>"
//                               @"<fromdate>%@</fromdate>"
//                               @"<todate>%@</todate>"
//                               @"<activitystatus></activitystatus>"
//                               @"<activitytype></activitytype>"
//                               @"<rang1>1</rang1>"
//                               @"<rang2>1</rang2>"
//                               @"<attr1></attr1>"
//                               @"<attr2></attr2>"
//                               @"<attr3></attr3>"
//                               @"<salestage></salestage>"
//                               @"</GetSFAActivityBasedOnSearchCriteria>"
//                               @"</SOAP:Body>"
//                               @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,FromDate,ToDate];
    
//    NSData *envelope = [envelopeText1 dataUsingEncoding:NSUTF8StringEncoding];
//    
//    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
//    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
//    NSLog(@"URL IS %@",theurl);
//    // NSLog(@"REQUEST IS %@",envelopeText);
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
//    
//    NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText1 length]];
//    
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:envelope];
//    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
//    
//    [[RequestDelegate alloc]initiateRequest:request name:@"SearchActivities_Connection"];
    
    NSString * envelopeText = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<GetActivityBasedOnSearchCriteria xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                               @"<positionid>%@</positionid>"
                               @"<fromdate>%@</fromdate>"
                               @"<todate>%@</todate>"
                               @"<activitytype></activitytype>"
                               @"<activitystatus>Open</activitystatus>"
                               @"<assignedperson></assignedperson>"
                               @"<tehsilname></tehsilname>"
                               @"<pplname></pplname>"
                               @"<tgmname>TGM</tgmname>"
                               @"<tkmname></tkmname>"
                               @"</GetActivityBasedOnSearchCriteria>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,MonthDate,FromDate];
    
    NSString * envelopeText1 = [NSString stringWithFormat:
                                @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                @"<SOAP:Body>"
                                @"<GetActivityBasedOnSearchCriteria xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                @"<positionid>%@</positionid>"
                                @"<fromdate>10-Jun-2014</fromdate>"
                                @"<todate>10-Apr-2015</todate>"
                                @"<activitytype></activitytype>"
                                @"<activitystatus></activitystatus>"
                                @"<assignedperson></assignedperson>"
                                @"<tehsilname></tehsilname>"
                                @"<pplname></pplname>"
                                @"<tgmname></tgmname>"
                                @"<tkmname></tkmname>"
                                @"</GetActivityBasedOnSearchCriteria>"
                                @"</SOAP:Body>"
                                @"</SOAP:Envelope>",userDetailsVal_.ROW_ID] ;
    /*
     NSString * envelopeText = [NSString stringWithFormat:
     @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
     @"<SOAP:Body>"
     @"<GetSFAActivityBasedOnSearchCriteria xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
     @"<positionid>%@</positionid>"
     @"<PPLName>%@</PPLName>"
     @"<fromdate>%@</fromdate>"
     @"<todate>%@</todate>"
     @"<activitystatus>%@</activitystatus>"
     @"<activitytype>%@</activitytype>"
     @"<rang1>%ld</rang1>"
     @"<rang2>%ld</rang2>"
     @"<attr1></attr1>"
     @"<attr2></attr2>"
     @"<attr3></attr3>"
     @"</GetSFAActivityBasedOnSearchCriteria>"
     @"</SOAP:Body>"
     @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,txtSelectPPL.text,txtFromDate.text,txtTODate.text,txtSelectStatus.text,txtActivityType.text,startIndex,endIndex] ;
     */
    //please change range make dynamic insted of
    /*
     search_activitiesresultpage_variables.pplName_ = txtSelectTal.text; // use of instance variable is ,which we can use in next class/// for search and pagination purpose
     search_activitiesresultpage_variables.fromDate_ = txtFromDate.text; // use of instance variable is ,which we can use in next class/// for search and pagination purpose
     search_activitiesresultpage_variables.todate_ = txtTODate.text; // use of instance variable is ,which we can use in next class/// for search and pagination purpose
     search_activitiesresultpage_variables.activityStatus_ = txtSelectAssTo.text; // use of instance variable is ,which we can use in next class/// for search and pagination purpose
     search_activitiesresultpage_variables.activityType_ = txtActivityType.text;// use of instance variable is ,which we can use in next class/// for search and pagination purpose
     */
    
    NSLog(@"\n envlopeString Search Activity....Monthr  !!!!%@",envelopeText);
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    
    NSLog(@"URL IS %@",theurl);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    
    NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"SearchActivitiesMonth_Connection"];
    
}
-(void)SearchActivitiesMonth_Connection:(NSNotification*)notification
{
    
    dashboardActivities_Month_Arr=[[NSMutableArray alloc] init];
    
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n _ActivitySearch_Found response...Month %@ ",response);
    
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Server Error !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        NSLog(@"Ek....");
        
        TBXMLElement *soapBody = [TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement];
        TBXMLElement *container = [TBXML childElementNamed:@"GetActivityBasedOnSearchCriteriaResponse" parentElement:soapBody];
        if(container)
        {
            NSLog(@"inner");
            TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
            if (tuple)
            {
                do {
                    NSLog(@"Inside..");
                    dashboardActivityMonth_list = nil;
                    dashboardActivityMonth_list = [[dashBoardActivity alloc]init];
                    /*
                     <tuple>
                     <old>
                     <S_OPTY_POSTN>
                     <OPTY_NAME>1-788U78A</OPTY_NAME>
                     <OPTY_ID>1-788U78A</OPTY_ID>
                     <PRODUCT_NAME>Ace Zip</PRODUCT_NAME>
                     <PARENT_PRODUCT_NAME>Ace_Zip</PARENT_PRODUCT_NAME>
                     <OPTY_CREATED>19-SEP-2014</OPTY_CREATED>
                     <TGM_TKM_NAME xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
                     <TGM_TKM_PHONE_NUMBER xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
                     <ACCOUNT_TYPE>TGM</ACCOUNT_TYPE>
                     <ACCOUNT_ID xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
                     <SALES_STAGE_NAME>Closed Lost at C1A</SALES_STAGE_NAME>
                     <SALE_STAGE_UPDATED_DATE>07-MAY-2015</SALE_STAGE_UPDATED_DATE>
                     <LEAD_ASSIGNED_NAME>AJAY PARAB</LEAD_ASSIGNED_NAME>
                     <LEAD_ASSIGNED_CELL_NUMBER>9999999999</LEAD_ASSIGNED_CELL_NUMBER>
                     <LEAD_ASSIGNED_POSITION_NAME>TMCV-Sal-W-MUM-1001680-Jogeshwari-Pickup-DSE-33</LEAD_ASSIGNED_POSITION_NAME>
                     <LEAD_ASSIGNED_POSITION_ID>1-7F0Y20</LEAD_ASSIGNED_POSITION_ID>
                     <POSTN_TYPE_CD>DSE</POSTN_TYPE_CD>
                     <CONTACT_NAME>ANAND KUMAR</CONTACT_NAME>
                     <CONTACT_ID>1-788U783</CONTACT_ID>
                     <ADDRESS_ID>1-788U788</ADDRESS_ID>
                     <CONTACT_ADDRESS>FINANCE ONE INDIA BULLS, 20TH FLR,</CONTACT_ADDRESS>
                     <CONTACT_CELL_NUMBER>2266586333</CONTACT_CELL_NUMBER>
                     <ACTIVITY_PENDING_TYPE>Call Customer</ACTIVITY_PENDING_TYPE>
                     <ACTIVITY_ID>1-7D4701T</ACTIVITY_ID>
                     <PLANNED_START_DATE>08-MAY-2015 09:28:13</PLANNED_START_DATE>
                     <ACTIVITY_DESCRIPTION>TYPE TEST</ACTIVITY_DESCRIPTION>
                     <ACTIVITY_STATUS>Open</ACTIVITY_STATUS>
                     <X_TALUKA xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
                     <X_PROSPECT_SRC>TGM</X_PROSPECT_SRC>
                     <X_DISTRICT xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
                     <INFLUENCER>TGM</INFLUENCER>
                     </S_OPTY_POSTN>
                     </old>
                     </tuple>
                     */
                    
                    
                    TBXMLElement *table  = [TBXML childElementNamed:@"S_OPTY_POSTN" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                    TBXMLElement *X_OPTY_NAME = [TBXML childElementNamed:@"OPTY_NAME" parentElement:table];
                    dashboardActivityMonth_list.OPPTY_NAME =[TBXML textForElement:X_OPTY_NAME];
                    NSLog(@"OptyNAmE : %@",dashboardActivityMonth_list.OPPTY_NAME);
                    
                    TBXMLElement *X_OPTY_ID = [TBXML childElementNamed:@"OPTY_ID" parentElement:table];
                    dashboardActivityMonth_list.OPPTY_ROWID =[TBXML textForElement:X_OPTY_ID];
                    NSLog(@"OptyID : %@",dashboardActivityMonth_list.OPPTY_ROWID);
                    
                    TBXMLElement *X_PRODUCT_NAME1 = [TBXML childElementNamed:@"PARENT_PRODUCT_NAME" parentElement:table];
                    dashboardActivityMonth_list.PRODUCT_NAME1 =[TBXML textForElement:X_PRODUCT_NAME1];
                    
                    TBXMLElement *X_OPTY_CREATED = [TBXML childElementNamed:@"OPTY_CREATED" parentElement:table];
                    dashboardActivityMonth_list.OPTY_CREAT_DATE =[TBXML textForElement:X_OPTY_CREATED];
                    
                    
                    TBXMLElement *X_TGM_TKM_NAME = [TBXML childElementNamed:@"TGM_TKM_NAME" parentElement:table];
                    dashboardActivityMonth_list.TGM_TKM_NAME =[TBXML textForElement:X_TGM_TKM_NAME];
                    
                    
                    TBXMLElement *X_TGM_TKM_PHONE_NUMBER = [TBXML childElementNamed:@"TGM_TKM_PHONE_NUMBER" parentElement:table];
                    dashboardActivityMonth_list.TGM_TKM_PHONE_NUMBER =[TBXML textForElement:X_TGM_TKM_PHONE_NUMBER];
                    
                    
                    TBXMLElement *X_ACCOUNT_TYPE = [TBXML childElementNamed:@"ACCOUNT_TYPE" parentElement:table];
                    dashboardActivityMonth_list.ACCOUNT_TYPE =[TBXML textForElement:X_ACCOUNT_TYPE];
                    
                    TBXMLElement *X_ACCOUNT_ID = [TBXML childElementNamed:@"ACCOUNT_ID" parentElement:table];
                    dashboardActivityMonth_list.ACCOUNT_ID =[TBXML textForElement:X_ACCOUNT_ID];
                    
                    TBXMLElement *X_SALES_STAGE_NAME = [TBXML childElementNamed:@"SALES_STAGE_NAME" parentElement:table];
                    dashboardActivityMonth_list.SALES_STAGE_NAME =[TBXML textForElement:X_SALES_STAGE_NAME];
                    
                    TBXMLElement *X_SALE_STAGE_UPDATED_DATE = [TBXML childElementNamed:@"SALE_STAGE_UPDATED_DATE" parentElement:table];
                    dashboardActivityMonth_list.SALES_STAGE_DATE =[TBXML textForElement:X_SALE_STAGE_UPDATED_DATE];
                    
                    TBXMLElement *X_LEAD_ASSIGNED_NAME = [TBXML childElementNamed:@"LEAD_ASSIGNED_NAME" parentElement:table];
                    dashboardActivityMonth_list.LEAD_ASSIGNED_NAME =[TBXML textForElement:X_LEAD_ASSIGNED_NAME];
                    
                    TBXMLElement *X_LEAD_ASSIGNED_CELL_NUMBER = [TBXML childElementNamed:@"LEAD_ASSIGNED_CELL_NUMBER" parentElement:table];
                    dashboardActivityMonth_list.LEAD_ASSIGNED_CELL_NUMBER =[TBXML textForElement:X_LEAD_ASSIGNED_CELL_NUMBER];
                    
                    TBXMLElement *X_LEAD_ASSIGNED_POSITION_ID = [TBXML childElementNamed:@"LEAD_ASSIGNED_POSITION_ID" parentElement:table];
                    dashboardActivityMonth_list.LEAD_ASSIGNED_POSITION_ID =[TBXML textForElement:X_LEAD_ASSIGNED_POSITION_ID];
                    
                    TBXMLElement *X_CONTACT_NAME = [TBXML childElementNamed:@"CONTACT_NAME" parentElement:table];
                    dashboardActivityMonth_list.CONTACT_NAME =[TBXML textForElement:X_CONTACT_NAME];
                    
                    TBXMLElement *X_CONTACT_ID = [TBXML childElementNamed:@"CONTACT_ID" parentElement:table];
                    dashboardActivityMonth_list.CONTACT_ID =[TBXML textForElement:X_CONTACT_ID];
                    
                    TBXMLElement *X_ADDRESS_ID = [TBXML childElementNamed:@"ADDRESS_ID" parentElement:table];
                    dashboardActivityMonth_list.ADDRESS_ID =[TBXML textForElement:X_ADDRESS_ID];
                    
                    TBXMLElement *X_CONTACT_ADDRESS = [TBXML childElementNamed:@"CONTACT_ADDRESS" parentElement:table];
                    dashboardActivityMonth_list.CONTACT_ADDRESS =[TBXML textForElement:X_CONTACT_ADDRESS];
                    
                    TBXMLElement *X_CONTACT_CELL_NUMBER = [TBXML childElementNamed:@"CONTACT_CELL_NUMBER" parentElement:table];
                    dashboardActivityMonth_list.CONTACT_CELL_NUM =[TBXML textForElement:X_CONTACT_CELL_NUMBER];
                    
                    TBXMLElement *X_ACTIVITY_PENDING_TYPE = [TBXML childElementNamed:@"ACTIVITY_PENDING_TYPE" parentElement:table];
                    dashboardActivityMonth_list.ACTIVITY_PENDING_TYPE =[TBXML textForElement:X_ACTIVITY_PENDING_TYPE];
                    
                    TBXMLElement *X_ACTIVITY_ID = [TBXML childElementNamed:@"ACTIVITY_ID" parentElement:table];
                    dashboardActivityMonth_list.ACTIVITY_ROW_ID =[TBXML textForElement:X_ACTIVITY_ID];
                    
                    TBXMLElement *X_PLANNED_START_DATE = [TBXML childElementNamed:@"PLANNED_START_DATE" parentElement:table];
                    dashboardActivityMonth_list.ACTIVITY_PLAN_START_DATE =[TBXML textForElement:X_PLANNED_START_DATE];
                    
                    TBXMLElement *X_ACTIVITY_DESCRIPTION = [TBXML childElementNamed:@"ACTIVITY_DESCRIPTION" parentElement:table];
                    dashboardActivityMonth_list.DESCRIPTION =[TBXML textForElement:X_ACTIVITY_DESCRIPTION];
                    
                    TBXMLElement *X_ACTIVITY_STATUS = [TBXML childElementNamed:@"ACTIVITY_STATUS" parentElement:table];
                    dashboardActivityMonth_list.ACTIVITY_STATUS =[TBXML textForElement:X_ACTIVITY_STATUS];
                    getStaus=[TBXML textForElement:X_ACTIVITY_STATUS];
                    NSLog(@"Status check..%@",getStaus);
                    if ([getStaus isEqualToString:@"Open"]) {
                        NSLog(@"Status is Open");
                        [OpenStatus_Arr addObject:getStaus];
                    } else if([getStaus isEqualToString:@"Done"]){
                        NSLog(@"status Done");
                        [DoneStatus_Arr addObject:getStaus];
                    }else
                    {
                        NSLog(@"Diffrent ");
                    }
                    
                    
                    TBXMLElement *X_PRODUCT_NAME = [TBXML childElementNamed:@"PRODUCT_NAME" parentElement:table];
                    dashboardActivityMonth_list.PRODUCT_LINE =[TBXML textForElement:X_PRODUCT_NAME];
                    
                    [dashboardActivities_Month_Arr addObject:dashboardActivityMonth_list];
                } while ((tuple = tuple->nextSibling));
                NSLog(@"Counter.. %lu",(unsigned long)[dashboardActivities_Month_Arr count]);
                NSLog(@"Counter: Open %lu",(unsigned long)[OpenStatus_Arr count]);
                NSLog(@"Counter: Done %lu",(unsigned long)[DoneStatus_Arr count]);
                
                if([OpenStatus_Arr count]==0)
                {
                    
                    NSLog(@"Open 0");
                    self.slices = [NSMutableArray arrayWithCapacity:1];
                    NSNumber * blah1 = [NSNumber numberWithInt:100];
                    _slices= [NSMutableArray arrayWithObjects: blah1,nil];
                    
                }else if ([DoneStatus_Arr count]==0)
                {
                    NSLog(@"Done 0");
                    self.slices = [NSMutableArray arrayWithCapacity:1];
                    NSNumber * blah1 = [NSNumber numberWithInt:100];
                    _slices= [NSMutableArray arrayWithObjects: blah1,nil];
                }else
                {
                    NSLog(@"Extra");
                }
                
                //    for(int i = 0; i < 5; i ++)
                //    {
                //        NSNumber * blah = [NSNumber numberWithInt:i];
                //        NSArray * items = [NSArray arrayWithObjects: blah, blah, nil];
                //
                //        NSNumber *one = [NSNumber numberWithInt:rand()%60+0];
                //        [_slices addObject:one];
                //    }
                //    [self.pieChartLeft setFrame:CGRectMake(-20,0, 100, 100)];
                /*
                 [self.pieChartLeft setDataSource:self];
                 [self.pieChartLeft setStartPieAngle:M_PI_2];
                 [self.pieChartLeft setAnimationSpeed:1.0];
                 [self.pieChartLeft setLabelFont:[UIFont fontWithName:@"DBLCDTempBlack" size:24]];
                 // [self.pieChartLeft setLabelRadius:160];
                 [self.pieChartLeft setShowPercentage:YES];
                 //[self.pieChartLeft setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
                 [self.pieChartLeft setPieBackgroundColor:[UIColor blackColor]];
                 [self.pieChartLeft setPieCenter:CGPointMake(120, 110)];
                 [self.pieChartLeft setUserInteractionEnabled:NO];
                 [self.pieChartLeft setLabelShadowColor:[UIColor blackColor]];
                 [self.pieChartLeft setLabelRadius:0];
                 
                 [[self.percentageLabel layer] setCornerRadius:61.0f];
                 [[self.percentageLabel layer] setMasksToBounds:YES];
                 self.sliceColors =[NSArray arrayWithObjects:
                 [UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
                 [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
                 [UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],
                 [UIColor colorWithRed:229/255.0 green:66/255.0 blue:115/255.0 alpha:1],
                 [UIColor colorWithRed:148/255.0 green:141/255.0 blue:139/255.0 alpha:1],nil];
                 
                 self.downArrow.transform = CGAffineTransformMakeRotation(M_PI);*/
                
                
                [self.pieChartRight setDataSource:self];
                [self.pieChartRight setStartPieAngle:M_PI_2];
                [self.pieChartRight setAnimationSpeed:1.0];
                [self.pieChartRight setLabelFont:[UIFont fontWithName:@"DBLCDTempBlack" size:24]];
                // [self.pieChartLeft setLabelRadius:160];
                [self.pieChartRight setShowPercentage:YES];
                //[self.pieChartLeft setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
                 [self.pieChartLeft setPieBackgroundColor:[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1]];
                [self.pieChartRight setPieCenter:CGPointMake(120, 110)];
                [self.pieChartRight setUserInteractionEnabled:NO];
                [self.pieChartRight setLabelShadowColor:[UIColor blackColor]];
                [self.pieChartRight setLabelRadius:0];
                
                [[self.percentageLabel1 layer] setCornerRadius:61.0f];
                [[self.percentageLabel1 layer] setMasksToBounds:YES];
                self.sliceColors =[NSArray arrayWithObjects:
                                   [UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
                                   [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
                                   [UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],
                                   [UIColor colorWithRed:229/255.0 green:66/255.0 blue:115/255.0 alpha:1],
                                   [UIColor colorWithRed:148/255.0 green:141/255.0 blue:139/255.0 alpha:1],nil];
                
                self.downArrow.transform = CGAffineTransformMakeRotation(M_PI);
                [self viewDidAppear:YES];
                
                
                _percentageLabel1.text=[NSString stringWithFormat:@"%d", [dashboardActivities_Month_Arr count]];
                if(dashboardActivities_ListArr>=0){
                }
                else
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Server Error!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
                
            }
        }
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    // Do view manipulation here.
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}
#pragma mark - Split view


- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}



#pragma mark - XYPieChart Data Source

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return self.slices.count;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    return [[self.slices objectAtIndex:index] intValue];
    
}

- (UIColor*)pieChart:(XYPieChart*)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    if (pieChart==self.pieChartLeft )
    {
        return [UIColor colorWithRed:151/255.0 green:182/255.0 blue:68/255.0 alpha:1];
    }
    else
    {
       return [self.sliceColors objectAtIndex:(index % self.sliceColors.count)];
    }
}

#pragma mark - XYPieChart Delegate
- (void)pieChart:(XYPieChart *)pieChart willSelectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"will select slice at index %lu",(unsigned long)index);
}
- (void)pieChart:(XYPieChart *)pieChart willDeselectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"will deselect slice at index %lu",(unsigned long)index);
}
- (void)pieChart:(XYPieChart *)pieChart didDeselectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"did deselect slice at index %lu",(unsigned long)index);
}
- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"did select slice at index %lu",(unsigned long)index);
    self.selectedSliceLabel.text = [NSString stringWithFormat:@"$%@",[self.slices objectAtIndex:index]];
}
@end
