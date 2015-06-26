//
//  ActivitySearchViewController.m
//  NEEV
//
//  Created by Sachin Sharma on 27/03/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//


//
#import "ActivityViewController.h"
#import "ActivityListViewController.h"
#import "LoginViewController.h"
#import "ManageOpportunity.h"
#import "SearchOpprtunityViewController.h"
#import "CreateActivityViewController.h"
#import "ActivitySearchViewController.h"
#import  "AppDelegate.h"
#import "RequestDelegate.h"
#import "TBXML.h"
#import "SearchActivity_List.h"
#import "ActivityListViewController.h"
#import "PendulumView.h"
#import "MBProgressHUD.h"



NSString* RESULTCOUNT;
NSInteger NO_OF_PAGECOUNT;
NSInteger CURRENT_PAGE;
NSInteger INT_RESULTCOUNT;

@interface ActivitySearchViewController ()<RSLoadingIndicatorDelegate>
{
    UIAlertView *alert;
    
    RSLoadingIndicator *indicator;
    UIButton *button;
    NSTimer *ticker;
    NSTimer *stopTimer;
}
    @property (weak, nonatomic) IBOutlet UILabel *dateLabel;
    @property (nonatomic, strong) NSDate *selectedDate;

@end


@implementation ActivitySearchViewController

@synthesize activitypplIDPickerArr,activityPPLNamePickerArr,activityType_PickerArr,activityStatus,activityAssignTo,activityType_TalArr,activityAssignLOB;

@synthesize textactivitytype,textDate,textdse,textppl,textfrmDate,textstatus,texttaluka;

- (void)viewDidLoad {
    
      [super viewDidLoad];
      self.automaticallyAdjustsScrollViewInsets = NO;
    
//    [self.view addSubview:indicator];
    
//    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [button setTitle:NSLocalizedString(@"Restart", nil) forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [button sizeToFit];
//    CGRect frame = button.frame;
//    frame.origin.x = roundf((self.view.bounds.size.width - frame.size.width) / 2.0f);
//    frame.origin.y = 100;
//    button.frame = frame;
//    [indicator addSubview:button];
//    button.enabled = NO;
    
    self.SearchBTN.layer.cornerRadius = 4;
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
    appdelegate.ActivityList=[[NSMutableArray alloc] init];
    
    // Do any additional setup after loading the view.
    
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];//AppDelegate instance
    userDetailsVal_ = [UserDetails_Var sharedmanager]; // usedetails instance
    
    appdelegate.fromACTIVITYDetail = @"cameFromActivityList";
    
    
    

    activitypplIDPickerArr = [[NSMutableArray alloc]init]; // For Activity PPL_ID
    activityPPLNamePickerArr = [[NSMutableArray alloc]init];// For Activity PPL Name
    activityType_PickerArr = [[NSMutableArray alloc]init];// for Activty TYPE
    activityStatus = [[NSMutableArray alloc]initWithObjects:@"Open",@"Done", nil];
    
    activityAssignLOB = [[NSMutableArray alloc] init];
    activityAssignTo = [[NSMutableArray alloc] init];
    activityType_TalArr = [[NSMutableArray alloc] init];
    
//    search_activitiesresultpage_variables = [Search_Activitiesresultpage_variables sharedmanager]; //create singleton instance pf search activities class
    
    
    isActivitystatusClicked = false; // for checking  click on activitystatus textview
    isPPLNameclicked = false;// for checking  click on isPPLName textview
    isActivityTypeClicked = false;// for checking  click on ActivityType textview
    
    [self callActivity_PPL]; // function for parsing PPL activity
    [self CallActivity_Type]; // fuction for parsing activty type
    [self callActivity_TALUKA];
    [self callAssignTo];
    
    textfrmDate.delegate = self;
    textDate.delegate = self;
    textactivitytype.delegate = self;
    textdse.delegate = self;
    texttaluka.delegate = self;
    
    //  startIndex = 1; endIndex = 20; // set index range fathing data for search activity data
    
    // for search activities after cicking on seach button
    
    DisplaySearchActivitiesDetailsArray = [[NSMutableArray alloc]init];
    appdelegate.ActivityList=[[NSMutableArray alloc] init];
    
    //abhishek
    textfrmDate.delegate = self;
    textDate.delegate = self;
    textactivitytype.delegate = self;
    textstatus.delegate = self;
    textppl.delegate = self;
}

//abhishek

//text field delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField // Abhishek
{
    NSLog(@"\n Testing.....");
    //Abhishek
    
    if (textField == self.textfrmDate) {
        NSLog(@"\n Testing.....");
        [textField resignFirstResponder];
        return NO;
    }
    
    if (textField == self.textDate) {
        NSLog(@"\n Testing.....");
        [textField resignFirstResponder];
        return NO;
    }
    
    if (textField == self.textactivitytype) {
        NSLog(@"\n Testing.....");
        [textField resignFirstResponder];
        return NO;
    }
    
    if (textField == self.textstatus) {
        NSLog(@"\n Testing.....");
        [textField resignFirstResponder];
        return NO;
    }
    
    if (textField == self.textppl) {
        NSLog(@"\n Testing.....");
        [textField resignFirstResponder];
        return NO;
    }
    
    return YES;
}



