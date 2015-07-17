//
//  TestDrvieViewController.m
//  test
//
//  Created by admin on 02/03/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import "CreateOpportunityViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "RequestDelegate.h"
#import "TBXML.h"
#import "MBProgressHUD.h"
#import "ContactsList.h"
#import "CreateActivityViewController.h"


@interface CreateOpportunityViewController ()

@end

@implementation CreateOpportunityViewController
{
    
}


@synthesize scroll_icons;
@synthesize showStates;

@synthesize btn_CreateAccount,btn_CreateContact;//Abhishek
@synthesize btn_CreateOpty;//Abhishek


UIAlertView *alert;
// UIImageView *scroll_icons;
- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    self.appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    userDetailsVal_ = [UserDetails_Var sharedmanager];
    createcontactresult = [CreateContactResult sharedmanager]; // create
    createaccountaginstcontact = [CreateAccountAginstContact sharedmanager];// create ACcount Against
    pl_productid_product = [PL_ProductID_Product sharedmanager]; // for create PL_ProductID_Product
    createopportunity = [CreateOpportunity sharedmanager]; // For create CreateOpprtunity ID
    createaccount = [CreateAccount sharedmanager]; // For create Account ID
    
    [self.SearchContact setBackgroundColor:[UIColor grayColor]];
    [self.SearchContact.layer setBorderColor:[UIColor grayColor].CGColor];
    [self.SearchContact.layer setBorderWidth:1.0];
    [self.SearchContact.layer setCornerRadius:16.0f];
    self.SearchContact.backgroundColor=[UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:0.5];
    self.SearchContact.textAlignment = NSTextAlignmentLeft;
    if ([self.SearchContact respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        self.SearchContact.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter contact" attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }
    
    CGFloat borderWidth = 2.0f;
    self.contactListView.frame = CGRectInset( self.contactListView.frame, -borderWidth, -borderWidth);
    self.contactListView.layer.borderColor = [UIColor grayColor].CGColor;
    self.contactListView.layer.borderWidth = borderWidth;
    
    self.LOB.delegate=self;
    self.opp_Contact_LOB_PickerArr=[[NSMutableArray alloc] init];
    self.PPL_List_PickerArr=[[NSMutableArray alloc] init];
    self.PL_List_PickerArr=[[NSMutableArray alloc] init];
    self.Application_List_PickerArr=[[NSMutableArray alloc] init];
    self.Financier_List_PickerArr=[[NSMutableArray alloc] init];
    self.Source_Contact_List_PickerArr=[[NSMutableArray alloc] initWithObjects:@"Showroom Walk-in",@"Event",@"Referral",@"Others", nil];
    self.States_List_PickerArr=[[NSMutableArray alloc] init];
    self.District_List_PickerArr=[[NSMutableArray alloc] init];
    self.City_List_PickerArr=[[NSMutableArray alloc] init];
    self.Taluka_List_PickerArr=[[NSMutableArray alloc] init];
    self.PostalCode_List_PickerArr=[[NSMutableArray alloc] init];
    
    
    
    self.contactTableview.delegate=self;
    self.contactTableview.dataSource=self;
    
    CGRect newFrame = self.OpportunityScrollView.frame;
    newFrame.size.height = 500;
    self.OpportunityScrollView.frame = newFrame;
    
    self.view.layer.borderColor =  [UIColor colorWithRed:(4/255.0) green:(41/255.0) blue:(82/255.0) alpha:1].CGColor;
    self.view.layer.borderWidth = 3.0f;
    
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header_strip.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header_strip1.png"] forBarMetrics:UIBarMetricsDefault];
    
    
    // Navigation bar button on right side
    //    UIButton *btnInfo =  [UIButton buttonWithType:UIButtonTypeCustom];
    //    [btnInfo setImage:[UIImage imageNamed:@"icon_info.png"] forState:UIControlStateNormal];
    //    [btnInfo addTarget:self action:@selector(info_btn) forControlEvents:UIControlEventTouchUpInside];
    //    [btnInfo setFrame:CGRectMake(-15, -5, 40, 40)];
    
    
    UIButton *btnInfo =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btnInfo setImage:[UIImage imageNamed:@"header_Cicon_3.png"] forState:UIControlStateNormal];
    [btnInfo addTarget:self action:@selector(info_btn) forControlEvents:UIControlEventTouchUpInside];
    [btnInfo setFrame:CGRectMake(-15, -5, 40, 40)];
    
    //    UIButton *btnLogout =  [UIButton buttonWithType:UIButtonTypeCustom];
    //    [btnLogout setImage:[UIImage imageNamed:@"icon_logout.png"] forState:UIControlStateNormal];
    //    [btnLogout addTarget:self action:@selector(logOut_btn) forControlEvents:UIControlEventTouchUpInside];
    //    [btnLogout setFrame:CGRectMake(44, -5, 40, 40)];
    
    UIButton *btnLogout =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLogout setImage:[UIImage imageNamed:@"header_Cicon_4.png"] forState:UIControlStateNormal];
    [btnLogout addTarget:self action:@selector(logOut_btn) forControlEvents:UIControlEventTouchUpInside];
    [btnLogout setFrame:CGRectMake(44, -5, 40, 40)];
    
    UIView *rightBarButtonItems = [[UIView alloc] initWithFrame:CGRectMake(10,10,90,40)];
    [rightBarButtonItems addSubview:btnInfo];
    [rightBarButtonItems addSubview:btnLogout];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButtonItems];
    self.OpportunityScrollView.delegate=self;
    
    //textfield background color
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity:[self.States_List_PickerArr  count]];
    [dict setObject:[NSString stringWithFormat:@"Maharastra"] forKey:@"MH"];
    [dict setObject:[NSString stringWithFormat:@"Andaman and Nicobar Islands"] forKey:@"AN"];
    [dict setObject:[NSString stringWithFormat:@"Andhra Pradesh"] forKey:@"AP"];
    [dict setObject:[NSString stringWithFormat:@"Arunachal Pradesh"] forKey:@"AR"];
    [dict setObject:[NSString stringWithFormat:@"Assam"] forKey:@"AS"];
    [dict setObject:[NSString stringWithFormat:@"Bihar"] forKey:@"BR"];
    [dict setObject:[NSString stringWithFormat:@"Chhattisgarh"] forKey:@"CG"];
    [dict setObject:[NSString stringWithFormat:@"Chandigarh"] forKey:@"CH"];
    [dict setObject:[NSString stringWithFormat:@"Daman and Diu"] forKey:@"DD"];
    [dict setObject:[NSString stringWithFormat:@"Delhi"] forKey:@"DL"];
    [dict setObject:[NSString stringWithFormat:@"Dadra and Nagar Haveli"] forKey:@"DN"];
    [dict setObject:[NSString stringWithFormat:@"Goa"] forKey:@"GA"];
    [dict setObject:[NSString stringWithFormat:@"Gujarat"] forKey:@"GJ"];
    [dict setObject:[NSString stringWithFormat:@"Himachal Pradesh"] forKey:@"HP"];
    [dict setObject:[NSString stringWithFormat:@"Haryana"] forKey:@"HR"];
    [dict setObject:[NSString stringWithFormat:@"Jharkhand"] forKey:@"JH"];
    [dict setObject:[NSString stringWithFormat:@"Jammu and Kashmir"] forKey:@"JK"];
    [dict setObject:[NSString stringWithFormat:@"Karnataka"] forKey:@"KA"];
    [dict setObject:[NSString stringWithFormat:@"Kerala"] forKey:@"KL"];
    [dict setObject:[NSString stringWithFormat:@"Lakshadweep"] forKey:@"LD"];
    [dict setObject:[NSString stringWithFormat:@"Meghalaya"] forKey:@"ML"];
    [dict setObject:[NSString stringWithFormat:@"Manipur"] forKey:@"MN"];
    [dict setObject:[NSString stringWithFormat:@"Madhya Pradesh"] forKey:@"MP"];
    [dict setObject:[NSString stringWithFormat:@"Mizoram"] forKey:@"MZ"];
    [dict setObject:[NSString stringWithFormat:@"Nagaland"] forKey:@"NL"];
    [dict setObject:[NSString stringWithFormat:@"Odisha"] forKey:@"OR"];
    [dict setObject:[NSString stringWithFormat:@"Punjab"] forKey:@"PB"];
    [dict setObject:[NSString stringWithFormat:@"Puducherry"] forKey:@"PY"];
    [dict setObject:[NSString stringWithFormat:@"Rajasthan"] forKey:@"RJ"];
    [dict setObject:[NSString stringWithFormat:@"Sikkim"] forKey:@"SK"];
    [dict setObject:[NSString stringWithFormat:@"Telangana"] forKey:@"TG"];
    [dict setObject:[NSString stringWithFormat:@"Tamil Nadu"] forKey:@"TN"];
    [dict setObject:[NSString stringWithFormat:@"Tripura"] forKey:@"TR"];
    [dict setObject:[NSString stringWithFormat:@"Uttarnchal"] forKey:@"UA"];
    [dict setObject:[NSString stringWithFormat:@"Uttar Pradesh"] forKey:@"UP"];
    [dict setObject:[NSString stringWithFormat:@"West Bengal"] forKey:@"WB"];
    NSLog(@"%@",[dict description]);
    
    
    
    //   self.textfirst.layer.borderWidth=2.0f;
    // self.textfirst.layer.borderColor=[UIColor colorWithRed:(49/255.0)
    //green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    
    
    
    self.textfirst.layer.borderWidth=1.0f;
    //    self.textfirst.layer.borderColor=[UIColor colorWithRed:(49/255.0)green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    
    self.textfirst.layer.borderColor=[UIColor colorWithRed:(186/255.0)green:(183/255.0) blue:(183/255.0) alpha:1].CGColor;
    
    
    self.textlast.layer.borderWidth=1.0f;
    //    self.textlast.layer.borderColor=[UIColor colorWithRed:(49/255.0)green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    
    self.textlast.layer.borderColor=[UIColor colorWithRed:(186/255.0)green:(183/255.0) blue:(183/255.0) alpha:1].CGColor;
    
    
    
    self.textnumber.layer.borderWidth=1.0f;
    //    self.textnumber.layer.borderColor=[UIColor colorWithRed:(49/255.0)green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    
    self.textnumber.layer.borderColor=[UIColor colorWithRed:(186/255.0)green:(183/255.0) blue:(183/255.0) alpha:1].CGColor;
    
    self.textid.layer.borderWidth=1.0f;
    //    self.textid.layer.borderColor=[UIColor colorWithRed:(49/255.0)green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    self.textid.layer.borderColor=[UIColor colorWithRed:(186/255.0)green:(183/255.0) blue:(183/255.0) alpha:1].CGColor;
    
    
    
    self.textadd1.layer.borderWidth=1.0f;
    //    self.textadd1.layer.borderColor=[UIColor colorWithRed:(49/255.0)green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    self.textadd1.layer.borderColor=[UIColor colorWithRed:(186/255.0)green:(186/255.0) blue:(183/255.0) alpha:1].CGColor;
    
    self.textadd2.layer.borderWidth=1.0f;
    //    self.textadd2.layer.borderColor=[UIColor colorWithRed:(49/255.0)green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    self.textadd2.layer.borderColor=[UIColor colorWithRed:(186/255.0)green:(183/255.0) blue:(183/255.0) alpha:1].CGColor;
    
    
    
    self.textArea.layer.borderWidth=1.0f;
    //    self.textArea.layer.borderColor=[UIColor colorWithRed:(49/255.0)green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    self.textArea.layer.borderColor=[UIColor colorWithRed:(186/255.0)green:(183/255.0) blue:(183/255.0) alpha:1].CGColor;
    
    
    
    self.textpostalcode.layer.borderWidth=1.0f;
    //    self.textpostalcode.layer.borderColor=[UIColor colorWithRed:(49/255.0)green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    
    self.textpostalcode.layer.borderColor=[UIColor colorWithRed:(186/255.0)green:(183/255.0) blue:(183/255.0) alpha:1].CGColor;
    
    
    
    self.textTaluka.layer.borderWidth=1.0f;
    //    self.textTaluka.layer.borderColor=[UIColor colorWithRed:(49/255.0)green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    
    self.textTaluka.layer.borderColor=[UIColor colorWithRed:(186/255.0)green:(183/255.0) blue:(183/255.0) alpha:1].CGColor;
    
    
    
    self.textCity.layer.borderWidth=1.0f;
    //    self.textCity.layer.borderColor=[UIColor colorWithRed:(49/255.0)green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    
    self.textCity.layer.borderColor=[UIColor colorWithRed:(186/255.0)green:(183/255.0) blue:(183/255.0) alpha:1].CGColor;
    
    self.textDistrict.layer.borderWidth=1.0f;
    //    self.textDistrict.layer.borderColor=[UIColor colorWithRed:(49/255.0)green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    
    self.textDistrict.layer.borderColor=[UIColor colorWithRed:(186/255.0)green:(183/255.0) blue:(183/255.0) alpha:1].CGColor;
    
    
    self.textState.layer.borderWidth=1.0f;
    //    self.textState.layer.borderColor=[UIColor colorWithRed:(49/255.0)green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    self.textState.layer.borderColor=[UIColor colorWithRed:(186/255.0)green:(183/255.0) blue:(183/255.0) alpha:1].CGColor;
    
    self.textPanchayat.layer.borderWidth=1.0f;
    //    self.textPanchayat.layer.borderColor=[UIColor colorWithRed:(49/255.0)green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    self.textPanchayat.layer.borderColor=[UIColor colorWithRed:(186/255.0)green:(183/255.0) blue:(183/255.0) alpha:1].CGColor;
    
    self.Account.layer.borderWidth=1.0f;
    //    self.Account.layer.borderColor=[UIColor colorWithRed:(49/255.0)green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    self.Account.layer.borderColor=[UIColor colorWithRed:(186/255.0)green:(183/255.0) blue:(183/255.0) alpha:1].CGColor;
    
    self.LOB.layer.borderWidth=1.0f;
    //    self.LOB.layer.borderColor=[UIColor colorWithRed:(49/255.0)green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    self.LOB.layer.borderColor=[UIColor colorWithRed:(186/255.0)green:(183/255.0) blue:(183/255.0) alpha:1].CGColor;
    
    self.PPL.layer.borderWidth=1.0f;
    //    self.PPL.layer.borderColor=[UIColor colorWithRed:(49/255.0)green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    self.PPL.layer.borderColor=[UIColor colorWithRed:(186/255.0)green:(183/255.0) blue:(183/255.0) alpha:1].CGColor;
    
    self.PL.layer.borderWidth=1.0f;
    //    self.PL.layer.borderColor=[UIColor colorWithRed:(49/255.0)green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    self.PL.layer.borderColor=[UIColor colorWithRed:(186/255.0)green:(183/255.0) blue:(183/255.0) alpha:1].CGColor;
    
    
    
    self.txtfldApp.layer.borderWidth=1.0f;
    //    self.txtfldApp.layer.borderColor=[UIColor colorWithRed:(49/255.0)green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    self.txtfldApp.layer.borderColor=[UIColor colorWithRed:(186/255.0)green:(183/255.0) blue:(183/255.0) alpha:1].CGColor;
    
    
    self.APPLICATION.layer.borderWidth=1.0f;
    //    self.APPLICATION.layer.borderColor=[UIColor colorWithRed:(49/255.0)green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    self.APPLICATION.layer.borderColor=[UIColor colorWithRed:(186/255.0)green:(183/255.0) blue:(183/255.0) alpha:1].CGColor;
    
    self.SOURCEOFCONTACT.layer.borderWidth=1.0f;
    //    self.SOURCEOFCONTACT.layer.borderColor=[UIColor colorWithRed:(49/255.0)green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    
    self.SOURCEOFCONTACT.layer.borderColor=[UIColor colorWithRed:(186/255.0)green:(183/255.0) blue:(183/255.0) alpha:1].CGColor;
    
    self.FINANCIER.layer.borderWidth=1.0f;
    //    self.FINANCIER.layer.borderColor=[UIColor colorWithRed:(49/255.0)green:(110/255.0) blue:(191/255.0) alpha:1].CGColor;
    self.FINANCIER.layer.borderColor=[UIColor colorWithRed:(186/255.0)green:(183/255.0) blue:(183/255.0) alpha:1].CGColor;
    
    
    UIButton *state = [UIButton buttonWithType:UIButtonTypeCustom];
    state.frame=CGRectMake(379, 0, 30, 30);
    [state setBackgroundImage:[UIImage imageNamed:@"dropdown1.png"] forState:UIControlStateNormal];
    // state.backgroundColor=[UIColor blueColor];
    [state addTarget:self action:@selector(statedropdown) forControlEvents:UIControlEventTouchUpInside];
    [self.textState addSubview:state];
    
    
    [self.textState addTarget: self action: @selector(buttonClicked:)forControlEvents: UIControlEventTouchUpInside]; //Abhishek Custom Action
    self.textState.delegate = self;
    // [self.textState setEnabled:NO];//set enabled
    
    self.textnumber.delegate = self; //Abhishek // For Phone number validation
    [self.textnumber addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged]; //Abhishek // For phone number validation
    
    
    UIButton *District = [UIButton buttonWithType:UIButtonTypeCustom];
    District.frame = CGRectMake(379, 0, 30, 30);
    [District setBackgroundImage:[UIImage imageNamed:@"dropdown1.png"] forState:UIControlStateNormal];
    
    [District addTarget:self action:@selector(Districtdropdown) forControlEvents:UIControlEventTouchUpInside];
    [self.textDistrict addSubview:District];
    
    UIButton *city = [UIButton buttonWithType:UIButtonTypeCustom];
    city.frame = CGRectMake(379, 0, 30, 30);
    [city setBackgroundImage:[UIImage imageNamed:@"dropdown1.png"] forState:UIControlStateNormal];
    
    [city addTarget:self action:@selector(Citydropdown) forControlEvents:UIControlEventTouchUpInside];
    [self.textCity addSubview:city];
    
    UIButton *taluka = [UIButton buttonWithType:UIButtonTypeCustom];
    taluka.frame = CGRectMake(379, 0, 30, 30);
    [taluka setBackgroundImage:[UIImage imageNamed:@"dropdown1.png"] forState:UIControlStateNormal];
    
    [taluka addTarget:self action:@selector(Talukadropdown) forControlEvents:UIControlEventTouchUpInside];
    [self.textTaluka addSubview:taluka];
    
    UIButton *pincode = [UIButton buttonWithType:UIButtonTypeCustom];
    pincode.frame = CGRectMake(379, 0, 30, 30);
    [pincode setBackgroundImage:[UIImage imageNamed:@"dropdown1.png"] forState:UIControlStateNormal];
    
    [pincode addTarget:self action:@selector(Pincodedropdown) forControlEvents:UIControlEventTouchUpInside];
    [self.textpostalcode addSubview:pincode];
    
    UIButton *LOB = [UIButton buttonWithType:UIButtonTypeCustom];
    LOB.frame = CGRectMake(379, 0, 30, 30);
    [LOB setBackgroundImage:[UIImage imageNamed:@"dropdown1.png"] forState:UIControlStateNormal];
    
    [LOB addTarget:self action:@selector(LOBdropdown) forControlEvents:UIControlEventTouchUpInside];
    [self.LOB addSubview:LOB];
    
    UIButton *PPL = [UIButton buttonWithType:UIButtonTypeCustom];
    PPL.frame = CGRectMake(379, 0, 30, 30);
    [PPL setBackgroundImage:[UIImage imageNamed:@"dropdown1.png"] forState:UIControlStateNormal];
    
    [PPL addTarget:self action:@selector(PPLdropdown) forControlEvents:UIControlEventTouchUpInside];
    [self.PPL addSubview:PPL];
    
    UIButton *PL = [UIButton buttonWithType:UIButtonTypeCustom];
    PL.frame = CGRectMake(379, 0, 30, 30);
    [PL setBackgroundImage:[UIImage imageNamed:@"dropdown1.png"] forState:UIControlStateNormal];
    
    [PL addTarget:self action:@selector(PLdropdown) forControlEvents:UIControlEventTouchUpInside];
    [self.PL addSubview:PL];
    
    
    UIButton *APP = [UIButton buttonWithType:UIButtonTypeCustom];
    APP.frame = CGRectMake(379, 0, 30, 30);
    [APP setBackgroundImage:[UIImage imageNamed:@"dropdown1.png"] forState:UIControlStateNormal];
    
    [APP addTarget:self action:@selector(APPdropdown) forControlEvents:UIControlEventTouchUpInside];
    [self.APPLICATION addSubview:APP];
    
    UIButton *CONTACT = [UIButton buttonWithType:UIButtonTypeCustom];
    CONTACT.frame = CGRectMake(379, 0, 30, 30);
    [CONTACT setBackgroundImage:[UIImage imageNamed:@"dropdown1.png"] forState:UIControlStateNormal];
    
    [CONTACT addTarget:self action:@selector(CONTACTdropdown) forControlEvents:UIControlEventTouchUpInside];
    [self.SOURCEOFCONTACT addSubview:CONTACT];
    
    UIButton *FINANCIER = [UIButton buttonWithType:UIButtonTypeCustom];
    FINANCIER.frame = CGRectMake(379, 0, 30, 30);
    [FINANCIER setBackgroundImage:[UIImage imageNamed:@"dropdown1.png"] forState:UIControlStateNormal];
    
    [FINANCIER addTarget:self action:@selector(FINANCIERdropdown) forControlEvents:UIControlEventTouchUpInside];
    [self.FINANCIER addSubview:FINANCIER];
    
    
    self.textDistrict.delegate = self; //abhishek
    self.textCity.delegate = self; //abhishek
    self.textTaluka.delegate = self; //abhishek
    self.textpostalcode.delegate = self; //abhishek
    self.LOB.delegate = self;//abhishek
    self.PPL.delegate = self;//abhishek
    self.PL.delegate = self;//abhishek
    self.APPLICATION.delegate = self;//abhishek
    self.SOURCEOFCONTACT.delegate = self;//abhishek
    self.FINANCIER.delegate = self;//abhishek
    
    
    
    // textfiled placeholder images
    
    /* _textArea.rightViewMode = UITextFieldViewModeAlways;
     _textArea.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textlist@2x.png"]];
     
     _textArea.rightView.frame = CGRectMake(0, 0, 30, 30);*/
    
    
    /*   _textState.rightViewMode = UITextFieldViewModeAlways;
     _textState.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textlist@2x.png"]];
     
     _textState.rightView.frame = CGRectMake(0, 0, 30, 30);
     
     _textTaluka.rightViewMode = UITextFieldViewModeAlways;
     _textTaluka.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textlist@2x.png"]];
     
     _textTaluka.rightView.frame = CGRectMake(0, 0, 30, 30);
     
     
     _textCity.rightViewMode = UITextFieldViewModeAlways;
     _textCity.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textlist@2x.png"]];
     
     _textCity.rightView.frame = CGRectMake(0, 0, 30, 30);
     
     
     _textDistrict.rightViewMode = UITextFieldViewModeAlways;
     _textDistrict.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textlist@2x.png"]];
     
     _textDistrict.rightView.frame = CGRectMake(0, 0, 30, 30);
     
     
     _textTaluka.rightViewMode = UITextFieldViewModeAlways;
     _textTaluka.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textlist@2x.png"]];
     
     _textTaluka.rightView.frame = CGRectMake(0, 0, 30, 30);
     
     
     
     _textpostalcode.rightViewMode = UITextFieldViewModeAlways;
     _textpostalcode.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textlist@2x.png"]];
     
     _textpostalcode.rightView.frame = CGRectMake(0, 0, 30, 30);*/
    
    
    _txtfldLob.rightViewMode = UITextFieldViewModeAlways;
    _txtfldLob.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textlist@2x.png"]];
    _txtfldLob.rightView.frame = CGRectMake(0, 0, 30, 30);
    
    
    _txtfldPpl.rightViewMode = UITextFieldViewModeAlways;
    _txtfldPpl.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textlist@2x.png"]];
    _txtfldPpl.rightView.frame = CGRectMake(0, 0, 30, 30);
    
    
    _txtfldpl.rightViewMode = UITextFieldViewModeAlways;
    _txtfldpl.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textlist@2x.png"]];
    _txtfldpl.rightView.frame = CGRectMake(0, 0, 30, 30);
    
    
    _txtfldApp.rightViewMode = UITextFieldViewModeAlways;
    _txtfldApp.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textlist@2x.png"]];
    _txtfldApp.rightView.frame = CGRectMake(0, 0, 30, 30);
    
    _txtfldContact.rightViewMode = UITextFieldViewModeAlways;
    _txtfldContact.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textlist@2x.png"]];
    _txtfldContact.rightView.frame = CGRectMake(0, 0, 30, 30);
    
    _txtFinancer.rightViewMode = UITextFieldViewModeAlways;
    _txtFinancer.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textlist@2x.png"]];
    _txtFinancer.rightView.frame = CGRectMake(0, 0, 30, 30);
    
    showStates = [[NSMutableArray alloc] initWithObjects:@"Andaman & Nicobar",@"Andhra Pradesh",@"Arunachal Pradesh",@"Assam",@"Bihar",@"Chattishgarh",@"Chennai",@"Daman & Diu",@"Delhi",@"Dadra, Nagarhaveli",@"Goa",@"Gujarat",@"Himachal Pradesh",@"Haryana",@"Jharkhand",@"Jammu & Kashmir",@"Karnataka",@"Kerala",@"Lakshwadeep",@"Maharashtra",@"Meghalaya",@"Manipur",@"Madhya Pradesh",@"Mizoram",@"Nagaland",@"Orrisa",@"Punjab",@"Pondicherry",@"Rajasthan",@"Sikkim",@"Telangana",@"Tamil Nadu",@"Tripura",@"Uttarkhand",@"Uttar Pradesh",@"West Bengal",nil];
    
    btn_CreateAccount.enabled = NO; //Abhishek
    // btn_CreateAccount.backgroundColor = [UIColor colorWithRed:(165/255.0)green:(177/255.0) blue:(12/255.0) alpha:1]; //Abhishek
    btn_CreateAccount.backgroundColor = [UIColor colorWithRed:(101/255.0)green:(104/255.0) blue:(27/255.0) alpha:1];
    
    self.CreateOppurtunityView.layer.borderColor=[UIColor colorWithRed:(255/255.0)green:(255/255.0) blue:(255/255.0) alpha:1].CGColor;
    btn_CreateOpty.enabled = NO;//Abhishek
    btn_CreateOpty.backgroundColor = [UIColor colorWithRed:(101/255.0)green:(104/255.0) blue:(27/255.0) alpha:1];//Abhishek
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestLOBListFound:) name:@"LobListFound" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestPPL_ListFound:) name:@"PPL_ListFound" object:nil];
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestPL_ListFound:) name:@"PL_ListFound" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestApplication_ListFound:) name:@"Application_ListFound" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(request_Financier_ListFound:) name:@"Financier_ListFound" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(request_Indian_States_ListFound:) name:@"Indian_States_ListFound" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(request_District_ListFound:) name:@"District_ListFound" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(request_City_ListFound:) name:@"City_ListFound" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(request_PostalCode_ListFound:) name:@"Postal_code_ListFound" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(request_Taluka_ListFound:) name:@"Taluka_ListFound" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(contactlistfetchedAlert:) name:@"Contact_ListPopulated" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(CreateContactFound:) name:@"CreateContact_Found" object:nil];// create contact notification
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(CreateAccountFound:) name:@"CreateAccountFound" object:nil];// create contact notification
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(PL_ProductID_ListFound:) name:@"PL_ProductID_ListFound" object:nil]; // PL_Product_
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(CreateAccountAgainst_ContactFound:) name:@"CreateAccountAgainst_ContactFound" object:nil]; // PL_Product_
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getCreateOpportunity_Found:) name:@"getCreateOpportunity_Found" object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"\nView Did Dissapears...!!!!");
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"LobListFound" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"PPL_ListFound" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"PL_ListFound" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"Application_ListFound" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"Financier_ListFound" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"Indian_States_ListFound" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"District_ListFound" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"City_ListFound" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"Postal_code_ListFound" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"Taluka_ListFound" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"CreateContactConnectionFound" object:nil]; //create contact// remove from notification
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"CreateAccountFound" object:nil]; //crea
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"PL_ProductID_ListFound" object:nil]; //crea
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"CreateAccountAgainst_ContactFound" object:nil]; //crea
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"getCreateOpportunity_Found" object:nil]; //
    
}


