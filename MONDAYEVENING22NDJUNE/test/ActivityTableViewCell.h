//
//  ActivityTableViewCell.h
//  NEEV
//
//  Created by Sachin Sharma on 02/04/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ActivityPendingList.h"

@interface ActivityTableViewCell : UITableViewCell

{
    
  
    AppDelegate *appdelegate;
    
}


@property (weak, nonatomic) IBOutlet UILabel *lbl_Planned_Date;

@property (weak, nonatomic) IBOutlet UILabel *lbl_Activity_Type;

@property (weak, nonatomic) IBOutlet UILabel *lbl_Activity_Status;

@property (weak, nonatomic) IBOutlet UILabel *lbl_Description;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *updateButton;

@property (strong, nonatomic) IBOutlet NSString *ACTIVITY_TYPE;
@property (strong, nonatomic) IBOutlet NSString *ACTIVITY_ID;
@end

