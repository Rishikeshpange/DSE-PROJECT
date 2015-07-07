//
//  ActivityListViewController.m
//  NEEV
//
//  Created by admin on 17/03/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import "ActivityListViewController.h"
#import "dashboardTodaysActivity_Cell_VC.h"
#import "dasboard_Email_tableCell_VC.h"
#import "Dashboard_Leads_tablecell_VC.h"
#import "LoginViewController.h"
#import "TBXML.h"
#import "Activity_List.h"
#import "MBProgressHUD.h"
#import "RequestDelegate.h"
#import "Activity_List.h"

@interface ActivityListViewController ()
{
    UIAlertView *alert;

    Boolean isdataAvailable;
}
@end

@implementation ActivityListViewController
@synthesize tableView;
@synthesize _ViewTableData;



-(void)viewWillAppear:(BOOL)animated
{    //[self callActivityList];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ActivityListFound:) name:@"ActivityListFound" object:nil];//Abhishek //For Activity Count
    [self.tableView reloadData];
   }



-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ActivityListFound" object:nil];//Abhishek // for artifact fail
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header_strip1.png"] forBarMetrics:UIBarMetricsDefault];
    
    
    
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];//AppDelegate instance
    userDetailsVal_ = [UserDetails_Var sharedmanager]; // usedetails instance
    appdelegate.fromACTIVITYDetail=@"cameFromActivitySearchList";
    //[[appdelegate.ActivityList objectAtIndex:0] description];
    
    if ([appdelegate.ActivityList count ]==0)
    {
        alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                           message:@"There are no activities"
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil,nil];
        [alert show];

    }
    else
    {
        Activities_ListArr=appdelegate.ActivityList;
    }
   /* NSLog(@"OPPTY_ROWID:%@",[[appdelegate.ActivityList objectAtIndex:0] valueForKey:@"OPPTY_ROWID"]);*/
//     NSLog(@"%@",[[Activities_ListArr objectAtIndex:0] valueForKey:@"OPPTY_ROWID"]);
//    NSLog(@"%@",[[[Activities_ListArr objectAtIndex:0] allKeys] description]);
    //Search button
    
    _searchButton.layer.cornerRadius = 35; // this value vary as per your desire
    _searchButton.clipsToBounds = YES;
    
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
    


    //a=15;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)info_btn
{
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
    
     return [appdelegate.ActivityList count];
    NSLog(@"%d",[appdelegate.ActivityList count]);
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0 || indexPath.row == ([indexPath length]-1))
    {
        cell.layer.cornerRadius = 10;
        
    }
    cell.layer.cornerRadius = 10;
    
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
    UIView *bgColorView = [[UIView alloc] init];
//    [bgColorView setBackgroundColor:[UIColor colorWithRed:(1/255.0) green:(29/255.0) blue:(115/255.0) alpha:1]];
    [bgColorView setBackgroundColor:[UIColor lightGrayColor]];
    bgColorView.layer.cornerRadius = 10;
    // [cell setSelectedBackgroundView:bgColorView];
    // [bgColorView release];
   
