//
//  AnalyticsReportViewController.m
//  DSE
//
//  Created by admin on 20/05/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//


//Abhishek

#import "AnalyticsReportViewController.h"
#import "AnalyticsViewController.h"
#import "LoginViewController.h"
@interface AnalyticsReportViewController ()
{
    NSMutableArray *DSEnames;
    NSString *dateString;
    int fixedYear,numValue;
    long getmonthNumber;
    

}
@end
@implementation AnalyticsReportViewController
@synthesize txtFromDate,txtSelectDSE,txtTODate;
@synthesize _firstView,_SecondView;
@synthesize analyticsYear,analyticsMonth,analyticsSalesStages;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    DSEnames = [NSMutableArray arrayWithObjects:@"PL Wise",@"PPL Wise",nil];
    
     fixedYear=2010;
    analyticsYear=[[NSMutableArray alloc] init];
    analyticsMonth=[[NSMutableArray alloc]initWithObjects:@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December", nil];
    [self currentDate];
    UIButton *btnInfo =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btnInfo setImage:[UIImage imageNamed:@"header_Cicon_3.png"] forState:UIControlStateNormal];
    [btnInfo addTarget:self action:@selector(info_btn) forControlEvents:UIControlEventTouchUpInside];
    [btnInfo setFrame:CGRectMake(-15, -5, 40, 40)];
    
    //    UIButton *btnLogout =  [UIButton buttonWithType:UIButtonTypeCustom];
    //    [btnLogout setImage:[UIImage imageNamed:@"icon_logout.png"] forState:UIControlStateNormal];
    //    [btnLogout addTarget:self action:@selector(logOut_btn) forControlEvents:UIControlEventTouchUpInside];
    //    [btnLogout setFrame:CGRectMake(44, -5, 40, 40)];
     self.searchBTN.layer.cornerRadius=4;
    UIButton *btnLogout =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLogout setImage:[UIImage imageNamed:@"header_Cicon_4.png"] forState:UIControlStateNormal];
    [btnLogout addTarget:self action:@selector(logOut_btn) forControlEvents:UIControlEventTouchUpInside];
    [btnLogout setFrame:CGRectMake(44, -5, 40, 40)];
    
    UIView *rightBarButtonItems = [[UIView alloc] initWithFrame:CGRectMake(10,10,90,40)];
    [rightBarButtonItems addSubview:btnInfo];
    [rightBarButtonItems addSubview:btnLogout];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButtonItems];

    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header_strip1.png"] forBarMetrics:UIBarMetricsDefault];
    for (int i=fixedYear; i<=numValue; i++)
    {
        NSLog(@"Year ..Values. %d",i);
        //[analyticsYear addObject:[NSNumber numberWithInt:i]];
        NSString *strFromInt = [NSString stringWithFormat:@"%d",i];
        [analyticsYear addObject:strFromInt];
        // NSLog(@"YEar..Array... %@",strFromInt);
        
        //NSLog(@"no=%@",[analyticsYear objectAtIndex:i])
    }

   //Abhishek
    self.txtSelectDSE.delegate = self; //Abhishek
    self.txtFromDate.delegate = self; //Abhishek
    self.txtTODate.delegate = self; //Abhishek
    
    

    // Do any additional setup after loading the view.
}





- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField // Abhishek
{
    NSLog(@"\n Testing.....");
    
    if (textField == self.txtSelectDSE) {
        [textField resignFirstResponder];
        return NO;
    }
    else if (textField == self.txtFromDate){
        [textField resignFirstResponder];
        return NO;
    }
    else if (textField == self.txtTODate){
        [textField resignFirstResponder];
        return NO;
    }
    else
    {
        return YES;
    }
    return YES;
}


-(void)info_btn
{
    [self performSegueWithIdentifier:@"infoView" sender:self];
}
-(void)logOut_btn
{
   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DSE"
                                       message:@"Do you want to Log out"
                                      delegate:self
                             cancelButtonTitle:@"No"
                             otherButtonTitles:@"Yes",nil];
    [alert show];
    
    
    NSLog(@"Home biscuit from Sanfrancisco");
}
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

