//
//  INFOViewController.m
//  DSE
//
//  Created by Rishikesh on 07/07/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import "INFOViewController.h"

@interface INFOViewController ()

@end

@implementation INFOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 515, 30)];
    fromLabel.text = @"About Us";
    fromLabel.textColor=[UIColor whiteColor];
//    fromLabel.numberOfLines = 1;
//    fromLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
//    fromLabel.adjustsFontSizeToFitWidth = YES;
    fromLabel.adjustsLetterSpacingToFitWidth = YES;
//    fromLabel.minimumScaleFactor = 10.0f/12.0f;
    fromLabel.clipsToBounds = YES;
    fromLabel.backgroundColor = [UIColor colorWithRed:115/255.0f green:182/255.0f blue:68/255.0f alpha:1];
//    fromLabel.textColor = [UIColor blackColor];
//    fromLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:fromLabel];
    UITextView *newTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 55, 515,500)];
    [newTextView setFont:[UIFont systemFontOfSize:16]];
    newTextView.text = @"WatchKit apps do not use the same layout model as iOS apps. When assembling the scenes of your WatchKit app interface, you do not create view hierarchies by placing elements arbitrarily in the available space. Instead, as you add elements to your scene, Xcode arranges the items for you, stacking them vertically on different lines. At runtime, Apple Watch takes those elements and lays them out for you based on the available space.Although Xcode handles the overall layout of your interface, WatchKit provides ways to fine tune the position of items within a scene. The size and position of most items can be configured using the Attributes inspector. Changing the position of an item changes lets you set the horizontal and vertical alignment of that item at its current location in the element stack. The sizing options let you specify a fixed width for an item or give it the ability to resize itself within the available space. Group objects offer another important tool for arranging other elements in your interface. Group elements are a container for other elements, giving you the option to arrange elements in the group horizontally as well as vertically. You can nest groups within other groups and use each group’s spacing and inset values to alter the size and position of items. Groups have no default visual representation but they can be configured with a background color or image if you want.Figure 5-1 shows how you can arrange different elements in your storyboard file. The first three elements are labels, which have different alignments within the interface controller’s bounds. Below the labels is a group object containing two images arranged horizontally. The interface also contains a separator and a button stacked vertically underneath the group object.Xcode supports customizing your interface for the different sizes of Apple Watch. The changes you make in the storyboard editor by default apply to all sizes of Apple Watch, but you can customize your storyboard scenes as needed for different devices. For example, you might make minor adjustments to the spacing and layout of items or specify different images for different device size.To customize an item for a specific device size, use the plus buttons (+) in the Attributes inspector to override the value of an attribute for a given device. Clicking a plus button adds a new device-specific entry for the attribute. Changes you make to that version of the attribute affect only the selected device. Figure 5-2 shows how text scaling is handled differently for Apple Watch 42mm.";
    
    newTextView.backgroundColor=[UIColor clearColor];
    newTextView.userInteractionEnabled = YES;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(Cancel)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Cancel" forState:UIControlStateNormal];
    button.frame = CGRectMake(180.0, 568, 180.0, 35);
    button.backgroundColor=[UIColor colorWithRed:115/255.0f green:182/255.0f blue:68/255.0f alpha:1];
    button.layer.cornerRadius=2;
    [self.view addSubview:button];
    
    [self.view addSubview:newTextView];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)Cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