//    cell.backgroundColor = [UIColor colorWithRed:(1/255.0) green:(31/255.0) blue:(65/255.0) alpha:1] ;
     cell.backgroundColor = [UIColor whiteColor] ;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    cell.textLabel.textColor=[UIColor colorWithRed:(216/255.0) green:(218/255.0) blue:(221/255.0) alpha:1];
    //  cell.textLabel.highlightedTextColor = [UIColor colorWithRed:(0/255.0) green:(13/255.0) blue:(65/255.0) alpha:1];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds] ;
    //  cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:(178/255.0) green:(183/255.0) blue:(63/255.0) alpha:1];
    
    cell.selectedBackgroundView=bgColorView;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        cell.layer.cornerRadius = 10;
        
    }
    //cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    // cell.imageView.image = [UIImage imageNamed:@"creme_brelee.jpg"];
    
    return cell;*/
    
    if (tableView == self.tableView) {
        static NSString *MyIdentifier = @"TodaysActivitiesViewCellIdentifier";
        
        dashboardTodaysActivity_Cell_VC *cell = [self.tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        if (cell == nil)
        {
            cell = [[dashboardTodaysActivity_Cell_VC alloc] initWithStyle:UITableViewCellStyleDefault
                                                          reuseIdentifier:MyIdentifier];
        }
        //[cell.layer setBorderColor:(__bridge CGColorRef)([UIColor colorWithRed:49 green:110 blue:119 alpha:1])];
      //  [cell.layer setBorderColor:[UIColor colorWithRed:49/255 green:110/255 blue:119/255 alpha:1].CGColor];
         //[UIColor colorWithRed:49 green:110 blue:119 alpha:1]];
//        [cell.layer setBorderColor:[UIColor blueColor].CGColor];
//        [cell.layer setBorderWidth:2.0f];
        cell.layer.borderColor =  [UIColor colorWithRed:(218/255.0) green:(218/255.0) blue:(218/255.0) alpha:1].CGColor;
        cell.layer.borderWidth = 1.0f;
        cell.layer.cornerRadius=5;

        cell.lbl_customer.text = @"CUSTOMER NAME :";
               // cell.lbl_customer.text =[[Activities_ListArr objectAtIndex:indexPath.row] valueForKey:@"ACCOUNT_NAME"];
        //cell.textLabel.text = [recipes objectAtIndex:indexPath.row];
       // cell.lbl_CustomerName.text =[Activities_Customer_list objectAtIndex:indexPath.row];
        cell.lbl_CustomerName.text =[[appdelegate.ActivityList objectAtIndex:indexPath.row] valueForKey:@"CONTACT_NAME"];
        NSLog(@"%@",cell.lbl_CustomerName.text);
        NSLog(@"%ld",(long)indexPath.row);
        cell.lbl_opty.text = @"OPPORTUNITY ID :";
       // cell.lbl_OptyId.text =[Activities_ListArr objectAtIndex:indexPath.row];
             
        
             cell.lbl_OptyId.text =[[appdelegate.ActivityList objectAtIndex:indexPath.row] valueForKey:@"OPPTY_ROWID"];
        NSLog(@"%@",cell.lbl_OptyId.text);
//        cell.optyCounter.text=@"4";

        return cell;
        
     //   cell.backgroundColor = [UIColor clearColor];
       // return 0;
    }
    /*
    if (tableView == self.Leads_TV) {
        
        static NSString *MyIdentifier = @"LeadsIdentifier";
        Dashboard_Leads_tablecell_VC *cell = [self.Leads_TV dequeueReusableCellWithIdentifier:MyIdentifier];
        
        if (cell == nil)
        {
            cell = [[Dashboard_Leads_tablecell_VC alloc] initWithStyle:UITableViewCellStyleDefault
                                                       reuseIdentifier:MyIdentifier];
        }
        
        cell.lbl_leadName.text = @"Warm Lead";
        cell.lbl_leadSummary.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, ";
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }*/
    //return 0;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if ([[segue identifier] isEqualToString:@"showActivity"])
//    {
//        ActivityListViewController *detailViewController =
//        [segue destinationViewController];
//        NSLog(@"0 -- %@",detailViewController);
//    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    appdelegate.row=indexPath.row; //Activity flag to store clicked index path to carry forward to activity detail
    appdelegate.OPTY_ID_For_Activity_Detail=[[Activities_ListArr objectAtIndex:indexPath.row] valueForKey:@"OPPTY_ROWID"];
    
    appdelegate.fromManageOptyDetail=nil;
     appdelegate.fromOPTYDetail=nil;

    
    
    
    // [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    /*
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                {
                    [self performSegueWithIdentifier:@"showActivity" sender:[tableView cellForRowAtIndexPath:indexPath]];
                    NSLog(@"Products");
                    
                }
                    break;
                case 1:
                {
                    [self performSegueWithIdentifier:@"showActivity" sender:[tableView cellForRowAtIndexPath:indexPath]];
                    
                    NSLog(@"Stores");
                }
                    break;
                case 2:
                {
                    [self performSegueWithIdentifier:@"showActivity" sender:[tableView cellForRowAtIndexPath:indexPath]];
                    
                    NSLog(@"Packages");
                }
                    break;
                case 3:
                {
                    [self performSegueWithIdentifier:@"showActivity" sender:[tableView cellForRowAtIndexPath:indexPath]];
                    
                    NSLog(@"Finances");
                    
                    break;
                }
                case 4:
                {
                    [self performSegueWithIdentifier:@"showActivity" sender:[tableView cellForRowAtIndexPath:indexPath]];
                    
                    NSLog(@"Finances");
                    
                    break;
                }
                    
                case 5:
                {
                    [self performSegueWithIdentifier:@"showActivity" sender:[tableView cellForRowAtIndexPath:indexPath]];
                    
                    NSLog(@"Finances");
                    
                    break;
                }
                case 6:
                {
                    [self performSegueWithIdentifier:@"showActivity" sender:[tableView cellForRowAtIndexPath:indexPath]];
                    
                    NSLog(@"Finances");
                    
                    break;
                }
                    break;
                default:
                    break;
            }
    }*/
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)callActivityList
{
    NSLog(@"Extra..");
    // self.startLoop = startLoop_;
    // self.endLoop = endLoop_;
    NSString * envelopeText = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<GetListOfActivityForNSELOBDSE xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                               @"<positionid>%@</positionid>"
                               @"<activitystatus>Open</activitystatus>"
                               @"</GetListOfActivityForNSELOBDSE>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",userDetailsVal_.ROW_ID];
    
    
   
    
    
    NSString * envelopeText1 = [NSString stringWithFormat:
                                @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                @"<SOAP:Body>"
                                @"<GetActivityBasedOnDate xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                @"<positionid>%@</positionid>"
                                @"<act_start_date>13-MAR-2014</act_start_date>"// --activity start date pass in dd-mmm-yyyy format
                                @"<act_status>Open</act_status>"
                                @"<rang1>%d</rang1>"
                                @"<rang2>%d</rang2>"
                                @"</GetActivityBasedOnDate>"
                                @"</SOAP:Body>"
                                @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,1,20] ;
    
    NSLog(@"\n envlopeString Of user details....!!!!%@",envelopeText);
    
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@",theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    
    NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"ActivityDetails_Connection"];
}

