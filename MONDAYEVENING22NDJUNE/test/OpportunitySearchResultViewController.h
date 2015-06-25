//
//  OpportunitySearchResultViewController.h
//  DSM
//
//  Created by Sachin Sharma on 24/04/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UserDetails_Var.h"
@interface OpportunitySearchResultViewController : UIViewController<UITableViewDataSource,UITabBarDelegate>
{
    
    UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;
    
}
@property(strong,nonatomic)NSMutableArray *optySearchDetails;
@property(strong,nonatomic)NSMutableArray *optySearchDetails_Comes;
@property(strong,nonatomic)NSString *txtFromDate;
@property(strong,nonatomic)NSString *txtToDate;
@property(strong,nonatomic)NSString *txtSalesStages;
@property(strong,nonatomic)NSString *txtPPL;
@property(strong,nonatomic)NSString *txtActivityType;
@property(strong,nonatomic)NSString *txtActivityStatus;

@property(strong,nonatomic)NSString *CustomerName;
@property (weak, nonatomic) IBOutlet UITableView *tableViewData;
@end