//Abhishek

- (IBAction)txt_mobileNoAction:(id)sender {
    
    NSLog(@"\n txt mobile number.....");
}


//Abhishek

-(void)textFieldDidChange :(UITextField *)theTextField{
    NSLog( @"text changed: %@", theTextField.text);
    
    NSUInteger testLen = [self length:self.textnumber.text];
    NSLog(@"\n\n testLen .... %d",testLen);
    
    if (testLen >10) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Invalid Cell Number " delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
        self.textnumber.text = @"";
    }
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string //Abhishek
{
    if (textField == self.textnumber) {
        NSLog(@"test");
        NSString * test123 = string;
        NSLog(@"\n \n test.. %@",test123);
        
        if (![self isNumeric:test123] ){ //mobileNumber Check //Abhishek
            // self.textnumber.text = @"";
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Enter number only " delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            alertView.delegate = self;
            alertView.tag = 130;
            [alertView show];
        }
        else {
            NSLog(@"\n\n Allowed");
        }
    }
    return YES;
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField // Abhishek
{
    NSLog(@"\n Testing.....");
    
    if (textField == self.textnumber) {
        NSLog(@"\n Testing.....");
        return YES;
    }
    
    if (textField == self.textState) {
        [textField resignFirstResponder];
        return NO;
    }
    else if (textField == self.textDistrict){
        [textField resignFirstResponder];
        return NO;
    }
    else if (textField == self.textCity){
        [textField resignFirstResponder];
        return NO;
    }
    else if (textField == self.textTaluka){
        [textField resignFirstResponder];
        return NO;
    }
    else if (textField == self.textpostalcode){
        [textField resignFirstResponder];
        return NO;
    }
    else if (textField == self.LOB ){
        [textField resignFirstResponder];
        return NO;
    }
    else if (textField == self.PPL){
        [textField resignFirstResponder];
        return NO;
    }
    else if (textField ==  self.PL){
        [textField resignFirstResponder];
        return NO;
    }
    else if (textField ==  self.APPLICATION){
        [textField resignFirstResponder];
        return NO;
    }
    else if (textField == self.SOURCEOFCONTACT){
        [textField resignFirstResponder];
        return NO;
    }
    else if (textField == self.FINANCIER ){
        [textField resignFirstResponder];
        return NO;
    }
    else
    {
        return YES;
    }
    return YES;
}


#pragma mark - Create oppurtunity textfield methods
//- (IBAction)textLob:(UITextField *)sender {
-(void)LOBdropdown{
    //[self.LOB resignFirstResponder];
    // [self.LOB setText:sender.text];
    
    self.LOB.text = @"";//abhishek
    self.PPL.text = @"";//abhishek
    self.PL.text = @"";//abhishek
    self.APPLICATION.text = @"";//abhishek
    self.SOURCEOFCONTACT.text = @"";//abhishek
    self.FINANCIER.text = @"";//abhishek
    
    
    NSString * envelopeText = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<GetAllLOB xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\" />"
                               @" </SOAP:Body>"
                               @"</SOAP:Envelope>"];
    
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",self.appdelegate.URL,self.appdelegate.artifact]];
    NSLog(@"URL IS .... %@",theurl);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    [[RequestDelegate alloc]initiateRequest:request name:@"GetLOB"];
}




