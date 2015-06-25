//
//  ActivityDetailsViewController.m
//  NEEV
//
//  Created by admin on 17/03/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import "ActivityDetailsViewController.h"
#import "LoginViewController.h"
#import "ActivityTableViewCell.h"

#import "ActivityPendingList.h"
#import "RequestDelegate.h"
#import "TBXML.h"
#import "Activity_List.h"
#import "MBProgressHUD.h"
#import "Activity_List.h"
#import "ActivityPendingList.h"
#import "SearchActivity_List.h"
@interface ActivityDetailsViewController ()
{
    UIAlertView *alert;
    NSString *counterString;
}
@end

@implementation ActivityDetailsViewController

@synthesize customerName,customerNumber,assigntoName,assigntoNumber,optyCounter;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self showAlert];
    
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];//AppDelegate instance
    userDetailsVal_ = [UserDetails_Var sharedmanager]; // usedetails instance
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header_strip1.png"] forBarMetrics:UIBarMetricsDefault];
     self.automaticallyAdjustsScrollViewInsets = NO;
    
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
    
    NSLog(@"pending activities from manage opty to detail :%d",[pendingActivities_ListArr count]);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButtonItems];
    self.textscroll=[[UIScrollView alloc]init];
    
    
    self.textscroll.contentSize=CGSizeMake(550, 500);

   
    self.tableview.separatorInset=UIEdgeInsetsZero;
    
    
//    self.activityInfo.layer.borderColor =  [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1].CGColor;
    
     self.activityInfo.layer.borderColor =[UIColor colorWithRed:(216/255.0) green:(218/255.0) blue:(221/255.0) alpha:1].CGColor;

    self.activityInfo.layer.borderWidth = 3.0f;
    self.activityInfo.layer.cornerRadius = 7;
    
     appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];//AppDelegate instance
    NSLog(@"%@",appdelegate.fromOPTYDetail);
    if ([appdelegate.fromOPTYDetail isEqualToString:@"CameFromOptyDetail"])
    {
        NSLog(@"%d",appdelegate.optyrow);
         NSLog(@"%@",appdelegate.CONTACT_CELL_NUMBER);
         NSLog(@"%@",appdelegate.CONTACT_NAME);
//        customerName.text=[[pendingActivities_ListArr objectAtIndex:appdelegate.optyrow] valueForKey:@"CONTACT_NAME"];
//        customerNumber.text=[[pendingActivities_ListArr objectAtIndex:appdelegate.optyrow] valueForKey:@"CONTACT_CELL_NUMBER"];
//    
        customerNumber.text=appdelegate.CONTACT_CELL_NUMBER;
       customerName.text=appdelegate.CONTACT_NAME;
//        
//        customerNumber.text=[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"CONTACT_CELL_NUMBER"];
    // [self callPendingActivityList];
        NSLog(@"CameFromOptyDetail");
    }
    else if([appdelegate.fromACTIVITYDetail isEqualToString:@"cameFromActivitySearchList"])
    {
         NSLog(@"CameFromActivitySearchListview");
   
        customerName.text=[[DisplaySearchActivitiesDetailsArray objectAtIndex:appdelegate.row] valueForKey:@"CONTACT_NAME"];
        
        customerNumber.text=[[DisplaySearchActivitiesDetailsArray objectAtIndex:appdelegate.row] valueForKey:@"CONTACT_CELL_NUM"];
        ;
        NSLog(@"%@",[[DisplaySearchActivitiesDetailsArray objectAtIndex:appdelegate.row] valueForKey:@"ACTIVITY_PLAN_START_DATE"]);
//        customerName.text=[[appdelegate.ActivityList objectAtIndex:appdelegate.row] valueForKey:@"CONTACT_NAME"];
//        
//        customerNumber.text=[[appdelegate.ActivityList objectAtIndex:appdelegate.row] valueForKey:@"CONTACT_CELL_NUM"];
//        ;
//     NSLog(@"%@",[[appdelegate.ActivityList objectAtIndex:appdelegate.row] valueForKey:@"ACTIVITY_PLAN_START_DATE"]);
         [self callPendingActivityList];
  //  [self callPendingActivityList];
    }
    else if([appdelegate.fromManageOptyDetail isEqualToString:@"CameFromManageOptyToDetail"])
    {
        NSLog(@"CameFromManageOptyListView");
        customerName.text=[[appdelegate.OppurtunityList objectAtIndex:appdelegate.Manageoptyrow] valueForKey:@"CONTACT_NAME"];
           customerNumber.text=[[appdelegate.OppurtunityList objectAtIndex:appdelegate.Manageoptyrow] valueForKey:@"CONTACT_CELL_NUMBER"];
        [self callPendingActivityList];
       // NSLog(@"%@",[[appdelegate.OppurtunityList objectAtIndex:appdelegate.Manageoptyrow] valueForKey:@"ACTIVITY_PLAN_START_DT"]);
       // [self callPendingActivityList];
        //  [self callPendingActivityList];
    }

    
   
    // Do any additional setup after loading the view.
}

