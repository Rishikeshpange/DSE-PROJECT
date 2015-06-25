//
//  CreateActivityViewController.m
//  NEEV
//
//  Created by admin on 20/03/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import "CreateActivityViewController.h"
#import "LoginViewController.h"
#import "TBXML.h"
#import "MBProgressHUD.h"
#import "RequestDelegate.h"
#import "Opportunity_List.h"
@interface CreateActivityViewController ()
{
    UIAlertView *alert;
}
@end

@implementation CreateActivityViewController
@synthesize activityType_PickerArr,activityCreate_Arr;
@synthesize txtActivityType,txtActivityDate,txtActivityTime,descTxt;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];//AppDelegate instance
    userDetailsVal_ = [UserDetails_Var sharedmanager]; // usedetails instance
    activityType_PickerArr=[[NSMutableArray alloc] init];
    
     createcontactresult = [CreateContactResult sharedmanager];
    activityCreate_Arr=[[NSMutableArray alloc] init];
    // Make Button Corner Rounded
    self.btnSave.layer.cornerRadius=3;
    self.btnSave.layer.masksToBounds=YES;

    self.btnCancel.layer.cornerRadius=3;
    self.btnCancel.layer.masksToBounds=YES;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header_strip1.png"] forBarMetrics:UIBarMetricsDefault];
    [self.viewType.layer setCornerRadius:2.0];
    self.viewType.layer.borderColor = [UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
    self.viewType.layer.borderWidth = 2;
    
    [self.descTxt.layer setCornerRadius:1.0];
    self.descTxt.layer.borderColor = [UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
    self.descTxt.layer.borderWidth = 2;
  // self.descTxt.delegate=self;
    
    [self.txtActivityType.layer setCornerRadius:1.0];
    self.txtActivityType.layer.borderColor = [UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
    self.txtActivityType.layer.borderWidth = 2;
    
    [self.txtActivityDate.layer setCornerRadius:1.0];
    self.txtActivityDate.layer.borderColor = [UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
    self.txtActivityDate.layer.borderWidth = 2;
    
    [self.txtActivityTime.layer setCornerRadius:1.0];
    self.txtActivityTime.layer.borderColor = [UIColor colorWithRed:(206/255.0) green:(205/255.0) blue:(205/255.0) alpha:1].CGColor;
    self.txtActivityTime.layer.borderWidth = 2;
    
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
    
     self.originalCenter = self.view.center;
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    
  //  NSLog(@"originalCenter:%ld",self.originalCenter );

    _btnSave.enabled = YES; //Abhishek
    _btnSave.backgroundColor = [UIColor colorWithRed:(115/255.0)green:(182/255.0) blue:(68/255.0) alpha:1]; //Abhishek
    
    txtActivityType.delegate = self;//abhishek
    txtActivityDate.delegate = self;//abhishek
    txtActivityTime.delegate = self;//abhishek
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButtonItems];
    // Do any additional setup after loading the view.
    [self CallActivity_Type];
    

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




-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ActivityType_Found" object:nil];//Gautam // For
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ActivityCreateType_Found" object:nil];//Gautam // For
     [[NSNotificationCenter defaultCenter]removeObserver:self name:@"LinkCampaign_Found" object:nil];
     [[NSNotificationCenter defaultCenter]removeObserver:self name:@"SelectLinkCampaign_Found" object:nil];
    appdelegate.fromCreateoppurtunityPage=nil;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ActivityType_Found:) name:@"ActivityType_Found" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ActivityCreateType_Found:) name:@"ActivityCreateType_Found" object:nil];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(LinkCampaignListFound:) name:@"LinkCampaign_Found" object:nil];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SelectLinkCampaignListFound:) name:@"SelectLinkCampaign_Found" object:nil];
    
}
-(void)info_btn
{
    //  NSLog(@"Home biscuit from Sanfrancisco");
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField // Abhishek
{
    NSLog(@"\n Testing.....");
    
    if (textField == self.txtActivityType) {
        NSLog(@"\n Testing.....");
        [textField resignFirstResponder];
        return NO;
    }
    
    if (textField == self.txtActivityDate) {
        NSLog(@"\n Testing.....");
        [textField resignFirstResponder];
        return NO;
    }
    
    if (textField == self.txtActivityTime) {
        NSLog(@"\n Testing.....");
        [textField resignFirstResponder];
        return NO;
    }
    
    return YES;
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
   
}
// delegate mehod for uialertView

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==50)
    {
        
        alert = [[UIAlertView alloc] initWithTitle:@"Link Campaign"
                                           message:@"Do you want to Link Campaign"
                                          delegate:self
                                 cancelButtonTitle:@"No"
                                 otherButtonTitles:@"Yes",nil];
        alert.tag=60;
        [alert show];
       
    }
    else if (alertView.tag==60)
    {
        if (buttonIndex==0)
        {
             [self.navigationController popViewControllerAnimated:YES];
             NSLog(@"%ld ",(long)buttonIndex);
        }
        else if (buttonIndex==1)
        {
          NSLog(@"%ld ",(long)buttonIndex);
            if ([appdelegate.fromCreateoppurtunityPage isEqualToString:@"fromCreateoppurtunityPage"])
            {
                NSString * envelopeText2 = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                            @"<SOAP:Body>"
                                            @"<GetCampainDetailsForDSM xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                            @"<plname>%@</plname>"
                                            @"</GetCampainDetailsForDSM>"
                                            @"</SOAP:Body>"
                                            @"</SOAP:Envelope>",appdelegate.createOptyPL];
                
                
                NSData *envelope = [envelopeText2 dataUsingEncoding:NSUTF8StringEncoding];
                
                NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
                NSLog(@"URL IS %@",theurl);
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
                NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText2 length]];
                [request setHTTPMethod:@"POST"];
                [request setHTTPBody:envelope];
                [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
                [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
                
                [[RequestDelegate alloc]initiateRequest:request name:@"Linkcampaign_Connection"];
            }
            else
            {
                
            }

        }
    
    }
    else if (alertView.tag==80)
    {
        if (buttonIndex==0)
        {
            [self.navigationController popViewControllerAnimated:YES];
            NSLog(@"%ld ",(long)buttonIndex);
        }
    }
}
-(void)LinkCampaignListFound:(NSNotification*)notification  // Activity Response
{
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
        if(counterString1>0)
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
            alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                               message:@"No Link Campaign Found for respective PL"
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil];
            [alert show];
            
            descTxt.text=nil;
            txtActivityType.text=nil;
            txtActivityDate.text=nil;
            txtActivityTime.text=nil;
            
            
        }
    }
    
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
        NSString * envelopeText1 = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:asi=\"http://siebel.com/asi/\" xmlns:con=\"http://www.siebel.com/xml/Contact%%20Interface\">"
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
                                    @"</soapenv:Envelope>",createcontactresult.Id_,appdelegate.newactivityOptyID,self.selectedLinkCampaignValue];
        
        
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
            
            descTxt.text=nil;
            txtActivityType.text=nil;
            txtActivityDate.text=nil;
            txtActivityTime.text=nil;
            
        }
    }
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button Index =%ld",(long)buttonIndex);
    if (alertView.tag==60)
    {
         NSLog(@"TAG 60");
    }
    else if (alertView.tag==50)
    {
        if (buttonIndex == 0) {
            
           [self.navigationController popViewControllerAnimated:YES];
        }
        if (buttonIndex==1) {
            NSLog(@"Glen Maxwell");
             [self.navigationController popViewControllerAnimated:YES];
        
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
        // [self dismissViewControllerAnimated:YES completion:nil];
        //  [self.parentViewController.navigationController popToRootViewControllerAnimated:YES];
        //  [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
    }
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

- (IBAction)btnActivityType:(id)sender {
    
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
        
        [actionSheet showFromRect:[(UITextField *)sender frame] inView:self.viewType animated:YES];
        actionSheet.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
    }
    else{
        [actionSheet showInView:self.view];
    }
    actionSheet.tag = 1;
    

}




