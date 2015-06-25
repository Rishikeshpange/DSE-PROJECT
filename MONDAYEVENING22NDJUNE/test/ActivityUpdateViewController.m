//
//  ActivityUpdateViewController.m
//  NEEV
//
//  Created by admin on 01/04/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import "ActivityUpdateViewController.h"
#import "LoginViewController.h"
#import "Activity_List.h"
#import "ActivityPendingList.h"
#import "Opportunity_List.h"
#import "RequestDelegate.h"
#import "TBXML.h"
#import "MBProgressHUD.h"
#import "ActivityListViewController.h"
@interface ActivityUpdateViewController ()
{
    UIAlertView *alert;
    int flag;
    NSString *stringFromDate;
    NSString *stringDate;
    NSString *dateTime;
}
@end

@implementation ActivityUpdateViewController
@synthesize flagset,activityType_PickerArr,txtActivityType,txtSelectDate,txtSelectTime,txtDescription;
@synthesize lblAccountType,lblAddress,lblCustomerName,lblMobileNo,lblOptyId,lblTGMTKM_Name,lblTGMTKMNumber;
- (void)viewDidLoad {
    [super viewDidLoad];
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];//AppDelegate instance
    userDetailsVal_ = [UserDetails_Var sharedmanager]; // usedetails instance
    NSLog(@"%d",flagset);
    activityType_PickerArr = [[NSMutableArray alloc]init];// for Activty TYPE
    appdelegate.FromUpdateActivityString = @"FromUpdateActivityString";
    
    
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
    
    
    self.originalCenter = self.view.center;
    NSLog(@"Activity List... %@",activityPending_list.ACTIVITY_STATUS);
    
    NSLog(@"Activity List... %@",activity_list.CONTACT_NAME);
    NSLog(@"Activity List... %@",activity_list.OPPTY_ROWID);
    NSLog(@"Activity List... %@",activity_list.CONTACT_CELL_NUM);
    NSLog(@"Activity List... %@",activity_list.CONTACT_ADDRESS);
//    NSLog(@"Activity List... %@",activity_list.TGM_TKM_NAME);
//    NSLog(@"Activity List... %@",activity_list.TGM_TKM_PHONE_NUMBER);
    NSLog(@"Activity List... %@",activity_list.ACCOUNT_TYPE);
    
    self.btnCancel.layer.cornerRadius=3;
    self.btnCancel.layer.masksToBounds = YES;
    
    self.btnUpdate.layer.cornerRadius=3;
    self.btnUpdate.layer.masksToBounds = YES;
    
    
