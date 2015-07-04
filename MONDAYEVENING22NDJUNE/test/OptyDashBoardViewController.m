//
//  OptyDashBoardViewController.m
//DSM
//
//  Created by admin on 21/05/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import "OptyDashBoardViewController.h"
#import "TBXML.h"
#import "RequestDelegate.h"
#import "DetailViewController.h"
@interface OptyDashBoardViewController ()
{
    NSString *CO_QTY_STR,*C1_QTY_STR,*C1A_QTY_STR,*C2_QTY_STR,*C3_QTY_STR,*C0L_QTY_STR,*C1L_QTY_STR,*C2L_QTY_STR,*day1;
    NSMutableArray *OpenStatus_Arr,*DoneStatus_Arr;
    NSNumber *openAdd,*doneAdd;
    int x,y,z,a,b,counter,c,d,e;
    NSArray *foo;
        float perSumC0,perSumC1,perSumC1A,perSumC2,perSumC3,perSumC4,perSumC5,perSumC6;
}
@end

@implementation OptyDashBoardViewController
@synthesize Opty_Arr;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];//AppDelegate instance
    userDetailsVal_ = [UserDetails_Var sharedmanager]; // usedetails instance
    
    
    
    
    /*self.slices = [NSMutableArray arrayWithCapacity:2];
     
    NSNumber * blah = [NSNumber numberWithInt:20];
    NSNumber * blah1 = [NSNumber numberWithInt:80];
     
     //
     _slices= [NSMutableArray arrayWithObjects: blah1,blah, nil];
     
     
     
     //    for(int i = 0; i < 5; i ++)
     //    {
     //        NSNumber * blah = [NSNumber numberWithInt:i];
     //        NSArray * items = [NSArray arrayWithObjects: blah, blah, nil];
     //
     //        NSNumber *one = [NSNumber numberWithInt:rand()%60+0];
     //        [_slices addObject:one];
     //    }
     //    [self.pieChartLeft setFrame:CGRectMake(-20,0, 100, 100)];
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
    
    [self CallOptyDetailsDashBoard];
     
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.pieChartLeft setHidden:YES];
    NSLog(@"..... will ");
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(OpportunitiesDashBoard_Found:) name:@"OpportunitiesDashBoard_Found" object:nil];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    
    NSLog(@" Will Appear");
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"OpportunitiesDashBoard_Found" object:nil];//Gautam // For searchActivities_Found Countx
}

- (void)viewDidAppear:(BOOL)animated
{
    
    NSLog(@"did appear");
    
    [super viewDidAppear:animated];
    
    [self.pieChartLeft reloadData];
    
    //[self.pieChartRight reloadData];
    
}

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
    //1-70CX8VQ
    
    
    NSLog(@"\n OPTY COUNTER %@",envelopeText);
    
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
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSM" message:@"No data found " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        
    }
    else if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        //  [self hideAlert];
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSM" message:@"Something went wrong.Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
            
            
            
            
        
            TBXMLElement *C0L_QTY = [TBXML childElementNamed:@"C0L_QTY" parentElement:table];
            C0L_QTY_STR=[TBXML textForElement:C0L_QTY];
            c = [C0L_QTY_STR intValue];
              NSLog(@"OptyID Opty Id : %@",C0L_QTY_STR);
            
            TBXMLElement *C1L_QTY = [TBXML childElementNamed:@"C1L_QTY" parentElement:table];
            C1L_QTY_STR=[TBXML textForElement:C1L_QTY];
            d = [C1L_QTY_STR intValue];
            
            TBXMLElement *C2L_QTY = [TBXML childElementNamed:@"C2L_QTY" parentElement:table];
            C2L_QTY_STR=[TBXML textForElement:C2L_QTY];
            e = [C2L_QTY_STR intValue];
            
            
            
            counter=x+y+z+a+b+c+d+e;
        }
        else
        {
            
        }
        NSLog(@"Count : For Opty %d",counter);
        if (counter>0) {
            
            perSumC0 =0;
            float devidesumC0=0;
            
            devidesumC0 = (float)x/counter;
            NSLog(@".... %f",devidesumC0);
            
            perSumC0=devidesumC0*100.0f;
            NSLog(@"percent calculation C0 %f",perSumC0);
            
            perSumC1 =0;
            float devidesumC1=0;
            
            devidesumC1 = (float)y/counter;
            NSLog(@".... %f",devidesumC1);
            
            perSumC1=devidesumC1*100.0f;
            NSLog(@"percent calculation C1 %f",perSumC1);
            
            perSumC1A =0;
            float devidesumC1A=0;
            
            devidesumC1A = (float)z/counter;
            NSLog(@".... %f",devidesumC1A);
            
            perSumC1A=devidesumC1A*100.0f;
            NSLog(@"percent calculation C1A %f",perSumC1A);
            
            perSumC2 =0;
            float devidesumC2=0;
            
            devidesumC2 = (float)a/counter;
            NSLog(@".... %f",devidesumC1);
            
            perSumC2=devidesumC2*100.0f;
            NSLog(@"percent calculation C2 %f",perSumC2);
            
            perSumC3 =0;
            float devidesumC3=0;
            
            devidesumC3 = (float)b/counter;
            NSLog(@".... %f",devidesumC3);
            
            perSumC3=devidesumC3*100.0f;
            NSLog(@"percent calculation C3 %f",perSumC3);
            
            
            perSumC4 =0;
            float devidesumC4=0;
            
            devidesumC4 = (float)c/counter;
            NSLog(@".... %f",devidesumC3);
            
            perSumC4=devidesumC4*100.0f;
            NSLog(@"percent calculation C3 %f",perSumC4);
            
            
            perSumC5 =0;
            float devidesumC5=0;
            
            devidesumC5 = (float)d/counter;
            NSLog(@".... %f",devidesumC5);
            
            perSumC5=devidesumC5*100.0f;
            NSLog(@"percent calculation C3 %f",perSumC5);
            
            
            
            perSumC6 =0;
            float devidesumC6=0;
            
            devidesumC6 = (float)e/counter;
            NSLog(@".... %f",devidesumC6);
            
            perSumC6=devidesumC6*100.0f;
            NSLog(@"percent calculation C3 %f",perSumC6);
            
            
            
            self.slices = [NSMutableArray arrayWithCapacity:5];
            
            NSNumber * c0count =[NSNumber numberWithFloat:perSumC0];
            NSNumber * c1count = [NSNumber numberWithFloat:perSumC1];
            NSNumber * c1Acount =[NSNumber numberWithFloat:perSumC1A];
            NSNumber * c2count = [NSNumber numberWithFloat:perSumC2];
            NSNumber * c3count = [NSNumber numberWithFloat:perSumC3];
            NSNumber * c4count = [NSNumber numberWithFloat:perSumC4];
            
            NSNumber * c5count = [NSNumber numberWithFloat:perSumC5];
            NSNumber * c6count = [NSNumber numberWithFloat:perSumC6];
            
            
            
            _slices= [NSMutableArray arrayWithObjects: c0count,c1count,c1Acount,c2count,c3count,c4count,c5count,c6count ,nil];
            
            [self.pieChartLeft setDataSource:self];
            [self.pieChartLeft setStartPieAngle:M_PI_2];
            [self.pieChartLeft setAnimationSpeed:1.0];
            [self.pieChartLeft setLabelFont:[UIFont fontWithName:@"DBLCDTempBlack" size:24]];
            // [self.pieChartLeft setLabelRadius:160];
            [self.pieChartLeft setShowPercentage:YES];
            //[self.pieChartLeft setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
            [self.pieChartLeft setPieBackgroundColor:[UIColor colorWithRed:(245/255.0) green:(244/255.0) blue:(244/255.0) alpha:1]];
            [self.pieChartLeft setPieCenter:CGPointMake(120, 110)];
            [self.pieChartLeft setUserInteractionEnabled:NO];
            [self.pieChartLeft setLabelShadowColor:[UIColor whiteColor]];
            [self.pieChartLeft setLabelRadius:0];
            
            [[self.percentageLabel layer] setCornerRadius:61.0f];
            [[self.percentageLabel layer] setMasksToBounds:YES];
            self.sliceColors =[NSArray arrayWithObjects:
                               [UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],
                               [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
                               [UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
                               [UIColor colorWithRed:229/255.0 green:66/255.0 blue:115/255.0 alpha:1],
                               [UIColor colorWithRed:148/255.0 green:141/255.0 blue:139/255.0 alpha:1],
                               [UIColor colorWithRed:250/255.0 green:212/255.0 blue:18/255.0 alpha:1],
                               [UIColor colorWithRed:236/255.0 green:53/255.0 blue:25/255.0 alpha:1],
                               [UIColor colorWithRed:53/255.0 green:245/255.0 blue:38/255.0 alpha:1],
                               nil];
            
            self.downArrow.transform = CGAffineTransformMakeRotation(M_PI);
            
            [self.pieChartLeft setHidden:NO];
            
            
            [self viewDidAppear:YES];
            
            
            
            
            
            /*
             self.slices = [NSMutableArray arrayWithCapacity:1];
             
             NSNumber * blah1 = [NSNumber numberWithInt:100];
             // NSNumber * blah2 = [NSNumber numberWithInt:80];
             //  NSNumber * bla3 = [NSNumber numberWithInt:20];
             //  NSNumber * blah4 = [NSNumber numberWithInt:80];
             
             //
             _slices= [NSMutableArray arrayWithObjects:blah1, nil];
             
             
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
             [UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],
             [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
             [UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
             [UIColor colorWithRed:229/255.0 green:66/255.0 blue:115/255.0 alpha:1],
             [UIColor colorWithRed:148/255.0 green:141/255.0 blue:139/255.0 alpha:1],nil];
             
             self.downArrow.transform = CGAffineTransformMakeRotation(M_PI);
             
             [self viewDidAppear:YES];*/

            
        }
        _percentageLabel.text=[NSString stringWithFormat:@"%d",counter];
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

#pragma mark - XYPieChart Data Source

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return self.slices.count;
}
- (NSUInteger)numberOfSlicesInPieChart1:(XYPieChart *)pieChart
{
    return self.slices.count;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    return [[self.slices objectAtIndex:index] intValue];
    
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex1:(NSUInteger)index
{
    return [[self.slices objectAtIndex:index] intValue];
    
}

- (UIColor*)pieChart:(XYPieChart*)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    
    return [self.sliceColors objectAtIndex:(index % self.sliceColors.count)];
}

- (UIColor*)pieChart:(XYPieChart*)pieChart colorForSliceAtIndex1:(NSUInteger)index
{
    
    return [self.sliceColors objectAtIndex:(index % self.sliceColors.count)];
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