- (void)buttonClicked:(id)sender
{
ticker = [NSTimer scheduledTimerWithTimeInterval:1.0f / 33.0f target:self selector:@selector(tick) userInfo:nil repeats:YES] ;
button.enabled = NO;
}
- (void)tick
{
[indicator didScroll:0.8f];
}
              
- (void)stop
{
[indicator stopLoading];
}
              
              
#pragma mark - RSLoadingIndicatorDelegate
              
- (void)startLoading
{
// stopTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(stop) userInfo:nil repeats:NO] ;
}
              
- (void)stopLoading
{
[ticker invalidate];
                
ticker = nil;
                  
[stopTimer invalidate];
                
stopTimer = nil;
                  
button.enabled = YES;
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)textfromdate:(id)sender {
  
  
    
    if ([self.view viewWithTag:9]) {
        return;
    }
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
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(changeDate_:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datePicker];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 44)] ;
    toolBar.tag = 11;
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] ;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissDatePicker:)];
    [toolBar setItems:[NSArray arrayWithObjects:spacer, doneButton, nil]];
    [self.view addSubview:toolBar];
    
    [UIView beginAnimations:@"MoveIn" context:nil];
    toolBar.frame = toolbarTargetFrame;
    datePicker.frame = datePickerTargetFrame;
    darkView.alpha = 0.5;
    [UIView commitAnimations];

    
}



- (void)changeDate_:(UIDatePicker *)sender {
    NSLog(@"New Date: %@", sender.date);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MMM-yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:sender.date];
    NSLog(@"Date..Set  From : : %@",stringFromDate);
    textfrmDate.text=stringFromDate;
    
    
    
}


- (void)changeDate:(UIDatePicker *)sender {
    NSLog(@"New Date: %@", sender.date);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MMM-yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:sender.date];
    NSLog(@"Date..Set  From : : %@",stringFromDate);
    textDate.text=stringFromDate;
    
 
    
}

- (void)removeViews:(id)object {
    [[self.view viewWithTag:9] removeFromSuperview];
    [[self.view viewWithTag:10] removeFromSuperview];
    [[self.view viewWithTag:11] removeFromSuperview];
}

- (void)dismissDatePicker:(id)sender
{
    
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





- (IBAction)todate:(id)sender {
    
    
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
-(void)viewDidDisappear:(BOOL)animated
{

    [self.pendulum removeFromSuperview];
}



-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"Activity_PPL_Found" object:nil];//abhishek // For Activity_PPL Count
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ActivityType_Found" object:nil];//abhishek // For ActivityType Count
    // [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ActivityType_Found" object:nil];//abhishek // For opportunity Count
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"searchActivities_Found" object:nil];//abhishek // For searchActivities_Found Count
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ActivityTaluka_Found" object:nil];//abhishek // For searchActivities_Found Count
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"SaleAssign_To_Found" object:nil];//abhishek // For searchActivities_Found Count
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"searchActivities_Found1" object:nil];
   
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Activity_PPL_Found:) name:@"Activity_PPL_Found" object:nil];//Abhishek //For Activity Type Dropdown Count
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ActivityType_Found:) name:@"ActivityType_Found" object:nil];//Abhishek //For activity type
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(searchActivities_Found:) name:@"searchActivities_Found" object:nil];//Abhishek //for search activites after pressing search button
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ActivityTaluka_Found:) name:@"ActivityTaluka_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SaleAssign_To_Found:) name:@"SaleAssign_To_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(searchActivities_Found1:) name:@"searchActivities_Found1" object:nil];
}
    

    
    
