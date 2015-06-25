//
//  ActivityListViewController.h
//  NEEV
//
//  Created by admin on 17/03/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UserDetails_Var.h"
#import "AppDelegate.h"


@interface ActivityListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

    {
        UserDetails_Var *userDetailsVal_;
        AppDelegate *appdelegate;
        NSInteger noOfPageCounts;
        NSInteger currentPage;
        NSInteger startIndex, endIndex;//
    }


@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIView *_ViewTableData;

@end
