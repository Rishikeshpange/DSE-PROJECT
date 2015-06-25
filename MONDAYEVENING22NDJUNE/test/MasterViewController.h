//
//  MasterViewController.h
//  test
//
//  Created by Sebastian Boldt on 07.03.13.
//  Copyright (c) 2013 LetsIDev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailViewController;

@interface MasterViewController : UITableViewController<UIAlertViewDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

//@property (strong, nonatomic) DetailViewManager *detailViewManager;

@property(nonatomic, assign) CGFloat maximumPrimaryColumnWidth NS_AVAILABLE_IOS(8_0);

@property(nonatomic,assign) CGFloat max NS_AVAILABLE_IOS(7_0);

@property(nonatomic, assign) CGFloat maximumPrimaryColumnWidth1 NS_AVAILABLE_IOS(7_0);

@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;



@end