-(void)PPLdropdown
{
    [self.PPL resignFirstResponder];
    
    self.PL.text = @""; //Abhishek
    self.APPLICATION.text = @"";//abhishek
    
    if ([self.PPL_List_PickerArr count] == 0)//abhishek
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"ALERT"
                                                       message:@"Data not avilable for selected LOB"
                                                      delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@""
                                      delegate:self
                                      cancelButtonTitle:nil
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:nil];
        
        // Add buttons one by one (e.g. in a loop from array etc...)
        for (int i=0; i<[self.PPL_List_PickerArr count]; i++)
        {
            [actionSheet addButtonWithTitle:[self.PPL_List_PickerArr objectAtIndex:i]];
        }
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            [actionSheet showFromRect:[self.PPL frame] inView:self.oppurtunityView animated:YES];
        }
        else
        {
            [actionSheet showInView:self.view];
        }
        
        actionSheet.tag = 2000;
        [self.appdelegate hideAlert];
        
    }
}

//- (IBAction)textPl:(id)sender {

-(void)PLdropdown{
    [self.PL resignFirstResponder];
    
    self.APPLICATION.text = @"";//Abhishek
    
    if ([self.LOB.text isEqualToString:@""] || [self.PPL.text isEqualToString:@""] ) //Abhishek
    {
        NSLog(@"\n\n checking");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ALERT"
                                                        message:@"Please select From LOB & PPL First"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    else
    {
        NSLog(@"%@",[self.PL_List_PickerArr description]);
        
        if ([self.PL_List_PickerArr count] == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ALERT"
                                                            message:@"Data not avilable"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                          initWithTitle:@""
                                          delegate:self
                                          cancelButtonTitle:nil
                                          destructiveButtonTitle:nil
                                          otherButtonTitles:nil];
            
            // Add buttons one by one (e.g. in a loop from array etc...)
            for (int i=0; i<[self.PL_List_PickerArr count]; i++)
            {
                [actionSheet addButtonWithTitle:[self.PL_List_PickerArr objectAtIndex:i]];
            }
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                [actionSheet showFromRect:[self.PL frame] inView:self.oppurtunityView animated:YES];
            }
            else
            {
                [actionSheet showInView:self.view];
            }
            actionSheet.tag = 3000;
            [self.appdelegate hideAlert];
        }
    }
}



//Abhishek

//- (IBAction)textapp:(id)sender {


-(void)APPdropdown
{
    [self call_PL_ProductLine];
    
    [self.APPLICATION resignFirstResponder];
    
    
    if ([self.Application_List_PickerArr count]==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ALERT"
                                                        message:@"Please select From LOB & PPL First"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@""
                                      delegate:self
                                      cancelButtonTitle:nil
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:nil];
        
        // Add buttons one by one (e.g. in a loop from array etc...)
        
        for (int i=0; i<[self.Application_List_PickerArr count]; i++)
        {
            [actionSheet addButtonWithTitle:[self.Application_List_PickerArr objectAtIndex:i]];
        }
        
        //
        //
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            [actionSheet showFromRect:[self.APPLICATION frame] inView:self.oppurtunityView animated:YES];
        }
        
        else
        {
            [actionSheet showInView:self.view];
        }
        
        actionSheet.tag = 4000;
        [self.appdelegate hideAlert];
    }
}

//- (IBAction)textfinance:(id)sender {
-(void)FINANCIERdropdown{
    
    [self.FINANCIER resignFirstResponder];
    [self showAlert];
    
    
    NSString * envelopeText = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<GetFinancierDetailsForDSM xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\" />"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>"];
    
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",self.appdelegate.URL,self.appdelegate.artifact]];
    NSLog(@"URL IS .... %@",theurl);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    [[RequestDelegate alloc]initiateRequest:request name:@"GetFinanceList"];
    //actionSheet4.tag = 5000;
}

//- (IBAction)textContact:(id)sender {

-(void)CONTACTdropdown
{
    [self.SOURCEOFCONTACT resignFirstResponder];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@""
                                  delegate:self
                                  cancelButtonTitle:nil
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:nil];
    
    // Add buttons one by one (e.g. in a loop from array etc...)
    for (int i=0; i<[self.Source_Contact_List_PickerArr count]; i++)
    {
        [actionSheet addButtonWithTitle:[self.Source_Contact_List_PickerArr objectAtIndex:i]];
    }
    
    //
    //
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        //
        [actionSheet showFromRect:[self.SOURCEOFCONTACT frame] inView:self.oppurtunityView animated:YES];
    }
    else
    {
        [actionSheet showInView:self.view];
    }
    
    actionSheet.tag = 6000;
    [self.appdelegate hideAlert];
    
    
}
-(void)statedropdown{
    //- (IBAction)textState:(UITextField *)sender {
    //  [self.textState resignFirstResponder]; //Abhishek
    
    [self showAlert];
    //[self.textState setText:sender.text];
    
    //Abbhishek
    self.textState.text = @"";
    self.textDistrict.text = @"";
    self.textCity.text = @"";
    self.textTaluka.text = @"";
    self.textpostalcode.text = @"";
    
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
                               @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"correlationID\">00215ef7-d846-11e4-faf1-0ea55009db29</DC>"
                               @"</Logger>"
                               @"</header>"
                               @"</SOAP:Header>"
                               @"<SOAP:Body>"
                               @"<GetAllIndianStates xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\" />"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>"];
    
    
    
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",self.appdelegate.URL,self.appdelegate.artifact]];
    NSLog(@"URL IS .... %@",theurl);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    [[RequestDelegate alloc]initiateRequest:request name:@"GetIndianStates"];
}



