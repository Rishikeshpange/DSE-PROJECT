//
//  ManageoptyToDetailView.h
//  DSE
//
//  Created by Rishikesh on 01/05/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDetails_Var.h"
#import "AppDelegate.h"

@interface ManageoptyToDetailView : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource,UIActionSheetDelegate>
{
    
    UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;
    
}
@property(strong,nonatomic)NSMutableArray *optySearchDetails;
@property(strong,nonatomic)NSMutableArray *optySearchDetails_Comes;

@property (weak, nonatomic) IBOutlet UILabel *OPTY_ID;
@property (weak, nonatomic) IBOutlet UILabel *OPTY_CREATE_DATE;
@property (weak, nonatomic) IBOutlet UILabel *SALES_STAGE_NAME;
@property (weak, nonatomic) IBOutlet UILabel *PRODUCT_NAME;

@property (weak, nonatomic) IBOutlet UILabel *CONTACT_NAME;
@property (weak, nonatomic) IBOutlet UILabel *CONTACT_CELL_NUMBER;
@property (weak, nonatomic) IBOutlet UILabel *CONTACT_ADDRESS;

@property (weak, nonatomic) IBOutlet UILabel *CUSTOMER_ACCOUNT_NAME;
@property (weak, nonatomic) IBOutlet UILabel *CUSTOMER_PHONE_NUMBER;

@property (strong, nonatomic) IBOutlet UIActionSheet *actionSheet;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;


@property(strong,nonatomic)NSMutableArray *LinkCampaignList;
@property (strong, nonatomic) IBOutlet NSString *selectedLinkCampaignValue;




@end