//    self.txtActivityType.layer.borderColor = [UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
//    self.txtActivityType.layer.borderWidth = 2;
//    
//    self.txtSelectDate.layer.borderColor = [UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
//    self.txtSelectDate.layer.borderWidth = 2;
//    
//    self.txtSelectTime.layer.borderColor = [UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
//    self.txtSelectTime.layer.borderWidth = 2;
//    
//    self.txtDescription.layer.borderColor = [UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
//    self.txtDescription.layer.borderWidth = 2;
    
    
    self.txtActivityType.layer.borderColor = [UIColor colorWithRed:(188/255.0) green:(186/255.0) blue:(187/255.0) alpha:1].CGColor;
    self.txtActivityType.layer.borderWidth = 2;
    
    self.txtSelectDate.layer.borderColor = [UIColor colorWithRed:(188/255.0) green:(186/255.0) blue:(187/255.0) alpha:1].CGColor;
    self.txtSelectDate.layer.borderWidth = 2;
    
    self.txtSelectTime.layer.borderColor = [UIColor colorWithRed:(188/255.0) green:(186/255.0) blue:(187/255.0) alpha:1].CGColor;
    self.txtSelectTime.layer.borderWidth = 2;
    
    self.txtDescription.layer.borderColor = [UIColor colorWithRed:(188/255.0) green:(186/255.0) blue:(187/255.0) alpha:1].CGColor;
    self.txtDescription.layer.borderWidth = 2;
    
    // Do any additional setup after loading the view.
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
    // Do any additional setup after loading the view.}
    
    
    NSLog(@"Status : %@", activityPending_list.ACTIVITY_STATUS);
    
    if([activityPending_list.ACTIVITY_STATUS isEqual:@"Done"])
    {
        alert = [[UIAlertView alloc] initWithTitle:@"DSE"
                                           message:@"This activity is already marked as done! You cannot update it."
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil,nil];
        alert.tag=50;
        [alert show];
        //[self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
    if(flagset==1)
    {
        NSLog(@"From ...Opty");
        self.lblCustomerName.text=opportunity_list.CONTACT_NAME;
        self.lblMobileNo.text=opportunity_list.CONTACT_CELL_NUMBER;
        self.lblAddress.text=opportunity_list.CONTACT_ADDRESS;
        
        self.lblTGMTKM_Name.text=opportunity_list.TGM_TKM_NAME;
        self.lblTGMTKMNumber.text=opportunity_list.TGM_TKM_PHONE_NUMBER;
        self.lblAccountType.text=opportunity_list.ACCOUNT_TYPE;
        
        self.lblOptyId.text=opportunity_list.OPTY_ID;
    }
    else{
        NSLog(@"From ...Activty");
        self.lblCustomerName.text=activityPending_list.CONTACT_NAME;
        self.lblMobileNo.text=activityPending_list.CONTACT_CELL_NUMBER;
        self.lblAddress.text=activityPending_list.CONTACT_ADDRESS;
        
        self.lblTGMTKM_Name.text=activityPending_list.TGM_TKM_NAME;
        self.lblTGMTKMNumber.text=activityPending_list.TGM_TKM_PHONE_NUMBER;
       // self.lblAccountType.text=activity_list.ACCOUNT_TYPE;
        
        self.lblOptyId.text=activityPending_list.OPTY_ID;
    }
    
    if([lblCustomerName.text isEqual:@""])
    {
        lblCustomerName.text=@"Not Available";
    }
    if([self.lblMobileNo.text isEqual:@""])
    {
        self.lblMobileNo.text=@"Not Available";
    }
    if([self.lblAddress.text isEqual:@""])
    {
        self.lblAddress.text=@"Not Available";
    }
    if([self.lblTGMTKM_Name.text isEqual:@""])
    {
        self.lblTGMTKM_Name.text=@"Not Available";
    }
    if([self.lblTGMTKMNumber.text isEqual:@""])
    {
        self.lblTGMTKMNumber.text=@"Not Available";
    }
    if([self.lblAccountType.text isEqual:@""])
    {
        NSLog(@"ekssss");
        lblAccountType.text=@"Not Available";
    }
    if([self.lblOptyId.text isEqual:@""])
    {
        lblOptyId.text=@"Not Available";
    }
    
    //abhishek
    _btnUpdate.enabled = YES; //abhishek
    _btnUpdate.backgroundColor = [UIColor colorWithRed:(115/255.0)green:(182/255.0) blue:(68/255.0) alpha:1];//abhishek
    
    txtActivityType.delegate = self; //abhishek
    txtSelectDate.delegate = self; //abhishek
    txtSelectTime.delegate = self; //abhishek
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
   
    [self CallActivity_Type];
}

