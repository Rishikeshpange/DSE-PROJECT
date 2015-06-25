//
//  ProductTableviewController.h
//  DSE
//
//  Created by Rishikesh on 02/04/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Analyticstableviewcell.h"

@interface ProductTableviewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong) IBOutlet NSMutableArray *items;
@property(nonatomic, strong) IBOutlet NSMutableArray *colorArray;
@end