-(void)callActivity_PPL
{
    /*<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">
     <SOAP:Body>
     <GetLOBForNeev xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\" />
     </SOAP:Body>
     </SOAP:Envelope>";;*/
    
    //HC For thane
    
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
    
    
    // frm logged in user locaion
    
    
    NSString * envelopeText1 = [NSString stringWithFormat:
    @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
    @"<SOAP:Body>"
    @"<GetListOfTehsil xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
    @"<poistionid></poistionid>"
    @"<districtname>UserDetails.getDistrict()</districtname>"
    @"</GetListOfTehsil>"
    @"</SOAP:Body>"
    @"</SOAP:Envelope>"];
    
    
    
    
    
  
    
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
    
    [[RequestDelegate alloc]initiateRequest:request name:@"getActivityPPLConnection"];
}
-(void)Activity_PPL_Found:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n Activity_PPL_Found response... %@ ",response);
    
    if (activitypplIDPickerArr || activityPPLNamePickerArr)
    {
        [activitypplIDPickerArr removeAllObjects];
        [activityPPLNamePickerArr removeAllObjects];
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
            [activitypplIDPickerArr addObject:PPL_ID_];
            
            TBXMLElement *PPL_NAME = [TBXML childElementNamed:@"PPL_NAME" parentElement:S_PROD_LN];
            NSString *PPL_NAME_ = [TBXML textForElement:PPL_NAME];
            NSLog(@"\n SALE_STAGE_NAME : %@",PPL_NAME_);
            [activityPPLNamePickerArr addObject:PPL_NAME_];
            
        }while ((tuple = tuple->nextSibling));
        
    }
    
    if ((activityType_PickerArr.count) > 0){
        //[appdelegate hideAlert];
    }
    
    NSLog(@" \n\n activityPPLNamePickerArr....!!! %lu ",(unsigned long)[activityPPLNamePickerArr count]);
    NSLog(@" \n\n activityPPLNamePickerArr....!!! %lu ",(unsigned long)[activitypplIDPickerArr count]);
    
}


// For calling ACTIVITY TYPE


-(void)CallActivity_Type
{       NSString * envelopeText = [NSString stringWithFormat:
                                   @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                   @"<SOAP:Body>"
                                   @"<getListOfActivityJavaCall xmlns=\"http://schemas.cordys.com/NeevJavaCall\" />"
                                   @"</SOAP:Body>"
                                   @"</SOAP:Envelope>"];
  /*
    NSString * envelopeText1 = [NSString stringWithFormat:
                                @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                @"<SOAP:Body>"
                                @"<GetTMCVActivityType xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\" />"
                                @"</SOAP:Body>"
                                @"</SOAP:Envelope>"] ;
   */
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
    }/*
      if ((pplNamePickerArr.count) > 0)
      {
      //  [appdelegate hideAlert];
      }*/
    
    /*
     if (activityType_PickerArr)
     {
     [activityType_PickerArr removeAllObjects];
     }
     TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
     TBXMLElement *container = [TBXML childElementNamed:@"getListOfActivityJavaCall" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
     TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
     
     if (tuple)
     {
     do
     {
     TBXMLElement *S_Lst_Of_Val  = [TBXML childElementNamed:@"S_Lst_Of_Val" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
     TBXMLElement *NAME = [TBXML childElementNamed:@"NAME" parentElement:S_Lst_Of_Val];
     NSString *str_NAME = [TBXML textForElement:NAME];
     NSLog(@"\n str_S_Lst_Of_Val : %@",str_NAME);
     [activityType_PickerArr addObject:str_NAME];
     
     }while ((tuple = tuple->nextSibling));
     }
     
     if (((activitypplIDPickerArr.count)|| (activityPPLNamePickerArr.count)) > 0){
     //  [appdelegate hideAlert];
     }
     NSLog(@" \n\n activityPPLNamePickerArr....!!! %lu ",(unsigned long)[activityType_PickerArr count]);
     */
}
// Call Taluka..
-(void)callActivity_TALUKA
{
    /*"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">" +
     "<SOAP:Body>" +
     "<GetListOfTehsil xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">" +
     "<poistionid>"+ UserDetails.getROW_ID()+ "</poistionid>" +
     "<districtname>"+ UserDetails.getDistrict()+ "</districtname>" +
     "</GetListOfTehsil>" +
     "</SOAP:Body>" +
     "</SOAP:Envelope>";*/
    
    NSString * envelopeText = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<GetListOfTehsil xmlns=\"com.cordys.tatamotors.Neevsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                               @"<poistionid>%@</poistionid>"
                               @"<districtname>Thane</districtname>"
                               @"<attr1></attr1>"
                               @"</GetListOfTehsil>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",userDetailsVal_.ROW_ID];
    
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
    
    [[RequestDelegate alloc]initiateRequest:request name:@"getActivityTaluka"];
}
-(void)ActivityTaluka_Found:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n _ActivityTaluka_Found response... %@ ",response);
    
    if (activityType_TalArr)
    {
        [activityType_TalArr removeAllObjects];
    }
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    TBXMLElement *container = [TBXML childElementNamed:@"GetListOfTehsilResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
    
    if (tuple)
    {
        do
        {
            TBXMLElement *S_Lst_Of_Val  = [TBXML childElementNamed:@"CX_DISTRICT_MAS" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
            TBXMLElement *NAME = [TBXML childElementNamed:@"X_TALUKA" parentElement:S_Lst_Of_Val];
            NSString *str_NAME = [TBXML textForElement:NAME];
            NSLog(@"\n str_S_Lst_Of_Val : %@",str_NAME);
            [activityType_TalArr addObject:str_NAME];
            
        }while ((tuple = tuple->nextSibling));
    }
    
    if (((activitypplIDPickerArr.count)|| (activityPPLNamePickerArr.count)) > 0){
        //  [appdelegate hideAlert];
    }
    NSLog(@" \n\n activityPPLNamePickerArr....!!! %lu ",(unsigned long)[activityType_PickerArr count]);
    
}
-(void)callAssignTo
{
 //   NSLog(@"Distict %@ %@",appdelegate.loginUD,userDetailsVal_.ROW_ID);
    
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
    
    
NSString * envelopeText1 = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<GetListOfNseOrDseForDSM xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                               @"<positionid>%@</positionid>"
                               @"<positionname></positionname>"
                               @"<buname></buname>"
                               @"<searchpostitionname1></searchpostitionname1>"
                               @"<searchpostitionname2></searchpostitionname2>"
                               @"</GetListOfNSEOrLOBDSEForDSM>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",userDetailsVal_.ROW_ID];
    
    NSLog(@"\n envlopeString Of Assign TO....!!!!%@",envelopeText);
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
    
    [[RequestDelegate alloc]initiateRequest:request name:@"getActivity_AssignTo"];
    
}

