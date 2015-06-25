

#import "AnalyticsViewController.h"

#import "DetailViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Analyticstableviewcell.h"
#import "AnalyticsProductTableViewCell.h"
#import "analytics_list.h"
#import "RequestDelegate.h"
#import "TBXML.h"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


@interface AnalyticsViewController ()
{
    UIAlertView *alert;
    NSMutableArray *ProductName;
    int sum,sum1,sum1A,sum2,sum3;
    float prcntsum,prcntsum1,prcntsum1A,prcntsum2,prcntsum3,total;
    NSDateFormatter *df,*df1,*df2;
    int getmonth;
    NSString *_strFromDate,*_strTodate;
      NSMutableArray * C3StageValue,*Date_Arr;
     NSString *dateString,*dateString1,*dayString,*Monthdate;
     NSDate *sevenDaysAgo;
    NSString *values;
    NSRange range;
    int flag,flag_1;
     NSArray *listValues;
}
@end

@implementation AnalyticsViewController


@synthesize Piechartanalytics = _pieChart;


@synthesize selectedSliceLabel = _selectedSlice;
@synthesize numOfSlices = _numOfSlices;
@synthesize indexOfSlices = _indexOfSlices;
@synthesize downArrow = _downArrow;
@synthesize slices = _slices;
@synthesize sliceColors = _sliceColors;
@synthesize passDSE,passFromdate,passTodate;
@synthesize percentageLabel = _percentageLabel;
@synthesize passdseid;
@synthesize c0sum,c2sum,c1sum,c1Asum,c3sum;
@synthesize getmonthNo;

@synthesize passMonth,passYear,PassSalesStages;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Data Comes :%@ %@ --> %@",passFromdate,passTodate,passDSE);
    // Do any additional setup after loading the view.
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];//AppDelegate instance
    userDetailsVal_ = [UserDetails_Var sharedmanager]; //usedetails instance
    analyticsdisplayarray=[[NSMutableArray alloc] init];
    ProductName =[[NSMutableArray alloc] init];
     Date_Arr=[[NSMutableArray alloc] init];
    
    c0sum =[[NSMutableArray alloc] init];
    c1sum =[[NSMutableArray alloc] init];
    c1Asum =[[NSMutableArray alloc] init];
    c2sum =[[NSMutableArray alloc] init];
    c3sum =[[NSMutableArray alloc] init];
    
    if (self.productable == nil) {
        self.productable = [[ProductTableviewController alloc] init];
    }
    if (self.reportTable == nil) {
        self.reportTable = [[ReportTableViewController alloc] init];
    }
    
    [self.AnalyticsTableview setDataSource:self.productable];
    [self.AnalyticsTableview  setDelegate:self.productable];
    self.productable.view = self.productable.tableView;
    
    //  [self.tblview setDataSource:self.reportTable];
    //  [self.tblview  setDelegate:self.reportTable];
    //   self.reportTable.view = self.reportTable.tableView;
    
    
    self.view.layer.borderColor =  [UIColor colorWithRed:(4/255.0) green:(41/255.0) blue:(82/255.0) alpha:1].CGColor;
    self.view.layer.borderWidth = 3.0f;
    
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
    
    
    
    //self.slices = [NSMutableArray arrayWithCapacity:10];
    
    //NSNumber * blah = [NSNumber numberWithInt:50];
    //_slices= [NSMutableArray arrayWithObjects: blah, blah,blah,blah,blah,blah,blah,blah,blah,blah, nil];
    
    
    
    //    for(int i = 0; i < 5; i ++)
    //    {
    //        NSNumber * blah = [NSNumber numberWithInt:i];
    //        NSArray * items = [NSArray arrayWithObjects: blah, blah, nil];
    //
    //        NSNumber *one = [NSNumber numberWithInt:rand()%60+0];
    //        [_slices addObject:one];
    //    }
    //    [self.pieChartLeft setFrame:CGRectMake(-20,0, 100, 100)];
    [self.Piechartanalytics setDataSource:self];
    [self.Piechartanalytics setStartPieAngle:M_PI_2];
    [self.Piechartanalytics setAnimationSpeed:1.0];
    [self.Piechartanalytics setLabelFont:[UIFont fontWithName:@"DBLCDTempBlack" size:24]];
    // [self.pieChartLeft setLabelRadius:160];
    [self.Piechartanalytics setShowPercentage:YES];
    //[self.pieChartLeft setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
//    [self.Piechartanalytics setPieBackgroundColor:[UIColor blackColor]];
     [self.Piechartanalytics setPieBackgroundColor:[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1]];
    // [self.Piechartanalytics setPieBackgroundColor:[UIColor whiteColor]];
    [self.Piechartanalytics setPieCenter:CGPointMake(120, 110)];
    [self.Piechartanalytics setUserInteractionEnabled:YES];
//    [self.Piechartanalytics setLabelShadowColor:[UIColor blackColor]];
   // [self.Piechartanalytics setPieBackgroundColor:[UIColor whiteColor]];
     [self.Piechartanalytics setPieBackgroundColor:[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1]];
    [self.Piechartanalytics setLabelRadius:0];
    
    [[self.percentageLabel layer] setCornerRadius:61.0f];
    [[self.percentageLabel layer] setMasksToBounds:YES];
    
    
    
