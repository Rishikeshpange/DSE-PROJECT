//
//  manageOpportunity_Cell.h
//  SFA
//
//  Created by Abhishek on 24/03/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//










#import <UIKit/UIKit.h>

@interface manageOpportunity_Cell : UITableViewCell
{
    
}
@property (weak, nonatomic) IBOutlet UILabel *lbl_CustName;

@property (weak, nonatomic) IBOutlet UIView *manage_opty_bg_view;


@property (weak, nonatomic) IBOutlet UILabel *lblPhoneNumber;



@property (weak, nonatomic) IBOutlet UILabel *lbl_ProductName;

@property (weak, nonatomic) IBOutlet UILabel *lbl_phoneNumber;

@property (weak, nonatomic) IBOutlet UILabel *lbl_CustomerName;



@property (weak, nonatomic) IBOutlet UILabel *lbl_opty_Created_date;

@property (weak, nonatomic) IBOutlet UILabel *lbl_Sales_stages;
@property (weak, nonatomic) IBOutlet UILabel *lbl_LAST_DONE_ACTIVITY_T;
@property (weak, nonatomic) IBOutlet UILabel *Account_Name;
@property (weak, nonatomic) IBOutlet UILabel *Customer_name_R;
@property (weak, nonatomic) IBOutlet UILabel *product_name_R;
@property (weak, nonatomic) IBOutlet UILabel *lbl_sales_stage_name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_opty_create_date;
@property (weak, nonatomic) IBOutlet UILabel *lbl_last_dobe_activity_R;

///// MAin View
/*
@property (weak, nonatomic) IBOutlet UILabel *lbl_Customer_Name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Product_Name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_OpTy_Created_Date;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Cont_Phn_Num;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Sales_Stages;
@property (weak, nonatomic) IBOutlet UILabel *lbl_LAST_DONE_ACTIVITY_TYPE;
*/

@property (weak, nonatomic) IBOutlet UILabel *lbl_Prod_Name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Cust_Name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_OptyCreation_Name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_phn_Name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_SalesStages_Name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_LastDone_Name;
@end