-(void)ActivityListFound:(NSNotification*)notification  // Activity Response
{
    int i = 0; //for test loop
    Activities_ListArr=[[NSMutableArray alloc] init];
    Activities_Customer_list=[[NSMutableArray alloc] init];
    
    NSError *err;
    TBXMLElement *X_PROSPECT_SRC;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n ActivityDetails_Connection response... %@ ",response);
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    
    TBXMLElement *soapBody = [TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement];
    TBXMLElement *container = [TBXML childElementNamed:@"GetListOfActivityForNSELOBDSEResponse" parentElement:soapBody];
    if(container)
    {
        TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        ///  NSLog(@"Tuple..%@",tuple);
        if (tuple)
        {
            do {
                activity_list = nil;
                activity_list = [[Activity_List alloc]init];
                
                /*
                 <S_OPTY_POSTN>
                 <OPTY_NAME>1-788U78A</OPTY_NAME>
                 <OPTY_ID>1-788U78A</OPTY_ID>
                 <PRODUCT_NAME1>Ace Zip</PRODUCT_NAME1>
                 <OPTY_CREATED>19-SEP-2014</OPTY_CREATED>
                 <TGM_TKM_NAME xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
                 <TGM_TKM_PHONE_NUMBER xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
                 <ACCOUNT_TYPE>TGM</ACCOUNT_TYPE>
                 <ACCOUNT_ID xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
                 <SALES_STAGE_NAME>Closed Lost at C1A</SALES_STAGE_NAME>
                 <SALE_STAGE_UPDATED_DATE>27-JAN-2015</SALE_STAGE_UPDATED_DATE>
                 <LEAD_ASSIGNED_NAME>AJAY PARAB</LEAD_ASSIGNED_NAME>
                 <LEAD_ASSIGNED_CELL_NUMBER>9999999999</LEAD_ASSIGNED_CELL_NUMBER>
                 <LEAD_ASSIGNED_POSITION_NAME>TMCV-Sal-W-MUM-1001680-Jogeshwari-Pickup-DSE-33</LEAD_ASSIGNED_POSITION_NAME>
                 <LEAD_ASSIGNED_POSITION_ID>1-7F0Y20</LEAD_ASSIGNED_POSITION_ID>
                 <CONTACT_NAME>ANAND KUMAR</CONTACT_NAME>
                 <CONTACT_ID>1-788U783</CONTACT_ID>
                 <ADDRESS_ID>1-788U788</ADDRESS_ID>
                 <CONTACT_ADDRESS>FINANCE ONE INDIA BULLS, 20TH FLR,</CONTACT_ADDRESS>
                 <CONTACT_CELL_NUMBER>2266586333</CONTACT_CELL_NUMBER>
                 <ACTIVITY_PENDING_TYPE>Test Drive</ACTIVITY_PENDING_TYPE>
                 <ACTIVITY_ID>1-7BN1O73</ACTIVITY_ID>
                 <PLANNED_START_DATE>28-FEB-2015 17:14:05</PLANNED_START_DATE>
                 <ACTIVITY_DESCRIPTION>FFF</ACTIVITY_DESCRIPTION>
                 <ACTIVITY_STATUS>Open</ACTIVITY_STATUS>
                 <PRODUCT_NAME>Ace_Zip</PRODUCT_NAME>
                 </S_OPTY_POSTN>
                 */
                
                TBXMLElement *table  = [TBXML childElementNamed:@"S_OPTY_POSTN" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                X_PROSPECT_SRC = [TBXML childElementNamed:@"OPTY_NAME" parentElement:table];
                NSString *str_NAME = [TBXML textForElement:X_PROSPECT_SRC];
                activity_list.X_PROSPECT_SRC =[TBXML textForElement:X_PROSPECT_SRC];
                // [Activities_ListArr addObject:str_NAME];
                
                X_PROSPECT_SRC = [TBXML childElementNamed:@"OPTY_ID" parentElement:table];
                NSString *str_OpTyId = [TBXML textForElement:X_PROSPECT_SRC];
                activity_list.X_PROSPECT_SRC =[TBXML textForElement:X_PROSPECT_SRC];
                [Activities_ListArr addObject:str_OpTyId];
                
                
                X_PROSPECT_SRC = [TBXML childElementNamed:@"CONTACT_NAME" parentElement:table];
                NSString *str_Contact_Name = [TBXML textForElement:X_PROSPECT_SRC];
                activity_list.X_PROSPECT_SRC =[TBXML textForElement:X_PROSPECT_SRC];
                [Activities_Customer_list addObject:str_Contact_Name];
                
            } while ((tuple = tuple->nextSibling));
            //NSLog(@"Opty Id's 11%@",Activities_ListArr);
            [self.tableView reloadData];
        }
        NSLog(@"Opty Id's 12%@",Activities_Customer_list);
        NSLog(@"Counter.. %lu",(unsigned long)[Activities_ListArr count]);
        //NSLog(@"...Data..Available %hhu",isdataAvailable);
        [_ViewTableData setHidden:NO];
    }
}
    -(void)showAlert
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    
    -(void)hideAlert
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }

@end
