//
//  ContactTableViewCell.m
//  DSE
//
//  Created by Rishikesh on 09/04/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import "ContactTableViewCell.h"

@implementation ContactTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)callContact:(id)sender
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://8005551212"]];

    };
   
}
- (IBAction)SendMail:(id)sender
{
    
    MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
     NSArray *recipentsArray = [[NSArray alloc]initWithObjects:self.mail, nil];
    [controller setToRecipients:recipentsArray ];
    [controller setSubject:@"My Subject"];
    [controller setMessageBody:@"Hello there." isHTML:NO];
    if (controller)
    {
        [self.window.rootViewController presentViewController:controller animated:YES completion:nil];

    }
   // [self.superview presentModalViewController:controller animated:YES];
    
    
    
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
    }
    [self.window.rootViewController dismissModalViewControllerAnimated:YES];
}


@end
