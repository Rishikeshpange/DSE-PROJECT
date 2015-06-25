//
//  ActivityDetailsViewController.h
//  NEEV
//
//  Created by admin on 17/03/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDetails_Var.h"
#import "AppDelegate.h"
#import "ActivityPendingList.h"

@interface ActivityDetailsViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

{
    
    UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;
    
}


@property (strong, nonatomic) IBOutlet UIScrollView *textscroll;

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIView *activityInfo;



@property (weak, nonatomic) IBOutlet UILabel *customerName;

@property (weak, nonatomic) IBOutlet UILabel *customerNumber;


@property (weak, nonatomic) IBOutlet UILabel *assigntoName;

@property (weak, nonatomic) IBOutlet UILabel *assigntoNumber;


@property (strong, nonatomic) IBOutlet NSString *ACTIVITY_TYPE;
@property (strong, nonatomic) IBOutlet NSString *ACTIVITY_ID;





 


 
 @property (weak, nonatomic) IBOutlet UILabel *optyCounter;
 
 




@end
