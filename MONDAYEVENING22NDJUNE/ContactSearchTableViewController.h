//
//  ContactSearchTableViewController.h
//  DSE
//
//  Created by Rishikesh on 09/04/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MBProgressHUD.h"


@interface ContactSearchTableViewController : UITableViewController<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property(strong,nonatomic) IBOutlet  AppDelegate *appdelegate;



@property(nonatomic, strong) IBOutlet NSMutableArray *ContactList;

-(void)showAlert;
-(void)hideAlert;
@end