- (IBAction)btnSelectDate:(id)sender
{
    if ([self.view viewWithTag:9])
{
    return;
}
    CGRect toolbarTargetFrame = CGRectMake(200, self.view.bounds.size.height-500-44, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(200, self.view.bounds.size.height-500, 320, 216);
    
    UIView *darkView = [[UIView alloc] initWithFrame:self.view.bounds];
    darkView.alpha = 0;
    darkView.backgroundColor = [UIColor blackColor];
    darkView.tag = 9;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDatePicker:)];
    [darkView addGestureRecognizer:tapGesture];
    [self.view addSubview:darkView];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height+44, 320, 216)];
    datePicker.tag = 10;
    datePicker.datePickerMode=UIDatePickerModeDate;
    
    [datePicker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
    //datePicker.backgroundColor=[UIColor colorWithRed:(2/255.0) green:(18/255.0) blue:(40/255.0) alpha:1];
    datePicker.backgroundColor=[UIColor whiteColor];
    datePicker.layer.borderColor = [UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    datePicker.layer.borderWidth = 2;
    [[UILabel appearanceWhenContainedIn:[UIDatePicker class], nil]
     setTextColor:[UIColor whiteColor]];
    
    [self.view addSubview:datePicker];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 44)] ;
    toolBar.tag = 11;
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] ;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissDatePicker:)];
    [toolBar setItems:[NSArray arrayWithObjects:spacer, doneButton, nil]];
    toolBar.layer.borderColor = [UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    toolBar.layer.borderWidth = 2;
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
   // [formatter setDateFormat:@"MM/dd/yyyy"];
    [formatter setDateFormat:@"dd-MMM-yyyy"];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    NSString *stringFromDate = [formatter stringFromDate:sender.date];
    self.RequestStringDate = [formatter1 stringFromDate:sender.date];
    NSLog(@"Date..Set  From : : %@",stringFromDate);
    NSLog(@"self.RequestStringDate : %@",self.RequestStringDate);
    txtActivityDate.text=stringFromDate;
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

- (IBAction)btnSelectTime:(id)sender {
    if ([self.view viewWithTag:9]) {
        return;
    }
    CGRect toolbarTargetFrame = CGRectMake(200, self.view.bounds.size.height-500-44, 320, 44);
    CGRect datePickerTargetFrame = CGRectMake(200, self.view.bounds.size.height-500, 320, 216);
    
    UIView *darkView = [[UIView alloc] initWithFrame:self.view.bounds];
    darkView.alpha = 0;
    
    darkView.backgroundColor = [UIColor blackColor];
    darkView.tag = 9;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDatePicker:)];
    [darkView addGestureRecognizer:tapGesture];
    [self.view addSubview:darkView];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height+44, 320, 216)];
    datePicker.tag = 10;
    
    [datePicker addTarget:self action:@selector(changeDate_:) forControlEvents:UIControlEventValueChanged];
    //datePicker.backgroundColor=[UIColor colorWithRed:(2/255.0) green:(18/255.0) blue:(40/255.0) alpha:1];
    datePicker.backgroundColor=[UIColor whiteColor];
    datePicker.layer.borderColor = [UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    datePicker.layer.borderWidth = 2;
    [[UILabel appearanceWhenContainedIn:[UIDatePicker class], nil]
     setTextColor:[UIColor whiteColor]];
    datePicker.datePickerMode=UIDatePickerModeTime;
    [self.view addSubview:datePicker];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 44)] ;
    toolBar.tag = 11;
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] ;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissDatePicker:)];
    [toolBar setItems:[NSArray arrayWithObjects:spacer, doneButton, nil]];
    toolBar.layer.borderColor = [UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    toolBar.layer.borderWidth = 2;
    [self.view addSubview:toolBar];
    
    [UIView beginAnimations:@"MoveIn" context:nil];
    toolBar.frame = toolbarTargetFrame;
    datePicker.frame = datePickerTargetFrame;
    darkView.alpha = 0.8;
    [UIView commitAnimations];
}

