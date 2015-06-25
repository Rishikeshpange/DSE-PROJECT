//
//  UpdateOptyViewController.h
//  DSE
//
//  Created by admin on 02/04/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateOptyViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewFirst;

@property (weak, nonatomic) IBOutlet UIView *viewSecond;

@property (weak, nonatomic) IBOutlet UIView *viewFirst_Change;


@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControll;
@property (weak, nonatomic) IBOutlet UIButton *btnPersonalDetails;

@property (weak, nonatomic) IBOutlet UIView *btnFirstView;

@property (weak, nonatomic) IBOutlet UIView *btnSecondView;

@property (weak, nonatomic) IBOutlet UIButton *btnFirst;

@property (weak, nonatomic) IBOutlet UIButton *btnSecond;


- (IBAction)btnFirstView:(id)sender;

- (IBAction)btnSecondView:(id)sender;


/// Product view Fileds :

@property (weak, nonatomic) IBOutlet UITextField *txtSelectLOB;

@property (weak, nonatomic) IBOutlet UITextField *txtSelectPL;


@property (weak, nonatomic) IBOutlet UITextField *txtSelectPPL;

@property (weak, nonatomic) IBOutlet UITextField *txtAppType;
// Contact Details View

@property (weak, nonatomic) IBOutlet UITextField *txtFirstName;

@property (weak, nonatomic) IBOutlet UITextField *txtAddress1;

@property (weak, nonatomic) IBOutlet UITextField *txtPincode;

@property (weak, nonatomic) IBOutlet UITextField *txtState;


@property (weak, nonatomic) IBOutlet UITextField *txtLastName;

@property (weak, nonatomic) IBOutlet UITextField *txtAddress2;

@property (weak, nonatomic) IBOutlet UITextField *txtCity;








@end
