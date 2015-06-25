//
//  ManageOpportunity.h
//  NEEV
//
//  Created by Sachin Sharma on 20/03/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDetails_Var.h"
#import "AppDelegate.h"

@interface ManageOpportunity : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UserDetails_Var *userDetailsVal_;
    AppDelegate *appdelegate;
}
@property (weak, nonatomic) IBOutlet UITableView *opportunoity_tv;


@property(nonatomic,retain)NSString *startLoop;//for start range to display result
@property(nonatomic,retain)NSString *endLoop;//for end range to display result

@property(nonatomic,retain)NSString *ResultCount;



@end

