//
//  AppDelegate.h
//  test
//
//  Created by Sebastian Boldt on 07.03.13.
//  Copyright (c) 2013 LetsIDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic) BOOL authenticated;

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) IBOutlet UISplitViewController *splitViewController;
@property(nonatomic,retain) NSString *URL;
@property(nonatomic,retain) NSMutableString *artifact;
 @property(nonatomic,retain) UIAlertView *alertProgress;
@property(nonatomic, strong) IBOutlet NSMutableArray *ContactList;
@property(nonatomic, strong) IBOutlet NSMutableArray *ActivityList;
@property(nonatomic, strong) IBOutlet NSMutableArray *OppurtunityList;//optyview
@property(nonatomic, strong) IBOutlet NSMutableArray *SearchOppurtunityList;//searchoptyview
@property(nonatomic, strong) IBOutlet NSMutableArray *ActivityListForSearch;
@property(nonatomic, readwrite)  NSInteger *row;//clicled activity row indexpath in activitylist view
@property(nonatomic,retain)  NSString *OPTY_ID_For_Activity_Detail;
@property(nonatomic, readwrite)  NSInteger *optyrow;

//ManageOPTYView
@property(nonatomic, readwrite)  NSInteger *Manageoptyrow;
@property(nonatomic,retain)NSArray *loginUD;

@property(nonatomic,retain) NSString *fromOPTYDetail;
@property(nonatomic,retain) NSString *fromACTIVITYDetail;
@property(nonatomic,retain) NSString *fromManageOptyDetail;
@property(nonatomic,retain) NSString *Account_Id;//create opty page
@property(nonatomic,retain) NSString *Address_Id;//create opty page
@property(nonatomic,retain) NSString *Product_Id;//create opty page

@property(nonatomic,retain) NSString *accountName;//create quote update account(serach opty)
@property(nonatomic,retain) NSString *accountPhoneNumber;//create quote update account(serach opty)


@property(nonatomic,retain) NSString *PPL;//create quote update opty(search opty)
//@property(nonatomic,retain) NSString *accountPhoneNumber;//create quote update account

@property(nonatomic,retain) NSString *fromCreatequote;//create quote ->update opty


@property(nonatomic,retain) NSString *fromCreateoppurtunityPage;//flag for create new activity for opty
@property(nonatomic,retain) NSString *newactivityOptyID;
@property(nonatomic,retain) NSString *createOptyPL;


@property(nonatomic,retain) NSString *fromManageOptyview;
@property(nonatomic,retain) NSString *fromSearchOptyview;

@property(nonatomic,retain) NSString *opty_idDetailPage;//from detail page
@property(nonatomic,retain) NSString *CUSTOMER_ACCOUNT_NAME;//fromdetailpage
@property(nonatomic,retain) NSString *CUSTOMER_PHONE_NUMBER;//fromdetailpage
@property(nonatomic,retain) NSString *SALE_STAGE_NAME;//fromdetailpage
@property(nonatomic,retain) NSString *CONTACT_NAME;//fromdetailpage
@property(nonatomic,retain) NSString *CONTACT_CELL_NUMBER;//fromdetailpage

@property(nonatomic,retain) NSString *PRODUCT_NAME;//fromdetailpage
@property(nonatomic,retain) NSString *PRODUCT_NAME1;//fromdetailpage
@property(nonatomic,retain) NSString *CONTACT_ID;//fromdetailpage
@property(nonatomic,retain) NSString *VC;//fromdetailpage

@property (strong, nonatomic) IBOutlet NSString *ACTIVITY_TYPE;//frompending activity cell
@property (strong, nonatomic) IBOutlet NSString *ACTIVITY_ID;//frompending activity cell

@property (strong, nonatomic) IBOutlet NSString *FromUpdateActivityString;

@property (strong, nonatomic) IBOutlet NSString *reloadDataArrChange;
@property (strong, nonatomic) IBOutlet NSString *CUSTOMER_ACCOUNT_ID;//For Opty detail page CUSTOMER_ACCOUNT_ID


@property (strong, nonatomic) IBOutlet NSString *toandfromdate;

-(void)hideAlert;
-(void)callArtifactRequest;
-(void)callDateRequest;

@end