-(void)DoneActivity_Found:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n DoneFound response... %@ ",response);
    
    
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Something gone wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    else
    {
        TBXMLElement *container = [TBXML childElementNamed:@"ns:SFATMCVInsertOrUpdate_Output" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        //
        //
        TBXMLElement *ListOfTmActionInterface =[TBXML childElementNamed:@"ListOfTmActionInterface" parentElement:container];
        TBXMLElement *Action =[TBXML childElementNamed:@"Action" parentElement:ListOfTmActionInterface];
        
        if (Action) {
            
            TBXMLElement *ActivityId =[TBXML childElementNamed:@"ActivityId" parentElement:Action];
            TBXMLElement *IntegrationId =[TBXML childElementNamed:@"IntegrationId" parentElement:Action];
            TBXMLElement *Id =[TBXML childElementNamed:@"Id" parentElement:Action];
            
            
            
            NSLog(@"%@,%@",appdelegate.ACTIVITY_ID,appdelegate.ACTIVITY_TYPE);
            NSLog(@"pending activities from manage opty to detail :%lu",(unsigned long)[pendingActivities_ListArr count]);
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MM/dd/yyyy hh:mm:ss"];
            NSString *stringFromDate = [formatter stringFromDate:[NSDate date]];
           
            NSLog(@"stringFromDate : : %@",appdelegate.toandfromdate);
            NSString * envelopeText1 =[NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                       @"<SOAP:Body>"
                                       @"<SFATMCVInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                                       @"<ListOfTmActionInterface xmlns=\"http://www.siebel.com/xml/TMActionInterface/\">"
                                       @"<Action>"
                                       @"<Status>Done</Status>"
                                       @"<PlannedStart>%@</PlannedStart>"
                                       @"<PlannedCompletion>%@</PlannedCompletion>"
                                       @"<ActivityId>%@</ActivityId>"
                                       @"</Action>"
                                       @"</ListOfTmActionInterface>"
                                       @"</SFATMCVInsertOrUpdate_Input>"
                                       @"</SOAP:Body>"
                                       @"</SOAP:Envelope>",appdelegate.toandfromdate,appdelegate.toandfromdate,appdelegate.ACTIVITY_ID];
            
            
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
            
            [[RequestDelegate alloc]initiateRequest:request name:@"Done_Activity_second_request"];

            
//            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Done" message:@"Activity Marked as Done" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alertView show];
//            NSLog(@"%@,%@,%@",appdelegate.ACTIVITY_TYPE,appdelegate.ACTIVITY_ID,appdelegate.opty_idDetailPage);
//            if ([appdelegate.ACTIVITY_TYPE isEqualToString:@"Papers Submitted"])
//            {
//                NSString * envelopeText1 =[NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                                           @"<SOAP:Body>"
//                                           @"<SFATMCVOPTYInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
//                                           @"<ListOfTMOpportunityInterface xmlns=\"http://www.siebel.com/xml/TM%%20Opportunity%%20Interface\">"
//                                           @"<Opportunity>"
//                                           @"<Id>%@</Id>"
//                                           @"<SalesStage>C1A (Papers submitted)</SalesStage>"
//                                           @"</Opportunity>"
//                                           @"</ListOfTMOpportunityInterface>"
//                                           @"</SFATMCVOPTYInsertOrUpdate_Input>"
//                                           @"</SOAP:Body>"
//                                           @"</SOAP:Envelope>",appdelegate.opty_idDetailPage];
//                
//                NSData *envelope = [envelopeText1 dataUsingEncoding:NSUTF8StringEncoding];
//                
//                NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
//                // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
//                NSLog(@"URL IS %@",theurl);
//                // NSLog(@"REQUEST IS %@",envelopeText);
//                
//                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
//                
//                NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText1 length]];
//                
//                [request setHTTPMethod:@"POST"];
//                [request setHTTPBody:envelope];
//                [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//                [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
//                
//                [[RequestDelegate alloc]initiateRequest:request name:@"After_Done_Activity"];
//            }
            
        }
        
        else
        {
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Activity error response" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
}
-(void)DoneActivity_second_request_Found:(NSNotification*)notification
{
    
    //[self hideAlertSuperview];//Abhishek //Test later
    
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n DoneFound response... %@ ",response);
    
    
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Something gone wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    else
    {
        TBXMLElement *container = [TBXML childElementNamed:@"ns:SFATMCVInsertOrUpdate_Output" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        //
        //
        TBXMLElement *ListOfTmActionInterface =[TBXML childElementNamed:@"ListOfTmActionInterface" parentElement:container];
        TBXMLElement *Action =[TBXML childElementNamed:@"Action" parentElement:ListOfTmActionInterface];
        
        if (Action) {
            
            TBXMLElement *ActivityId =[TBXML childElementNamed:@"ActivityId" parentElement:Action];
            TBXMLElement *IntegrationId =[TBXML childElementNamed:@"IntegrationId" parentElement:Action];
            TBXMLElement *Id =[TBXML childElementNamed:@"Id" parentElement:Action];
            
            
                        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Done" message:@"Activity Marked as Done" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
           // alertView.tag=50;
                        [alertView show];
            if ([appdelegate.fromOPTYDetail isEqualToString:@"CameFromOptyDetail"])
            {
                [self getPendingActivities];
            
            }
            else if ([appdelegate.fromACTIVITYDetail isEqualToString:@"cameFromActivitySearchList"])
            {
            [self callPendingActivityList];
            }
            NSLog(@"%@,%@,%@",appdelegate.ACTIVITY_TYPE,appdelegate.ACTIVITY_ID,appdelegate.opty_idDetailPage);
        if ([appdelegate.ACTIVITY_TYPE isEqualToString:@"Papers Submitted"])
                        {
                            NSString * envelopeText1 =[NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                                       @"<SOAP:Body>"
                                                       @"<SFATMCVOPTYInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                                                       @"<ListOfTMOpportunityInterface xmlns=\"http://www.siebel.com/xml/TM%%20Opportunity%%20Interface\">"
                                                       @"<Opportunity>"
                                                       @"<Id>%@</Id>"
                                                       @"<SalesStage>C1A (Papers submitted)</SalesStage>"
                                                       @"</Opportunity>"
                                                       @"</ListOfTMOpportunityInterface>"
                                                       @"</SFATMCVOPTYInsertOrUpdate_Input>"
                                                       @"</SOAP:Body>"
                                                       @"</SOAP:Envelope>",appdelegate.opty_idDetailPage];
            
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
            
                            [[RequestDelegate alloc]initiateRequest:request name:@"After_Done_Activity"];
                        }
            
        }
        
        else
        {
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Activity error response" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
}


-(void)After_DoneActivity_Found:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n DoneFound response... %@ ",response);
    
    
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Something gone wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else{
        
        
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement *container = [TBXML childElementNamed:@"ns:SFATMCVOPTYInsertOrUpdate_Output" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        
        TBXMLElement *ListOfContactInterface =[TBXML childElementNamed:@"ListOfTMOpportunityInterface" parentElement:container];
        
        TBXMLElement *Opportunity = [TBXML childElementNamed:@"Opportunity" parentElement:ListOfContactInterface];
         TBXMLElement *IntegrationId = [TBXML childElementNamed:@"IntegrationId" parentElement:ListOfContactInterface];
        TBXMLElement *Id = [TBXML childElementNamed:@"Id" parentElement:Opportunity];
        if (Id)
        {
            [self hideAlert];
           NSString *stringID = [TBXML textForElement:Id];
            NSLog(@"\nListOfContactInterface.....!!!!!%@",stringID);
            
            alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Activity Done Successfully!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        
        else
        {
            [self hideAlert];
            alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Server Error!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }

    
}

-(void)viewWillAppear:(BOOL)animated
{
    if ([appdelegate.FromUpdateActivityString isEqualToString:@"FromUpdateActivityString"])
    {
        appdelegate.FromUpdateActivityString=nil;
//       [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(PendingActivityListFoundRefresh:) name:@"PendingActivityListFound" object:nil];
        if ([appdelegate.fromOPTYDetail isEqualToString:@"CameFromOptyDetail"])
        {
            [self getPendingActivities];
        }
        else if ([appdelegate.fromACTIVITYDetail isEqualToString:@"cameFromActivitySearchList"])
        {
        
       [self callPendingActivityList];
        }
        
    }
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(PendingActivityListFound:) name:@"PendingActivityListFound" object:nil];  //For Activity Count
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DoneActivity_Found:) name:@"Activity_Done_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(After_DoneActivity_Found:) name:@"After_Activity_Done_Found" object:nil];
    
   [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getPendingActivityListFound:) name:@"getPendingActivityListFound" object:nil];
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DoneActivity_second_request_Found:) name:@"Activity_Done_second_request_Found" object:nil];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"PendingActivityListFound" object:nil];
//    appdelegate.fromOPTYDetail=nil;
//    appdelegate.fromACTIVITYDetail=nil;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
  //  alert.tag=30;
    [alert show];
    NSLog(@"Home biscuit from Sanfrancisco");
}
// delegate mehod for uialertView

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
//    NSLog(@"Button Index =%ld",(long)buttonIndex);
//    if (alertView.tag==50)
//    {
//        if (buttonIndex == 0) {
//            
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//        if (buttonIndex==1) {
////            NSLog(@"Glen Maxwell");
////            LoginViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
////            //[self.navigationController pushViewController:secondViewController animated:YES];
////            [self presentViewController:secondViewController animated:YES completion:nil ];
////            //  [self.navigationController popToRootViewControllerAnimated:TRUE];
////            // [self dismissViewControllerAnimated:YES completion:nil];
////            //  [self.parentViewController.navigationController popToRootViewControllerAnimated:YES];
////            //  [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
//        }
//
//    }
//    else if (alertView.tag==30)
//    {
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
  //  }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([appdelegate.fromOPTYDetail isEqualToString:@"CameFromOptyDetail"])
    {
   
        return [pendingActivities_ListArr count];
    }
    else if ([appdelegate.fromACTIVITYDetail isEqualToString:@"cameFromActivitySearchList"])
    {
    // return [appdelegate.ActivityList count];
       return [pendingActivities_ListArr count];
      //  return 1;
    }//count number of row from counting array hear cataGorry is An Array
    else if ([appdelegate.fromManageOptyDetail isEqualToString:@"CameFromManageOptyToDetail"])
    {
        // return [appdelegate.ActivityList count];
        return [pendingActivities_ListArr count];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"Row Selected ... %ld",(long)indexPath.row);
    activityPending_list = [pendingActivities_ListArr objectAtIndex:indexPath.row];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@".....Ek don teen char");
    if ([appdelegate.fromOPTYDetail isEqualToString:@"CameFromOptyDetail"])
    {
    activityPending_list = nil;
    activityPending_list = [[ActivityPendingList alloc]init];
    activityPending_list = [pendingActivities_ListArr objectAtIndex:indexPath.row];
    NSLog(@"...Data Final ..%@",pendingActivities_ListArr);
    }
    else
    {
     NSLog(@"noneed to alloc pending list");
    }
    static NSString *MyIdentifier = @"activitydetailcell";
    ActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (tableView == self.tableview)
    {
        if (cell == nil) {
            cell = [[ActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
        }
        
        cell.backgroundColor=[UIColor clearColor];
//        [cell.layer setBorderColor:[UIColor whiteColor].CGColor];
        [cell.layer setBorderColor:[UIColor colorWithRed:(216/255.0) green:(218/255.0) blue:(221/255.0) alpha:1].CGColor];
        // [cell.layer setBorderColor:[UIColor whiteColor].CGColor];
        [cell.layer setBorderWidth:2.0f];
        cell.layer.cornerRadius=5;
        
        NSLog(@"activity..%@",activityPending_list.ACCOUNT_ID);
        
        if ([appdelegate.fromOPTYDetail isEqualToString:@"CameFromOptyDetail"])
        {
            cell.lbl_Planned_Date.text=[[pendingActivities_ListArr objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_PLAN_START_DT"];
            cell.lbl_Activity_Type.text=[[pendingActivities_ListArr objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_TYPE"];
            
//            cell.lbl_Activity_Status.text=[NSString stringWithFormat:@"%@                            %@",[[pendingActivities_ListArr objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_TYPE"],[[pendingActivities_ListArr objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_STATUS"]];
            
cell.lbl_Activity_Status.text=[NSString stringWithFormat:@"%@",[[pendingActivities_ListArr objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_STATUS"]];
            
            cell.lbl_Description.text=[[pendingActivities_ListArr objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_DESC"];
            
//            NSLog(@"activity..%@", [[pendingActivities_ListArr objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_TYPE"]);
//            NSLog(@"activity..%@",[[pendingActivities_ListArr objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_STATUS"]);
//           NSLog(@"activity..%@",[[pendingActivities_ListArr objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_DESC"]);
//            NSLog(@"activity..%@",[[pendingActivities_ListArr objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_PLAN_START_DT"]);


        }
        else if([appdelegate.fromACTIVITYDetail isEqualToString:@"cameFromActivitySearchList"])
        {
            if ([appdelegate.reloadDataArrChange isEqualToString:@"reloadDataArrChange"])
            {
                cell.lbl_Planned_Date.text=[[appdelegate.ActivityListForSearch  objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_PLAN_START_DT"];
//                cell.lbl_Activity_Type.text=[[appdelegate.ActivityListForSearch  objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_TYPE"];
//                cell.lbl_Activity_Status.text=[NSString stringWithFormat:@"%@    %@",[[appdelegate.ActivityListForSearch  objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_TYPE"],[[appdelegate.ActivityListForSearch  objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_STATUS"]];
                cell.lbl_Activity_Type.text=[[appdelegate.ActivityListForSearch  objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_TYPE"];
             
                
                cell.lbl_Activity_Status.text=[NSString stringWithFormat:@"%@",[[appdelegate.ActivityListForSearch  objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_STATUS"]];
                cell.lbl_Description.text=[[appdelegate.ActivityListForSearch  objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_DESC"];
                
                NSLog(@"%@,%@,%@,%@",cell.lbl_Planned_Date.text,cell.lbl_Activity_Type.text,cell.lbl_Activity_Status.text,cell.lbl_Description.text);

            }
            else
            {
            cell.lbl_Planned_Date.text=[[appdelegate.ActivityList objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_PLAN_START_DT"];
//            cell.lbl_Activity_Type.text=[[appdelegate.ActivityList objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_TYPE"];
//            cell.lbl_Activity_Status.text=[NSString stringWithFormat:@"%@    %@",[[appdelegate.ActivityList objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_TYPE"],[[appdelegate.ActivityList objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_STATUS"]];
                
                cell.lbl_Activity_Type.text=[[appdelegate.ActivityList objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_TYPE"];
                
                
                cell.lbl_Activity_Status.text=[NSString stringWithFormat:@"%@",[[appdelegate.ActivityList objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_STATUS"]];
            cell.lbl_Description.text=[[appdelegate.ActivityList objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_DESC"];
            
            NSLog(@"%@,%@,%@,%@",cell.lbl_Planned_Date.text,cell.lbl_Activity_Type.text,cell.lbl_Activity_Status.text,cell.lbl_Description.text);
            }
            
            
//            cell.lbl_Planned_Date.text=[[appdelegate.ActivityList objectAtIndex:appdelegate.row] valueForKey:@"ACTIVITY_PLAN_START_DATE"];
//             cell.lbl_Activity_Type.text=[[appdelegate.ActivityList objectAtIndex:appdelegate.row] valueForKey:@"ACTIVITY_TYPE"];
//            cell.lbl_Activity_Status.text=[NSString stringWithFormat:@"%@                    %@",[[appdelegate.ActivityList objectAtIndex:appdelegate.row] valueForKey:@"ACTIVITY_TYPE"],[[appdelegate.ActivityList objectAtIndex:appdelegate.row] valueForKey:@"ACTIVITY_STATUS"]];
//             cell.lbl_Description.text=[[appdelegate.ActivityList objectAtIndex:appdelegate.row] valueForKey:@"DESCRIPTION"];

          /*  cell.lbl_Planned_Date.text=[[pendingActivities_ListArr objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_PLAN_START_DT"];
            cell.lbl_Activity_Type.text=[[pendingActivities_ListArr objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_TYPE"];
            cell.lbl_Activity_Status.text=[NSString stringWithFormat:@"%@                    %@",[[pendingActivities_ListArr objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_TYPE"],[[pendingActivities_ListArr objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_STATUS"]];
            cell.lbl_Description.text=[[pendingActivities_ListArr objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_DESC"];*/

            
//            NSLog(@"activity..%@", [[appdelegate.ActivityList objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_TYPE"]);
//            NSLog(@"activity..%@",[[appdelegate.ActivityList objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_STATUS"]);
//            NSLog(@"activity..%@",[[appdelegate.ActivityList objectAtIndex:indexPath.row] valueForKey:@"DESCRIPTION"]);
//            NSLog(@"activity..%@",[[appdelegate.ActivityList objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_PLAN_START_DATE"]);
        }
        else if([appdelegate.fromManageOptyDetail isEqualToString:@"CameFromManageOptyToDetail"])
        {
            cell.lbl_Planned_Date.text=[[pendingActivities_ListArr objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_PLAN_START_DT"];
            cell.lbl_Activity_Type.text=[[pendingActivities_ListArr objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_TYPE"];
            cell.lbl_Activity_Status.text=[NSString stringWithFormat:@"%@                    %@",[[pendingActivities_ListArr objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_TYPE"],[[pendingActivities_ListArr objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_STATUS"]];
            cell.lbl_Description.text=[[pendingActivities_ListArr objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_DESC"];
            
        }
      
        if ([cell.lbl_Activity_Status.text isEqualToString:@"Done"])
        {
            cell.doneButton.enabled=NO;
            cell.updateButton.enabled=NO;
        }
        else if ([cell.lbl_Activity_Status.text isEqualToString:@"Open"])
        {
        cell.doneButton.enabled=YES;
             cell.updateButton.enabled=YES;
        }
        
        if ([cell.lbl_Description.text isEqualToString:@""])
        {
           cell.lbl_Description.text=@"Unavailable";
        }
        if ([cell.lbl_Activity_Status.text isEqualToString:@""])
        {
            cell.lbl_Activity_Status.text=@"Unavailable";
             cell.doneButton.enabled=NO;
        }
        if ([cell.lbl_Activity_Type.text isEqualToString:@""])
        {
            cell.lbl_Activity_Type.text=@"Unavailable";
            // cell.updateButton.enabled=NO;
        }
        if ([cell.lbl_Planned_Date.text isEqualToString:@""])
        {
            cell.lbl_Planned_Date.text=@"Unavailable";
        }
        return cell;
    }
    return 0;
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
   // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    [bgColorView setBackgroundColor:[UIColor redColor]];
    bgColorView.layer.cornerRadius = 10;
    // [cell setSelectedBackgroundView:bgColorView];
    // [bgColorView release];
    
    cell.backgroundColor = [UIColor colorWithRed:(1/255.0) green:(31/255.0) blue:(65/255.0) alpha:1] ;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    cell.textLabel.textColor=[UIColor colorWithRed:(216/255.0) green:(218/255.0) blue:(221/255.0) alpha:1];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds] ;
   // cell.selectedBackgroundView=bgColorView;
    
}

-(void)callPendingActivityList
{
    NSString *opty_id=[[NSString alloc]init];
    if ([appdelegate.fromOPTYDetail isEqualToString:@"CameFromOptyDetail"])
    {
      opty_id=  [[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"OPTY_ID"];
       
        NSLog(@"CameFromOptyDetail");
    }
    else if([appdelegate.fromACTIVITYDetail isEqualToString:@"cameFromActivitySearchList"])
    {
        NSLog(@"CameFromActivitySearchListview");
        opty_id=appdelegate.OPTY_ID_For_Activity_Detail;
    
    }
    else if([appdelegate.fromManageOptyDetail isEqualToString:@"CameFromManageOptyToDetail"])
    {
        NSLog(@"CameFromManageOptyListView");
        opty_id=[[appdelegate.OppurtunityList objectAtIndex:appdelegate.Manageoptyrow] valueForKey:@"OPTY_ID"];
    
    }

    NSString * envelopeText = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
    @"<SOAP:Header xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
    @"<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"
    @"<Logger xmlns=\"http://schemas.cordys.com/General/1.0/\" />"
    @"</header>"
    @"</SOAP:Header>"
    @"<SOAP:Body>"
    @"<GetListOfActivityForOpportunitySFA xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
    @"<activitystatus>Open</activitystatus>"
    @"<optyid>%@</optyid>"
    @"</GetListOfActivityForOpportunitySFA>"
    @"</SOAP:Body>"
    @"</SOAP:Envelope>",opty_id];
    
//    NSString * envelopeText = [NSString stringWithFormat:
//                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                               @"<SOAP:Body>"
//                               @"<GetListOfActivityForOpportunity xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
//                               @"<positionid>%@</positionid>"
//                               @"<activitystatus>Open</activitystatus>"
//                               @"</GetListOfActivityForOpportunity>"
//                               @"</SOAP:Body>"
//                               @"</SOAP:Envelope>",activity_list.OPPTY_ROWID];
//    
//    NSString * envelopeText1 = [NSString stringWithFormat:
//                                @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                                @"<SOAP:Body>"
//                                @"<GetListOfActivityForNSELOBDSE xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
//                                @"<positionid>%@</positionid>"
//                                @"<activitystatus>Open</activitystatus>"
//                                @"</GetListOfActivityForNSELOBDSE>"
//                                @"</SOAP:Body>"
//                                @"</SOAP:Envelope>",activity_list.OPPTY_ROWID];
    
    
    
    NSLog(@"\n envlopeString Of user details....!!!!%@",envelopeText);
    
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    NSLog(@"URL IS %@",theurl);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"PendingActivityDetails_Connection"];
}
-(void)PendingActivityListFound:(NSNotification*)notification  // Activity Response
{
    int i = 0; //for test loop
    pendingActivities_ListArr=[[NSMutableArray alloc] init];
    pendingActivities_Customer_list=[[NSMutableArray alloc] init];
    //appdelegate.ActivityList=[[NSMutableArray alloc] init];
     appdelegate.ActivityListForSearch=[[NSMutableArray alloc] init];
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
                
                /*
                 <S_OPTY>
                 <ACTIVITY_PLAN_START_DT>28-FEB-2015 17:14:05</ACTIVITY_PLAN_START_DT>
                 <ACTIVITY_TYPE>Test Drive</ACTIVITY_TYPE>
                 <ACTIVITY_ID>1-7BN1O73</ACTIVITY_ID>
                 <ACTIVITY_STATUS>Open</ACTIVITY_STATUS>
                 <ACTIVITY_DESC>FFF</ACTIVITY_DESC>
                 <TGM_TKM_NAME xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
                 <TGM_TKM_PHONE_NUMBER xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
                 <ACCOUNT_ID xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
                 <CONTACT_NAME>ANAND KUMAR</CONTACT_NAME>
                 <CONTACT_ID>1-788U783</CONTACT_ID>
                 <CONTACT_ADDRESS>FINANCE ONE INDIA BULLS, 20TH FLR,</CONTACT_ADDRESS>
                 <CONTACT_CELL_NUMBER>2266586333</CONTACT_CELL_NUMBER>
                 <OPTY_NAME>1-788U78A</OPTY_NAME>
                 <OPTY_ID>1-788U78A</OPTY_ID>
                 <OPTY_CREATED>19-SEP-2014</OPTY_CREATED>
                 <SALES_STAGE_NAME>Closed Lost at C1A</SALES_STAGE_NAME>
                 <SALE_STAGE_UPDATED_DATE>27-JAN-2015</SALE_STAGE_UPDATED_DATE>
                 <LEAD_ASSIGNED_NAME>AJAY PARAB</LEAD_ASSIGNED_NAME>
                 <LEAD_ASSIGNED_CELL_NUMBER>9999999999</LEAD_ASSIGNED_CELL_NUMBER>
                 <LEAD_POSITION>TMCV-Sal-W-MUM-1001680-Jogeshwari-Pickup-DSE-33</LEAD_POSITION>
                 <LEAD_POSITION_ID>1-7F0Y20</LEAD_POSITION_ID>
                 <X_PROSPECT_SRC>TGM</X_PROSPECT_SRC>
                 </S_OPTY>
                 
                 */
                
                TBXMLElement *table  = [TBXML childElementNamed:@"S_OPTY" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                TBXMLElement *X_ACTIVITY_TYPE = [TBXML childElementNamed:@"ACTIVITY_TYPE" parentElement:table];
                //NSString *str_NAME = [TBXML textForElement:X_ACTIVITY_TYPE];
                activityPending_list.ACTIVITY_TYPE =[TBXML textForElement:X_ACTIVITY_TYPE];
                
                //NSLog(@"OptyNAmE : %@",str_NAME);
                
                // [Activities_ListArr addObject:str_NAME];
                
                TBXMLElement *X_OPTY_ID = [TBXML childElementNamed:@"OPTY_ID" parentElement:table];
                //NSString *str_OpTyId = [TBXML textForElement:X_OPTY_ID];
                activityPending_list.OPTY_ID =[TBXML textForElement:X_OPTY_ID];
                NSLog(@"OptyID : %@",activityPending_list.OPTY_ID);
                
                TBXMLElement *X_ACTIVITY_PLAN_START_DT = [TBXML childElementNamed:@"ACTIVITY_PLAN_START_DT" parentElement:table];
                activityPending_list.ACTIVITY_PLAN_START_DT =[TBXML textForElement:X_ACTIVITY_PLAN_START_DT];
                
                TBXMLElement *X_ACTIVITY_ID = [TBXML childElementNamed:@"ACTIVITY_ID" parentElement:table];
                activityPending_list.ACTIVITY_ID =[TBXML textForElement:X_ACTIVITY_ID];
                
                
                TBXMLElement *X_ACTIVITY_STATUS = [TBXML childElementNamed:@"ACTIVITY_STATUS" parentElement:table];
                activityPending_list.ACTIVITY_STATUS =[TBXML textForElement:X_ACTIVITY_STATUS];
                
                TBXMLElement *X_ACTIVITY_DESC = [TBXML childElementNamed:@"ACTIVITY_DESC" parentElement:table];
                activityPending_list.ACTIVITY_DESC =[TBXML textForElement:X_ACTIVITY_DESC];
                
                TBXMLElement *X_CONTACT_NAME = [TBXML childElementNamed:@"CONTACT_NAME" parentElement:table];
                activityPending_list.CONTACT_NAME =[TBXML textForElement:X_CONTACT_NAME];
                
                TBXMLElement *X_CONTACT_ID = [TBXML childElementNamed:@"CONTACT_ID" parentElement:table];
                activityPending_list.CONTACT_ID =[TBXML textForElement:X_CONTACT_ID];
                
                
                TBXMLElement *X_CONTACT_ADDRESS = [TBXML childElementNamed:@"CONTACT_ADDRESS" parentElement:table];
                activityPending_list.CONTACT_ADDRESS =[TBXML textForElement:X_CONTACT_ADDRESS];
                
                TBXMLElement *X_CONTACT_CELL_NUMBER = [TBXML childElementNamed:@"CONTACT_CELL_NUMBER" parentElement:table];
                activityPending_list.CONTACT_CELL_NUMBER =[TBXML textForElement:X_CONTACT_CELL_NUMBER];
                
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
                
                TBXMLElement *ACCOUNT_NAME = [TBXML childElementNamed:@"ACCOUNT_NAME" parentElement:table];
                activityPending_list.ACCOUNT_NAME =[TBXML textForElement:ACCOUNT_NAME];
                
                TBXMLElement *ACCOUNT_ID = [TBXML childElementNamed:@"ACCOUNT_ID" parentElement:table];
                activityPending_list.ACCOUNT_ID =[TBXML textForElement:ACCOUNT_ID];
                
                TBXMLElement *OPTY_ID = [TBXML childElementNamed:@"OPTY_ID" parentElement:table];
                activityPending_list.OPTY_ID =[TBXML textForElement:OPTY_ID];
                
                TBXMLElement *RESULT_COUNT = [TBXML childElementNamed:@"RESULT_COUNT" parentElement:table];
                activityPending_list.RESULT_COUNT =[TBXML textForElement:RESULT_COUNT];
                
                TBXMLElement *ACCOUNT_PHONE_NUMBER = [TBXML childElementNamed:@"ACCOUNT_PHONE_NUMBER" parentElement:table];
                activityPending_list.ACCOUNT_PHONE_NUMBER =[TBXML textForElement:ACCOUNT_PHONE_NUMBER];
                
                
                [pendingActivities_ListArr addObject:activityPending_list];
             //  [appdelegate.ActivityList addObject:activityPending_list];
                 [appdelegate.ActivityListForSearch addObject:activityPending_list];
            } while ((tuple = tuple->nextSibling));
            appdelegate.reloadDataArrChange=@"reloadDataArrChange";
            [self.tableview reloadData];
        }
        NSLog(@"Opty Id's 12%@",pendingActivities_ListArr);
        NSLog(@"Counter.. %lu",(unsigned long)[pendingActivities_ListArr count]);
        int counterString1=[pendingActivities_ListArr count];
        if(pendingActivities_ListArr>=0){
            optyCounter.text = [NSString stringWithFormat:@"%d", counterString1];
            [self hideAlert];
        }
    }
    
}

//- (void)getPendingActivitiesRefresh
//{
//    //    NSLog(@"%@",[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"OPTY_ID"]);
//    //     NSLog(@"%@",[[appdelegate.ActivityList objectAtIndex:appdelegate.optyrow] valueForKey:@"OPPTY_ROWID"]);
//    
//    //    NSString * envelopeText = [NSString stringWithFormat:
//    //                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//    //                               @"<SOAP:Body>"
//    //                               @"<GetListOfActivityForOpportunity xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
//    //                               @"<positionid>%@</positionid>"
//    //                               @"<activitystatus>Open</activitystatus>"
//    //                               @"</GetListOfActivityForOpportunity>"
//    //                               @"</SOAP:Body>"
//    //                               @"</SOAP:Envelope>",[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"OPTY_ID"]];
//    
//    NSString * envelopeText1 = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                                @"<SOAP:Header xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                                @"<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"
//                                @"<Logger xmlns=\"http://schemas.cordys.com/General/1.0/\" />"
//                                @"</header>"
//                                @"</SOAP:Header>"
//                                @"<SOAP:Body>"
//                                @"<GetListOfActivityForOpportunitySFA xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
//                                @"<activitystatus></activitystatus>"
//                                @"<optyid>%@</optyid>"
//                                @"</GetListOfActivityForOpportunitySFA>"
//                                @"</SOAP:Body>"
//                                @"</SOAP:Envelope>",appdelegate.opty_idDetailPage];
//    
//    NSData *envelope = [envelopeText1 dataUsingEncoding:NSUTF8StringEncoding];
//    
//    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
//    NSLog(@"URL IS %@",theurl);
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
//    NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText1 length]];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:envelope];
//    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
//    
//    [[RequestDelegate alloc]initiateRequest:request name:@"PendingActivityDetails_Connection"];
//    
//}
//-(void)PendingActivityListFoundRefresh:(NSNotification*)notification  // Activity Response
//{
//    int i = 0; //for test loop
//    pendingActivities_ListArr=[[NSMutableArray alloc] init];
//    pendingActivities_Customer_list=[[NSMutableArray alloc] init];
//    //NSArray  *array_=[[NSArray alloc] init];
//    NSError *err;
//    NSString *response=[[notification userInfo]objectForKey:@"response"];
//    
//    NSLog(@"\n PendingActivityDetails_Connection response... %@ ",response);
//    
//    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
//    
//    TBXMLElement *soapBody = [TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement];
//    TBXMLElement *container = [TBXML childElementNamed:@"GetListOfActivityForOpportunitySFAResponse" parentElement:soapBody];
//    if(container)
//    {
//        TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
//        ///  NSLog(@"Tuple..%@",tuple);
//        if (tuple)
//        {
//            do {
//                activityPending_list = nil;
//                activityPending_list = [[ActivityPendingList alloc]init];
//                
//                TBXMLElement *table  = [TBXML childElementNamed:@"S_OPTY" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
//                //                TBXMLElement *X_ACTIVITY_TYPE = [TBXML childElementNamed:@"ACTIVITY_TYPE" parentElement:table];
//                //                //NSString *str_NAME = [TBXML textForElement:X_ACTIVITY_TYPE];
//                //                activityPending_list.ACTIVITY_TYPE =[TBXML textForElement:X_ACTIVITY_TYPE];
//                
//                //NSLog(@"OptyNAmE : %@",str_NAME);
//                
//                // [Activities_ListArr addObject:str_NAME];
//                
//                TBXMLElement *X_ACTIVITY_PLAN_START_DT = [TBXML childElementNamed:@"ACTIVITY_PLAN_START_DT" parentElement:table];
//                activityPending_list.ACTIVITY_PLAN_START_DT =[TBXML textForElement:X_ACTIVITY_PLAN_START_DT];
//                
//                TBXMLElement *X_ACTIVITY_STATUS = [TBXML childElementNamed:@"ACTIVITY_STATUS" parentElement:table];
//                activityPending_list.ACTIVITY_STATUS =[TBXML textForElement:X_ACTIVITY_STATUS];
//                
//                TBXMLElement *X_ACTIVITY_DESC = [TBXML childElementNamed:@"ACTIVITY_DESC" parentElement:table];
//                activityPending_list.ACTIVITY_DESC =[TBXML textForElement:X_ACTIVITY_DESC];
//                
//                TBXMLElement *X_ACTIVITY_TYPE = [TBXML childElementNamed:@"ACTIVITY_TYPE" parentElement:table];
//                activityPending_list.ACTIVITY_TYPE =[TBXML textForElement:X_ACTIVITY_TYPE];
//                
//                TBXMLElement *X_ACTIVITY_ID = [TBXML childElementNamed:@"ACTIVITY_ID" parentElement:table];
//                activityPending_list.ACTIVITY_ID =[TBXML textForElement:X_ACTIVITY_ID];
//                
//                TBXMLElement *X_CONTACT_NAME = [TBXML childElementNamed:@"CONTACT_NAME" parentElement:table];
//                activityPending_list.CONTACT_NAME =[TBXML textForElement:X_CONTACT_NAME];
//                
//                TBXMLElement *X_CONTACT_ID = [TBXML childElementNamed:@"CONTACT_ID" parentElement:table];
//                activityPending_list.CONTACT_ID =[TBXML textForElement:X_CONTACT_ID];
//                
//                
//                TBXMLElement *X_CONTACT_ADDRESS = [TBXML childElementNamed:@"CONTACT_ADDRESS" parentElement:table];
//                activityPending_list.CONTACT_ADDRESS =[TBXML textForElement:X_CONTACT_ADDRESS];
//                
//                TBXMLElement *X_CONTACT_CELL_NUMBER = [TBXML childElementNamed:@"CONTACT_CELL_NUMBER" parentElement:table];
//                activityPending_list.CONTACT_CELL_NUMBER =[TBXML textForElement:X_CONTACT_CELL_NUMBER];
//                
//                TBXMLElement *X_OPTY_ID = [TBXML childElementNamed:@"OPTY_ID" parentElement:table];
//                //NSString *str_OpTyId = [TBXML textForElement:X_OPTY_ID];
//                activityPending_list.OPTY_ID =[TBXML textForElement:X_OPTY_ID];
//                
//                NSLog(@"OptyID : %@",activityPending_list.OPTY_ID);
//                TBXMLElement *X_OPTY_NAME = [TBXML childElementNamed:@"OPTY_NAME" parentElement:table];
//                activityPending_list.OPTY_NAME =[TBXML textForElement:X_OPTY_NAME];
//                
//                
//                TBXMLElement *X_OPTY_CREATED = [TBXML childElementNamed:@"OPTY_CREATED" parentElement:table];
//                activityPending_list.OPTY_CREATED =[TBXML textForElement:X_OPTY_CREATED];
//                
//                TBXMLElement *X_SALES_STAGE_NAME = [TBXML childElementNamed:@"SALES_STAGE_NAME" parentElement:table];
//                activityPending_list.SALES_STAGE_NAME =[TBXML textForElement:X_SALES_STAGE_NAME];
//                
//                
//                TBXMLElement *X_SALE_STAGE_UPDATED_DATE = [TBXML childElementNamed:@"SALE_STAGE_UPDATED_DATE" parentElement:table];
//                activityPending_list.SALE_STAGE_UPDATED_DATE =[TBXML textForElement:X_SALE_STAGE_UPDATED_DATE];
//                
//                
//                TBXMLElement *X_LEAD_ASSIGNED_NAME = [TBXML childElementNamed:@"LEAD_ASSIGNED_NAME" parentElement:table];
//                activityPending_list.LEAD_ASSIGNED_NAME =[TBXML textForElement:X_LEAD_ASSIGNED_NAME];
//                
//                TBXMLElement *X_LEAD_ASSIGNED_CELL_NUMBER = [TBXML childElementNamed:@"LEAD_ASSIGNED_CELL_NUMBER" parentElement:table];
//                activityPending_list.LEAD_ASSIGNED_CELL_NUMBER =[TBXML textForElement:X_LEAD_ASSIGNED_CELL_NUMBER];
//                
//                TBXMLElement *X_LEAD_POSITION = [TBXML childElementNamed:@"LEAD_POSITION" parentElement:table];
//                activityPending_list.LEAD_POSITION =[TBXML textForElement:X_LEAD_POSITION];
//                
//                
//                
//                TBXMLElement *X_LEAD_POSITION_ID = [TBXML childElementNamed:@"LEAD_POSITION_ID" parentElement:table];
//                activityPending_list.LEAD_POSITION_ID =[TBXML textForElement:X_LEAD_POSITION_ID];
//                
//                TBXMLElement *X_PROSPECT_SRC = [TBXML childElementNamed:@"X_PROSPECT_SRC" parentElement:table];
//                activityPending_list.X_PROSPECT_SRC =[TBXML textForElement:X_PROSPECT_SRC];
//                
//                TBXMLElement *X_RESULT_COUNT = [TBXML childElementNamed:@"RESULT_COUNT" parentElement:table];
//                activityPending_list.RESULT_COUNT =[TBXML textForElement:X_RESULT_COUNT];
//                //
//                //
//                [pendingActivities_ListArr addObject:activityPending_list];
//            } while ((tuple = tuple->nextSibling));
//             [self.tableview reloadData];
//        }
//        
//        
//        NSLog(@"Opty Id's 12%@",pendingActivities_ListArr);
//        NSLog(@"Counter.. %lu",(unsigned long)[pendingActivities_ListArr count]);
//        int counterString1=[pendingActivities_ListArr count];
//        if(pendingActivities_ListArr>=0)
//        {
////            ActivityDetailsViewController* activityDetailViewController_VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ActivityDetailsViewController"];
////            [self.navigationController pushViewController:activityDetailViewController_VC animated:YES];
////            //     optyCounter.text = [NSString stringWithFormat:@"%d", counterString1];
////            [self hideAlert];
////            
//            
//        }
//        else
//        {
//            alert = [[UIAlertView alloc] initWithTitle:@"ALERT"
//                                               message:@"There are no pending Activities"
//                                              delegate:self
//                                     cancelButtonTitle:@"OK"
//                                     otherButtonTitles:nil];
//            [alert show];
//            
//            
//        }
//    }
//    
//}


- (void)getPendingActivities
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
    NSLog(@"log opty id:%@",appdelegate.opty_idDetailPage);
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
        
        [[RequestDelegate alloc]initiateRequest:request name:@"getPendingActivityDetails_Connection"];
    
    
}
-(void)getPendingActivityListFound:(NSNotification*)notification  // Activity Response
{
    int i = 0; //for test loop
    pendingActivities_ListArr=[[NSMutableArray alloc] init];
    pendingActivities_Customer_list=[[NSMutableArray alloc] init];
     appdelegate.ActivityListForSearch=[[NSMutableArray alloc] init];
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
                [appdelegate.ActivityListForSearch  addObject:activityPending_list];
            } while ((tuple = tuple->nextSibling));
            // [self._tableView reloadData];
        }
        
        
        NSLog(@"Opty Id's 12%@",pendingActivities_ListArr);
        NSLog(@"Counter.. %lu",(unsigned long)[pendingActivities_ListArr count]);
        int counterString1=[pendingActivities_ListArr count];
        if(pendingActivities_ListArr>=0)
        {
//            ActivityDetailsViewController* activityDetailViewController_VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ActivityDetailsViewController"];
//            [self.navigationController pushViewController:activityDetailViewController_VC animated:YES];
//            //     optyCounter.text = [NSString stringWithFormat:@"%d", counterString1];
//            [self hideAlert];
            appdelegate.reloadDataArrChange=@"reloadDataArrChange";
             [self.tableview reloadData];
            
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

-(void)showAlert
{
    [MBProgressHUD showHUDAddedLoading:self.view animated:YES];
}
-(void)hideAlert
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}

-(void)hideAlertSuperview
{
    [MBProgressHUD hideHUDForView:self.view.superview animated:YES];
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */




@end
