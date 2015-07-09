//
//  INFOViewController.m
//  DSE
//
//  Created by Rishikesh on 07/07/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import "INFOViewController.h"

@interface INFOViewController ()

@end

@implementation INFOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 575, 30)];
    fromLabel.text = @"About Us";
    fromLabel.textColor=[UIColor whiteColor];
//    fromLabel.numberOfLines = 1;
//    fromLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
//    fromLabel.adjustsFontSizeToFitWidth = YES;
    fromLabel.adjustsLetterSpacingToFitWidth = YES;
//    fromLabel.minimumScaleFactor = 10.0f/12.0f;
    fromLabel.clipsToBounds = YES;
    fromLabel.backgroundColor = [UIColor colorWithRed:115/255.0f green:182/255.0f blue:68/255.0f alpha:1];
//    fromLabel.textColor = [UIColor blackColor];
//    fromLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:fromLabel];
    UITextView *newTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 55, 575,500)];
    [newTextView setFont:[UIFont systemFontOfSize:16]];
    newTextView.text = @"Background\n\nPreviously, there was a challenge in follow up of most of the leads created by  TBSS, reason being Visibility of those leads to correct person(sales executives). Apparently, a lot of leads were lost in the process. Hence, to overcome this challenge, Tata Motors needed a Mobility Solution especially for those executives who can actually do follow up and close the leads as a Retail or Lost Customer.\n\nTata Technologies Solution\n\nThe purpose of the app is to help the District Sales Manger to build relationships, generate and execute sales objectives for assigned areas of responsibility.District Sales Manger contacts the potential customers and identify new business opportunities. District Sales Manager takes a follow up of the leads which he assigns to DSE’s (District Sales Executives) under him.\n\nSalient Features\n\n Lead Generation\n Lead Management – Assigning leads, Updating leads, creating follow up activities, Searching leads\n Activity Creation\nActivity Management\n Analytics – Product Wise, DSE Wise\n\nProject Details\n\nThis App is used by the Dealer Sales Manager (DSM) which makes it easier for the DSM to create leads on the spot and track those leads too.  The DSM has the facilities  to assign and update the leads, create follow up activities for leads and view leads that he has assigned.  This App is integrated with the backend system of Tata Motors. The created or updated data is directly reflected in the backend system.Analytics report feature is also present in the App that shows the monthly analytics of leads, Product wise and DSE (Dealer Sales Executive) wise. The analytics  graph is  generated using the backend data.\n\nImpact and Business Benefits\n\nStreamline Sales Admin\nThis App streamlines the entire sales process  from lead capturing to analytics.\n\nIncrease Competitive Advantage\nIt speeds up the sales process  cycle and helps the sales person to concentrate on their next appointment.\n\nSales conversations can happen anywhere, anytime: at a desk, over lunch, in the hallway\nThe sales conversation isn’t limited to one place. It help the manager to present the company in a professional way, and to stand out from the competition.\n\nComposed Analytics\nHaving a graphical report on mobile as well  as  tablet makes it easier for the DSM to understand the pitfalls of sales action plan and improve the sales department for better results.Having a graphical report on mobile as well  as  tablet makes it easier for the DSM to understand the pitfalls of sales action plan and improve the sales department for better results";
    
    newTextView.backgroundColor=[UIColor clearColor];
    newTextView.userInteractionEnabled = YES;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(Cancel)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Cancel" forState:UIControlStateNormal];
    button.frame = CGRectMake(195.0, 560, 180.0, 35);
    button.backgroundColor=[UIColor colorWithRed:115/255.0f green:182/255.0f blue:68/255.0f alpha:1];
    button.layer.cornerRadius=2;
    [self.view addSubview:button];
    
    [self.view addSubview:newTextView];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)Cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
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
