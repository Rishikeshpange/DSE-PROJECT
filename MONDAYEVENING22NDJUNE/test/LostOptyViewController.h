//
//  LostOptyViewController.h
//  NEEV
//
//  Created by admin on 28/03/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface LostOptyViewController : UIViewController<UIActionSheetDelegate,UITextFieldDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtReason;
@property (weak, nonatomic) IBOutlet UITextField *txtMakeLost;
@property (weak, nonatomic) IBOutlet UITextField *txtModeLost;
@property (weak, nonatomic) IBOutlet UITextView *txtDescription;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNmuberLabel;

@property (weak, nonatomic) IBOutlet UIView *viewFirst;
@property (weak, nonatomic) IBOutlet  AppDelegate *appdelegate;
@property (strong, nonatomic) IBOutlet NSMutableArray *ReasonLostArray;
@property (strong, nonatomic) IBOutlet NSMutableArray *MakeLostArray;
@property (strong, nonatomic) IBOutlet NSMutableArray *ModeLostArray;
@property (strong, nonatomic) IBOutlet UIActionSheet *actionSheet;

@property(strong,nonatomic)NSMutableArray *MakeLostSalesStageArr;

@property (assign) CGPoint originalCenter;

@property (nonatomic,strong) IBOutlet NSString *Account_Name;

@end