-(void)currentDate
{
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY"];
    dateString = [dateFormatter stringFromDate:currDate];
    NSLog(@"%@",dateString);
    numValue = [dateString intValue];
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
//from dsm
- (IBAction)btnSelectMonth:(id)sender {
    
    NSLog(@"Activity...Data %@",analyticsMonth);
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:self
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    // ObjC Fast Enumeration
    for (NSString *title in analyticsMonth) {
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
//from dsm
- (IBAction)btnSelectYear:(id)sender {
    
    if([self.txtFromDate isEqual:@""])
    {
     //   [self hideAlert];
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@" Please select month " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    
    else{
        NSLog(@"btneventfor year");
        NSLog(@"Activity year ...Data %@",analyticsYear);
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                  delegate:self
                                         cancelButtonTitle:nil
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:nil];
        // ObjC Fast Enumeration
        for (NSString *title in analyticsYear) {
            [actionSheet addButtonWithTitle:title];
        }
        actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
        actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            [actionSheet showFromRect:[(UITextField *)sender frame] inView:self._SecondView animated:YES];
            actionSheet.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
        }
        else{
            [actionSheet showInView:self.view];
        }
        actionSheet.tag = 2;
        
    }}
//from DSM
- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSLog(@"button click ....%ld",(long)buttonIndex);
    if(txtFromDate)
    {
        switch (popup.tag) {
            case 1:
                if(buttonIndex == actionSheet.cancelButtonIndex)
                {
                    NSLog(@"ek..");
                    return;
                }
                else
                {
                    getmonthNumber=buttonIndex;
                    NSLog(@"Button index %ld",(long)buttonIndex);
                    self.txtFromDate.text = NSLocalizedString([analyticsMonth objectAtIndex:buttonIndex],@"");
                    
                }
                
        }
    }
    if(txtTODate)
    {
        switch (popup.tag) {
            case 2:
                if(buttonIndex == actionSheet.cancelButtonIndex)
                {    return;
                }else{
                    NSLog(@"Button index %ld",(long)buttonIndex);
                    txtTODate.text = NSLocalizedString([analyticsYear objectAtIndex:buttonIndex],@"");
                }
                
        }
    }
    if(txtSelectDSE)
    {
                NSLog(@"... in");
                switch (popup.tag)
                {
                        NSLog(@"... in");
                    case 3:
                        if(buttonIndex == actionSheet.cancelButtonIndex)
                        {
                            NSLog(@"ek..");
                            return;
                        }
                        else
                        {
                            NSLog(@"Button index %ld",(long)buttonIndex);
                            self.txtSelectDSE.text = NSLocalizedString([DSEnames objectAtIndex:buttonIndex],@"");
                            
                        }
                        
                }
            }

    
    //if
//    if(_txtSalesStage){
//        switch (popup.tag) {
//            case 3:
//                if(buttonIndex == actionSheet.cancelButtonIndex)
//                {    return;
//                }else{
//                    NSLog(@"Button index %ld",(long)buttonIndex);
//                    _txtSalesStage.text = NSLocalizedString([_analyticsSalesStages objectAtIndex:buttonIndex],@"");
//                }
//                
//                if (buttonIndex==2) {
//                    
//                    
//                    self.txtSelectDSE.hidden=NO;
//                    self.selectdselabel.hidden=NO;
//                    self.btndse.hidden=NO;
//                    
//                    self.textyear.hidden=NO;
//                    self.labelselectyear.hidden=NO;
//                    self.btnyear.hidden=NO;
//                    
//                    self.txtSelectMonth.hidden=NO;
//                    self.labelselectmonth.hidden=NO;
//                    self.btnmonth.hidden=NO;
//                    
//                    self.txtSelectDSE.text = @"";
//                    self.txtSelectMonth.text=@"";
//                    self.txtSelectYear.text=@"";
//                    
//                    
//                    
//                }
//                else if (buttonIndex==1)
//                {
//                    self.txtSelectDSE.hidden=YES;
//                    self.selectdselabel.hidden=YES;
//                    self.btndse.hidden=YES;
//                    
//                    
//                    self.textyear.hidden=NO;
//                    self.labelselectyear.hidden=NO;
//                    self.btnyear.hidden=NO;
//                    
//                    self.txtSelectMonth.hidden=NO;
//                    self.labelselectmonth.hidden=NO;
//                    self.btnmonth.hidden=NO;
//                    
//                    
//                    
//                }
//                else
//                {
//                    self.txtSelectDSE.hidden=YES;
//                    self.selectdselabel.hidden=YES;
//                    self.btndse.hidden=YES;
//                    
//                    
//                    self.textyear.hidden=YES;
//                    self.labelselectyear.hidden=YES;
//                    self.btnyear.hidden=YES;
//                    
//                    self.txtSelectMonth.hidden=YES;
//                    self.labelselectmonth.hidden=YES;
//                    self.btnmonth.hidden=YES;
//                    
//                    
//                    
//                }
//        }//if
//    }
    
//    if(_txtSelectDSE){
//        switch (popup.tag) {
//            case 4:
//                if(buttonIndex == actionSheet.cancelButtonIndex)
//                {    return;
//                }else{
//                    NSLog(@"Button index %ld",(long)buttonIndex);
//                    _txtSelectDSE.text = NSLocalizedString([dselistarray objectAtIndex:buttonIndex],@"");
//                    passid=[dseidarray objectAtIndex:buttonIndex];
//                    NSLog(@"pass id %@",passid);
//                }
//        }
//    }//}
    
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
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"dd-MMM-yyyy"];
//    NSString *stringFromDate = [formatter stringFromDate:sender.date];
//    NSLog(@"Date..Set  From : : %@",stringFromDate);
//    txtFromDate.text=stringFromDate;
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


- (IBAction)btnSelectDSE:(id)sender {
    
    NSLog(@"Activity...Data %@",DSEnames);
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:self
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    // ObjC Fast Enumeration
    for (NSString *title in DSEnames) {
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
    actionSheet.tag = 3;
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
    
    [datePicker addTarget:self action:@selector(changeDate_:) forControlEvents:UIControlEventValueChanged];
//    [datePicker addTarget:self action:@selector(changeDate_:) forControlEvents:UIControlEventEditingDidBegin];

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
- (void)changeDate_:(UIDatePicker *)sender {
    NSLog(@"New Date: %@", sender.date);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MMM-yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:sender.date];
    NSLog(@"Date..Set  To: : %@",stringFromDate);
    txtTODate.text=stringFromDate;
    
    
}
//- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
//    
//    NSLog(@"button click ....%ld",(long)buttonIndex);
//    if(txtSelectDSE){
//        NSLog(@"... in");
//        switch (popup.tag) {
//                NSLog(@"... in");
//            case 1:
//                if(buttonIndex == actionSheet.cancelButtonIndex)
//                {
//                    NSLog(@"ek..");
//                    return;
//                }else{
//                    NSLog(@"Button index %ld",(long)buttonIndex);
//                    self.txtSelectDSE.text = NSLocalizedString([DSEnames objectAtIndex:buttonIndex],@"");
//                    
//                }
//                
//        }
//    }
//}

//- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
//    
//    NSLog(@"button click ....%ld",(long)buttonIndex);
//    if(txtSelectMonth){
//        switch (popup.tag) {
//            case 1:
//                if(buttonIndex == actionSheet.cancelButtonIndex)
//                {
//                    NSLog(@"ek..");
//                    return;
//                }else{
//                    NSLog(@"Button index %ld",(long)buttonIndex);
//                    getmonthNumber=buttonIndex;
//                    NSLog(@"Button index %ld",getmonthNumber);
//                    self.txtSelectMonth.text = NSLocalizedString([analyticsMonth objectAtIndex:buttonIndex],@"");
//                    
//                }
//                
//        }
//    }
//    if(txtSelectYear){
//        switch (popup.tag) {
//            case 2:
//                if(buttonIndex == actionSheet.cancelButtonIndex)
//                {    return;
//                }else{
//                    NSLog(@"Button index %ld",(long)buttonIndex);
//                    txtSelectYear.text = NSLocalizedString([analyticsYear objectAtIndex:buttonIndex],@"");
//                }
//                
//        }
//    }//if
//    if(txtSalesStage){
//        switch (popup.tag) {
//            case 3:
//                if(buttonIndex == actionSheet.cancelButtonIndex)
//                {    return;
//                }else{
//                    NSLog(@"Button index %ld",(long)buttonIndex);
//                    txtSalesStage.text = NSLocalizedString([analyticsSalesStages objectAtIndex:buttonIndex],@"");
//                }
//        }
//    }//if
//}

- (IBAction)SearchBtn:(id)sender
{
    if(txtFromDate.text && txtTODate.text.length && txtSelectDSE.text.length > 0)
    {
        
 [self performSegueWithIdentifier:@"searchPass" sender:nil];
    }
    else{
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Please select Fields " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        
    }

   
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if(txtFromDate.text && txtTODate.text.length && txtSelectDSE.text.length> 0)
//    {
    
        
        
        if ([segue.identifier isEqualToString:@"searchPass"]) {
            NSLog(@"in....");
            
            NSLog(@". %@ %@ %@",txtFromDate.text,txtSelectDSE.text,txtTODate.text);
            NSString *s,*S1,*s2;
            // NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            s=txtFromDate.text;
            S1=txtSelectDSE.text;
            s2=txtTODate.text;
            AnalyticsViewController *destViewController = segue.destinationViewController;
            destViewController.passFromdate=s;
            destViewController.passDSE=S1;
            destViewController.passTodate=s2;
            
            destViewController.passMonth=s;
            destViewController.passYear=s2;
            destViewController.PassSalesStages=S1;
            destViewController.getmonthNo=getmonthNumber;
        }
//        
//    }
//    else{
//        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Please select Fields " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alertView show];
//        
//    }

    }
@end