-(void)Districtdropdown{
    
    if ([self.textState.text isEqualToString:@""] ) //Ahishek
    {
        NSLog(@"\n\n checking");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ALERT"
                                                        message:@"Please select state"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    self.textDistrict.text = @"";
    self.textCity.text = @"";
    self.textTaluka.text = @"";
    self.textpostalcode.text = @"";
    
    [self showAlert];
    //   NSString *statesstring=self.textState.text;
    NSArray *statesstring = [self.dict allKeysForObject:self.textState.text];
    NSLog(@"%@",[statesstring objectAtIndex:0]);
    self.statestringdecoded=[statesstring objectAtIndex:0];
    
    
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
                               @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"correlationID\">00215ef7-d846-11e4-fd00-63521e2f1f31</DC>"
                               @"</Logger>"
                               @"</header>"
                               @"</SOAP:Header>"
                               @"<SOAP:Body>"
                               @"<GetAllIndianDistricts xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                               @"<state>%@</state>"
                               @"</GetAllIndianDistricts>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",self.statestringdecoded];
    
    
    
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",self.appdelegate.URL,self.appdelegate.artifact]];
    NSLog(@"URL IS .... %@",theurl);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    [[RequestDelegate alloc]initiateRequest:request name:@"GetDistrict"];
    
    
}
//- (IBAction)textCity:(UITextField *)sender {
-(void)Citydropdown{
    
    if ([self.textState.text isEqualToString:@""] || [self.textDistrict.text isEqualToString:@""] ) //Abhishek
    {
        NSLog(@"\n\n checking");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ALERT"
                                                        message:@"State or District field is missing"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    self.textCity.text = @"";
    self.textTaluka.text = @"";
    self.textpostalcode.text = @"";
    
    [self showAlert];
    NSString * envelopeText = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<GetAllIndianCity xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                               @"<state>%@</state>"
                               @"<dist>%@</dist>"
                               @"</GetAllIndianCity>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",self.statestringdecoded,self.textDistrict.text];
    
    
    
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",self.appdelegate.URL,self.appdelegate.artifact]];
    NSLog(@"URL IS .... %@",theurl);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    [[RequestDelegate alloc]initiateRequest:request name:@"GetCity"];
    
    
}
//- (IBAction)textPincode:(UITextField *)sender {
-(void)Pincodedropdown{
    // [self.textpostalcode resignFirstResponder];
    self.textpostalcode.text = @"";
    
    [self showAlert];
    NSString * envelopeText = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<GetAllIndianPostalCode xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                               @"<state>%@</state>"
                               @"<dist>%@</dist>"
                               @"<city>%@</city>"
                               @"<taluka>%@</taluka>"
                               @"</GetAllIndianPostalCode>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",self.statestringdecoded,self.textDistrict.text,self.textCity.text,self.textTaluka.text];
    
    
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",self.appdelegate.URL,self.appdelegate.artifact]];
    NSLog(@"URL IS .... %@",theurl);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    [[RequestDelegate alloc]initiateRequest:request name:@"GetPostalCode"];
    
}

//- (IBAction)textTaluka:(UITextField *)sender {
-(void)Talukadropdown{
    [self.textTaluka resignFirstResponder];
    //[self.textState setText:sender.text];
    
    self.textTaluka.text = @"";
    self.textpostalcode.text = @"";
    
    [self showAlert];
    
    NSString * envelopeText = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<GetAllIndianTaluka xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                               @"<state>%@</state>"
                               @"<dist>%@</dist>"
                               @"<city>%@</city>"
                               @"</GetAllIndianTaluka>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",self.statestringdecoded,self.textDistrict.text,self.textCity.text];
    
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",self.appdelegate.URL,self.appdelegate.artifact]];
    NSLog(@"URL IS .... %@",theurl);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    [[RequestDelegate alloc]initiateRequest:request name:@"GetTaluka"];
}

- (IBAction)getAccountNumber:(id)sender {
    
}


#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"ContactViewCell";
    
    ContactViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[ContactViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
    cell.backgroundColor=[UIColor clearColor];
    cell.cellView.layer.cornerRadius=5;
    
    cell.contactViewImage.layer.cornerRadius=37.5;
    cell.contactViewImage.layer.cornerRadius = cell.contactViewImage.frame.size.height /2;
    cell.contactViewImage.layer.masksToBounds = YES;
    cell.contactViewImage.layer.borderWidth = 0;
    
    [cell.contactViewImage.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [cell.contactViewImage.layer setBorderWidth: 2.0];
    
    cell.contactViewImage.image=[UIImage imageNamed:@"28.jpg"];
    
    
    return cell;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)info_btn
{
    //  NSLog(@"Home biscuit from Sanfrancisco");
    [self performSegueWithIdentifier:@"infoView" sender:self];
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
    //  NSLog(@"Home biscuit from Sanfrancisco");
}
// delegate mehod for uialertView
#pragma mark - UIAlertView Delegate
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
#pragma mark - Scroll View Delegate
//scroll view

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSLog(@"test");
    
    self.scroll_icons.image=[UIImage imageNamed:@"icon_scroll.png"];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.scroll_icons.image=[UIImage imageNamed:@"icon_upscroll.png"];
    
    NSLog(@"Dhoom..");
}

#pragma mark - Request's response Delegate Methods
-(void)requestLOBListFound:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\nResponse....%@",response);
    
    if (self.opp_Contact_LOB_PickerArr)
    {
        
        [self.opp_Contact_LOB_PickerArr removeAllObjects];
        
    }
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    TBXMLElement *container = [TBXML childElementNamed:@"GetAllLOBResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
    
    if (tuple)
    {
        
        do {
            
            TBXMLElement *S_PROD_LN  = [TBXML childElementNamed:@"S_LST_OF_VAL" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
            
            TBXMLElement *NAME = [TBXML childElementNamed:@"VAL" parentElement:S_PROD_LN];
            NSString* Name = [TBXML textForElement:NAME];
            NSLog(@"CONTACT_ID : %@",Name);
            [self.opp_Contact_LOB_PickerArr addObject:Name];
            
        }while ((tuple = tuple->nextSibling));
    }
    
    [self hideAlert];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@""
                                  delegate:self
                                  cancelButtonTitle:nil
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:nil];
    
    // Add buttons one by one (e.g. in a loop from array etc...)
    for (int i=0; i<[self.opp_Contact_LOB_PickerArr count]; i++)
    {
        [actionSheet addButtonWithTitle:[self.opp_Contact_LOB_PickerArr objectAtIndex:i]];
        
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        
        [actionSheet showFromRect:[self.LOB frame] inView:self.oppurtunityView animated:YES];
    }
    
    
    else
    {
        
        [actionSheet showInView:self.view];
        
    }
    
    actionSheet.tag = 1000;
    
    [self.appdelegate hideAlert];
    
}
-(void)requestPPL_ListFound:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\nResponse....%@",response);
    
    if (self.PPL_List_PickerArr)
    {
        
        [self.PPL_List_PickerArr removeAllObjects];
        
    }
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    TBXMLElement *container = [TBXML childElementNamed:@"GetPPLFromLOBResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
    
    if (tuple)
    {
        
        do {
            
            TBXMLElement *S_PROD_LN  = [TBXML childElementNamed:@"S_PROD_LN" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
            
            TBXMLElement *NAME = [TBXML childElementNamed:@"NAME" parentElement:S_PROD_LN];
            NSString* Name = [TBXML textForElement:NAME];
            NSLog(@"PPLIST FOR LOB : %@",Name);
            
            
            [self.PPL_List_PickerArr addObject:Name];
            
        }while ((tuple = tuple->nextSibling));
    }
    NSLog(@"%d",[self.PPL_List_PickerArr count]);
    
    
    
}
-(void)requestPL_ListFound:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\nResponse....%@",response);
    
    if (self.PL_List_PickerArr)
    {
        
        [self.PL_List_PickerArr removeAllObjects];
        
    }
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    TBXMLElement *container = [TBXML childElementNamed:@"GetPLFromPPLResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
    
    if (tuple)
    {
        
        do {
            
            TBXMLElement *S_PROD_LN  = [TBXML childElementNamed:@"s_prod_int" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
            
            TBXMLElement *NAME = [TBXML childElementNamed:@"PL" parentElement:S_PROD_LN];
            NSString* Name = [TBXML textForElement:NAME];
            NSLog(@"PLIST FOR PPL : %@",Name);
            
            
            [self.PL_List_PickerArr addObject:Name];
            
        }while ((tuple = tuple->nextSibling));
    }
    NSLog(@"%d",[self.PL_List_PickerArr count]);
    
    
}

-(void)requestApplication_ListFound:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\nResponse....%@",response);
    
    if (self.Application_List_PickerArr)
    {
        
        [self.Application_List_PickerArr removeAllObjects];
        
    }
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    TBXMLElement *container = [TBXML childElementNamed:@"GetTMCVIndentAppsResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
    
    if (tuple)
    {
        
        do {
            
            TBXMLElement *S_Lst_Of_Val  = [TBXML childElementNamed:@"S_Lst_Of_Val" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
            
            TBXMLElement *NAME = [TBXML childElementNamed:@"NAME" parentElement:S_Lst_Of_Val];
            NSString* Name = [TBXML textForElement:NAME];
            NSLog(@"Application_LIST FOR PPL : %@",Name);
            
            
            [self.Application_List_PickerArr addObject:Name];
            
        }while ((tuple = tuple->nextSibling));
    }
    NSLog(@"%d",[self.Application_List_PickerArr count]);
    
    
}
-(void)request_Financier_ListFound:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\nResponse....%@",response);
    
    if (self.Financier_List_PickerArr)
    {
        
        [self.Financier_List_PickerArr removeAllObjects];
        
    }
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    TBXMLElement *container = [TBXML childElementNamed:@"GetFinancierDetailsForDSMResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
    
    if (tuple)
    {
        
        do {
            
            TBXMLElement *S_ORG_EXT  = [TBXML childElementNamed:@"S_ORG_EXT" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
            
            
            
            TBXMLElement *ACC_NAME = [TBXML childElementNamed:@"ACC_NAME" parentElement:S_ORG_EXT];
            
            NSString* Name = [TBXML textForElement:ACC_NAME];
            
            NSLog(@"Application_LIST FOR PPL : %@",Name);
            
            
            [self.Financier_List_PickerArr addObject:Name];
            
        }while ((tuple = tuple->nextSibling));
    }
    
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@""
                                  delegate:self
                                  cancelButtonTitle:nil
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:nil];
    [actionSheet addButtonWithTitle:@"SELF"];
    
    
    for (int i=0; i<[self.Financier_List_PickerArr count]; i++)
    {
        [actionSheet addButtonWithTitle:[self.Financier_List_PickerArr objectAtIndex:i]];
        
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        
        [actionSheet showFromRect:[self.FINANCIER frame] inView:self.oppurtunityView animated:YES];
        [self hideAlert];
    }
    
    else
    {
        
        [actionSheet showInView:self.view];
        
    }
    
    actionSheet.tag = 7000;
    
    
}
-(void)request_Indian_States_ListFound:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\nResponse....%@",response);
    
    if (self.States_List_PickerArr)
    {
        
        [self.States_List_PickerArr removeAllObjects];
        
    }
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    TBXMLElement *container = [TBXML childElementNamed:@"GetAllIndianStatesResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
    
    if (tuple)
    {
        
        do {
            
            TBXMLElement *CX_DISTRICT_MAS  = [TBXML childElementNamed:@"CX_DISTRICT_MAS" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
            
            TBXMLElement *NAME = [TBXML childElementNamed:@"X_STATE" parentElement:CX_DISTRICT_MAS];
            NSString* Name = [TBXML textForElement:NAME];
            NSLog(@"CX_DISTRICT_MAS : %@",Name);
            [self.States_List_PickerArr addObject:Name];
            // NSLog(@"%@",Name);
        }while ((tuple = tuple->nextSibling));
        
        self.dict = [[NSMutableDictionary alloc]initWithCapacity:[self.States_List_PickerArr  count]];
        [ self.dict setObject:[NSString stringWithFormat:@"Maharastra"] forKey:@"MH"];
        [ self.dict setObject:[NSString stringWithFormat:@"Andaman and Nicobar Islands"] forKey:@"AN"];
        [ self.dict setObject:[NSString stringWithFormat:@"Andhra Pradesh"] forKey:@"AP"];
        [ self.dict setObject:[NSString stringWithFormat:@"Arunachal Pradesh"] forKey:@"AR"];
        [ self.dict setObject:[NSString stringWithFormat:@"Assam"] forKey:@"AS"];
        [ self.dict setObject:[NSString stringWithFormat:@"Bihar"] forKey:@"BR"];
        [self.dict setObject:[NSString stringWithFormat:@"Chhattisgarh"] forKey:@"CG"];
        [self.dict setObject:[NSString stringWithFormat:@"Chandigarh"] forKey:@"CH"];
        [self.dict setObject:[NSString stringWithFormat:@"Daman and Diu"] forKey:@"DD"];
        [self.dict setObject:[NSString stringWithFormat:@"Delhi"] forKey:@"DL"];
        [self.dict setObject:[NSString stringWithFormat:@"Dadra and Nagar Haveli"] forKey:@"DN"];
        [self.dict setObject:[NSString stringWithFormat:@"Goa"] forKey:@"GA"];
        [self.dict setObject:[NSString stringWithFormat:@"Gujarat"] forKey:@"GJ"];
        [self.dict setObject:[NSString stringWithFormat:@"Himachal Pradesh"] forKey:@"HP"];
        [self.dict setObject:[NSString stringWithFormat:@"Haryana"] forKey:@"HR"];
        [self.dict setObject:[NSString stringWithFormat:@"Jharkhand"] forKey:@"JH"];
        [self.dict setObject:[NSString stringWithFormat:@"Jammu and Kashmir"] forKey:@"JK"];
        [self.dict setObject:[NSString stringWithFormat:@"Karnataka"] forKey:@"KA"];
        [self.dict setObject:[NSString stringWithFormat:@"Kerala"] forKey:@"KL"];
        [self.dict setObject:[NSString stringWithFormat:@"Lakshadweep"] forKey:@"LD"];
        [self.dict setObject:[NSString stringWithFormat:@"Meghalaya"] forKey:@"ML"];
        [self.dict setObject:[NSString stringWithFormat:@"Manipur"] forKey:@"MN"];
        [self.dict setObject:[NSString stringWithFormat:@"Madhya Pradesh"] forKey:@"MP"];
        [self.dict setObject:[NSString stringWithFormat:@"Mizoram"] forKey:@"MZ"];
        [self.dict setObject:[NSString stringWithFormat:@"Nagaland"] forKey:@"NL"];
        [self.dict setObject:[NSString stringWithFormat:@"Odisha"] forKey:@"OR"];
        [self.dict setObject:[NSString stringWithFormat:@"Punjab"] forKey:@"PB"];
        [self.dict setObject:[NSString stringWithFormat:@"Puducherry"] forKey:@"PY"];
        [self.dict setObject:[NSString stringWithFormat:@"Rajasthan"] forKey:@"RJ"];
        [self.dict setObject:[NSString stringWithFormat:@"Sikkim"] forKey:@"SK"];
        [self.dict setObject:[NSString stringWithFormat:@"Telangana"] forKey:@"TG"];
        [self.dict setObject:[NSString stringWithFormat:@"Tamil Nadu"] forKey:@"TN"];
        [self.dict setObject:[NSString stringWithFormat:@"Tripura"] forKey:@"TR"];
        [self.dict setObject:[NSString stringWithFormat:@"Uttarnchal"] forKey:@"UA"];
        [self.dict setObject:[NSString stringWithFormat:@"Uttar Pradesh"] forKey:@"UP"];
        [self.dict setObject:[NSString stringWithFormat:@"West Bengal"] forKey:@"WB"];
        NSLog(@"%@",[self.dict description]);
        
        
        
    }
    [self hideAlert];
    
    //  [self.progressView removeFromSuperview];
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@""
                                  delegate:self
                                  cancelButtonTitle:nil
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:nil];
    
    
    for (int i=0; i<[self.States_List_PickerArr count]; i++)
    {
        // [actionSheet addButtonWithTitle:[self.States_List_PickerArr objectAtIndex:i]];
        [actionSheet addButtonWithTitle: [self.dict valueForKey:[self.States_List_PickerArr objectAtIndex:i]]];
        // [self.dict valueForKey:[self.States_List_PickerArr objectAtIndex:i]];
        NSLog(@"statesEncoded:%d,%@",i,[self.dict valueForKey:[self.States_List_PickerArr objectAtIndex:i]]);
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [actionSheet showFromRect:[self.textState frame] inView:self.oppurtunityView animated:YES];
    }
    else
    {
        [actionSheet showInView:self.view];
    }
    
    actionSheet.tag = 100;
}



-(void)request_District_ListFound:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\nResponse....%@",response);
    
    if (self.District_List_PickerArr)
    {
        
        [self.District_List_PickerArr removeAllObjects];
        
    }
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    TBXMLElement *container = [TBXML childElementNamed:@"GetAllIndianDistrictsResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
    
    if (tuple)
    {
        
        do {
            
            TBXMLElement *CX_DISTRICT_MAS  = [TBXML childElementNamed:@"CX_DISTRICT_MAS" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
            
            TBXMLElement *X_DISTRICT = [TBXML childElementNamed:@"X_DISTRICT" parentElement:CX_DISTRICT_MAS];
            NSString* Name = [TBXML textForElement:X_DISTRICT];
            // NSLog(@"X_DISTRICT: %@",X_DISTRICT);
            
            
            [self.District_List_PickerArr addObject:Name];
            
        }while ((tuple = tuple->nextSibling));
    }
    
    [self hideAlert];
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@""
                                  delegate:self
                                  cancelButtonTitle:nil
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:nil];
    
    
    for (int i=0; i<[self.District_List_PickerArr count]; i++)
    {
        [actionSheet addButtonWithTitle:[self.District_List_PickerArr objectAtIndex:i]];
        
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [actionSheet showFromRect:[self.textDistrict frame] inView:self.oppurtunityView animated:YES];
    }
    else
    {
        
        [actionSheet showInView:self.view];
        
    }
    
    actionSheet.tag = 200;
    
    
}

-(void)request_City_ListFound:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\nResponse....%@",response);
    
    
    
    if (self.City_List_PickerArr)
    {
        
        [self.City_List_PickerArr removeAllObjects];
        
    }
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    TBXMLElement *container = [TBXML childElementNamed:@"GetAllIndianCityResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
    
    if (tuple)
    {
        
        do {
            
            TBXMLElement *CX_DISTRICT_MAS  = [TBXML childElementNamed:@"CX_DISTRICT_MAS" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
            
            TBXMLElement *X_CITY = [TBXML childElementNamed:@"X_CITY" parentElement:CX_DISTRICT_MAS];
            NSString* Name = [TBXML textForElement:X_CITY];
            
            
            
            [self.City_List_PickerArr addObject:Name];
            
        }while ((tuple = tuple->nextSibling));
    }
    
    [self hideAlert];
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@""
                                  delegate:self
                                  cancelButtonTitle:nil
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:nil];
    
    
    for (int i=0; i<[self.City_List_PickerArr count]; i++)
    {
        [actionSheet addButtonWithTitle:[self.City_List_PickerArr objectAtIndex:i]];
        
    }
    
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        
        [actionSheet showFromRect:[self.textCity frame] inView:self.oppurtunityView animated:YES];
    }
    
    
    else
    {
        
        [actionSheet showInView:self.view];
        
    }
    
    actionSheet.tag = 300;
    
    
}
-(void)request_PostalCode_ListFound:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\nResponse....%@",response);
    
    if (self.PostalCode_List_PickerArr)
    {
        
        [self.PostalCode_List_PickerArr removeAllObjects];
        
    }
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    TBXMLElement *container = [TBXML childElementNamed:@"GetAllIndianPostalCodeResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
    
    if (tuple)
    {
        
        do {
            
            TBXMLElement *CX_DISTRICT_MAS  = [TBXML childElementNamed:@"CX_DISTRICT_MAS" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
            
            TBXMLElement *X_POSTAL_CODE = [TBXML childElementNamed:@"X_POSTAL_CODE" parentElement:CX_DISTRICT_MAS];
            NSString* Name = [TBXML textForElement:X_POSTAL_CODE];
            if ([Name isEqualToString:@" "]) {
                
                [self.PostalCode_List_PickerArr addObject:@"UNAVAILABLE"];
            }
            else
            {
                [self.PostalCode_List_PickerArr addObject:Name];
            }
            
            
        }while ((tuple = tuple->nextSibling));
    }
    [self hideAlert];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@""
                                  delegate:self
                                  cancelButtonTitle:nil
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:nil];
    
    
    
    for (int i=0; i<[self.PostalCode_List_PickerArr count]; i++)
    {
        [actionSheet addButtonWithTitle:[self.PostalCode_List_PickerArr objectAtIndex:i]];
        
    }
    
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        
        [actionSheet showFromRect:[self.textpostalcode frame] inView:self.oppurtunityView animated:YES];
    }
    
    
    else
    {
        
        [actionSheet showInView:self.view];
        
    }
    
    actionSheet.tag = 400;
    
    
}
-(void)request_Taluka_ListFound:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\nResponse....%@",response);
    
    if (self.Taluka_List_PickerArr)
    {
        
        [self.Taluka_List_PickerArr removeAllObjects];
        
    }
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    TBXMLElement *container = [TBXML childElementNamed:@"GetAllIndianTalukaResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    TBXMLElement *tuple =[TBXML childElementNamed:@"tuple" parentElement:container];
    
    if (tuple)
    {
        
        do {
            
            TBXMLElement *CX_DISTRICT_MAS  = [TBXML childElementNamed:@"CX_DISTRICT_MAS" parentElement:[TBXML childElementNamed:@"old" parentElement:tuple]];
            
            TBXMLElement *X_TALUKA = [TBXML childElementNamed:@"X_TALUKA" parentElement:CX_DISTRICT_MAS];
            NSString* Name = [TBXML textForElement:X_TALUKA];
            //  NSLog(@"CX_DISTRICT_MAS : %@",Name);
            
            
            [self.Taluka_List_PickerArr addObject:Name];
            
        }while ((tuple = tuple->nextSibling));
    }
    
    [self hideAlert];
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@""
                                  delegate:self
                                  cancelButtonTitle:nil
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:nil];
    
    
    for (int i=0; i<[self.Taluka_List_PickerArr count]; i++)
    {
        [actionSheet addButtonWithTitle:[self.Taluka_List_PickerArr objectAtIndex:i]];
        
    }
    
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        
        [actionSheet showFromRect:[self.textTaluka frame] inView:self.oppurtunityView animated:YES];
    }
    
    
    else
    {
        
        [actionSheet showInView:self.view];
        
    }
    
    actionSheet.tag = 500;
    
    
}

