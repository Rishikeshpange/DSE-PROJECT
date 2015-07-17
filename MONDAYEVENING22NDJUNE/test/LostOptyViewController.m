//
//  LostOptyViewController.m
//  NEEV
//
//  Created by admin on 28/03/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import "LostOptyViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "RequestDelegate.h"
#import "TBXML.h"
#import "MBProgressHUD.h"

@interface LostOptyViewController ()
{
    UIAlertView *alert;
    UILabel *lbl;
}
@end

@implementation LostOptyViewController
@synthesize MakeLostSalesStageArr;
@synthesize txtDescription;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Navigationbar Buttons
      self.appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];//AppDelegate instance
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
    
    
    lbl = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0,txtDescription.frame.size.width - 10.0, 34.0)];
    
    
    [lbl setText:@"Descrption"];
    [lbl setFont:[UIFont systemFontOfSize:15]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextColor:[UIColor lightGrayColor]];
    txtDescription.delegate = self;
    
    [txtDescription addSubview:lbl];
       
//    self.NameLabel.text=[[self.appdelegate.OppurtunityList objectAtIndex:self.appdelegate.optyrow] valueForKey:@"CUSTOMER_ACCOUNT_NAME"];
//    self.phoneNmuberLabel.text=[[self.appdelegate.OppurtunityList objectAtIndex:self.appdelegate.optyrow] valueForKey:@"CUSTOMER_PHONE_NUMBER"];
    
    self.NameLabel.text=self.appdelegate.CUSTOMER_ACCOUNT_NAME;
    self.phoneNmuberLabel.text=self.appdelegate.CUSTOMER_PHONE_NUMBER;
    MakeLostSalesStageArr=[[NSMutableArray alloc] initWithObjects:@"Closed Lost at C0",@"Closed Lost at C1",@"Closed Lost at C1A",@"Closed Lost at C2",@"Closed Lost at C3", nil];

    
    
    //Make View Rounded
    self.viewFirst.layer.cornerRadius=3;
     self.viewFirst.layer.borderColor=[UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
     self.viewFirst.layer.borderWidth=2.0f;
    self.viewFirst.layer.masksToBounds=YES;

    
    // Make Button Corner Rounded
    self.btnSave.layer.cornerRadius=4;
    self.btnCancel.layer.cornerRadius=4;
    self.btnSave.layer.masksToBounds=YES;
    self.btnCancel.layer.masksToBounds=YES;
    
    // Radious for text Fileds .
    self.txtReason.layer.borderWidth=2.0f;
    self.txtMakeLost.layer.borderWidth=2.0f;
    self.txtModeLost.layer.borderWidth=2.0f;
    self.txtDescription.layer.borderWidth=2.0f;

    self.txtReason.layer.borderColor=[UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
    self.txtMakeLost.layer.borderColor=[UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
    
    self.txtModeLost.layer.borderColor=[UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
    self.txtDescription.layer.borderColor=[UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
    
    self.originalCenter = self.view.center;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    self.txtReason.delegate = self;//Abhishek
    self.txtMakeLost.delegate = self;//Abhishek
    self.txtModeLost.delegate = self;//Abhishek
    
    //Abhishek
    _btnSave.enabled = YES;
    _btnSave.backgroundColor = [UIColor colorWithRed:(115/255.0)green:(182/255.0) blue:(68/255.0) alpha:1];
    
    [self ReasonLostTo];
    [self MakeLostTo];
   // [self ModelLostTo];

}

-(void)viewWillAppear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Reason_Lost_Found:) name:@"Reason_Lost_Found" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Make_Lost_To_Found:) name:@"Make_Lost_Found" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Model_Lost_Found:) name:@"Model_Lost_Found" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Lost_Opty_Found:) name:@"Lost_Opty_Found" object:nil];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"Reason_Lost_Found" object:nil];
     [[NSNotificationCenter defaultCenter]removeObserver:self name:@"Make_Lost_Found" object:nil];
     [[NSNotificationCenter defaultCenter]removeObserver:self name:@"Model_Lost_Found" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"Lost_Opty_Found" object:nil];
    
    
}