//    self.sliceColors =[NSArray arrayWithObjects:
//                       [UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
//                       [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
//                       [UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],
//                       [UIColor colorWithRed:229/255.0 green:66/255.0 blue:115/255.0 alpha:1],
//                       [UIColor colorWithRed:148/255.0 green:141/255.0 blue:139/255.0 alpha:1],nil];
    
    self.sliceColors =[NSArray arrayWithObjects:
                       [UIColor colorWithRed:255/255.0 green:245/255.0 blue:124/255.0 alpha:1],
                       [UIColor colorWithRed:156/255.0 green:255/255.0 blue:162/255.0 alpha:1],
                       [UIColor colorWithRed:90/255.0 green:225/255.0 blue:225/255.0 alpha:1],
                       [UIColor colorWithRed:255/255.0 green:159/255.0 blue:160/255.0 alpha:1],
                       [UIColor colorWithRed:252/255.0 green:188/255.0 blue:99/255.0 alpha:1],nil];
    
    self.downArrow.transform = CGAffineTransformMakeRotation(M_PI);
    
    
    
    
    
    
    
    
    [self.view bringSubviewToFront:self.tblview];
    
    
    //self.tblview.delegate=self;
    // self.AnalyticsTableview.delegate=self;
    
    
    
    self.Piechartanalytics.delegate=self;
    
    
    
    self.tblview.separatorColor = [UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1];
    
    
    self.AnalyticsTableview.separatorColor = [UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1];
    
    
    if (SYSTEM_VERSION_LESS_THAN(@"8.0"))
    {
        UILabel *timelabel3=[[UILabel alloc]initWithFrame:CGRectMake(30, 450, 120, 21)];
        timelabel3.backgroundColor=[UIColor clearColor];
        timelabel3.text=@"PRODUCT NAME";
        timelabel3.font=[UIFont boldSystemFontOfSize:14];
        timelabel3.textColor=[UIColor whiteColor];
       // timelabel3.textColor=[UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1];
        
        [self.view addSubview:timelabel3];
        
        UILabel *timelabel1=[[UILabel alloc]initWithFrame:CGRectMake(220, 450, 66, 21)];
        timelabel1.backgroundColor=[UIColor clearColor];
        timelabel1.text=@"C0";
        timelabel1.font=[UIFont boldSystemFontOfSize:14];
        timelabel1.textColor=[UIColor whiteColor];
        [self.view addSubview:timelabel1];
        
        UILabel *timelabel2=[[UILabel alloc]initWithFrame:CGRectMake(320, 450, 66, 21)];
        timelabel2.backgroundColor=[UIColor clearColor];
        timelabel2.text=@"C1";
        timelabel2.font=[UIFont boldSystemFontOfSize:14];
        timelabel2.textColor=[UIColor whiteColor];
        [self.view addSubview:timelabel2];
        
        UILabel *timelabel=[[UILabel alloc]initWithFrame:CGRectMake(415, 450, 66, 21)];
        timelabel.backgroundColor=[UIColor clearColor];
        timelabel.text=@"C1A";
        timelabel.font=[UIFont boldSystemFontOfSize:14];
        timelabel.textColor=[UIColor whiteColor];
        [self.view addSubview:timelabel];
        
        
        UILabel *timelabel4=[[UILabel alloc]initWithFrame:CGRectMake(512, 450, 66, 21)];
        timelabel4.backgroundColor=[UIColor clearColor];
        timelabel4.text=@"C2";
        timelabel4.font=[UIFont boldSystemFontOfSize:14];
        timelabel4.textColor=[UIColor whiteColor];
        
        [self.view addSubview:timelabel4];
        
        UILabel *timelabel5=[[UILabel alloc]initWithFrame:CGRectMake(613, 450, 66, 21)];
        timelabel5.backgroundColor=[UIColor clearColor];
        timelabel5.text=@"C3";
        timelabel5.font=[UIFont boldSystemFontOfSize:14];
        timelabel5.textColor=[UIColor whiteColor];
        
        [self.view addSubview:timelabel5];
        
        
        [self.view bringSubviewToFront:timelabel];
        [self.view bringSubviewToFront:timelabel1];
        [self.view bringSubviewToFront:timelabel2];
        [self.view bringSubviewToFront:timelabel3];
        [self.view bringSubviewToFront:timelabel4];
        [self.view bringSubviewToFront:timelabel5];
        
        
    }
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        UILabel *timelabel3=[[UILabel alloc]initWithFrame:CGRectMake(40, 450, 120, 21)];
        timelabel3.backgroundColor=[UIColor clearColor];
        timelabel3.text=@"PRODUCT NAME";
        timelabel3.font=[UIFont boldSystemFontOfSize:14];
        timelabel3.textColor=[UIColor blackColor];
        //timelabel3.textColor=[UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1];
        [self.view addSubview:timelabel3];
        
        UILabel *timelabel1=[[UILabel alloc]initWithFrame:CGRectMake(230, 450, 66, 21)];
        timelabel1.backgroundColor=[UIColor clearColor];
        timelabel1.text=@"C0";
        timelabel1.font=[UIFont boldSystemFontOfSize:14];
        timelabel1.textColor=[UIColor blackColor];
        [self.view addSubview:timelabel1];
        
        UILabel *timelabel2=[[UILabel alloc]initWithFrame:CGRectMake(330, 450, 66, 21)];
        timelabel2.backgroundColor=[UIColor clearColor];
        timelabel2.text=@"C1";
        timelabel2.font=[UIFont boldSystemFontOfSize:14];
        timelabel2.textColor=[UIColor blackColor];
        [self.view addSubview:timelabel2];
        
        UILabel *timelabel=[[UILabel alloc]initWithFrame:CGRectMake(425, 450, 66, 21)];
        timelabel.backgroundColor=[UIColor clearColor];
        timelabel.text=@"C1A";
        timelabel.font=[UIFont boldSystemFontOfSize:14];
        timelabel.textColor=[UIColor blackColor];
        [self.view addSubview:timelabel];
        
        
        UILabel *timelabel4=[[UILabel alloc]initWithFrame:CGRectMake(522, 450, 66, 21)];
        timelabel4.backgroundColor=[UIColor clearColor];
        timelabel4.text=@"C2";
        timelabel4.font=[UIFont boldSystemFontOfSize:14];
        timelabel4.textColor=[UIColor blackColor];
        
        [self.view addSubview:timelabel4];
        
        UILabel *timelabel5=[[UILabel alloc]initWithFrame:CGRectMake(623, 450, 66, 21)];
        timelabel5.backgroundColor=[UIColor clearColor];
        timelabel5.text=@"C3";
        timelabel5.font=[UIFont boldSystemFontOfSize:14];
        timelabel5.textColor=[UIColor blackColor];
        
        [self.view addSubview:timelabel5];
        
        
        [self.view bringSubviewToFront:timelabel];
        [self.view bringSubviewToFront:timelabel1];
        [self.view bringSubviewToFront:timelabel2];
        [self.view bringSubviewToFront:timelabel3];
        [self.view bringSubviewToFront:timelabel4];
        [self.view bringSubviewToFront:timelabel5];
        
    }
    
    self.TitleView.layer.borderWidth=2.0f;
    self.TitleView.layer.borderColor=[UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    self.TitleView.layer.borderColor=[UIColor colorWithRed:(218/255.0) green:(218/255.0) blue:(218/255.0) alpha:1].CGColor;

    
    //    self.tblview.layer.borderWidth=2.0f;
    //    self.tblview.layer.borderColor=[UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    
    self.view.layer.borderColor =  [UIColor colorWithRed:(4/255.0) green:(41/255.0) blue:(82/255.0) alpha:1].CGColor;
    self.view.layer.borderWidth = 3.0f;
    
    
    self.AnalyticsTableview.layer.borderWidth=2.0f;
//    self.AnalyticsTableview.layer.borderColor=[UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    self.AnalyticsTableview.layer.borderColor=[UIColor colorWithRed:(218/255.0) green:(218/255.0) blue:(218/255.0) alpha:1].CGColor;

    
    self.tblview.layer.borderWidth=2.0f;
//    self.tblview.layer.borderColor=[UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    
    self.tblview.layer.borderColor=[UIColor colorWithRed:(218/255.0) green:(218/255.0) blue:(218/255.0) alpha:1].CGColor;
    
    
    self.DoughnutView.layer.borderWidth=2.0f;
//    self.DoughnutView.layer.borderColor=[UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    self.DoughnutView.layer.borderColor=[UIColor colorWithRed:(218/255.0) green:(218/255.0) blue:(218/255.0) alpha:1].CGColor;
    
    self.SalesStageTotalView.layer.borderWidth=2.0f;
//    self.SalesStageTotalView.layer.borderColor=[UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    self.SalesStageTotalView.layer.borderColor=[UIColor colorWithRed:(218/255.0) green:(218/255.0) blue:(218/255.0) alpha:1].CGColor;
    
    self.AnalyticsTableview.separatorInset = UIEdgeInsetsZero;
    
    NSDate *date = [NSDate date]; //I'm using this just to show the this is how you convert a date
    df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMM"];
    dateString= [df stringFromDate:date];
    NSLog(@"Date Final Month :%@",dateString);
    
    [df setDateFormat:@"dd"];
    dayString=[df stringFromDate:date];
    NSLog(@"Date Final Month :%@",dayString);
    
    //[dateformate setDateFormat:@"dd-MMM-yy"];
    df1= [[NSDateFormatter alloc] init];
    [df1 setDateFormat:@"dd-MMM-yy"];
    dateString1 = [df1 stringFromDate:date];
    NSLog(@"Date Final Month :%@",dateString1);
    //NSString *s=passMonth;
    passMonth=[passMonth substringToIndex:3];
    //NSString *ss=[passYear substringToIndex:MAX((int)[passYear length]-2,2)];
    passYear=[passYear substringFromIndex:[passYear length] - 4];
    
    //[state substringFromIndex: MAX([state length] - 2, 0)]
    NSLog(@"Pass Month of Sub and Year  :%@-->%@",passMonth,passYear);
    
    if([dateString isEqual:passMonth])
    {
        NSLog(@"Current Month Selected  and todays Date: %@",dayString);
        
        getmonth=[dayString intValue];
        int getactualmonth=getmonth-1;
        NSLog(@"Values of get month : %d",getactualmonth);
        sevenDaysAgo = [date dateByAddingTimeInterval:-getactualmonth*24*60*60];
        NSLog(@"30 days ago: %@", sevenDaysAgo);
        df2= [[NSDateFormatter alloc] init];
        [df2 setDateFormat:@"dd-MMM-yy"];
        Monthdate=[df2 stringFromDate:sevenDaysAgo];
        NSLog(@"Month Date : %@",Monthdate);
        
        
        values = @"";
        NSInteger i = 0;
        for(i = 0; i < getmonth ; i++)
        {
            NSDate *newDate1 = [sevenDaysAgo addTimeInterval:60*60*24*i];
            NSLog(@"Quick: %@", newDate1);
            [df2 setDateFormat:@"d-MMM-yy"];
            Monthdate=[df2 stringFromDate:newDate1];
            NSLog(@"Month Date : %@",Monthdate);
            
            values = [values stringByAppendingString:@"'"];
            values = [values stringByAppendingString:Monthdate];
            values = [values stringByAppendingString:@"'"];
            
            if(i != getmonth-1)
            {
                values = [values stringByAppendingString:@","];
            }
            [Date_Arr addObject:Monthdate];
        }
        if([Date_Arr count]>0){
            
            NSLog(@"String data: %@",Date_Arr[0]);
            _strFromDate=[Date_Arr objectAtIndex:0];
            _strTodate=[Date_Arr objectAtIndex:[Date_Arr count]-1];
            
            passFromdate=[Date_Arr objectAtIndex:0];
            passTodate=[Date_Arr objectAtIndex:[Date_Arr count]-1];
            NSLog(@"Array Last position :%@",Date_Arr[[Date_Arr count]-1]);
            
            NSLog(@"Date Array :%lu",(unsigned long)[Date_Arr count]);
            
            NSLog(@"Array Last position :%@",Date_Arr[[Date_Arr count]-1]);
            NSLog(@"Date Array :%lu",(unsigned long)[Date_Arr count]);
        }
        else
        {
            NSLog(@"No data ");
        }
    }
    else
    {
        flag_1=1;
        values = @"";
        NSLog(@"Other than current month");
        
        NSCalendar* cal = [NSCalendar currentCalendar];
        NSDateComponents* comps = [[NSDateComponents alloc] init];
        
        // Set your month here
        [comps setMonth:getmonthNo+1];
        
        range = [cal rangeOfUnit:NSCalendarUnitDay
                          inUnit:NSCalendarUnitMonth
                         forDate:[cal dateFromComponents:comps]];
        NSLog(@"Date : %d", range.length);
        NSInteger i = 1;
        NSString *values_1=@"";
        NSLog(@"Range :%lu",(unsigned long)range.length);
        getmonth=range.length;
        for( i = 01; i <=range.length; i++)
        {
            NSLog(@"Loooop...");
            values = [values stringByAppendingString:@"'"];
            values = [values stringByAppendingString:[NSString stringWithFormat:@"%d",i]];
            values = [values stringByAppendingString:@"-"];
            values = [values stringByAppendingString:passMonth];
            values = [values stringByAppendingString:@"-"];
            values = [values stringByAppendingString:passYear];
            values = [values stringByAppendingString:@"'"];
            
            // values_1 = [values_1 stringByAppendingString:@"'"];
            values_1 = [values_1 stringByAppendingString:[NSString stringWithFormat:@"%d",i]];
            values_1 = [values_1 stringByAppendingString:@"-"];
            values_1 = [values_1 stringByAppendingString:passMonth];
            values_1 = [values_1 stringByAppendingString:@"-"];
            values_1 = [values_1 stringByAppendingString:passYear];
            //values_1 = [values_1 stringByAppendingString:@"'"];
            
            //NSString *s=values_1;
            
            if(i != range.length)
            {
                values = [values stringByAppendingString:@","];
                values_1 = [values_1 stringByAppendingString:@","];
                
            }
        }
        NSLog(@"String : %@",values);
        NSLog(@"String :%@",values_1);
        
        for (int k=0; k<range.length; k++) {
            listValues =[values_1 componentsSeparatedByString:@","];
        }
        if([listValues count]>0){
            NSLog(@"Array position :%@",listValues[0]);
            NSLog(@"Date Array :%@",listValues);
            _strFromDate=[listValues objectAtIndex:0];
            _strTodate=[listValues objectAtIndex:[listValues count]-1];
            NSLog(@"Date Array :%lu",(unsigned long)[listValues count]);
            NSLog(@"Array Last position :%@",listValues[[listValues count]-1]);
        }else
        {
            NSLog(@"No data");
        }
        
    }



    if([passDSE isEqual:@"PL Wise"]){
        
        NSLog(@"...TGM Product %lu",(unsigned long)passDSE.length);
        [self selectePLwise];
        
        
    }
    else if ([passDSE isEqual:@"PPL Wise"]){
        
        //  NSLog(@"TGM SaleStage");
        [self selectePPLwise];
        
    }
}//GetPL_Analytics_Found