-(void)request_Contact_ListFound:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\nResponse....%@",response);
    
    
    //    for (int i=0; i<5; i++) {
    //        ContactsList *contact=[[ContactsList alloc] init];
    //        contact.Name=@"Rishikesh";
    //        contact.Address=@"Bandra";
    //        contact.email=@"rishikesh@gmail.com";
    //        contact.Contact=@"9898898";
    //
    //        [self.ContactList addObject:contact];
    //    }
    
    
    if (self.ContactList)
    {
        
        [self.ContactList removeAllObjects];
        
    }
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    TBXMLElement *container = [TBXML childElementNamed:@"ns:SFATMCVContactQueryByExample_Output" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    TBXMLElement *ListOfContactInterface =[TBXML childElementNamed:@"ListOfContactInterface" parentElement:container];
    
    if (ListOfContactInterface)
    {
        
        do {
            
            TBXMLElement *Contact  = [TBXML childElementNamed:@"Contact" parentElement:ListOfContactInterface];
            
            TBXMLElement *FirstName = [TBXML childElementNamed:@"FirstName" parentElement:Contact];
            TBXMLElement *LastName = [TBXML childElementNamed:@"LastName" parentElement:Contact];
            TBXMLElement *PersonalAddress = [TBXML childElementNamed:@"PersonalAddressName" parentElement:[TBXML childElementNamed:@"ListOfPersonalAddress" parentElement:[TBXML childElementNamed:@"PersonalAddress" parentElement:Contact]]];
            TBXMLElement *EmailAddress = [TBXML childElementNamed:@"EmailAddress" parentElement:Contact];
            
            NSString* Name = [TBXML textForElement:FirstName];
            // NSString* Name = [TBXML textForElement:FirstName];
            //NSString* adress = [TBXML textForElement:PersonalAddress];
            NSString* email = [TBXML textForElement:EmailAddress];
            
            ContactsList *contact=[[ContactsList alloc] init];
            contact.Name=Name;
            // contact.Address=adress;
            contact.email=email;
            contact.Contact=@"9898898";
            
            [self.ContactList addObject:contact];
            
            //            //  NSLog(@"CX_DISTRICT_MAS : %@",Name);
            //
            //
            //            [self.Taluka_List_PickerArr addObject:Name];
            
        }while ((ListOfContactInterface = ListOfContactInterface->nextSibling));
    }
    NSLog(@"%@",[[self.ContactList objectAtIndex:1] valueForKey:@"Name"]);
    
    
}

-(void)contactlistfetchedAlert:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\nResponse....%@",response);
    
    [self hideAlert];
    
}