-(void)SaleAssign_To_Found:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n _OptyAssign_Found response... %@ ",response);
    if (activityAssignTo)
    {
        [activityAssignTo removeAllObjects];
    }
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    TBXMLElement *container = [TBXML childElementNamed:@"GetListOfNseOrDseForDSMResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
    if (tuple)
    {
        do
        {
            
            TBXMLElement *S_Lst_Of_Val  = [TBXML childElementNamed:@"S_PARTY" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
            
            
            TBXMLElement *NAME = [TBXML childElementNamed:@"NSE_LOBDSE_NAME" parentElement:S_Lst_Of_Val];
            NSString *str_Name = [TBXML textForElement:NAME];
            [activityAssignLOB addObject:str_Name];
           // NSLog(@".... DSE's %@",str_Name);
            
            TBXMLElement *POSITION_ID = [TBXML childElementNamed:@"POSTION_ID" parentElement:S_Lst_Of_Val];
            NSString *str_Position = [TBXML textForElement:POSITION_ID];
         //   NSLog(@"\n str_NSE : %@",str_Position);
            [activityAssignTo addObject:str_Position];
            
            
            TBXMLElement *POSITION_NAME = [TBXML childElementNamed:@"POSTION_NAME" parentElement:S_Lst_Of_Val];
            NSString *str_PositionName = [TBXML textForElement:POSITION_NAME];
            NSLog(@"\n str_NSE : %@",str_PositionName);
            [activityAssignTo addObject:str_PositionName];
            
            
            TBXMLElement *POSITION_PHN = [TBXML childElementNamed:@"POSITION_PH_NUM" parentElement:S_Lst_Of_Val];
            NSString *str_PositionPhn = [TBXML textForElement:POSITION_PHN];
            NSLog(@"\n str_NSE : %@",str_PositionPhn);
            [activityAssignTo addObject:str_PositionPhn];
            
            
            TBXMLElement *LOB_NAME = [TBXML childElementNamed:@"LOBNAME" parentElement:S_Lst_Of_Val];
            NSString *str_LobName = [TBXML textForElement:LOB_NAME];
            NSLog(@"\n str_NSE : %@",str_LobName);
            [activityAssignTo addObject:str_LobName];
            
            TBXMLElement *POSITION_TYPE = [TBXML childElementNamed:@"POSITION_TYPE" parentElement:S_Lst_Of_Val];
            NSString *str_PositionType = [TBXML textForElement:POSITION_TYPE];
            NSLog(@"\n str_NSE : %@",str_PositionType);
            [activityAssignTo addObject:str_PositionType];
            
        }while ((tuple = tuple->nextSibling));
    }
    NSLog(@" \n\n activityPPLNamePickerArr....!!! %lu ",(unsigned long)[activityAssignTo count]);

}



- (IBAction)btnSearch:(id)sender
{
    
    
//     UIColor *ballColor = [UIColor colorWithRed:0.47 green:0.60 blue:0.89 alpha:1];
//   self.pendulum = [[PendulumView alloc] initWithFrame:CGRectMake(300, 400, 50, 50) ballColor:ballColor ballDiameter:12];
//    [self.view addSubview:self.pendulum];
    
   if ([self.textfrmDate.text isEqualToString:@""] ||
       [self.textDate.text isEqualToString:@""]) //||
      // [self.textactivitytype.text isEqualToString:@""]||
      // [self.textstatus.text isEqualToString:@""]||
      // [self.textppl.text isEqualToString:@""]) //Abhishek
       
   {
       NSLog(@"\n\n checking");
       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ALERT"
                                                       message:@"Please select values"
                                                      delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
       [alert show];
       return;
   }
   else{
    
    [self showAlert];//Abhishek
  
    [self CallSearch];
   }
    
}
-(void)CallSearch
{
if (self.textfrmDate.text.length == 0 && textDate.text.length == 0)
     {
     // [appdelegate hideAlert];
     alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Please select dates" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
     [alert show];
     return;
     }
     else
     {
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
     @"</SOAP:Envelope>",userDetailsVal_.ROW_ID]
         
         
         */
         
         
         
         
         
         NSString * envelopeText =[NSString stringWithFormat:
          @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
          @"<SOAP:Header xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
          @"<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"
          @"<Logger xmlns=\"http://schemas.cordys.com/General/1.0/\">"
          @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/testtool/testtool.caf</DC>"
          @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/methodsetsmanager/methodsetexplorer.caf</DC>"
          @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/sysresourcemgr/sysresourcemgr.caf</DC>"
          @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/com/cordys/cusp/cusp.caf</DC>"
          @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"hopCount\">0</DC>"
          @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"correlationID\">00215ef7-d846-11e4-e53d-0391e62b1f10</DC>"
          @"</Logger>"
          @"</header>"
          @"</SOAP:Header>"
          @"<SOAP:Body>"
          @"<GetActivityBasedOnSearchCriteriaForDsm xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
          @"<positionid>%@</positionid>"
          @"<fromdate>10-Nov-2014</fromdate>"
          @"<todate>14-Apr-2015</todate>"
          @"<activitytype></activitytype>"
          @"<activitystatus></activitystatus>"
          @"<assignedperson />"
          @"<tehsilname></tehsilname>"
          @"<pplname></pplname>"
          @"<dsepositionid></dsepositionid>"
          @"</GetActivityBasedOnSearchCriteriaForDsm>"
          @"</SOAP:Body>"
           @"</SOAP:Envelope>",userDetailsVal_.ROW_ID];
          
          NSString * envelopeText1 =[NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
         @"<SOAP:Body>"
         @"<GetSFAActivityBasedOnSearchCriteria xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
         @"<positionid>%@</positionid>"
         @"<PPLName>%@</PPLName>"
         @"<fromdate>%@</fromdate>"
         @"<todate>%@</todate>"
         @"<activitystatus>%@</activitystatus>"
         @"<activitytype>%@</activitytype>"
         @"<rang1>1</rang1>"
         @"<rang2>1</rang2>"
         @"<attr1></attr1>"
         @"<attr2></attr2>"
         @"<attr3></attr3>"
         @"<salestage></salestage>"
         @"</GetSFAActivityBasedOnSearchCriteria>"
         @"</SOAP:Body>"
         @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,self.textppl.text,self.textfrmDate.text,self.textDate.text,self.textstatus.text,self.textactivitytype.text];
         
         
         
         
         ; //please change range make dynamic insted of
     
     search_activitiesresultpage_variables.pplName_ = textppl.text; // use of instance variable is ,which we can use in next class/// for search and pagination purpose
     search_activitiesresultpage_variables.fromDate_ = textfrmDate.text; // use of instance variable is ,which we can use in next class/// for search and pagination purpose
     search_activitiesresultpage_variables.todate_ = textDate.text; // use of instance variable is ,which we can use in next class/// for search and pagination purpose
     search_activitiesresultpage_variables.activityStatus_ = textdse.text; // use of instance variable is ,which we can use in next class/// for search and pagination purpose
     search_activitiesresultpage_variables.activityType_ = textactivitytype.text;// use of instance variable is ,which we can use in next class/// for search and pagination purpose
     
     
     NSLog(@"\n envlopeString Of user details....!!!!%@",envelopeText);
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
     
     // }
     }
}
-(void)searchActivities_Found:(NSNotification*)notification
{
    //[self hideAlert];//Abhishek
    
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n _ActivityType_Found response... %@ ",response);
    
    
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Something gone wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    else{
    
    
    
    if (DisplaySearchActivitiesDetailsArray) {
        [DisplaySearchActivitiesDetailsArray removeAllObjects];
    }
    if (appdelegate.ActivityList) {
        [appdelegate.ActivityList removeAllObjects];
    }
    
    
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    TBXMLElement *container = [TBXML childElementNamed:@"GetSFAActivityBasedOnSearchCriteriaResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    
    
    TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
//   TBXMLElement *old =[TBXML childElementNamed:@"old" parentElement:tuple];
//       TBXMLElement *TABLE =[TBXML childElementNamed:@"TABLE" parentElement:old];
    if (tuple)
    {
//        TBXMLElement *old =[TBXML childElementNamed:@"old" parentElement:tuple];
//        TBXMLElement *TABLE =[TBXML childElementNamed:@"TABLE" parentElement:old];
        do {
            TBXMLElement *old =[TBXML childElementNamed:@"old" parentElement:tuple];
            TBXMLElement *TABLE =[TBXML childElementNamed:@"TABLE" parentElement:old];
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
             NSLog(@"searchActivity_list.OPTY_ID: %@",searchActivity_list.ACTIVITY_ROW_ID);
            
            TBXMLElement *PLANNED_START_DATE = [TBXML childElementNamed:@"ACTIVITY_PLAN_START_DATE" parentElement:TABLE];
            searchActivity_list.ACTIVITY_PLAN_START_DATE = [TBXML textForElement:PLANNED_START_DATE];
            
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
            [appdelegate.ActivityList addObject:searchActivity_list];
    
           // tuple= tuple->nextSibling;
        }
        while ((tuple = tuple->nextSibling));
    }
    [self CallSearch1];
//    ActivityListViewController* activityListViewController_VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ActivityListViewController"];
//    // searchOpportunityResult_VC.optySearchDetails_Comes=SearchOpportunityListArray;
//    
////    activityListViewController_VC. =txtSalesStage.text;
////    searchOpportunityResult_VC.txtFromDate=txtFromDate.text;
////    searchOpportunityResult_VC.txtToDate=txtToDate.text;
//    
//    [self.navigationController pushViewController:activityListViewController_VC animated:YES];
//    
//    NSLog(@"\n\nshow result...... resultcount....%@",RESULTCOUNT);
//     NSLog(@"\n\nappdelegate.ActivityList....%@",[[appdelegate.ActivityList objectAtIndex:0] valueForKey:@"OPPTY_ROWID"]);
//    NSLog(@"\n resultcount...... %u ",(unsigned)DisplaySearchActivitiesDetailsArray.count);
//    // [appdelegate hideAlert];
//    //ActivitiesResult_VC *activitiesResult_VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ActivitiesResult_VC"];
//    //[self.navigationController pushViewController:activitiesResult_VC animated:YES];
    }
}


-(void)CallSearch1
{
    if (self.textfrmDate.text.length == 0 && textDate.text.length == 0)
    {
        // [appdelegate hideAlert];
        alert=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Please select dates" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    else
    {
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
         @"</SOAP:Envelope>",userDetailsVal_.ROW_ID]
         
         
         */
        
        
        
        
        
        NSString * envelopeText =[NSString stringWithFormat:
                                  @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                  @"<SOAP:Header xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                  @"<header xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                                  @"<Logger xmlns=\"http://schemas.cordys.com/General/1.0/\">"
                                  @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/testtool/testtool.caf</DC>"
                                  @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/methodsetsmanager/methodsetexplorer.caf</DC>"
                                  @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/sysresourcemgr/sysresourcemgr.caf</DC>"
                                  @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"XForms\">/com/cordys/cusp/cusp.caf</DC>"
                                  @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"hopCount\">0</DC>"
                                  @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"correlationID\">00215ef7-d846-11e4-e53d-0391e62b1f10</DC>"
                                  @"</Logger>"
                                  @"</header>"
                                  @"</SOAP:Header>"
                                  @"<SOAP:Body>"
                                  @"<GetActivityBasedOnSearchCriteriaForDsm xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                  @"<positionid>%@</positionid>"
                                  @"<fromdate>10-Nov-2014</fromdate>"
                                  @"<todate>14-Apr-2015</todate>"
                                  @"<activitytype></activitytype>"
                                  @"<activitystatus></activitystatus>"
                                  @"<assignedperson />"
                                  @"<tehsilname></tehsilname>"
                                  @"<pplname></pplname>"
                                  @"<dsepositionid></dsepositionid>"
                                  @"</GetActivityBasedOnSearchCriteriaForDsm>"
                                  @"</SOAP:Body>"
                                  @"</SOAP:Envelope>",userDetailsVal_.ROW_ID];
        
//        NSString * envelopeText1 =[NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                                   @"<SOAP:Body>"
//                                   @"<GetSFAActivityBasedOnSearchCriteria xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
//                                   @"<positionid>%@</positionid>"
//                                   @"<PPLName></PPLName>"
//                                   @"<fromdate>%@</fromdate>"
//                                   @"<todate>%@</todate>"
//                                   @"<activitystatus></activitystatus>"
//                                   @"<activitytype></activitytype>"
//                                   @"<rang1>1</rang1>"
//                                   @"<rang2>%@</rang2>"
//                                   @"<attr1></attr1>"
//                                   @"<attr2></attr2>"
//                                   @"<attr3></attr3>"
//                                   @"<salestage></salestage>"
//                                   @"</GetSFAActivityBasedOnSearchCriteria>"
//                                   @"</SOAP:Body>"
//                                   @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,self.textfrmDate.text,self.textDate.text,searchActivity_list.RESULT_COUNT];
        
        NSString * envelopeText1 =[NSString stringWithFormat:@"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
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
                                   @"<salestage></salestage>"
                                   @"</GetSFAActivityBasedOnSearchCriteria>"
                                   @"</SOAP:Body>"
                                   @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,self.textppl.text,self.textfrmDate.text,self.textDate.text,self.textstatus.text,self.textactivitytype.text,RESULTCOUNT];
        
        
        
        
        ; //please change range make dynamic insted of
        
        search_activitiesresultpage_variables.pplName_ = textppl.text; // use of instance variable is ,which we can use in next class/// for search and pagination purpose
        search_activitiesresultpage_variables.fromDate_ = textfrmDate.text; // use of instance variable is ,which we can use in next class/// for search and pagination purpose
        search_activitiesresultpage_variables.todate_ = textDate.text; // use of instance variable is ,which we can use in next class/// for search and pagination purpose
        search_activitiesresultpage_variables.activityStatus_ = textdse.text; // use of instance variable is ,which we can use in next class/// for search and pagination purpose
        search_activitiesresultpage_variables.activityType_ = textactivitytype.text;// use of instance variable is ,which we can use in next class/// for search and pagination purpose
        
        
        NSLog(@"\n envlopeString Of user details....!!!!%@",envelopeText);
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
        
        [[RequestDelegate alloc]initiateRequest:request name:@"SearchActivities_Connection1"];
        
        // }
    }
}
-(void)searchActivities_Found1:(NSNotification*)notification
{
    [self hideAlert];//Abhishek
    
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n _ActivityType_Found1 response... %@ ",response);
    
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Something gone wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    else{
    
    
    
    
    if (DisplaySearchActivitiesDetailsArray) {
        [DisplaySearchActivitiesDetailsArray removeAllObjects];
    }
    if (appdelegate.ActivityList) {
        [appdelegate.ActivityList removeAllObjects];
    }
      
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    TBXMLElement *container = [TBXML childElementNamed:@"GetSFAActivityBasedOnSearchCriteriaResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    
    
        TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
    
        if(tuple)
        {
           
        
        do {
            TBXMLElement *old =[TBXML childElementNamed:@"old" parentElement:tuple];
            TBXMLElement *TABLE =[TBXML childElementNamed:@"TABLE" parentElement:old];
            searchActivity_list = nil;
            searchActivity_list = [[SearchActivity_List alloc]init];
            
            // TBXMLElement *table  = [TBXML childElementNamed:@"S_OPTY_POSTN" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
            
            TBXMLElement *OPTY_NAME = [TBXML childElementNamed:@"OPPTY_NAME" parentElement:TABLE];
            
            searchActivity_list.OPPTY_NAME = [TBXML textForElement:OPTY_NAME];
            
            
             //NSLog(@"X_PROSPECT_SRC : %@",searchActivity_list.OPTY_NAME);
            
            
            
            
            TBXMLElement *OPPTY_ROWID = [TBXML childElementNamed:@"OPPTY_ROWID" parentElement:TABLE];
            searchActivity_list.OPPTY_ROWID = [TBXML textForElement:OPPTY_ROWID];
               NSLog(@"searchActivity_list.OPTY_ID: %@",searchActivity_list.OPPTY_ROWID);
            
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
             NSLog(@"searchActivity_list.OPTY_ID: %@",[TBXML textForElement:ACTIVITY_ID]);
            
            TBXMLElement *PLANNED_START_DATE = [TBXML childElementNamed:@"ACTIVITY_PLAN_START_DATE" parentElement:TABLE];
            searchActivity_list.ACTIVITY_PLAN_START_DATE = [TBXML textForElement:PLANNED_START_DATE];
            
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
            [appdelegate.ActivityList addObject:searchActivity_list];
            
            
        }
            while ((tuple = tuple->nextSibling));
    }
    [self hideAlert];
    ActivityListViewController* activityListViewController_VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ActivityListViewController"];
    // searchOpportunityResult_VC.optySearchDetails_Comes=SearchOpportunityListArray;
    
    //    activityListViewController_VC. =txtSalesStage.text;
    //    searchOpportunityResult_VC.txtFromDate=txtFromDate.text;
    //    searchOpportunityResult_VC.txtToDate=txtToDate.text;
    
    [self.navigationController pushViewController:activityListViewController_VC animated:YES];
    
    NSLog(@"\n\nshow result...... resultcount....%@",RESULTCOUNT);
    NSLog(@"\n\nappdelegate.ActivityList....%@",[[appdelegate.ActivityList objectAtIndex:0] valueForKey:@"OPPTY_ROWID"]);
    NSLog(@"\n\nappdelegate.ActivityList....%@",[[appdelegate.ActivityList objectAtIndex:1] valueForKey:@"OPPTY_ROWID"]);
     NSLog(@"\n\nappdelegate.ActivityList....%@",[[appdelegate.ActivityList objectAtIndex:2] valueForKey:@"OPPTY_ROWID"]);
     NSLog(@"\n\nappdelegate.ActivityList....%@",[[appdelegate.ActivityList objectAtIndex:3] valueForKey:@"OPPTY_ROWID"]);
    NSLog(@"\n resultcount...... %u ",(unsigned)DisplaySearchActivitiesDetailsArray.count);
    // [appdelegate hideAlert];
    //ActivitiesResult_VC *activitiesResult_VC = [self.storyboard instantiateViewControllerWithIdentifier:@"ActivitiesResult_VC"];
    //[self.navigationController pushViewController:activitiesResult_VC animated:YES];
    }
}


- (IBAction)textactivitytype:(id)sender {
    
    [activityType_PickerArr sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)]; //Abhishek
    
    [self.textactivitytype resignFirstResponder];
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:self
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    for (NSString *title in activityType_PickerArr) {
        [actionSheet addButtonWithTitle:title];
    }
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        [actionSheet showFromRect:[(UITextField *)sender frame] inView:self.firstView animated:YES];
    }
    
    else{
        
        [actionSheet showInView:self.view];
        
    }
    
    actionSheet.tag = 1;
    
    
}