- (IBAction)btnSave:(id)sender {
    
    if ([txtActivityType.text isEqual:@""] || [txtActivityDate.text isEqual:@""] || [descTxt.text isEqual:@""])
    {
        alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Select a values" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        NSLog(@"Ala re ..!");
        [self showAlert]; //Abhishek
        [self CallCreateActivity];
        
        _btnSave.enabled = NO; //Abhishek
        _btnSave.backgroundColor = [UIColor colorWithRed:(101/255.0)green:(104/255.0) blue:(27/255.0) alpha:1]; //Abhishek
    }
    
    //CallCreateActivity;
}

- (IBAction)btnCancelled:(id)sender {
    txtActivityType.text=@"";
    txtActivityDate.text=@"";
    txtActivityTime.text=@"";
    descTxt.text=@"";
      [descTxt resignFirstResponder];
//    [self dismissViewControllerAnimated:YES completion:NULL];
//
    [self.navigationController popViewControllerAnimated:YES];
   // [self performSegueWithIdentifier:@"" sender:self];
  
}
- (void)changeDate_:(UIDatePicker *)sender {
    NSLog(@"New Date: %@", sender.date);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //[formatter setDateFormat:@"HH:mm aa"];
     [formatter setDateFormat:@"HH:mm:ss"];
    NSString *stringFromDate = [formatter stringFromDate:sender.date];
    //[dateFormat setDateFormat:@"cccc, MMM d, hh:mm aa"];
    NSLog(@"Date..Set  To: : %@",stringFromDate);
    txtActivityTime.text=stringFromDate;
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

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSLog(@"button click ....%ld",(long)buttonIndex);
    if(txtActivityType)
    {
        NSLog(@"... in");
        switch (popup.tag)
        {
            NSLog(@"... in");
            case 1:
                
                if(buttonIndex == actionSheet.cancelButtonIndex)
                {
                    NSLog(@"ek..");
                    return;
                }
                else
                {
                    NSLog(@"Button index %ld",(long)buttonIndex);
                    self.txtActivityType.text = NSLocalizedString([activityType_PickerArr objectAtIndex:buttonIndex],@"");
                    
                }
        }
    }
}


