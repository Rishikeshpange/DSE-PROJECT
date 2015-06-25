//
//  ContactTableViewCell.h
//  DSE
//
//  Created by Rishikesh on 09/04/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>


@interface ContactTableViewCell : UITableViewCell<MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *ContactImage;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet NSString *mail;

@property (weak) UIView *parentTableView;



@end