#pragma mark - ActionSheet View Delegate Method
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 1000)//Abhishekp/
    {
        if ( buttonIndex<0 ) //Abhishek
        {
            self.LOB.text = @""; //Abhishek
        }
        else //Abhishek
        {
            NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
            self.LOB.text = title;
            NSString * envelopeText = [NSString stringWithFormat:
                                       @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                       @"<SOAP:Body>"
                                       @"<GetPPLFromLOB xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                       @"<LOB>%@</LOB>"
                                       @"</GetPPLFromLOB>"
                                       @"</SOAP:Body>"
                                       @"</SOAP:Envelope>",title];
            
            
            NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
            NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",self.appdelegate.URL,self.appdelegate.artifact]];
            NSLog(@"URL IS .... %@",theurl);
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
            NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:envelope];
            [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
            [[RequestDelegate alloc]initiateRequest:request name:@"GetPPL_List"];
            NSLog(@"%@",title);
        }
    }
    else if (actionSheet.tag == 2000)
    {
        if ( buttonIndex<0 ) //Abhishek
        {
            self.PL.text = @""; //Abhishek
        }
        else//Abhishek
        {
            NSString *ppl = [actionSheet buttonTitleAtIndex:buttonIndex];
            self.PPL.text = ppl;
            
            NSString * envelopeText = [NSString stringWithFormat:
                                       @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                       @"<SOAP:Body>"
                                       @"<GetPLFromPPL xmlns=\"http://schemas.cordys.com/com.cordys.tatamotors.utilitysiebelwsapps\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                       @"<PPL_Name>%@</PPL_Name>"
                                       @"<LOB>%@</LOB>"
                                       @"</GetPLFromPPL>"
                                       @"</SOAP:Body>"
                                       @"</SOAP:Envelope>",ppl,self.LOB.text];
            
            
            NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
            NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",self.appdelegate.URL,self.appdelegate.artifact]];
            NSLog(@"URL IS .... %@",theurl);
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
            NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:envelope];
            [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
            [[RequestDelegate alloc]initiateRequest:request name:@"GetPL_List"];
            
        }
        
    }
    else if (actionSheet.tag == 3000)
    {
        if ( buttonIndex<0 ) //Abhishek
        {
            self.PPL.text = @""; //Abhishek
            
        }
        else//Abhishek
        {
            
            NSString *PL = [actionSheet buttonTitleAtIndex:buttonIndex];
            self.PL.text = PL;
            //
            NSString * envelopeText = [NSString stringWithFormat:
                                       @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                       @"<SOAP:Body>"
                                       @"<GetTMCVIndentApps xmlns=\"com.cordys.tatamotors.masfasiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                                       @"<lob>%@</lob>"
                                       @"</GetTMCVIndentApps>"
                                       @"</SOAP:Body>"
                                       @"</SOAP:Envelope>",self.LOB.text];
            
            NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
            NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",self.appdelegate.URL,self.appdelegate.artifact]];
            NSLog(@"URL IS .... %@",theurl);
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
            NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:envelope];
            [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
            [[RequestDelegate alloc]initiateRequest:request name:@"GetApplication_List"];
            
            NSLog(@"%@",PL);//Abhishek
        }
    }
    
    else if (actionSheet.tag == 4000)
    {
        if (buttonIndex<0)
        {
            self.APPLICATION.text = @"";
        }
        else
        {
            NSString *Application = [actionSheet buttonTitleAtIndex:buttonIndex];
            self.APPLICATION.text=Application;
            NSLog(@"%@",self.APPLICATION.text);
        }
    }
    else if (actionSheet.tag == 5000)
    {
        if (buttonIndex<0)
        {
            self.APPLICATION.text = @"";
        }
        else
        {
            NSString *Application = [actionSheet buttonTitleAtIndex:buttonIndex];
            self.APPLICATION.text=Application;
        }
    }
    else if (actionSheet.tag == 6000)
    {
        if (buttonIndex<0)
        {
            self.SOURCEOFCONTACT.text = @"";
        }
        else
        {
            NSString *SOURCEOFCONTACT = [actionSheet buttonTitleAtIndex:buttonIndex];
            self.SOURCEOFCONTACT.text = SOURCEOFCONTACT;
            NSLog(@"%@",self.SOURCEOFCONTACT.text);
        }
    }
    else if (actionSheet.tag == 7000)
    {
        if (buttonIndex<0)
        {
            self.FINANCIER.text = @"SELF";
        }
        else
        {
            NSString *FINANCIER = [actionSheet buttonTitleAtIndex:buttonIndex];
            self.FINANCIER.text = FINANCIER;
            NSLog(@"%@",self.FINANCIER.text);
        }
    }
    else if (actionSheet.tag == 100)
    {
        if (buttonIndex<0)
        {
            self.textState.text=@"";
        }
        else
        {
            NSString *state = [actionSheet buttonTitleAtIndex:buttonIndex];
            self.textState.text=state;
            NSLog(@"%@",self.textState.text);
        }
    }
    else if (actionSheet.tag == 200)
    {
        if (buttonIndex<0)
        {
            self.textDistrict.text=@"";
        }
        else
        {
            NSString *district = [actionSheet buttonTitleAtIndex:buttonIndex];
            self.textDistrict.text = district;
            NSLog(@"%@",self.textDistrict.text);
        }
    }
    else if (actionSheet.tag == 300)
    {
        if (buttonIndex<0)
        {
            self.textCity.text = @"";
        }
        else
        {
            NSString *city = [actionSheet buttonTitleAtIndex:buttonIndex];
            self.textCity.text = city;
            NSLog(@"%@",self.textCity.text);
        }
    }
    else if (actionSheet.tag == 400)
    {
        if (buttonIndex<0)
        {
            self.textpostalcode.text=@"";
        }
        else
        {
            NSString *postalCode = [actionSheet buttonTitleAtIndex:buttonIndex];
            self.textpostalcode.text=postalCode;
            NSLog(@"%@",self.textpostalcode.text);
        }
    }
    else if (actionSheet.tag==500)
    {
        if (buttonIndex<0)
        {
            self.textTaluka.text=@"";
        }
        else
        {
            NSString *taluka = [actionSheet buttonTitleAtIndex:buttonIndex];
            self.textTaluka.text=taluka;
            NSLog(@"%@",self.textTaluka.text);
        }
    }
}

-(void)tapOut:(UIGestureRecognizer *)gestureRecognizer {
    
    CGPoint p = [gestureRecognizer locationInView:self.view];
    if (p.y < 0) { // They tapped outside
        [self dismissWithClickedButtonIndex:0 animated:YES];
    }
}

//-(void) showFromTabBar:(UITabBar *)view {
//    [super.view showFromTabBar:view];
//
//    // Capture taps outside the bounds of this alert view
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOut:)];
//    tap.cancelsTouchesInView = NO; // So that legit taps on the table bubble up to the tableview
//    [self.superview addGestureRecognizer:tap];
//    [tap release];
//}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated
{
    
    
}


-(void)showAlert
{
    [MBProgressHUD showHUDAddedLoading:self.view animated:YES];
}
-(void)hideAlert
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}
- (IBAction)SearchContacts:(id)sender
{
    //    NSNotification *Taluka_Notification = [NSNotification notificationWithName:@"Contact_ListFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
    //    [[NSNotificationQueue defaultQueue]enqueueNotification:Taluka_Notification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    [self showAlert];
    NSString * envelopeText = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @" <SOAP:Body>"
                               @" <SFATMCVContactQueryByExample_Input xmlns=\"http://siebel.com/asi/\">"
                               @" <ListOfContactInterface xmlns=\"http://www.siebel.com/xml/Contact%20Interface\">"
                               @" <Contact>"
                               @" <CellularPhone>%@</CellularPhone>"
                               @" </Contact>"
                               @" </ListOfContactInterface>"
                               @" </SFATMCVContactQueryByExample_Input>"
                               @" </SOAP:Body>"
                               @"</SOAP:Envelope>",self.SearchContact.text];
    
    
    
    NSString *newString = [envelopeText stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSData *envelope = [newString dataUsingEncoding:NSUTF8StringEncoding];
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",self.appdelegate.URL,self.appdelegate.artifact]];
    
    NSLog(@"URL IS .... %@",theurl);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    NSString * msglength = [NSString stringWithFormat:@"%lu",(unsigned long)[envelopeText length]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    [[RequestDelegate alloc]initiateRequest:request name:@"GetContact"];
    
}


- (IBAction)createContactRequest:(id)sender
{
    
    NSLog(@"\n\n.. createContact Connection "); //Abhishek
    
    if ([self.textfirst.text isEqualToString:@""]||
        [self.textlast.text isEqualToString:@""] ||
        [self.textnumber.text isEqualToString:@""] ||
        // [self.textid.text isEqualToString:@""] ||
        // [self.textnumber.text isEqualToString:@""] ||
        [self.textadd1.text isEqualToString:@""] ||
        // [self.textadd2.text isEqualToString:@""] ||
        [self.textArea.text isEqualToString:@""] ||
        
        [self.textState.text isEqualToString:@""] ||
        [self.textDistrict.text isEqualToString:@""] ||
        [self.textCity.text isEqualToString:@""] ||
        //[self.textTaluka.text isEqualToString:@""] ||
        //[self.textpostalcode.text isEqualToString:@""]||
        //[self.textPanchayat.text isEqualToString:@""]||
        [self.Account.text isEqualToString:@""]
        )
    {
        NSLog(@" \n\n.. all fields are empty ");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ALERT"
                                                        message:@"fields are empty"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        return;
    }
    else{
        
        [self showAlert];//Abhishek
        
        NSLog(@"\n\n.. createContact Connection ");
        
        long IntegrationId = [[NSDate date]timeIntervalSince1970];
        NSLog(@"\n.....IntegrationId %ld",IntegrationId);
        
        NSLog(@"Position Details....%@",userDetailsVal_.POSITION_NAME);
        NSLog(@"Position Details....%@",userDetailsVal_.POSTN);
        NSLog(@"Position Details....%@",userDetailsVal_.ROW_ID);
        
        NSString * envelopeText = [NSString stringWithFormat:
                                   @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                   @"<SOAP:Body>"
                                   @"<SFATMCVContactInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                                   @"<ListOfContactInterface xmlns=\"http://www.siebel.com/xml/Contact%%20Interface\">"
                                   @"<Contact>"
                                   @"<CellularPhone>%@</CellularPhone>" // Cell phone no
                                   @"<EmailAddress>%@</EmailAddress>"// Email Id
                                   @"<FirstName>%@</FirstName>"  // First Name
                                   @"<IntegrationId>%ld</IntegrationId>" // Current System Time in milliSec Time in Milliseconds
                                   @"<LastName>%@</LastName>" //Last Name
                                   @"<ListOfRelatedSalesRep>"
                                   @"<RelatedSalesRep>"
                                   @"<Position>%@</Position>" // UserDetails. Getposition name
                                   @"<Id>%@</Id>"//UserDetails Row ID
                                   @"</RelatedSalesRep>"
                                   @"</ListOfRelatedSalesRep>"
                                   @"<ListOfRelatedOrganization>"
                                   @"<RelatedOrganization>"
                                   @"<Organization>%@</Organization>"  // User Deatails Get Org name
                                   @"</RelatedOrganization>"
                                   @"</ListOfRelatedOrganization>"
                                   @"<ListOfPersonalAddress>"
                                   @"<PersonalAddress>"
                                   
                                   @"<IntegrationId>%ld</IntegrationId>"
                                   //@"<PersonalAddressName>PARAMETER</PersonalAddressName>"
                                   //@"<TMCity>%@</TMCity>"
                                   @"<PersonalCountry>%@</PersonalCountry>"
                                   @"<PersonalPostalCode>%@</PersonalPostalCode>"
                                   @"<PersonalState>%@</PersonalState>"
                                   @"<PersonalStreetAddress>%@</PersonalStreetAddress>"
                                   @"<PersonalStreetAddress2>%@</PersonalStreetAddress2>"
                                   //@"<AddressId>PARAMETER</AddressId>"
                                   @"<TMPanchayat>%@</TMPanchayat>"
                                   @"<TMTaluka>%@</TMTaluka>"
                                   @"<TMDistrict>%@</TMDistrict>"
                                   @"<PersonalCity>%@</PersonalCity>"
                                   @"</PersonalAddress>"
                                   @"</ListOfPersonalAddress>"
                                   @"</Contact>"
                                   @"</ListOfContactInterface>"
                                   @"</SFATMCVContactInsertOrUpdate_Input>"
                                   @"</SOAP:Body>"
                                   @"</SOAP:Envelope>", _textnumber.text,
                                   _textid.text ,
                                   _textfirst.text,
                                   (long)[[NSDate date]timeIntervalSince1970],
                                   _textlast.text,
                                   userDetailsVal_.POSITION_NAME ,
                                   userDetailsVal_.ROW_ID,
                                   userDetailsVal_.ORGNAME,
                                   /*userDetailsVal_.ROW_ID,*/
                                   (long)[[NSDate date]timeIntervalSince1970],
                                   /*textCity.text,*/
                                   /*_textCity.text,*/
                                   @"India",
                                   _textpostalcode
                                   
                                   .text,
                                   self.statestringdecoded,
                                   _textadd1.text,
                                   _textadd2.text,
                                   _textPanchayat.text,
                                   _textTaluka.text,
                                   _textDistrict.text,_textCity.text];
        
        NSLog(@"\n envlopeString Of user details....!!!!%@",envelopeText);
        
        NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
        NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",self.appdelegate.URL,self.appdelegate.artifact]];
        // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
        NSLog(@"URL IS %@",theurl);
        NSLog(@"REQUEST IS %@",envelopeText);
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
        
        NSString *msglength = [NSString stringWithFormat:@"%i",[envelopeText length]];
        
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:envelope];
        [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
        
        [[RequestDelegate alloc]initiateRequest:request name:@"CreateContactConnection"];
        
        
        
    }
}

-(void)CreateContactFound:(NSNotification*)notification
{
    [self hideAlert]; //Abhishek
    
    NSError *err;
    NSString *response = [[notification userInfo]objectForKey:@"response"];
    NSLog(@"\nResponse....%@",response);
    
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Something Went Wrong. Please try again later" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }

    else{
    TBXMLElement *container = [TBXML childElementNamed:@"ns:SFATMCVContactInsertOrUpdate_Output" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    
    TBXMLElement *ListOfContactInterface = [TBXML childElementNamed:@"ListOfContactInterface" parentElement:container];
    
    TBXMLElement *Contact = [TBXML childElementNamed:@"Contact" parentElement:ListOfContactInterface];
    TBXMLElement *Id = [TBXML childElementNamed:@"Id" parentElement:Contact];
    if (Id)
    {
        createcontactresult.Id_ = [TBXML textForElement:Id];
        appdelegate.Account_Id=[TBXML textForElement:Id];
    }
    else
    {
        [appdelegate hideAlert];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Wrong data please feel it again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
        [alertView show];
        //[self resetTextValues];
    }
    
    TBXMLElement *IntegrationId = [TBXML childElementNamed:@"IntegrationId" parentElement:Contact];
    // createcontactresult.IntegrationId_ = [TBXML textForElement:IntegrationId];
    
    TBXMLElement *ListOfPersonalAddress =  [TBXML childElementNamed:@"ListOfPersonalAddress" parentElement:Contact];
    TBXMLElement *PersonalAddress = [TBXML childElementNamed:@"PersonalAddress" parentElement:ListOfPersonalAddress];
    TBXMLElement *IntegrationId2 = [TBXML childElementNamed:@"IntegrationId" parentElement:PersonalAddress];
    // createcontactresult.IntegrationId2_ = [TBXML textForElement:IntegrationId2];
    
    [appdelegate hideAlert];
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"Your Contact created successfully" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    alertView.delegate = self;
    alertView.tag = 110;
    [alertView show];
    }
}


- (IBAction)btncreateaccount:(id)sender
{
    NSLog(@"\n Create Account Action....");
    [self showAlert];//Abhishek
    [self callCreateAccountConnection]; //Abhishek
}


-(void)callCreateAccountConnection
{
    NSLog(@"\n\n.. create Account Connection ");
    NSLog(@"\n\n.. createcontactresult.Id_ %@",createcontactresult.Id_);
    
    NSString * envelopeText = [NSString stringWithFormat:
                               @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:asi=\"http://siebel.com/asi/\">"
                               @"<soapenv:Header/>"
                               @"<soapenv:Body>"
                               @"<asi:SFATMCVContactQueryById_Input>"
                               @"<asi:PrimaryRowId>%@</asi:PrimaryRowId>"
                               @"</asi:SFATMCVContactQueryById_Input>"
                               @"</soapenv:Body>"
                               @"</soapenv:Envelope>",createcontactresult.Id_];
    
    NSLog(@"\n envlopeString Of user details....!!!!%@",envelopeText);
    
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",self.appdelegate.URL,self.appdelegate.artifact]];
    
    NSLog(@"URL IS %@",theurl);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:150];
    
    NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"CreateAccount_ConnectionRequest"];
}