- (IBAction)textstatus:(id)sender {
    
     [self.textstatus resignFirstResponder];
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:self
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    for (NSString *title in activityStatus) {
        [actionSheet addButtonWithTitle:title];
    }
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        [actionSheet showFromRect:[(UITextField *)sender frame] inView:self.secondView animated:YES];
    }
    
    
    else{
        
        [actionSheet showInView:self.view];
        
    }
    
    actionSheet.tag = 4;
    
    
    
    
}



- (IBAction)textdsename:(id)sender {
    
     [self.textactivitytype resignFirstResponder];
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:self
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    for (NSString *title in activityAssignLOB) {
        [actionSheet addButtonWithTitle:title];
    }
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        [actionSheet showFromRect:[(UITextField *)sender frame] inView:self.firstView animated:YES];
    }
    
    
    else{
        
        [actionSheet showInView:self.view];
        
    }
    
    actionSheet.tag = 3;
    
    
    
    
}


- (IBAction)textselecttaluka:(id)sender {
    
    
     [self.textactivitytype resignFirstResponder];
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:self
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    for (NSString *title in activityType_PickerArr) {
        [actionSheet addButtonWithTitle:title];
    }
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        [actionSheet showFromRect:[(UITextField *)sender frame] inView:self.secondView animated:YES];
    }
    
    
    else{
        
        [actionSheet showInView:self.view];
        
    }
    
    actionSheet.tag = 2;
    
    
    
    
}