- (void)keyboardDidShow:(NSNotification *)note
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    [UIView setAnimationCurve:[note.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    self.view.center = CGPointMake(self.view.center.x, 100.0);
    [UIView commitAnimations];
}

- (void)keyboardDidHide:(NSNotification *)note
{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    [UIView setAnimationCurve:[note.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.view.center =  CGPointMake(self.view.center.x, self.originalCenter.y);
    [UIView commitAnimations];
    
}


//Abhishek

//Text Field Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField // Abhishek
{
    NSLog(@"\n Testing.....");
    
    if (textField == self.txtReason)
    {
        NSLog(@"\n Testing.....");
        [textField resignFirstResponder];
        return NO;
    }
    
    if (textField == self.txtMakeLost)
    {
        NSLog(@"\n Testing.....");
        [textField resignFirstResponder];
        return NO;
    }
    
    if (textField == self.txtModeLost)
    {
        NSLog(@"\n Testing.....");
        [textField resignFirstResponder];
        return NO;
    }
    
    return YES;
}


//abhishek

- (IBAction)LostOptyRequest:(id)sender
{
    //Abhishek
    if ([self.txtReason.text isEqualToString:@""]   ||
        [self.txtMakeLost.text isEqualToString:@""] ||
        [self.txtModeLost.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"Please Select Values" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    else
    {
        //Abhishek
        
        [self showAlert];//Abhishek
    _btnSave.enabled = NO; //abhishek
    _btnSave.backgroundColor = [UIColor colorWithRed:(101/255.0)green:(104/255.0) blue:(27/255.0) alpha:1]; //abhishek
    
    [self.txtDescription resignFirstResponder];
    NSString *opty_id=[[NSString alloc]init];
      NSString *sales_stages_name=[[NSString alloc]init];
    if ([self.appdelegate.fromOPTYDetail isEqualToString:@"CameFromOptyDetail"])
    {
        opty_id=  [[self.appdelegate.OppurtunityList objectAtIndex:self.appdelegate.optyrow] valueForKey:@"OPTY_ID"];
        opty_id=self.appdelegate.opty_idDetailPage;
        sales_stages_name=  [[self.appdelegate.OppurtunityList objectAtIndex:self.appdelegate.optyrow] valueForKey:@"SALE_STAGE_NAME"];
        sales_stages_name=self.appdelegate.SALE_STAGE_NAME;
        
        NSLog(@"CameFromOptyDetail");
    }
      else if([self.appdelegate.fromManageOptyDetail isEqualToString:@"CameFromManageOptyToDetail"])
    {
        NSLog(@"CameFromManageOptyListView");
        opty_id=[[self.appdelegate.OppurtunityList objectAtIndex:self.appdelegate.Manageoptyrow] valueForKey:@"OPTY_ID"];
        sales_stages_name=[[self.appdelegate.OppurtunityList objectAtIndex:self.appdelegate.Manageoptyrow] valueForKey:@"SALE_STAGE_NAME"];
        opty_id=self.appdelegate.opty_idDetailPage;
        sales_stages_name=self.appdelegate.SALE_STAGE_NAME;
        
    }
    
    if ([sales_stages_name containsString:@"C0"])
    {
        NSLog(@"C0");
        sales_stages_name=[MakeLostSalesStageArr objectAtIndex:0];
        NSLog(@"Sales Stages After :%@",sales_stages_name);
        
    }else if([sales_stages_name containsString:@"C1"])
    {
        NSLog(@"C1");
        sales_stages_name=[MakeLostSalesStageArr objectAtIndex:1];
        NSLog(@"Sales Stages  After :%@",sales_stages_name);
    }else if([sales_stages_name containsString:@"C1A"])
    {
        NSLog(@"C1A");
        sales_stages_name=[MakeLostSalesStageArr objectAtIndex:2];
        NSLog(@"Sales Stages  After :%@",sales_stages_name);
    }else if([sales_stages_name containsString:@"C2"])
    {
        NSLog(@"C2");
        sales_stages_name=[MakeLostSalesStageArr objectAtIndex:3];
        NSLog(@"Sales Stages  After :%@",sales_stages_name);
    }else if([sales_stages_name containsString:@"C3"])
    {
        NSLog(@"C2");
        sales_stages_name=[MakeLostSalesStageArr objectAtIndex:4];
        NSLog(@"Sales Stages  After :%@",sales_stages_name);
    }
    else
    {
        NSLog(@"Wrong");
    }

//
//     NSString * envelopeText = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\"><SOAP:Body>"
//    @"<SFATMCVOPTYInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\"><ListOfTMOpportunityInterface xmlns=\"http://www.siebel.com/xml/TM%%20Opportunity%%20Interface\">"
//    @"<Opportunity>"
//    @"<Id>%@</Id>"
//    @"<ClosureSummary>%@</ClosureSummary>"
//    @"<IntegrationId>%ld</IntegrationId>"
//    @"<Make>%@</Make>"
//    @"<Model>%@</Model>"
//    @"<ReasonWonLost>%@</ReasonWonLost>"
//    @"<SalesStage>%@</SalesStage>"
//    @"</Opportunity>"
//    @"</ListOfTMOpportunityInterface>"
//    @"</SFATMCVOPTYInsertOrUpdate_Input>"
//    @"</SOAP:Body>"
//    @"</SOAP:Envelope>",[[self.appdelegate.OppurtunityList objectAtIndex:self.appdelegate.optyrow] valueForKey:@"OPTY_ID"],self.txtDescription.text,(long)[[NSDate date]timeIntervalSince1970],self.txtMakeLost.text,self.txtModeLost.text,self.txtReason.text,[[self.appdelegate.OppurtunityList objectAtIndex:self.appdelegate.optyrow] valueForKey:@"SALE_STAGE_NAME"]];
    
    NSString * envelopeText = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\"><SOAP:Body>"
                               @"<SFATMCVOPTYInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\"><ListOfTMOpportunityInterface xmlns=\"http://www.siebel.com/xml/TM%%20Opportunity%%20Interface\">"
                               @"<Opportunity>"
                               @"<Id>%@</Id>"
                               @"<ClosureSummary>%@</ClosureSummary>"
                               @"<IntegrationId>%ld</IntegrationId>"
                               @"<Make>%@</Make>"
                               @"<Model>%@</Model>"
                               @"<ReasonWonLost>%@</ReasonWonLost>"
                               @"<SalesStage>%@</SalesStage>"
                               @"</Opportunity>"
                               @"</ListOfTMOpportunityInterface>"
                               @"</SFATMCVOPTYInsertOrUpdate_Input>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",opty_id,self.txtDescription.text,(long)[[NSDate date]timeIntervalSince1970],self.txtMakeLost.text,self.txtModeLost.text,self.txtReason.text,sales_stages_name];
    
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",self.appdelegate.URL,self.appdelegate.artifact]];
    NSLog(@"URL IS %@",theurl);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"Lost_Opty_Connection"];
        
    }


}



-(void)ReasonLostTo
{
     NSString * envelopeText = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
    @"<SOAP:Body>"
    @"<GetTMCVReasonLostType xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\" />"
    @"</SOAP:Body>"
    @"</SOAP:Envelope>"];
    
    
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",self.appdelegate.URL,self.appdelegate.artifact]];
    NSLog(@"URL IS %@",theurl);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"Reason_Lost_Connection"];


}

-(void)Reason_Lost_Found:(NSNotification*)notification
{
    int i = 0; //for test loop
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    self.ReasonLostArray=[[NSMutableArray alloc]init];
    NSLog(@"\n opportuntyCount response..... %@ ",response);
    if ([response isEqual:@""])
    {
       // [self hideAlert];
       
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Nothing in Response !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
       // [self hideAlert];
      
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Network Fault String!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    else
    {
        
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement *container = [TBXML childElementNamed:@"GetTMCVReasonLostTypeResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        if (self.ReasonLostArray)
        {
            [ self.ReasonLostArray removeAllObjects];
        }
        TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple)
        {
            do {
                
                
                TBXMLElement *S_Lst_Of_Val  = [TBXML childElementNamed:@"S_Lst_Of_Val" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                
                TBXMLElement *NAME = [TBXML childElementNamed:@"NAME" parentElement:S_Lst_Of_Val];
                
                NSString *nameString=[TBXML textForElement:NAME];
                [self.ReasonLostArray addObject:nameString];
                NSLog(@"%@", [TBXML textForElement:NAME]);
                
             
                
            } while ((tuple = tuple->nextSibling));
            NSLog(@"\nOpportunityListDisplayArr......%d",[self.ReasonLostArray count]);
//            //[appdelegate hideAlert];
            
           
            
            
        }
        else
        {
           
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Server Error!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}


-(void)MakeLostTo
{
    NSString * envelopeText = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
    @"<SOAP:Header xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
    @"<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"
    @"<Logger xmlns=\"http://schemas.cordys.com/General/1.0/\">"
    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/testtool/testtool.caf</DC>"
    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/methodsetsmanager/methodsetexplorer.caf</DC>"
    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/sysresourcemgr/sysresourcemgr.caf</DC>"
    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/com/cordys/cusp/cusp.caf</DC>"
    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"hopCount\">0</DC>"
    @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"correlationID\">00215ef7-d846-11e4-e7ab-229211ac173b</DC>"
    @"</Logger>"
    @"</header>"
    @"</SOAP:Header>"
    @"<SOAP:Body>"
    @"<GetTMCVMakeLostTypeNeev xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\" />"
    @"</SOAP:Body>"
    @"</SOAP:Envelope>"];
    
    
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",self.appdelegate.URL,self.appdelegate.artifact]];
    NSLog(@"URL IS %@",theurl);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"Make_Lost_Connection"];
    
    
}

-(void)Make_Lost_To_Found:(NSNotification*)notification
{
    int i = 0; //for test loop
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    self.MakeLostArray=[[NSMutableArray alloc]init];
    NSLog(@"\n Make LOst response..... %@ ",response);
    if ([response isEqual:@""])
    {
        // [self hideAlert];
        
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Nothing in Response !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        // [self hideAlert];
        
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Network Fault String!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    else
    {
        
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement *container = [TBXML childElementNamed:@"GetTMCVMakeLostTypeNeevResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        if (self.MakeLostArray)
        {
            [ self.MakeLostArray removeAllObjects];
        }
        TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple)
        {
            do {
                
                
                TBXMLElement *S_Lst_Of_Val  = [TBXML childElementNamed:@"S_Lst_Of_Val" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                
                TBXMLElement *NAME = [TBXML childElementNamed:@"NAME" parentElement:S_Lst_Of_Val];
                
                NSString *nameString=[TBXML textForElement:NAME];
                [self.MakeLostArray addObject:nameString];
                NSLog(@"%@", [TBXML textForElement:NAME]);
                
                
                
            } while ((tuple = tuple->nextSibling));
            NSLog(@"\nOpportunityListDisplayArr......%d",[self.MakeLostArray count]);
            //            //[appdelegate hideAlert];
            
            
            
            
        }
        else
        {
            
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Server Error!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

- (IBAction)btnCanelClicked:(id)sender
{
    self.txtReason.text=nil;
    self.txtMakeLost.text=nil;
    self.txtModeLost.text=nil;
    self.txtDescription.text=nil;
    [self.txtDescription resignFirstResponder];
     [self.navigationController popViewControllerAnimated:YES];
}


-(void)ModelLostTo
{
    NSString * envelopeText = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
    @"  <SOAP:Body>"
    @"    <GetTMCVModelLostType xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
    @"<maketype>%@</maketype>"
    @"</GetTMCVModelLostType>"
    @"</SOAP:Body>"
    @"</SOAP:Envelope>",self.txtModeLost.text];
    
    
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",self.appdelegate.URL,self.appdelegate.artifact]];
    NSLog(@"URL IS %@",theurl);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"Model_Lost_Connection"];
    
    
}

-(void)Model_Lost_Found:(NSNotification*)notification
{
    int i = 0; //for test loop
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    self.ModeLostArray=[[NSMutableArray alloc]init];
    NSLog(@"\n opportuntyCount response..... %@ ",response);
    if ([response isEqual:@""])
    {
        // [self hideAlert];
        
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Nothing in Response !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        // [self hideAlert];
        
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Network Fault String!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    else
    {
        
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement *container = [TBXML childElementNamed:@"GetTMCVModelLostTypeResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        if (self.ModeLostArray)
        {
            [ self.ModeLostArray removeAllObjects];
        }
        TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple)
        {
            do {
                
                
                TBXMLElement *S_Lst_Of_Val  = [TBXML childElementNamed:@"S_Lst_Of_Val" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                
                TBXMLElement *NAME = [TBXML childElementNamed:@"NAME" parentElement:S_Lst_Of_Val];
                
                NSString *nameString=[TBXML textForElement:NAME];
                [self.ModeLostArray addObject:nameString];
                NSLog(@"%@", [TBXML textForElement:NAME]);
                
                
                
            } while ((tuple = tuple->nextSibling));
            NSLog(@"\nmodelLostDisplayArr......%d",[self.ModeLostArray count]);
            //            //[appdelegate hideAlert];
            
            
            
            
        }
        else
        {
            
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Server Error!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
            NSLog(@"Activity...Data %@",self.ModeLostArray);
            self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                      delegate:self
                                             cancelButtonTitle:nil
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:nil];
            // ObjC Fast Enumeration
            for (NSString *title in self.ModeLostArray) {
                [self.actionSheet addButtonWithTitle:title];
            }
            self.actionSheet.cancelButtonIndex = [self.actionSheet addButtonWithTitle:@"Cancel"];
            self.actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
        
        
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
                [self.actionSheet showFromRect:self.txtModeLost.frame inView:self.txtReason animated:YES];
                self.actionSheet.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
            }
            else{
                [self.actionSheet showInView:self.view];
            }
            self.actionSheet.tag = 3;
        

    }
}
-(void)Lost_Opty_Found:(NSNotification*)notification
{
    
    [self hideAlert];//Abhishek
    int i = 0; //for test loop
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    self.ModeLostArray=[[NSMutableArray alloc]init];
    NSLog(@"\n opportuntyCount response..... %@ ",response);
    
    if ([response isEqual:@""])
    {
        // [self hideAlert];
        
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Nothing in Response !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        // [self hideAlert];
        
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Network Fault String!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    else
    {
        
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement *container = [TBXML childElementNamed:@"ns:SFATMCVOPTYInsertOrUpdate_Output" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        if (self.ModeLostArray)
        {
            [ self.ModeLostArray removeAllObjects];
        }
        TBXMLElement *ListOfTMOpportunityInterface =[TBXML childElementNamed:@"ListOfTMOpportunityInterface" parentElement:container];
          TBXMLElement *Opportunity =[TBXML childElementNamed:@"Opportunity"parentElement:ListOfTMOpportunityInterface];
        if (Opportunity)
        {
            do {
                
                
                TBXMLElement *Opportunity_Id  = [TBXML childElementNamed:@"Id" parentElement:Opportunity];
                
                TBXMLElement *IntegrationId = [TBXML childElementNamed:@"IntegrationId" parentElement:Opportunity];
                
                NSString *nameString=[TBXML textForElement:Opportunity_Id];
                NSString *nameString_IntegrationId=[TBXML textForElement:IntegrationId];
                
                if (nameString_IntegrationId)
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Done" message:@"Your Oppurtunity has been marked as Lost" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    alert.tag=50;
                    [alert show];
                }
                else
                {
                
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Your Oppurtunity has not been marked as Lost" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    
                    
                }
                  NSLog(@"%@", nameString);
                  NSLog(@"%@", nameString_IntegrationId);
                
                
                
            } while ((Opportunity = Opportunity->nextSibling));
            NSLog(@"\nmodelLostDisplayArr......%d",[self.ModeLostArray count]);
            //            //[appdelegate hideAlert];
           
            
            
            
        }
        else
        {
            
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Server Error!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

- (IBAction)btnModelLost:(id)sender {
    
    NSString * envelopeText = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"  <SOAP:Body>"
                               @"    <GetTMCVModelLostType xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                               @"<maketype>%@</maketype>"
                               @"</GetTMCVModelLostType>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",self.txtMakeLost.text];
    
    
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",self.appdelegate.URL,self.appdelegate.artifact]];
    NSLog(@"URL IS %@",theurl);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"Model_Lost_Connection"];
    

    
//    NSLog(@"Activity...Data %@",self.ModeLostArray);
//    self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Model Lost Type"
//                                              delegate:self
//                                     cancelButtonTitle:nil
//                                destructiveButtonTitle:nil
//                                     otherButtonTitles:nil];
//    // ObjC Fast Enumeration
//    for (NSString *title in self.ModeLostArray) {
//        [self.actionSheet addButtonWithTitle:title];
//    }
//    self.actionSheet.cancelButtonIndex = [self.actionSheet addButtonWithTitle:@"Cancel"];
//    self.actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
//    
//    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        
//        [self.actionSheet showFromRect:[(UITextField *)sender frame] inView:self.txtReason animated:YES];
//        self.actionSheet.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
//    }
//    else{
//        [self.actionSheet showInView:self.view];
//    }
//    self.actionSheet.tag = 3;
    
    
}
- (IBAction)btnReasonLost:(id)sender {
    
    NSLog(@"Activity...Data %@",self.ReasonLostArray);
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:self
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    // ObjC Fast Enumeration
    for (NSString *title in self.ReasonLostArray) {
        [self.actionSheet addButtonWithTitle:title];
    }
    self.actionSheet.cancelButtonIndex = [self.actionSheet addButtonWithTitle:@"Cancel"];
    self.actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        [self.actionSheet showFromRect:[(UITextField *)sender frame] inView:self.txtReason animated:YES];
        self.actionSheet.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
    }
    else{
        [self.actionSheet showInView:self.view];
    }
    self.actionSheet.tag = 1;
    
    
}
- (IBAction)btnMakeLost:(id)sender {
    
    NSLog(@"Activity...Data %@",self.MakeLostArray);
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:self
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    // ObjC Fast Enumeration
    for (NSString *title in self.MakeLostArray) {
        [self.actionSheet addButtonWithTitle:title];
    }
    self.actionSheet.cancelButtonIndex = [self.actionSheet addButtonWithTitle:@"Cancel"];
    self.actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        [self.actionSheet showFromRect:[(UITextField *)sender frame] inView:self.txtMakeLost animated:YES];
        self.actionSheet.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
    }
    else{
        [self.actionSheet showInView:self.view];
    }
    self.actionSheet.tag = 2;
    
    
}
- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (popup.tag ==1)
    {
         NSLog(@"button click ....%@",[self.ReasonLostArray objectAtIndex:buttonIndex]);
        self.txtReason.text=[self.ReasonLostArray objectAtIndex:buttonIndex];
    }
    else if (popup.tag==2)
    {
      NSLog(@"button click ....%@",[self.MakeLostArray objectAtIndex:buttonIndex]);
         self.txtMakeLost.text=[self.MakeLostArray objectAtIndex:buttonIndex];
    
    }
    else if (popup.tag==3)
    {
        NSLog(@"button click ....%@",[self.ModeLostArray objectAtIndex:buttonIndex]);
        self.txtModeLost.text=[self.ModeLostArray objectAtIndex:buttonIndex];
    }
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





// delegate mehod for uialertView



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
    [self performSegueWithIdentifier:@"infoView" sender:self];
}
-(void)logOut_btn
{
    alert = [[UIAlertView alloc] initWithTitle:@"DSE"
                                       message:@"Do you want to Log out"
                                      delegate:self
                             cancelButtonTitle:@"No"
                             otherButtonTitles:@"Yes",nil];
    alert.tag=30;
    [alert show];
    
    
    NSLog(@"Home biscuit from Sanfrancisco");
}
// delegate mehod for uialertView

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button Index =%ld",(long)buttonIndex);
    if (alertView.tag==30)
    {
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
    else if (alertView.tag==50)
    {
        if (buttonIndex == 0)
        {
            NSLog(@"David Miller");
            [self.navigationController popViewControllerAnimated:YES];
        }
        if (buttonIndex==1)
        {
            
             [self.navigationController popViewControllerAnimated:YES];
//            NSLog(@"Glen Maxwell");
//            LoginViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
//            //[self.navigationController pushViewController:secondViewController animated:YES];
//            [self presentViewController:secondViewController animated:YES completion:nil ];
//            //  [self.navigationController popToRootViewControllerAnimated:TRUE];
//            // [self dismissViewControllerAnimated:YES completion:nil];
//            //  [self.parentViewController.navigationController popToRootViewControllerAnimated:YES];
//            //  [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        }
    
    }
}

-(void)textViewDidBeginEditing:(UITextView *)sender
{
    if ([sender isEqual:txtDescription])
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.1];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationBeginsFromCurrentState:YES];
        
        self.view.center = CGPointMake(self.view.center.x, 50.0);
        [UIView commitAnimations];    }
    
    
}




- (void)textViewDidEndEditing:(UITextView *)theTextView
{
    if (![txtDescription hasText]) {
        lbl.hidden = NO;
    }
}

- (void) textViewDidChange:(UITextView *)textView
{
    if(![txtDescription hasText]) {
        lbl.hidden = NO;
    }
    else{
        lbl.hidden = YES;
    }
}


//Abhishek

-(void)showAlert
{
    [MBProgressHUD showHUDAddedLoading:self.view animated:YES];
    
}
-(void)hideAlert
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}



@end