-(void)CallCreateActivity
{
      NSLog(@"Login name..%@",userDetailsVal_.Login_Name);
    NSLog(@"cname..%@",[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"CONTACT_NAME"]);
    NSLog(@"%@",[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"OPTY_ID"]);
    NSLog(@"CREATEOPTYPAGE:%@",appdelegate.fromCreateoppurtunityPage);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMyyyyHHMMSS"];
    NSDate *todaysDate;
    todaysDate = [NSDate date];
   // todaysDate=[[NSDate date] timeIntervalSince1970];
       NSLog(@"RequestStringDate is %@",self.RequestStringDate);
    NSString *stringFromDate = [formatter stringFromDate:todaysDate];
    NSString *stringFromDate1 = [NSString stringWithFormat: @"%f", [[NSDate date] timeIntervalSince1970]];
     NSString *stringFromDate2 = [NSString stringWithFormat: @"%ld", [[NSDate date] timeIntervalSince1970]];
    
    NSDate *date = [NSDate date]; // get the current date and time.
    NSTimeInterval milliseconds = [date timeIntervalSince1970];
    
    NSString *opty_id=[[NSString alloc]init];
    if ([appdelegate.fromOPTYDetail isEqualToString:@"CameFromOptyDetail"])
    {
        opty_id=  [[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"OPTY_ID"];
        opty_id=appdelegate.opty_idDetailPage;
        
        NSLog(@"CameFromOptyDetail AND optyid:%@",opty_id);
    }
    else if([appdelegate.fromManageOptyDetail isEqualToString:@"CameFromManageOptyToDetail"])
    {
       
        opty_id=[[appdelegate.OppurtunityList objectAtIndex:appdelegate.Manageoptyrow] valueForKey:@"OPTY_ID"];
         NSLog(@"CameFromManageOptyListView AND optyid:%@",opty_id);
    }
    else if([appdelegate.fromCreateoppurtunityPage isEqualToString:@"fromCreateoppurtunityPage"])
    {
        
        opty_id=appdelegate.newactivityOptyID;
        NSLog(@"CameFromManageOptyListView AND optyid:%@",opty_id);
    }

    NSString * envelopeText = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @" <SOAP:Body>"
                               @"<SFATMCVInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                               @"<ListOfTmActionInterface xmlns=\"http://www.siebel.com/xml/TM%%20Action%%20Interface\">"
                               @"<Action operation=\"?\">"
                               @"<Type>%@</Type>"
                               @"<Owner>JJOSHI1001680</Owner>"
                               @"<PlannedStart>%@</PlannedStart>"
                               @"<Employees>JJOSHI1001680</Employees>"
                               @"<OpportunityId>%@</OpportunityId>"
                               @"<IntegrationId>%ld</IntegrationId>"
                               @"<Description>%@</Description>"
                               @"</Action>"
                               @"</ListOfTmActionInterface>"
                               @"</SFATMCVInsertOrUpdate_Input>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",self.txtActivityType.text,self.RequestStringDate,opty_id,(long)[[NSDate date]timeIntervalSince1970],descTxt.text];
//    NSString * envelopeText = [NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//  @" <SOAP:Body>"
//    @"<SFATMCVInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
//   @"<ListOfTmActionInterface xmlns=\"http://www.siebel.com/xml/TM%%20Action%%20Interface\">"
//    @"<Action operation=\"?\">"
//    @"<Type>%@</Type>"
//   @"<Owner>SAMSONJ1001680</Owner>"
//    @"<PlannedStart>%@</PlannedStart>"
//    @"<Employees>SAMSONJ1001680</Employees>"
//    @"<OpportunityId>%@</OpportunityId>"
//   @"<IntegrationId>%ld</IntegrationId>"
//    @"<Description>%@</Description>"
//    @"</Action>"
//  @"</ListOfTmActionInterface>"
//    @"</SFATMCVInsertOrUpdate_Input>"
// @"</SOAP:Body>"
//@"</SOAP:Envelope>",self.txtActivityType.text,self.RequestStringDate,[[appdelegate.OppurtunityList objectAtIndex:appdelegate.optyrow] valueForKey:@"OPTY_ID"],(long)[[NSDate date]timeIntervalSince1970],descTxt.text];

//
    NSString * envelopeText1 = [NSString stringWithFormat:
                                   @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                   @"<SOAP:Body>"
                                   @"<getListOfActivityJavaCall xmlns=\"http://schemas.cordys.com/NeevJavaCall\" />"
                                   @"</SOAP:Body>"
                                   @"</SOAP:Envelope>"];
    
    NSLog(@"\n envlopeString Of Activity Type Create....!!!!%@",envelopeText);
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
    
    [[RequestDelegate alloc]initiateRequest:request name:@"getCreateActivityTypeConnection"];
    
}//ActivityCreateType_Found
-(void)ActivityCreateType_Found:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n _ActivityCREATE_Found response... %@ ",response);
    
   [self hideAlert];//Abhishek
 
    if ([response isEqual:@""])
    {
        [self hideAlert];
     
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Nothing in Response !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        
    }
    else if ([response isEqual:@"SOAP:Fault"])
    {
        [self hideAlert];
     
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Network Fault String!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else
    {
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        
        
        TBXMLElement *container = [TBXML childElementNamed:@"ns:SFATMCVInsertOrUpdate_Output" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement *ListOfTmActionInterface =[TBXML childElementNamed:@"ListOfTmActionInterface" parentElement:container];
        TBXMLElement *Action = [TBXML childElementNamed:@"Action" parentElement:ListOfTmActionInterface];
        TBXMLElement *ActivityId = [TBXML childElementNamed:@"ActivityId" parentElement:Action];
        TBXMLElement *IntegrationId = [TBXML childElementNamed:@"IntegrationId" parentElement:Action];
         TBXMLElement *Id = [TBXML childElementNamed:@"Id" parentElement:Action];
        
        NSString *ActivityId_NAME = [TBXML textForElement:ActivityId];
        NSString *IntegrationId_NAME = [TBXML textForElement:IntegrationId];
         NSString *Id_NAME = [TBXML textForElement:Id];
        NSLog(@"\n SALE_STAGE_NAME : %@",ActivityId_NAME);
          NSLog(@"\n SALE_STAGE_NAME : %@",IntegrationId_NAME);
        NSArray *A=[[NSArray alloc]initWithObjects:ActivityId_NAME,IntegrationId_NAME, nil];
        
        if([appdelegate.fromCreateoppurtunityPage isEqualToString:@"fromCreateoppurtunityPage"])
        {
            
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Activity Created Successfully" message:[NSString stringWithFormat:@"Activity ID:%@",Id_NAME] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
           // alertView.tag=80;
            [alertView show];
            [descTxt resignFirstResponder];
        }
        else
        {
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Activity Created Successfully" message:[NSString stringWithFormat:@"Activity ID:%@",Id_NAME] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alertView.tag=80;
            [alertView show];
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