- (IBAction)textppl:(id)sender {
     [self.textactivitytype resignFirstResponder];
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:self
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    for (NSString *title in activityPPLNamePickerArr) {
        [actionSheet addButtonWithTitle:title];
    }
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        [actionSheet showFromRect:[(UITextField *)sender frame] inView:self.firstView animated:YES];
    }
    
    
    else{
        
        [actionSheet showInView:self.view];
        
    }
    
    actionSheet.tag = 5;

    
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"button click ....%ld",(long)buttonIndex);
    if(textactivitytype){
        NSLog(@"... in");
        switch (popup.tag) {
                NSLog(@"... in");
            case 1:
                if(buttonIndex == actionSheet.cancelButtonIndex)
                {
                    NSLog(@"ek..");
                    return;
                }
                
                else{
                    NSLog(@"Button index %ld",(long)buttonIndex);
                    self.textactivitytype.text = NSLocalizedString([activityType_PickerArr objectAtIndex:buttonIndex],@"");
                }
                
        }
    }
    if(texttaluka){
        switch (popup.tag) {
            case 2:
                if(buttonIndex == actionSheet.cancelButtonIndex)
                {
                    return;
                }else{
                    NSLog(@"Button index %ld",(long)buttonIndex);
                   self.texttaluka.text = NSLocalizedString([activityType_TalArr objectAtIndex:buttonIndex],@"");
                }
                
        }
    }//if
    if(textdse){
        switch (popup.tag) {
            case 3:
                if(buttonIndex == actionSheet.cancelButtonIndex)
                {
                    return;
                }else{
                    NSLog(@"Button index %ld",(long)buttonIndex);
                    textdse.text = NSLocalizedString([activityAssignLOB objectAtIndex:buttonIndex],@"");
                }
                
        }
    }//if
    if(textstatus){
        switch (popup.tag) {
            case 4:
                if(buttonIndex == actionSheet.cancelButtonIndex)
                {
                    return;
                }
                else{
   
                    NSLog(@"Button index %ld",(long)buttonIndex);
                    textstatus.text = NSLocalizedString([activityStatus objectAtIndex:buttonIndex],@"");
                }
                
        }
    }
    if(textppl){
        switch (popup.tag) {
            case 5:
                if(buttonIndex == actionSheet.cancelButtonIndex)
                {return;
                }else{
                    NSLog(@"Button index %ld",(long)buttonIndex);
                    textppl.text = NSLocalizedString([activityPPLNamePickerArr objectAtIndex:buttonIndex],@"");
                }
                
        }
    }//if
    
}

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
  //  return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
  //  return [source count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    //return [source objectAtIndex:row];
}

#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
       // NSLog(@"%@", [source objectAtIndex:row]);
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
