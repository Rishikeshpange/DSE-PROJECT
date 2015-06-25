//
//  UpdateOptyViewController.m
//  DSE
//
//  Created by admin on 02/04/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import "UpdateOptyViewController.h"

@interface UpdateOptyViewController ()

@end

@implementation UpdateOptyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header_strip.png"] forBarMetrics:UIBarMetricsDefault];
    
    // Navigation bar button on right side
    UIButton *btnInfo =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btnInfo setImage:[UIImage imageNamed:@"icon_info.png"] forState:UIControlStateNormal];
    [btnInfo addTarget:self action:@selector(info_btn) forControlEvents:UIControlEventTouchUpInside];
    [btnInfo setFrame:CGRectMake(-15, -5, 40, 40)];
    
    UIButton *btnLogout =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLogout setImage:[UIImage imageNamed:@"icon_logout.png"] forState:UIControlStateNormal];
    [btnLogout addTarget:self action:@selector(logOut_btn) forControlEvents:UIControlEventTouchUpInside];
    [btnLogout setFrame:CGRectMake(44, -5, 40, 40)];
    
    UIView *rightBarButtonItems = [[UIView alloc] initWithFrame:CGRectMake(10,10,90,40)];
    [rightBarButtonItems addSubview:btnInfo];
    [rightBarButtonItems addSubview:btnLogout];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButtonItems];
    

    
    
    
    
    
    [self.btnFirst setBackgroundImage: [UIImage imageNamed:@"product_details_1.png"] forState:UIControlStateNormal];
    
    [self.btnSecond setBackgroundImage: [UIImage imageNamed:@"contact_details_1.png"] forState:UIControlStateNormal];
    
    [self.viewFirst_Change setHidden:YES];
    [self.viewSecond setHidden:NO];
    
    self.btnFirstView.layer.cornerRadius =3;
    self.btnFirstView.layer.masksToBounds = YES;

    self.viewFirst.layer.masksToBounds = YES;
    
    self.btnSecondView.layer.cornerRadius =3;
    self.btnSecondView.layer.masksToBounds = YES;
    
    
    
    
    
   // self.viewFirst.layer.borderColor=[UIColor colorWithRed:(1/255.0) green:(43/255.0) blue:(98/255.0) alpha:1].CGColor;
    [self.viewFirst.layer setBorderColor:[UIColor colorWithRed:(1/255.0) green:(43/255.0) blue:(98/255.0) alpha:1].CGColor];
    [self.viewFirst.layer setBorderWidth:2.0f];
    
    self.btnFirstView.layer.borderColor=[UIColor colorWithRed:(1/255.0) green:(43/255.0) blue:(98/255.0) alpha:1].CGColor;
    
    // Product View
    
    self.txtSelectLOB.layer.borderWidth=2.0f;
    self.txtSelectPL.layer.borderWidth=2.0f;
    
    self.txtSelectPPL.layer.borderWidth=2.0f;
    self.txtAppType.layer.borderWidth=2.0f;
    
    
    self.txtSelectLOB.layer.borderColor=[UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    self.txtSelectPL.layer.borderColor=[UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    
    self.txtSelectPPL.layer.borderColor=[UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    self.txtAppType.layer.borderColor=[UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    
    
    //Contsct View
    
    self.txtFirstName.layer.borderWidth=2.0f;
    self.txtLastName.layer.borderWidth=2.0f;
    
    self.txtAddress1.layer.borderWidth=2.0f;
    self.txtAddress2.layer.borderWidth=2.0f;
    
    self.txtPincode.layer.borderWidth=2.0f;
    self.txtCity.layer.borderWidth=2.0f;
    
    self.txtState.layer.borderWidth=2.0f;
    
    self.txtFirstName.layer.borderColor=[UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    self.txtLastName.layer.borderColor=[UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    
    self.txtAddress1.layer.borderColor=[UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    self.txtAddress2.layer.borderColor=[UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    
    self.txtPincode.layer.borderColor=[UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    self.txtCity.layer.borderColor=[UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    
    self.txtState.layer.borderColor=[UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;


    
    // Rounded border for View's
    /*self.viewFirst.layer.cornerRadius=5;
    self.viewSecond.layer.masksToBounds=YES;
    self.viewFirst.layer.cornerRadius=5;
    self.viewSecond.layer.masksToBounds=YES;
    */
    // view.layer.cornerRadius = 5;
    //  view.layer.masksToBounds = YES;
    
    
    
    // Button Border Color
    /*
    self.btnTGM.layer.borderWidth=2.0f;
    self.btnTKM.layer.borderWidth=2.0f;
    
    self.btnTKM.layer.borderColor=[UIColor colorWithRed:(49/255.0) green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    
*/
    // Do any additional setup after loading the view.
}
- (IBAction)SelectLOB:(id)sender
{
    
    
    
}
- (IBAction)SelectgPPL:(id)sender
{
    
    
    
    
}
- (IBAction)SelectPL:(id)sender
{
    
    
    
    
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

- (IBAction)btnFirstView:(id)sender
{
    [self.viewSecond setHidden:NO];
    [self.viewFirst_Change setHidden:YES];
    [self.btnFirst setBackgroundImage: [UIImage imageNamed:@"product_details_1.png"] forState:UIControlStateNormal];
    
    [self.btnSecond setBackgroundImage: [UIImage imageNamed:@"contact_details_1.png"] forState:UIControlStateNormal];

}

- (IBAction)btnSecondView:(id)sender {
    
    [self.viewFirst_Change setHidden:NO];
    [self.viewSecond setHidden:YES];
    
    [self.btnFirst setBackgroundImage: [UIImage imageNamed:@"product_details.png"] forState:UIControlStateNormal];
    
    [self.btnSecond setBackgroundImage: [UIImage imageNamed:@"contact_details.png"] forState:UIControlStateNormal];
    
}
@end
