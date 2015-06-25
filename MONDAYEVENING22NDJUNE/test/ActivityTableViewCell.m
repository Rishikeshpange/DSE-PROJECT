//
//  ActivityTableViewCell.m
//  NEEV
//
//  Created by Sachin Sharma on 02/04/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import "ActivityTableViewCell.h"
#import "RequestDelegate.h"
#import "ActivityPendingList.h"
#import "TBXML.h"
#import "MBProgressHUD.h"

@implementation ActivityTableViewCell

- (void)awakeFromNib {
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DoneActivity_Found:) name:@"Activity_Done_Found" object:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)viewWillAppear:(BOOL)animated
{

    
    NSLog(@"..... will ");
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DoneActivity_Found:) name:@"Activity_Done_Found" object:nil];//Gautam //for search activites after pressing search button
//    //OpportunitiesDashBoard_Found
//    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SearchActivitiesMonth_Connection1:) name:@"Update_Activity_Found" object:nil];//Gautam //for search activites after pressing search button
    
  }

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (IBAction)DoneButtonClicked:(id)sender
{
    
    //[self showAlert]; //Abhishek //Test Later
    
    UITableView *tableView = (UITableView *)self.superview.superview;
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:tableView];
    NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:buttonPosition];
    NSLog(@"%ld",(long)indexPath.row);
   

     appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    
    self.ACTIVITY_TYPE=[[pendingActivities_ListArr objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_TYPE"];
    appdelegate.ACTIVITY_TYPE=[[pendingActivities_ListArr objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_TYPE"];
    self.ACTIVITY_ID=[[pendingActivities_ListArr objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_ID"];
    appdelegate.ACTIVITY_ID=[[pendingActivities_ListArr objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_ID"];
    NSLog(@"%@,%@",appdelegate.ACTIVITY_ID,appdelegate.ACTIVITY_TYPE);
    NSLog(@"pending activities from manage opty to detail :%lu",(unsigned long)[pendingActivities_ListArr count]);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy hh:mm:ss"];
    NSString *stringFromDate = [formatter stringFromDate:[NSDate date]];
    NSLog(@"stringFromDate : : %@",stringFromDate);
     appdelegate.toandfromdate=stringFromDate;
    
//    NSString * envelopeText1 =[NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                               @"<SOAP:Body>"
//                               @"<SFATMCVInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
//                               @"<ListOfTmActionInterface xmlns=\"http://www.siebel.com/xml/TMActionInterface/\">"
//                               @"<Action>"
//                               @"<Status>Done</Status>"
//                               @"<PlannedStart>%@</PlannedStart>"
//                               @"<PlannedCompletion>%@</PlannedCompletion>"
//                               @"<ActivityId>%@</ActivityId>"
//                               @"</Action>"
//                               @"</ListOfTmActionInterface>"
//                               @"</SFATMCVInsertOrUpdate_Input>"
//                               @"</SOAP:Body>"
//                               @"</SOAP:Envelope>",stringFromDate,stringFromDate,[[pendingActivities_ListArr objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_ID"]];
    
    NSString * envelopeText1 =[NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<SFATMCVInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                               @"<ListOfTmActionInterface xmlns=\"http://www.siebel.com/xml/TMActionInterface/\">"
                               @"<Action>"
                               @"<PlannedStart>%@</PlannedStart>"
                               @"<PlannedCompletion>%@</PlannedCompletion>"
                               @"<ActivityId>%@</ActivityId>"
                               @"</Action>"
                               @"</ListOfTmActionInterface>"
                               @"</SFATMCVInsertOrUpdate_Input>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",stringFromDate,stringFromDate,[[pendingActivities_ListArr objectAtIndex:indexPath.row] valueForKey:@"ACTIVITY_ID"]];

    
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
    
    [[RequestDelegate alloc]initiateRequest:request name:@"Done_Activity"];

}
-(void)DoneActivity_Found:(NSNotification*)notification
{
//    NSError *err;
//    NSString *response=[[notification userInfo]objectForKey:@"response"];
//    NSLog(@"\n DoneFound response... %@ ",response);
//    
//    
//    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
//    
//    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
//    {
//        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Fault String" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alertView show];
//    }
//
// else
// {
//    TBXMLElement *container = [TBXML childElementNamed:@"ns:SFATMCVInsertOrUpdate_Output" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
////
////    
//    TBXMLElement *ListOfTmActionInterface =[TBXML childElementNamed:@"ListOfTmActionInterface" parentElement:container];
//     TBXMLElement *Action =[TBXML childElementNamed:@"Action" parentElement:ListOfTmActionInterface];
//    
//    if (Action) {
//        
//        TBXMLElement *ActivityId =[TBXML childElementNamed:@"ActivityId" parentElement:Action];
//        TBXMLElement *IntegrationId =[TBXML childElementNamed:@"IntegrationId" parentElement:Action];
//        TBXMLElement *Id =[TBXML childElementNamed:@"Id" parentElement:Action];
//        
//        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Done" message:@"Activity Marked as Done" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alertView show];
//        
//        if ([self.ACTIVITY_TYPE isEqualToString:@"Papers Submitted"])
//        {
//             NSString * envelopeText1 =[NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//            @"<SOAP:Body>"
//            @"<SFATMCVOPTYInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
//            @"<ListOfTMOpportunityInterface xmlns=\"http://www.siebel.com/xml/TM%%20Opportunity%%20Interface\">"
//            @"<Opportunity>"
//            @"<Id>%@</Id>"
//            @"<SalesStage>C1A (Papers Submitted)</SalesStage>"
//            @"</Opportunity>"
//            @"</ListOfTMOpportunityInterface>"
//            @"</SFATMCVOPTYInsertOrUpdate_Input>"
//            @"</SOAP:Body>"
//            @"</SOAP:Envelope>",self.ACTIVITY_ID];
//            
//            NSData *envelope = [envelopeText1 dataUsingEncoding:NSUTF8StringEncoding];
//            
//            NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
//            // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
//            NSLog(@"URL IS %@",theurl);
//            // NSLog(@"REQUEST IS %@",envelopeText);
//            
//            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
//            
//            NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText1 length]];
//            
//            [request setHTTPMethod:@"POST"];
//            [request setHTTPBody:envelope];
//            [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//            [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
//            
//            [[RequestDelegate alloc]initiateRequest:request name:@"After_Done_Activity"];
//        }
//        
//        
//        
//    }
//    
//    else
//    {
//        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Activity error response" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alertView show];
//    }

}

- (IBAction)UpdateButtonClicked:(id)sender
{
    UITableView *tableView = (UITableView *)self.superview.superview;
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:tableView];
    NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:buttonPosition];
    NSLog(@"%ld",(long)indexPath.row);

    activityPending_list = [pendingActivities_ListArr objectAtIndex:indexPath.row ];
    
  
}

//Abhishek

-(void)showAlert
{
    [MBProgressHUD showHUDAddedLoading:self.superview animated:YES];
    
}
-(void)hideAlert
{
    [MBProgressHUD hideHUDForView:self.superview animated:YES];
    
}

@end
