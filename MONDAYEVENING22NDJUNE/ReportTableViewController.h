//
//  ReportTableViewController.h
//  DSE
//
//  Created by Rishikesh on 02/04/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportTableViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong) IBOutlet NSMutableArray *items;

@end