-(void)viewWillAppear:(BOOL)animated{
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(GetPL_Analytics_Found:) name:@"GetPL_Analytics_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(GetPPL_Analytics_Found:) name:@"GetPPL_Analytics_Found" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getdsewisereport_found:) name:@"getdsewisereport_found" object:nil];
    
    
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

-(void)viewWillDisappear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"GetPL_Analytics_Found" object:nil];//Gomzy // for Search Opportunities failed
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"GetPPL_Analytics_Found" object:nil];//Gomzy // for Search Opportunities failed
    
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"getdsewisereport_found" object:nil];
    
}

-(void)selectePLwise{
    
    NSString * envelopeText = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<GetSFAAnalyticsPLDtlsByPosition xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                               @"<posID>%@</posID>"
                               @"<fromDate>%@</fromDate>"
                               @"<toDate>%@</toDate>"
                               @"</GetSFAAnalyticsPLDtlsByPosition>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,_strFromDate,_strTodate];
    
    NSLog(@"\n envlopeString Of Assign TO....!!!!%@",envelopeText);
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@",theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    
    NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"getselectedPL_Connection"];
    
}
-(void)GetPL_Analytics_Found:(NSNotification*)notification
{
    
    
    
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\n opportuntyCount response..... %@ ",response);
    
    
    
    NSLog(@"\n opportuntyCount response..... %@ ",response);
    if ([response isEqual:@""])
    {
        //  [self hideAlert];
        NSLog(@"Nko re..");
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Nothing in Response !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        //[self hideAlert];
        NSLog(@"Dishkyauuu");
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Network Fault String!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    else
    {
        
        if (analyticsdisplayarray)
        {
            [ analyticsdisplayarray removeAllObjects];
            
        }
        
        analytics = nil;
        analytics = [[analytics_list alloc]init];
        
        //  [self hideAlert];
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement *container = [TBXML childElementNamed:@"GetSFAAnalyticsPLDtlsByPositionResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple)
        {
            
            
            
            do {
                analytics = nil;
                analytics = [[analytics_list alloc]init];
                
                TBXMLElement *S_PROD_LN  = [TBXML childElementNamed:@"TABLE" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                
                TBXMLElement *DSEPL = [TBXML childElementNamed:@"PL" parentElement:S_PROD_LN];
                analytics.PL = [TBXML textForElement:DSEPL];
                NSLog(@"Product : %@",analytics.PL);
                
                [ProductName addObject:analytics.PL];
                
                
                TBXMLElement *DSEalias = [TBXML childElementNamed:@"alias" parentElement:S_PROD_LN];
                analytics.alias = [TBXML textForElement:DSEalias];
                NSLog(@"Product : %@",analytics.alias);
                [c0sum addObject:analytics.alias];
                
                
                
                TBXMLElement *DSEalias1 = [TBXML childElementNamed:@"alias1" parentElement:S_PROD_LN];
                analytics.alias1 = [TBXML textForElement:DSEalias1];
                NSLog(@"Product : %@",analytics.alias1);
                [c1sum addObject:analytics.alias1];
                
                
                TBXMLElement *DSEalias2 = [TBXML childElementNamed:@"alias2" parentElement:S_PROD_LN];
                analytics.alias2 = [TBXML textForElement:DSEalias2];
                //[c0sum addObject:analytics.alias];
                [c1Asum addObject:analytics.alias2];
                
                
                
                TBXMLElement *DSEalias3 = [TBXML childElementNamed:@"alias3" parentElement:S_PROD_LN];
                analytics.alias3 = [TBXML textForElement:DSEalias3];
                [c2sum addObject:analytics.alias3];
                
                
                
                
                
                TBXMLElement *DSEalias4 = [TBXML childElementNamed:@"alias4" parentElement:S_PROD_LN];
                analytics.alias4 = [TBXML textForElement:DSEalias4];
                [c3sum addObject:analytics.alias4];
                
                
                [analyticsdisplayarray addObject:analytics];
                
                
            } while ((tuple = tuple->nextSibling));
            NSLog(@"\nOpportunityListDisplayArr......%d",[analyticsdisplayarray count]);
            
            
            if ((analyticsdisplayarray.count) > 0){
                
                [self.tblview reloadData];
                NSLog(@"In....");
                
                if (analyticsdisplayarray.count==c0sum.count) {
                    
                    sum=0;
                    for (NSNumber *num in c0sum)
                    {
                        sum += [num intValue];
                        NSLog(@"..%d",sum);
                        
                        //                    NSString *strFromInt = [NSString stringWithFormat:@"%d",sum];
                        //                    _c0sumlabel.text=strFromInt;            }
                    }
                    NSLog(@" C0..%d",sum);
                    
                    sum1=0;
                    for(NSNumber *num1 in c1sum){
                        
                        sum1 += [num1 intValue];
                        NSLog(@"c1 %d",sum1);
                        
                        //   NSString *strFromInt = [NSString stringWithFormat:@"%d",sum];
                        // _c0sumlabel.text=strFromInt;
                    }
                    NSLog(@"c1 %d",sum1);
                    for(NSNumber *num2 in c1Asum){
                        
                        sum1A += [num2 intValue];
                        NSLog(@"c1A %d",sum1A);
                        
                        //   NSString *strFromInt = [NSString stringWithFormat:@"%d",sum];
                        // _c0sumlabel.text=strFromInt;
                    }
                    NSLog(@"c1A %d",sum1A);
                    for(NSNumber *num3 in c2sum){
                        
                        sum2 += [num3 intValue];
                        NSLog(@"c1 %d",sum2);
                        
                        //   NSString *strFromInt = [NSString stringWithFormat:@"%d",sum];
                        // _c0sumlabel.text=strFromInt;
                    }
                    NSLog(@"c2 %d",sum2);
                    for(NSNumber *num4 in c3sum){
                        
                        sum3 += [num4 intValue];
                        NSLog(@"c1 %d",sum3);
                        
                        //   NSString *strFromInt = [NSString stringWithFormat:@"%d",sum];
                        // _c0sumlabel.text=strFromInt;
                    }
                    NSLog(@"c3 %d",sum3);
                    
                }
            }
            
            total =0;
            
            _C0Total.text=[NSString stringWithFormat:@"%d",sum];
            _C1Total.text=[NSString stringWithFormat:@"%d",sum1];
            
            _C1ATotal.text=[NSString stringWithFormat:@"%d",sum1A];
            
            _C2Total.text=[NSString stringWithFormat:@"%d",sum2];
            
            _C3Total.text=[NSString stringWithFormat:@"%d",sum3];
            
            total=sum+sum1+sum1A+sum2+sum3;
            NSLog(@"total %f",total);
            
            NSString *strngfrmfloat =[NSString stringWithFormat:@"%d",(int)total];
            _percentageLabel.text=strngfrmfloat;
            
            
            prcntsum =0;
            float devidesum=0;
            
            devidesum = (float)sum/total;
            NSLog(@".... %f",devidesum);
            
            prcntsum=devidesum*100.0f;
            
            NSLog(@"percent calculation sum0 %f",prcntsum);
            
            
            prcntsum1 =0;
            float devidesum1=0;
            
            devidesum1 = (float)sum1/total;
            NSLog(@".... %f",devidesum1);
            
            prcntsum1=devidesum1*100.0f;
            NSLog(@"percent calculation sum1 %f",prcntsum1);
            
            prcntsum1A =0;
            float devidesum2=0;
            
            devidesum2 = (float)sum1A/total;
            NSLog(@".... %f",devidesum2);
            
            prcntsum1A=devidesum2*100.0f;
            NSLog(@"percent calculation sum1A %f",prcntsum1A);
            
            prcntsum2 =0;
            float devidesum3=0;
            
            devidesum3 = (float)sum2/total;
            NSLog(@".... %f",devidesum3);
            
            prcntsum2=devidesum3*100.0f;
            NSLog(@"percent calculation sum1A %f",prcntsum2);
            
            
            prcntsum3 =0;
            float devidesum4=0;
            
            devidesum4 = (float)sum3/total;
            NSLog(@".... %f",devidesum4);
            
            NSLog(@"percent calculation sum1A %f",prcntsum3);
            
            prcntsum3=devidesum4*100.0f;
            NSLog(@"In....");
            [self.tblview  reloadData];
            NSLog(@"Product Name : %@",ProductName);
            
            self.slices = [NSMutableArray arrayWithCapacity:5];
            
            NSNumber * c0count =[NSNumber numberWithFloat:prcntsum];
            NSNumber * c1count = [NSNumber numberWithFloat:prcntsum1];
            NSNumber * c1Acount =[NSNumber numberWithFloat:prcntsum1A];
            NSNumber * c2count = [NSNumber numberWithFloat:prcntsum2];
            NSNumber * c3count = [NSNumber numberWithFloat:prcntsum3];
            
            _slices= [NSMutableArray arrayWithObjects: c0count,c1count,c1Acount,c2count,c3count ,nil];
            [self viewDidAppear:YES];
            
            //[self hideAlert];
            
        }
        NSLog(@" \n\n activityPPLNamePickerArr....!!! %lu ",(unsigned long)[analyticsdisplayarray count]);
    }
}
-(void)selectePPLwise{
    
    NSString * envelopeText = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<GetSFAAnalyticsPPLDtlsByPosition xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                               @"<posID>%@</posID>"
                               @"<fromDate>%@</fromDate>"
                               @"<toDate>%@</toDate>"
                               @"</GetSFAAnalyticsPPLDtlsByPosition>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",userDetailsVal_.ROW_ID,_strFromDate,_strTodate];
    
    NSLog(@"\n envlopeString Of Assign TO....!!!!%@",envelopeText);
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@",theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    
    NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"getselectedPPL_Connection"];
    
}
-(void)GetPPL_Analytics_Found:(NSNotification*)notification
{
    
    
    
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    
    
    NSLog(@"\n opportuntyCount response..... %@ ",response);
    if ([response isEqual:@""])
    {
        //  [self hideAlert];
        NSLog(@"Nko re..");
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Nothing in Response !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        //[self hideAlert];
        NSLog(@"Dishkyauuu");
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Network Fault String!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    else
    {
        
        if (analyticsdisplayarray)
        {
            [ analyticsdisplayarray removeAllObjects];
            
        }
        
        
        
        //  [self hideAlert];
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement *container = [TBXML childElementNamed:@"GetSFAAnalyticsPPLDtlsByPositionResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple)
        {
            
            
            do {
                
                analytics = nil;
                analytics = [[analytics_list alloc]init];
                NSLog(@"xxxxx");
                
                TBXMLElement *S_PROD_LN  = [TBXML childElementNamed:@"TABLE" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                
                TBXMLElement *DSEPPL = [TBXML childElementNamed:@"PPL" parentElement:S_PROD_LN];
                analytics.PL = [TBXML textForElement:DSEPPL];
                NSLog(@"Product PPL : %@",analytics.PL);
                [ProductName addObject:analytics.PL];
                
                
                TBXMLElement *DSEalias = [TBXML childElementNamed:@"alias" parentElement:S_PROD_LN];
                analytics.alias = [TBXML textForElement:DSEalias];
                NSLog(@"Product : %@",analytics.alias);
                [c0sum addObject:analytics.alias];
                
                
                
                TBXMLElement *DSEalias1 = [TBXML childElementNamed:@"alias1" parentElement:S_PROD_LN];
                analytics.alias1 = [TBXML textForElement:DSEalias1];
                NSLog(@"Product : %@",analytics.alias1);
                [c1sum addObject:analytics.alias1];
                
                
                TBXMLElement *DSEalias2 = [TBXML childElementNamed:@"alias2" parentElement:S_PROD_LN];
                analytics.alias2 = [TBXML textForElement:DSEalias2];
                [c1Asum addObject:analytics.alias2];
                
                
                TBXMLElement *DSEalias3 = [TBXML childElementNamed:@"alias3" parentElement:S_PROD_LN];
                analytics.alias3 = [TBXML textForElement:DSEalias3];
                [c2sum addObject:analytics.alias3];
                
                
                
                
                TBXMLElement *DSEalias4 = [TBXML childElementNamed:@"alias4" parentElement:S_PROD_LN];
                analytics.alias4 = [TBXML textForElement:DSEalias4];
                [c3sum addObject:analytics.alias4];
                
                
                [analyticsdisplayarray addObject:analytics];
                
                
            } while ((tuple = tuple->nextSibling));
            NSLog(@"\nOpportunityListDisplayArr......%d",[analyticsdisplayarray count]);
            
            
            if ((analyticsdisplayarray.count) > 0){
                
                [self.tblview reloadData];
                NSLog(@"In....");
                
                if (analyticsdisplayarray.count==c0sum.count) {
                    
                    sum=0;
                    for (NSNumber *num in c0sum)
                    {
                        sum += [num intValue];
                        NSLog(@"..%d",sum);
                        
                        //                    NSString *strFromInt = [NSString stringWithFormat:@"%d",sum];
                        //                    _c0sumlabel.text=strFromInt;            }
                    }
                    sum1=0;
                    for(NSNumber *num1 in c1sum){
                        
                        sum1 += [num1 intValue];
                        NSLog(@"c1 %d",sum1);
                        
                        //   NSString *strFromInt = [NSString stringWithFormat:@"%d",sum];
                        // _c0sumlabel.text=strFromInt;
                    }
                    for(NSNumber *num2 in c1Asum){
                        
                        sum1A += [num2 intValue];
                        NSLog(@"c1A %d",sum1A);
                        
                        //   NSString *strFromInt = [NSString stringWithFormat:@"%d",sum];
                        // _c0sumlabel.text=strFromInt;
                    }
                    
                    for(NSNumber *num3 in c2sum){
                        
                        sum2 += [num3 intValue];
                        NSLog(@"c1 %d",sum2);
                        
                        //   NSString *strFromInt = [NSString stringWithFormat:@"%d",sum];
                        // _c0sumlabel.text=strFromInt;
                    }
                    
                    for(NSNumber *num4 in c3sum){
                        
                        sum3 += [num4 intValue];
                        NSLog(@"c1 %d",sum3);
                        
                        //   NSString *strFromInt = [NSString stringWithFormat:@"%d",sum];
                        // _c0sumlabel.text=strFromInt;
                    }        }
            }
            
            total =0;
            
            _C0Total.text=[NSString stringWithFormat:@"%d",sum];
            _C1Total.text=[NSString stringWithFormat:@"%d",sum1];
            
            _C1ATotal.text=[NSString stringWithFormat:@"%d",sum1A];
            
            _C2Total.text=[NSString stringWithFormat:@"%d",sum2];
            
            _C3Total.text=[NSString stringWithFormat:@"%d",sum3];
            
            total=sum+sum1+sum1A+sum2+sum3;
            NSLog(@"total %f",total);
            
            NSString *strngfrmfloat =[NSString stringWithFormat:@"%d",(int)total];
            _percentageLabel.text=strngfrmfloat;
            
            
            prcntsum =0;
            float devidesum=0;
            
            devidesum = (float)sum/total;
            NSLog(@".... %f",devidesum);
            
            prcntsum=devidesum*100.0f;
            
            NSLog(@"percent calculation sum0 %f",prcntsum);
            
            
            prcntsum1 =0;
            float devidesum1=0;
            
            devidesum1 = (float)sum1/total;
            NSLog(@".... %f",devidesum1);
            
            prcntsum1=devidesum1*100.0f;
            NSLog(@"percent calculation sum1 %f",prcntsum1);
            
            prcntsum1A =0;
            float devidesum2=0;
            
            devidesum2 = (float)sum1A/total;
            NSLog(@".... %f",devidesum2);
            
            prcntsum1A=devidesum2*100.0f;
            NSLog(@"percent calculation sum1A %f",prcntsum1A);
            
            prcntsum2 =0;
            float devidesum3=0;
            
            devidesum3 = (float)sum2/total;
            NSLog(@".... %f",devidesum3);
            
            prcntsum2=devidesum3*100.0f;
            NSLog(@"percent calculation sum1A %f",prcntsum2);
            
            
            prcntsum3 =0;
            float devidesum4=0;
            
            devidesum4 = (float)sum3/total;
            NSLog(@".... %f",devidesum4);
            
            NSLog(@"percent calculation sum1A %f",prcntsum3);
            
            prcntsum3=devidesum4*100.0f;
            NSLog(@"In....");
            [self.tblview  reloadData];
            NSLog(@"Product Name : %@",ProductName);
            
            self.slices = [NSMutableArray arrayWithCapacity:5];
            
            NSNumber * c0count =[NSNumber numberWithFloat:prcntsum];
            NSNumber * c1count = [NSNumber numberWithFloat:prcntsum1];
            NSNumber * c1Acount =[NSNumber numberWithFloat:prcntsum1A];
            NSNumber * c2count = [NSNumber numberWithFloat:prcntsum2];
            NSNumber * c3count = [NSNumber numberWithFloat:prcntsum3];
            
            _slices= [NSMutableArray arrayWithObjects: c0count,c1count,c1Acount,c2count,c3count ,nil];
            [self viewDidAppear:YES];
            
            //[self hideAlert];
            
        }
        NSLog(@" \n\n activityPPLNamePickerArr....!!! %lu ",(unsigned long)[analyticsdisplayarray count]);
    }
}
-(void)viewDidLayoutSubviews
{
    if ([self.AnalyticsTableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.AnalyticsTableview setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.AnalyticsTableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.AnalyticsTableview setLayoutMargins:UIEdgeInsetsZero];
    }
    
    /* if ([self.tblview respondsToSelector:@selector(setSeparatorInset:)]) {
     [self.tblview setSeparatorInset:UIEdgeInsetsZero];
     }
     
     if ([self.tblview respondsToSelector:@selector(setLayoutMargins:)]) {
     [self.tblview setLayoutMargins:UIEdgeInsetsZero];
     }*/
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    
    
}






- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([passDSE isEqual:@"PL Wise"]){
        
        ///   NSLog(@"...TGM Product");
        //[self selectePLwise];
        return [ProductName count];
        
    }
    else if ([passDSE isEqual:@"PPL Wise"]){
        
        return [ProductName count];
        //  NSLog(@"TGM SaleStage");
        // [self selectePPLwise];
        
    }
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    analytics = nil;
    analytics = [[analytics_list alloc]init];
    analytics = [analyticsdisplayarray objectAtIndex:indexPath.row];
    NSLog(@"Inside the ..");
    static NSString *MyIdentifier = @"MyIdentifier";
    
    AnalyticsProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[AnalyticsProductTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                    reuseIdentifier:MyIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
//    cell.layer.borderColor =  [UIColor colorWithRed:(4/255.0) green:(41/255.0) blue:(82/255.0) alpha:1].CGColor;
     cell.layer.borderColor =  [UIColor colorWithRed:(218/255.0) green:(218/255.0) blue:(218/255.0) alpha:1].CGColor;
    cell.layer.borderWidth = 1.0f;
    
    self.tblview.separatorStyle = UITableViewCellSeparatorStyleNone;
    if([passDSE isEqual:@"PL Wise"])
    {
        analytics = [analyticsdisplayarray objectAtIndex:indexPath.row ];
        cell.C0.text=analytics.alias;
        cell.C1.text=analytics.alias1;
        cell.C1A.text=analytics.alias2;
        cell.C2.text=analytics.alias3;
        cell.C3.text=analytics.alias4;
        
        cell.ProductName.text=[ProductName objectAtIndex:indexPath.row];
    }
    if([passDSE isEqual:@"PPL Wise"])
    {
        // cell.ProductName.text=passDSE;
        analytics = [analyticsdisplayarray objectAtIndex:indexPath.row ];
        cell.C0.text=analytics.alias;
        cell.C1.text=analytics.alias1;
        cell.C1A.text=analytics.alias2;
        cell.C2.text=analytics.alias3;
        cell.C3.text=analytics.alias4;
        cell.ProductName.text=[ProductName objectAtIndex:indexPath.row];
        
        
    }
    return cell;
    
}

-(void)dsewisereport{
    
    NSString * envelopeText = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<SearchmonthreportforDse xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                               @"<positionid>%@</positionid>"
                               @"<fromdate>09-Apr-2014</fromdate>"
                               @"<todate>09-Apr-2015</todate>"
                               @"</SearchmonthreportforDse>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",passdseid];
    
    NSLog(@"\n envlopeString Of dsewise report TO....!!!!%@",envelopeText);
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@",theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    
    NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"getdsewisereport"];
    
    
    
}
-(void)getdsewisereport_found:(NSNotification*)notification
{
    
    
    
    
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    
    
    NSLog(@"\n opportuntyCount response..... %@ ",response);
    if ([response isEqual:@""])
    {
        //  [self hideAlert];
        NSLog(@"Nko re..");
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Nothing in Response !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        //[self hideAlert];
        NSLog(@"Dishkyauuu");
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Network Fault String!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    else
    {
        if (analyticsdisplayarray)
        {
            [ analyticsdisplayarray removeAllObjects];
            
        }
        //  [self hideAlert];
        TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
        TBXMLElement *container = [TBXML childElementNamed:@"SearchmonthreportforDseResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
        TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
        if (tuple)
        {
            do {
                analytics = nil;
                analytics = [[analytics_list alloc]init];
                
                
                NSLog(@"xxxxx");
                
                TBXMLElement *S_PROD_LN  = [TBXML childElementNamed:@"TABLE" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
                
                
                TBXMLElement *DSEalias = [TBXML childElementNamed:@"alias" parentElement:S_PROD_LN];
                analytics.alias = [TBXML textForElement:DSEalias];
                
                
                NSLog(@"Product : %@",analytics.alias);
                
                [c0sum addObject:analytics.alias];
                NSLog(@"TEST %@",c0sum);
                
                
                
                
                TBXMLElement *DSEalias1 = [TBXML childElementNamed:@"alias1" parentElement:S_PROD_LN];
                analytics.alias1 = [TBXML textForElement:DSEalias1];
                NSLog(@"Product : %@",analytics.alias1);
                [c1sum addObject:analytics.alias1];
                NSLog(@"TEST %@",c1sum);
                
                
                TBXMLElement *DSEalias2 = [TBXML childElementNamed:@"alias2" parentElement:S_PROD_LN];
                analytics.alias2 = [TBXML textForElement:DSEalias2];
                [c1Asum addObject:analytics.alias2];
                NSLog(@"TEST %@",c1Asum);
                
                
                
                TBXMLElement *DSEalias3 = [TBXML childElementNamed:@"alias3" parentElement:S_PROD_LN];
                analytics.alias3 = [TBXML textForElement:DSEalias3];
                [c2sum addObject:analytics.alias3];
                NSLog(@"TEST %@",c2sum);
                
                
                TBXMLElement *DSEalias4 = [TBXML childElementNamed:@"alias4" parentElement:S_PROD_LN];
                analytics.alias4 = [TBXML textForElement:DSEalias4];
                [c3sum addObject:analytics.alias4];
                NSLog(@"TEST %@",c3sum);
                
                
                
                [analyticsdisplayarray addObject:analytics];
            } while ((tuple = tuple->nextSibling));
            NSLog(@"\nOpportunityListDisplayArr......%d",[analyticsdisplayarray count]);
            
        }
        if ((analyticsdisplayarray.count) > 0){
            
            [self.tblview reloadData];
            NSLog(@"In....");
            
            
            
            if (analyticsdisplayarray.count==c0sum.count) {
                
                sum=0;
                for (NSNumber *num in c0sum)
                {
                    sum += [num intValue];
                    NSLog(@"..%d",sum);
                    
                    //                    NSString *strFromInt = [NSString stringWithFormat:@"%d",sum];
                    //                    _c0sumlabel.text=strFromInt;            }
                }
                
                for(NSNumber *num1 in c1sum){
                    
                    sum1 += [num1 intValue];
                    NSLog(@"c1 %d",sum1);
                    
                    //   NSString *strFromInt = [NSString stringWithFormat:@"%d",sum];
                    // _c0sumlabel.text=strFromInt;
                }
                for(NSNumber *num2 in c1Asum){
                    
                    sum1A += [num2 intValue];
                    NSLog(@"c1A %d",sum1A);
                    
                    //   NSString *strFromInt = [NSString stringWithFormat:@"%d",sum];
                    // _c0sumlabel.text=strFromInt;
                }
                
                for(NSNumber *num3 in c2sum){
                    
                    sum2 += [num3 intValue];
                    NSLog(@"c1 %d",sum2);
                    
                    //   NSString *strFromInt = [NSString stringWithFormat:@"%d",sum];
                    // _c0sumlabel.text=strFromInt;
                }
                
                for(NSNumber *num4 in c3sum){
                    
                    sum3 += [num4 intValue];
                    NSLog(@"c1 %d",sum3);
                    
                    //   NSString *strFromInt = [NSString stringWithFormat:@"%d",sum];
                    // _c0sumlabel.text=strFromInt;
                }        }
        }
        
        total =0;
        
        total=sum+sum1+sum1A+sum2+sum3;
        NSLog(@"total %f",total);
        
        NSString *strngfrmfloat =[NSString stringWithFormat:@"%d",(int)total];
        _percentageLabel.text=strngfrmfloat;
        
        
        prcntsum =0;
        float devidesum=0;
        
        devidesum = (float)sum/total;
        NSLog(@".... %f",devidesum);
        
        prcntsum=devidesum*100.0f;
        
        NSLog(@"percent calculation sum0 %f",prcntsum);
        
        
        prcntsum1 =0;
        float devidesum1=0;
        
        devidesum1 = (float)sum1/total;
        NSLog(@".... %f",devidesum1);
        
        prcntsum1=devidesum1*100.0f;
        NSLog(@"percent calculation sum1 %f",prcntsum1);
        
        prcntsum1A =0;
        float devidesum2=0;
        
        devidesum2 = (float)sum1A/total;
        NSLog(@".... %f",devidesum2);
        
        prcntsum1A=devidesum2*100.0f;
        NSLog(@"percent calculation sum1A %f",prcntsum1A);
        
        prcntsum2 =0;
        float devidesum3=0;
        
        devidesum3 = (float)sum2/total;
        NSLog(@".... %f",devidesum3);
        
        prcntsum2=devidesum3*100.0f;
        NSLog(@"percent calculation sum1A %f",prcntsum2);
        
        
        prcntsum3 =0;
        float devidesum4=0;
        
        devidesum4 = (float)sum3/total;
        NSLog(@".... %f",devidesum4);
        
        NSLog(@"percent calculation sum1A %f",prcntsum3);
        
        prcntsum3=devidesum4*100.0f;
        NSLog(@"In....");
        [self.tblview  reloadData];
        NSLog(@"Product Name : %@",ProductName);
        
        self.slices = [NSMutableArray arrayWithCapacity:5];
        
        NSNumber * c0count =[NSNumber numberWithFloat:prcntsum];
        NSNumber * c1count = [NSNumber numberWithFloat:prcntsum1];
        NSNumber * c1Acount =[NSNumber numberWithFloat:prcntsum1A];
        NSNumber * c2count = [NSNumber numberWithFloat:prcntsum2];
        NSNumber * c3count = [NSNumber numberWithFloat:prcntsum3];
        
        _slices= [NSMutableArray arrayWithObjects: c0count,c1count,c1Acount,c2count,c3count ,nil];
        
        [self viewDidAppear:YES];
        
        //[self hideAlert];
        
    }
    NSLog(@" \n\n activityPPLNamePickerArr....!!! %lu ",(unsigned long)[analyticsdisplayarray count]);
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.Piechartanalytics reloadData];
    
    
    
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
    if (index==0) {
        self.coLegend.backgroundColor=[self.sliceColors objectAtIndex:(index % self.sliceColors.count)];
        
    }
    else if (index==1)
    {
    self.c1Legend.backgroundColor=[self.sliceColors objectAtIndex:(index % self.sliceColors.count)];
    }
    else if (index==2)
    {
        self.c1AlEGEND.backgroundColor=[self.sliceColors objectAtIndex:(index % self.sliceColors.count)];
    }
    else if (index==3)
    {
        self.C2Legend.backgroundColor=[self.sliceColors objectAtIndex:(index % self.sliceColors.count)];
    }
    else if (index==4)
    {
        self.c3Legend.backgroundColor=[self.sliceColors objectAtIndex:(index % self.sliceColors.count)];
    }
    return [self.sliceColors objectAtIndex:(index % self.sliceColors.count)];
}

#pragma mark - XYPieChart Delegate
- (void)pieChart:(XYPieChart *)pieChart willSelectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"will select slice at index %d",index);
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection: 0];
    
    
//    UITableViewCell* cell = [self.tblview cellForRowAtIndexPath:indexPath];
//    //    cell.layer.borderWidth=2.0f;
//    //    cell.layer.borderColor=[UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1].CGColor;
//    //cell.backgroundColor=[UIColor redColor];
//    cell.highlighted=YES;
//    //cell.layer.borderColor=(__bridge CGColorRef)([UIColor whiteColor]);
//    
//    [self.tblview scrollToRowAtIndexPath:indexPath
//                        atScrollPosition:UITableViewScrollPositionTop
//                                animated:YES];
//    
//    
//    [self.tblview reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
}
- (void)pieChart:(XYPieChart *)pieChart willDeselectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"will deselect slice at index %d",index);
}
- (void)pieChart:(XYPieChart *)pieChart didDeselectSliceAtIndex:(NSUInteger)index
{
    self.coLegend.layer.borderWidth=0.0f;
    self.c1Legend.layer.borderWidth=0.0f;
    self.c1AlEGEND.layer.borderWidth=0.0f;
    self.C2Legend.layer.borderWidth=0.0f;
    self.c3Legend.layer.borderWidth=0.0f;

    NSLog(@"did deselect slice at index %d",index);
}
- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index
{
//    NSLog(@"did select slice at index %d",index);
//    self.selectedSliceLabel.text = [NSString stringWithFormat:@"$%@",[self.slices objectAtIndex:index]];
    
    NSLog(@"did select slice at index %d",index);
    
    if(index==0){
        
        self.coLegend.layer.borderWidth=3.0f;
        
        self.coLegend.layer.borderColor=[UIColor colorWithRed:(30/255.0) green:(144/255.0) blue:(255/255.0) alpha:1].CGColor;
        
    }
    else if (index==1)
    {
        self.c1Legend.layer.borderWidth=3.0f;
        
        self.c1Legend.layer.borderColor=[UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
        
    }
    
    else if (index==2)
    {
        self.c1AlEGEND.layer.borderWidth=3.0f;
        
        self.c1AlEGEND.layer.borderColor=[UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
        
    }
    
    else if (index==3)
    {
        self.C2Legend.layer.borderWidth=3.0f;
        
        self.C2Legend.layer.borderColor=[UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
        
    }
    else if (index==4)
    {
        self.c3Legend.layer.borderWidth=3.0f;
        
        self.c3Legend.layer.borderColor=[UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
        
    }
    
    

}



@end