-(void)CreateAccountFound:(NSNotification*)notification
{
    
    [self hideAlert]; //Abhishek
    
    NSError *err;
    NSString *response = [[notification userInfo]objectForKey:@"response"];
    NSLog(@"\nResponse....%@",response);
    
    
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Something Went Wrong. Please try again later" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    else{
    
    TBXMLElement *container = [TBXML childElementNamed:@"ns:SFATMCVContactQueryById_Output" parentElement:[TBXML childElementNamed:@"soapenv:Body" parentElement:tbxml.rootXMLElement]];
    
    TBXMLElement *ListOfContactInterface = [TBXML childElementNamed:@"ListOfContactInterface" parentElement:container];
    TBXMLElement *Contact = [TBXML childElementNamed:@"Contact" parentElement:ListOfContactInterface];
    TBXMLElement *ListOfPersonalAddress = [TBXML childElementNamed:@"ListOfPersonalAddress" parentElement:Contact];
    TBXMLElement *PersonalAddress = [TBXML childElementNamed:@"PersonalAddress" parentElement:ListOfPersonalAddress];
    TBXMLElement *Id = [TBXML childElementNamed:@"Id" parentElement:PersonalAddress];
    NSString *ID = [TBXML textForElement:Id];
    
    createaccountaginstcontact.Id_ = ID;
    appdelegate.Address_Id=ID;
    
    NSLog(@"\n\n PersonalAddress_Id...!!! %@ ",createaccountaginstcontact.Id_);
    
    [appdelegate hideAlert];
    
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"DSE" message:@"Your Account created successfully" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    
    alertView.delegate = self;
    alertView.tag = 120;
    [alertView show];
    
    
    
    //For Testing
    [self Call_createaccountaginstcontact];
    }
    
}



-(void)Call_createaccountaginstcontact
{
    NSLog(@"\n\n.. create Account Connection ");
    NSLog(@"\n\n.. createcontactresult.Id_ %@",createcontactresult.Id_);
    NSString *name = [NSString stringWithFormat:@"%@ %@",_textlast.text,_textlast.text];
    
    NSLog(@"\n\n name ....  : %@",name);
    
    NSString * envelopeText = [NSString stringWithFormat:
                               @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:acc=\"http://www.siebel.com/xml/Account%%20Interface\" xmlns:asi=\"http://siebel.com/asi/\">"
                               @"<soapenv:Header />"
                               @"<soapenv:Body>"
                               @"<asi:SFATMCVAccountInsertOrUpdate_Input>"
                               @"<ListOfAccountInterface>"
                               @"<Account operation=\"?\">"
                               @"<IntegrationId>%ld</IntegrationId>"
                               @"<Location>%@</Location>"
                               @"<MainPhoneNumber>%@</MainPhoneNumber>"
                               @"<Name>%@</Name>"
                               @"<ListOfBusinessAddress>"
                               @"<BusinessAddress IsPrimaryMVG=\"Y\" operation=\"?\">"
                               @"<AddressId>%@</AddressId>"
                               @"</BusinessAddress>"
                               @"</ListOfBusinessAddress>"
                               @"<ListOfRelatedContact>"
                               @"<RelatedContact IsPrimaryMVG=\"Y\" operation=\"?\">"
                               @"<ContactId>%@</ContactId>"
                               @"</RelatedContact>"
                               @"</ListOfRelatedContact>"
                               @"<ListOfRelatedSalesRep>"
                               @"<RelatedSalesRep IsPrimaryMVG=\"Y\">"
                               @"<Position>%@</Position>"
                               @"<PositionId>%@</PositionId>"
                               @"</RelatedSalesRep>"
                               @"</ListOfRelatedSalesRep>"
                               @"<ListOfRelatedOrganization>"
                               @"<RelatedOrganization IsPrimaryMVG=\"Y\">"
                               @"<Organization>%@</Organization>"
                               @"</RelatedOrganization>"
                               @"</ListOfRelatedOrganization>"
                               @"</Account>"
                               @"</ListOfAccountInterface>"
                               @"<asi:StatusObject>?</asi:StatusObject>"
                               @"</asi:SFATMCVAccountInsertOrUpdate_Input>"
                               @"</soapenv:Body>"
                               @"</soapenv:Envelope>",
                               (long)[[NSDate date]timeIntervalSince1970],
                               self.textCity.text,
                               _textnumber.text,
                               _Account.text,
                               createaccountaginstcontact.Id_,
                               createcontactresult.Id_,
                               userDetailsVal_.POSITION_NAME,
                               userDetailsVal_.ROW_ID,
                               userDetailsVal_.ORGNAME];
    
    NSLog(@"\n envlopeString Of user details....!!!!%@",envelopeText);
    
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",self.appdelegate.URL,self.appdelegate.artifact]];
    NSLog(@"URL IS %@",theurl);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:150];
    NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"CreateAccountaginstcontact_Request"];
    
}

-(void)CreateAccountAgainst_ContactFound:(NSNotification*)notification
{
    NSError *err;
    NSString *response = [[notification userInfo]objectForKey:@"response"];
    NSLog(@"\nResponse. CreateAccountAgainst_ContactFound...%@",response);
    
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Something Went Wrong. Please try again later" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    else{
    
    TBXMLElement *container = [TBXML childElementNamed:@"ns:SFATMCVAccountInsertOrUpdate_Output" parentElement:[TBXML childElementNamed:@"soapenv:Body" parentElement:tbxml.rootXMLElement]];
    
    TBXMLElement *ListOfAccountInterface = [TBXML childElementNamed:@"ListOfAccountInterface" parentElement:container];
    TBXMLElement *Account = [TBXML childElementNamed:@"Account" parentElement:ListOfAccountInterface];
    
    TBXMLElement *AccountId = [TBXML childElementNamed:@"AccountId" parentElement:Account];
    //TBXMLElement *PersonalAddress = [TBXML childElementNamed:@"PersonalAddress" parentElement:ListOfPersonalAddress];
    //TBXMLElement *Id = [TBXML childElementNamed:@"Id" parentElement:PersonalAddress];
    NSString *ID = [TBXML textForElement:AccountId];
    
    createaccount.AccountId_ = ID;
    NSLog(@"\n\n PersonalAddress_Idaccount...!!! %@ ",createaccount.AccountId_);
    [appdelegate hideAlert];
    }
}

#pragma mark - UIAlertView Delegate
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex //Abhishek // For contact and account
{
    
    // Is this my Alert View?
    if (alertView.tag == 110) {
        NSLog(@"\n\n Testing Alertview");
        if (buttonIndex == 0) {
            // 1st Other Button // OK Button
            //[self callCreateAccountConnection];
            
            
            btn_CreateAccount.enabled = YES;
            btn_CreateAccount.backgroundColor = [UIColor colorWithRed:(115/255.0)green:(182/255.0) blue:(68/255.0) alpha:1];
            
            btn_CreateContact.enabled = NO;
            btn_CreateContact.backgroundColor = [UIColor colorWithRed:(101/255.0)green:(104/255.0) blue:(27/255.0) alpha:1];
        }
        else if (buttonIndex == 1) {// 2nd Other Button // Cancel Button
        }
    }
    else if (alertView.tag == 120)
    {
        if (buttonIndex == 0) {
            // 1st Other Button // OK Button
            //[self callCreateAccountConnection];
            NSLog(@"\n\n Testing 123 Alertview");
            
            //Temprary Comment // Change if business suggest// Abhishek
            
            //            btn_CreateContact.enabled = YES;
            //            btn_CreateContact.backgroundColor = [UIColor colorWithRed:(115/255.0)green:(182/255.0) blue:(68/255.0) alpha:1];
            
            btn_CreateAccount.enabled = NO;
            btn_CreateAccount.backgroundColor = [UIColor colorWithRed:(101/255.0)green:(104/255.0) blue:(27/255.0) alpha:1];
            
            
            btn_CreateOpty.enabled = YES;
            btn_CreateOpty.backgroundColor = [UIColor colorWithRed:(115/255.0)green:(182/255.0) blue:(68/255.0) alpha:1];
            
            
//            btn_CreateOpty.enabled = NO; //Abhishek
//            btn_CreateOpty.backgroundColor = [UIColor colorWithRed:(101/255.0)green:(104/255.0) blue:(27/255.0) alpha:1]; //Abhishek
//            

            
        }
        else if (buttonIndex == 1) {// 2nd Other Button // Cancel Button
        }
    }
    
    else if (alertView.tag == 130)
    {
        if (buttonIndex == 0)
        {
            // 1st Other Button // OK Button
            //[self callCreateAccountConnection];
            NSLog(@"\n\n Testing 130 Alertview");
            
            //Temprary Comment // Change if business suggest// Abhishek
            
            //            btn_CreateContact.enabled = YES;
            //            btn_CreateContact.backgroundColor = [UIColor colorWithRed:(115/255.0)green:(182/255.0) blue:(68/255.0) alpha:1];
            self.textnumber.text = @"";
        }
        else if (buttonIndex == 1)
        {
            // 2nd Other Button // Cancel Button
        }
    }
}


-(void)call_PL_ProductLine
{
    NSLog(@"\nCall Procuct Line....!!!!");
    
    NSLog(@"\n _PL.text...!!! %@ ",self.PL.text);
    
    NSLog(@"\n\n.. createcontactresult.Id_ %@",createcontactresult.Id_);
    
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
                               @"<DC xmlns=\"http://schemas.cordys.com/General/1.0/\" name=\"correlationID\">00215ef7-d846-11e4-e719-d95a1a869db9</DC>"
                               @"</Logger>"
                               @"</header>"
                               @"</SOAP:Header>"
                               @"<SOAP:Body>"
                               @"<GetProductfromPLDSM xmlns=\"com.cordys.tatamotors.Dsmsiebelwsapp\" preserveSpace=\"no\" qAccess=\"0\" qValues=\"\">"
                               @"<PLName>%@</PLName>"
                               @"</GetProductfromPLDSM>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",self.PL.text];
    
    NSLog(@"\n envlopeString Of user pl production  details....!!!!%@",envelopeText);
    
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",self.appdelegate.URL,self.appdelegate.artifact]];
    
    NSLog(@"URL IS %@",theurl);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:150];
    
    NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"PL_ProductID_Request"];
    
}