- (void)keyboardDidShow:(NSNotification *)note
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    [UIView setAnimationCurve:[note.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    self.view.center = CGPointMake(self.view.center.x, 30.0);
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
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ActivityUpdates_Found" object:nil];//Gautam // For
}

-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ActivityType_Found:) name:@"ActivityType_Found" object:nil];//Gautam //For activity type
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ActivityUpdates_Found:) name:@"ActivityUpdates_Found" object:nil];//Gautam //For activity type
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
    [alert show];
    NSLog(@"Home biscuit from Sanfrancisco");
}
// delegate mehod for uialertView

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button Index =%ld",(long)buttonIndex);
    if (alertView.tag==50) {
        if (buttonIndex == 0) {
        
            [self.navigationController popViewControllerAnimated:YES];

        }
    }
    else{
    if (buttonIndex == 0) {
        
        NSLog(@"David Miller");
        if(flag==1)
        {
            [self dismissViewControllerAnimated:YES completion:NULL];
            
            [self.navigationController popViewControllerAnimated:YES];
    
            /*
            ActivityListViewController *activitiesResult_VC = [self.storyboard instantiateViewControllerWithIdentifier:@"activityList_controller"];
            [self.navigationController pushViewController:activitiesResult_VC animated:YES];*/
        }
        else
        {
            NSLog(@"Ethech...");
        }
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



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField // Abhishek
{
    // NSLog(@"\n Testing.....");
    
    if (textField == self.txtActivityType)
    {
        NSLog(@"\n Testing.....");
        [textField resignFirstResponder];
        return NO;
    }
    
    if (textField == self.txtSelectDate) {
        NSLog(@"\n Testing.....");
        [textField resignFirstResponder];
        return NO;
    }
    
    if (textField == self.txtSelectTime) {
        NSLog(@"\n Testing.....");
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void)CallActivity_Type
{       NSString * envelopeText = [NSString stringWithFormat:
                                   @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                   @"<SOAP:Body>"
                                   @"<getListOfActivityJavaCall xmlns=\"http://schemas.cordys.com/NeevJavaCall\" />"
                                   @"</SOAP:Body>"
                                   @"</SOAP:Envelope>"];
    
    NSLog(@"\n envlopeString Of Activity Type....!!!!%@",envelopeText);
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
- (IBAction)btnActivityType:(id)sender {
    NSLog(@"Activity...Data %@",activityType_PickerArr);
    
    [self showAlert];
    
    if([activityType_PickerArr count]>0)
    {
    
        [self hideAlert];
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
        
        [actionSheet showFromRect:[(UITextField *)sender frame] inView:self._firstView animated:YES];
        actionSheet.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
    }
    else{
        [actionSheet showInView:self.view];
    }
    actionSheet.tag = 1;
    }
    else
    {
        [self hideAlert];
        NSLog(@"Segmentation Fault");
    }
}

- (IBAction)btnToDate:(id)sender {
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
    datePicker.datePickerMode = UIDatePickerModeDate;
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
    [formatter setDateFormat:@"MM/dd/yyyy"];
    stringDate = [formatter stringFromDate:sender.date];
    NSLog(@"Date..Set  From : : %@",stringDate);
    txtSelectDate.text=stringDate;
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


- (IBAction)btnFromDate:(id)sender {
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
    datePicker.datePickerMode = UIDatePickerModeDate;
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
- (void)changeDate_:(UIDatePicker *)sender {
    NSLog(@"New Date: %@", sender.date);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@" HH:mm:ss"];
    stringFromDate = [formatter stringFromDate:sender.date];
    //[dateFormat setDateFormat:@"cccc, MMM d, hh:mm aa"];
    NSLog(@"Date..Set  To: : %@",stringFromDate);
    txtSelectTime.text=stringFromDate;
}
- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSLog(@"button click ....%ld",(long)buttonIndex);
    if(txtActivityType){
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
                    self.txtActivityType.text = NSLocalizedString([activityType_PickerArr objectAtIndex:buttonIndex],@"");
                    
                }
                
        }
    }
}

- (IBAction)btnUpdate:(id)sender {
    
    
    //stringDate = [NSString stringWithFormat:stringDate,stringFromDate];
    stringDate = [stringDate stringByAppendingString:stringFromDate];
    NSLog(@"Date and Time :%@",stringDate);
    NSLog(@"activity Pending..%@",activityPending_list.ACTIVITY_ID);
    NSLog(@".. %@ ",lblCustomerName.text);
    NSLog(@".. %@ ",lblMobileNo.text);
    NSLog(@".. %@ ",lblTGMTKM_Name.text);
    NSLog(@".. %@ ",lblAddress.text);
    NSLog(@".. %@ ",txtActivityType.text);
    NSLog(@".. %@ ",txtSelectTime.text);
    NSLog(@".. %@ ",txtSelectDate.text);
    
    if (txtActivityType.text.length==0 || txtSelectDate.text.length==0 || txtSelectTime.text.length==0)
    {
        alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Select a values" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        [self showAlert];//Abhishek
        [self CallActivityUpdate];
        
        _btnUpdate.enabled = NO;//abhishek
        _btnUpdate.backgroundColor = [UIColor colorWithRed:(101/255.0)green:(104/255.0) blue:(27/255.0) alpha:1];//abhishek
        
    }
    
    /*
    <SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">
    <SOAP:Body>
    <SFATMCVInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">
    <ListOfTmActionInterface xmlns=\"http://www.siebel.com/xml/TM%20Action%20Interface\">
    <Action operation=\"update\">"
    + "<Type>"
    + list.get(spnActivityDetail.getSelectedItemPosition())
    .toString()
    + "</Type>
    <PlannedStart>"
    + setDate
    + "</PlannedStart>" +"<Employees>" + UserDetails.LoginName +
    "</Employees>
    <Owner>" + UserDetails.LoginName +"</Owner>" + " <Description>"
    + ((TextView) findViewById(R.id.txtDescription)).getText()
    .toString()
    + "</Description>
    <ActivityId>"
    + _ad.ACTIVITY_ID
    + "</ActivityId>
    </Action>
    </ListOfTmActionInterface>
    </SFATMCVInsertOrUpdate_Input>
    </SOAP:Body>
    </SOAP:Envelope>*/
    
}
-(void)CallActivityUpdate
{
    NSLog(@"Login name..%@",userDetailsVal_.Login_Name);
    
     NSLog(@"Login name..%@",txtDescription.text);
    NSLog(@"Login name..%@",txtActivityType.text);
    
    NSString * envelopeText = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<SFATMCVInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                               @"<ListOfTmActionInterface xmlns=\"http://www.siebel.com/xml/TM%%20Action%%20Interface\">"
                               @"<Action operation=\"update\">"
                               @"<Type>%@</Type>"
                               @"<PlannedStart>%@</PlannedStart>"
                               @"<Employees>JJOSHI1001680</Employees>"
                               @"<Owner>JJOSHI1001680</Owner>"
                               @"<Description>%@</Description>"
                               @"<ActivityId>%@</ActivityId>"
                               @"</Action>"
                               @"</ListOfTmActionInterface>"
                               @"</SFATMCVInsertOrUpdate_Input>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",txtActivityType.text,stringDate,txtDescription.text,activityPending_list.ACTIVITY_ID];
    
    
    NSString * envelopeText1 = [NSString stringWithFormat:
                                   @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                   @"<SOAP:Body>"
                                   @"<getListOfActivityJavaCall xmlns=\"http://schemas.cordys.com/NeevJavaCall\" />"
                                   @"</SOAP:Body>"
                                   @"</SOAP:Envelope>"];
    
    
    NSLog(@"\n envlopeString Of Activity Type....!!!!%@",envelopeText);
    
    
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
    
    [[RequestDelegate alloc]initiateRequest:request name:@"getActivityUpdateConnection"];
    
}
-(void)ActivityUpdates_Found:(NSNotification*)notification
{
    [self hideAlert];//Abhishek
    
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n _ActivityType_Found response... %@ ",response);
    
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        [self hideAlert];
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"The username or password you entered is incorrect.\n*The user account will be locked after 3 unsucessfull attempts." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
    
    
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    TBXMLElement *container = [TBXML childElementNamed:@"ns:SFATMCVInsertOrUpdate_Output" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    
    TBXMLElement *ListOfContactInterface =[TBXML childElementNamed:@"ListOfTmActionInterface" parentElement:container];
    
    TBXMLElement *Opportunity = [TBXML childElementNamed:@"Action" parentElement:ListOfContactInterface];
    TBXMLElement *Id = [TBXML childElementNamed:@"Id" parentElement:Opportunity];
    if (Id)
    {
        
        updateActivty.Id_ = [TBXML textForElement:Id];
        NSLog(@"\nListOfContactInterface.....!!!!!%@",updateActivty.Id_);
        flag=1;
        alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Activity Updated Successfully ! " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

    }
    
    else
    {
        alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Server Error!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
   
    }
    
    
    /*
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
    }*/
}


- (IBAction)btnCancel:(id)sender {
    
    txtActivityType.text=@"";
    txtSelectDate.text=@"";
    txtSelectTime.text=@"";
    txtDescription.text=@"";
     [self.navigationController popViewControllerAnimated:YES];
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