-(void)PL_ProductID_ListFound:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\nResponse....%@",response);
    
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    
    TBXMLElement *container = [TBXML childElementNamed:@"GetProductfromPLDSMResponse" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    
    TBXMLElement *tuple = [TBXML childElementNamed:@"tuple" parentElement:container];
    
    TBXMLElement *old = [TBXML childElementNamed:@"old" parentElement:tuple];
    
    TBXMLElement *S_PROD_LN = [TBXML childElementNamed:@"S_PROD_LN" parentElement:old];
    //TBXMLElement *PersonalAddress = [TBXML childElementNamed:@"PersonalAddress" parentElement:ListOfPersonalAddress];
    TBXMLElement *PRODUCT = [TBXML childElementNamed:@"PRODUCT" parentElement:S_PROD_LN];
    TBXMLElement *PRODUCT_ID = [TBXML childElementNamed:@"PRODUCT_ID" parentElement:S_PROD_LN];
    
    NSString *PRODUCT_ = [TBXML textForElement:PRODUCT];
    pl_productid_product.PRODUCT_ = PRODUCT_;
    
    
    NSString *PRODUCT_ID_ = [TBXML textForElement:PRODUCT_ID];
    pl_productid_product.PRODUCT_ID_ = PRODUCT_ID_;
    appdelegate.Product_Id=PRODUCT_ID_;
    // createaccount.AccountId_ = ID;
    NSLog(@"\n\n PRODUCT_...!!! %@ ",PRODUCT_);
    NSLog(@"\n\n PRODUCT_ID_...!!! %@ ",PRODUCT_ID_);
    
    [appdelegate hideAlert];
    
}


- (IBAction)creat_opty:(id)sender {
    
    //Abhishek
    NSLog(@"\n\n.. createContact Connection "); //Abhishek
    
    if (
        [self.LOB.text isEqualToString:@""]||
        [self.PPL.text isEqualToString:@""]||
        [self.PL.text isEqualToString:@""] ||
        [self.APPLICATION.text isEqualToString:@""] ||
        [self.SOURCEOFCONTACT.text isEqualToString:@""] ||
        [self.FINANCIER.text isEqualToString:@""]
        )
    {
        NSLog(@" \n\n.. all fields are empty ");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ALERT"
                                                        message:@"fields are empty"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    else
    {
        NSLog(@"Action CreateOpty....!!!! ");
        
        //Abhishek
        btn_CreateContact.enabled = YES;
        btn_CreateContact.backgroundColor = [UIColor colorWithRed:(115/255.0)green:(182/255.0) blue:(68/255.0) alpha:1];
        
        [self callForCreateOpportunity];
        
        [self showAlert];//Abhishek
    }
}

-(void)callForCreateOpportunity
{
    self.appdelegate.createOptyPL = self.PL.text;
    NSLog(@"\n createcontactresult.Id_ %@",createcontactresult.Id_);
    NSLog(@"\n userDetailsVal_.POSITION_NAME %@",userDetailsVal_.POSITION_NAME);
    NSLog(@"\n userDetailsVal_.ROW_ID %@",userDetailsVal_.ROW_ID);
    NSLog(@"\n userDetailsVal_.ORGNAME %@",userDetailsVal_.ORGNAME);
    NSLog(@"\n userDetailsVal_.POSITION_NAME %@",userDetailsVal_.POSITION_NAME);
    NSLog(@"\n userDetailsVal_.ROW_ID %@",userDetailsVal_.ROW_ID);
    NSLog(@"\n pl_productid_product.PRODUCT_ %@",pl_productid_product.PRODUCT_);
    NSLog(@"\n lob %@",_txtfldLob.text);
    NSString * envelopeText = [NSString stringWithFormat:
                               @"<SOAP:Envelope xmlns:SOAP=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                               @"<SOAP:Body>"
                               @"<SFATMCVContactInsertOrUpdate_Input xmlns=\"http://siebel.com/asi/\">"
                               @"<ListOfContactInterface xmlns=\"http://www.siebel.com/xml/Contact%%20Interface\">"
                               @"<Contact operation=\"update\">"
                               @"<Id>%@</Id>"                                   // createcontactresult.Id_
                               @"<ListOfRelatedSalesRep>"
                               @"<RelatedSalesRep IsPrimaryMVG=\"Y\" operation=\"update\">"
                               @"<Position>%@</Position>" // userdetails position name
                               @"<Id>%@</Id>" //userdetails ROW_ID
                               @"</RelatedSalesRep>"
                               @"</ListOfRelatedSalesRep>"
                               @"<ListOfRelatedOrganization>"
                               @"<RelatedOrganization IsPrimaryMVG=\"Y\" operation=\"update\">"
                               @"<Organization>%@</Organization>"//userdetails ORGNAME
                               @"</RelatedOrganization>"
                               @"</ListOfRelatedOrganization>"
                               @"<ListOfOpportunity>"
                               @"<Opportunity operation=\"update\" searchspec=\"\"  >"
                               @"<IntegrationId>%ld</IntegrationId>"//Current System Time in milliSec Time in Milliseconds
                               @"<OptyFinancier>SHALIVAHAN NAGARI SAHAKARI PAT SANSTHA MARYADIT</OptyFinancier>"
                               @"<ParentProductLine>%@</ParentProductLine>"// values in "PPL" text field //product
                               @"<ProductLine>%@</ProductLine>"// values in "PL" text field // productid
                               @"<SourceOfContact/>"
                               
                               @"<Channel>MOBILE</Channel>"
                               
                               @"<CustomerType>First Time</CustomerType>"
                               @"<IntendedApplication>%@</IntendedApplication>"//values in "Application" text field
                               @"<TMLOB>%@</TMLOB>"//values in LOB text field
                               
                               @"<ProductId>%@</ProductId>"
                               
                               @"<ListOfOpportunityRelatedOrganization>"
                               @"<OpportunityRelatedOrganization IsPrimaryMVG=\"Y\" operation=\"update\">"
                               @"<Organization>%@</Organization>" //userdetails ORGNAME
                               @"</OpportunityRelatedOrganization>"
                               @"</ListOfOpportunityRelatedOrganization>"
                               
                               @"<ListOfOpportunityRelatedSalesRep>"
                               @"<OpportunityRelatedSalesRep IsPrimaryMVG=\"Y\" operation=\"\">"
                               @"<Position>%@</Position>" // userdetails positionname
                               @"<Id>%@</Id>" //userdetails getrowid
                               @"</OpportunityRelatedSalesRep>"
                               @"</ListOfOpportunityRelatedSalesRep>"
                               
                               @"<ListOfOpportunityRelatedProducts>"
                               
                               @"<OpportunityRelatedProducts operation=\"\">"
                               @"<Product>%@</Product>"
                               @"<ProductQuantity>1</ProductQuantity>"
                               @"<ParentProductLine>%@</ParentProductLine>"
                               @"<ProductLine>%@</ProductLine>"
                               @"</OpportunityRelatedProducts>"
                               @"</ListOfOpportunityRelatedProducts>"
                               @"</Opportunity>"
                               @"</ListOfOpportunity>"
                               @"</Contact>"
                               @"</ListOfContactInterface>"
                               @"</SFATMCVContactInsertOrUpdate_Input>"
                               @"</SOAP:Body>"
                               @"</SOAP:Envelope>",
                               createcontactresult.Id_,
                               userDetailsVal_.POSITION_NAME,
                               userDetailsVal_.ROW_ID,
                               userDetailsVal_.ORGNAME,
                               (long)[[NSDate date]timeIntervalSince1970],
                               self.PPL.text,
                               self.PL.text,
                               self.APPLICATION.text,
                               self.LOB.text,
                               pl_productid_product.PRODUCT_ID_,
                               userDetailsVal_.ORGNAME,
                               userDetailsVal_.POSITION_NAME ,
                               userDetailsVal_.ROW_ID,
                               pl_productid_product.PRODUCT_,
                               self.PPL.text,
                               self.PL.text];
    
    NSLog(@"\n envlopeString Of user details....!!!!%@",envelopeText);
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * theurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@&SAMLart=%@",self.appdelegate.URL,self.appdelegate.artifact]];
    // NSLog(@"URL IS %@",[NSString stringWithFormat:@"%@&SAMLart=%@",appdelegate.URL,appdelegate.artifact]);
    NSLog(@"URL IS %@",theurl);
    // NSLog(@"REQUEST IS %@",envelopeText);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theurl];
    NSString * msglength = [NSString stringWithFormat:@"%i",[envelopeText length]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msglength forHTTPHeaderField:@"Content-Length"];
    
    [[RequestDelegate alloc]initiateRequest:request name:@"createOpportunity_AgainstContact"];
    
    
    
    //Abhishek
    btn_CreateContact.enabled = NO; //Abhishek
    btn_CreateContact.backgroundColor = [UIColor colorWithRed:(101/255.0)green:(104/255.0) blue:(27/255.0) alpha:1];//Abhishek
    
    
    
}
-(void)getCreateOpportunity_Found:(NSNotification*)notification
{
    NSError *err;
    NSString *response=[[notification userInfo]objectForKey:@"response"];
    NSLog(@"\nResponse....%@",response);
    
    TBXML * tbxml = [TBXML newTBXMLWithXMLString:response error:&err];
    
    if ([response rangeOfString:@"SOAP:Fault"].location != NSNotFound )
    {
        [self hideAlert];
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Attention!" message:@"Something Went Wrong. Please try again later" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    else{
    
    TBXMLElement *container = [TBXML childElementNamed:@"ns:SFATMCVContactInsertOrUpdate_Output" parentElement:[TBXML childElementNamed:@"SOAP:Body" parentElement:tbxml.rootXMLElement]];
    
    
    TBXMLElement *ListOfContactInterface = [TBXML childElementNamed:@"ListOfContactInterface" parentElement:container];
    TBXMLElement *Contact = [TBXML childElementNamed:@"Contact" parentElement:ListOfContactInterface];
    TBXMLElement *IDC = [TBXML childElementNamed:@"Id" parentElement:Contact];
    TBXMLElement *ListOfOpportunity = [TBXML childElementNamed:@"ListOfOpportunity" parentElement:Contact];
    TBXMLElement *Opportunity = [TBXML childElementNamed:@"Opportunity" parentElement:ListOfOpportunity];
    TBXMLElement *Id = [TBXML childElementNamed:@"Id" parentElement:Opportunity];
    
    NSString *OPTY_ID_ = [TBXML textForElement:Id];
    createopportunity.Id_ = OPTY_ID_;
    
    if (OPTY_ID_)
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Oppurtunity Created Successfully" message:[NSString stringWithFormat:@"OPTY ID:%@",OPTY_ID_] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        self.appdelegate.newactivityOptyID=OPTY_ID_;
        NSLog(@"CO_OPTY_ID_%@",OPTY_ID_);
        self.appdelegate.fromCreateoppurtunityPage=@"fromCreateoppurtunityPage";
        CreateActivityViewController* CreateActivityViewController_VC = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateActivityViewController"];
        [self.navigationController pushViewController:CreateActivityViewController_VC animated:YES];
        
        [self hideAlert];
        [self emptyTextfield];
        
        //        self.PPL.text=nil;
        //        self.PL.text=nil;
        //        self.APPLICATION.text=nil;
        //        self.LOB.text=nil;
        //        self.SOURCEOFCONTACT.text=nil;
        //        self.FINANCIER.text=nil;
        //        _textfirst.text=nil;
        //        _textpostalcode=nil;
        //        _textState.text=nil;
        //        _textadd1.text=nil;
        //        _textadd2.text=nil;
        //        _textPanchayat.text=nil;
        //        _textTaluka.text=nil;
        //        _textDistrict.text=nil;
        //        _textCity.text=nil;
        //        _textlast=nil;
        //        _textid=nil;
        //        _textnumber=nil;
    }
    else
    {
        NSLog(@"");
    }
    
    NSString *CONTACT_ID = [TBXML textForElement:IDC];
    createopportunity.Contact_ = CONTACT_ID;
    NSLog(@"\n\n OPTY_ID_ ...!!! %@ ",createopportunity.Id_);
    NSLog(@"\n\n OPTY_ID_ ...!!! %@ ",createopportunity.Contact_);
    }
}

//Abhishek

// Mobile no Validation

-(BOOL)isNumeric:(NSString*)inputString
{
    NSCharacterSet *charcter = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *filtered;
    filtered = [[inputString componentsSeparatedByCharactersInSet:charcter] componentsJoinedByString:@""];
    
    return [inputString isEqualToString:filtered];
}

//Checking String Length

-(NSUInteger)length :(NSString *)inputString
{
    NSUInteger length = [inputString length];
    return length;
}

-(void)emptyTextfield
{
    
    self.PPL.text = nil;
    self.PL.text = nil;
    self.APPLICATION.text = nil;
    self.LOB.text = nil;
    self.SOURCEOFCONTACT.text = nil;
    self.FINANCIER.text = nil;
    _textfirst.text = nil;
    _textlast.text = nil;
    _textnumber.text = nil;
    
    _Account.text = nil;
    _textpostalcode = nil;
    _textState.text = nil;
    _textadd1.text = nil;
    _textadd2.text = nil;
    _textPanchayat.text = nil;
    _textTaluka.text = nil;
    _textDistrict.text = nil;
    _textCity.text = nil;
    _textlast = nil;
    _textid = nil;
    _textnumber = nil;
    
}



@end
