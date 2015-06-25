//
//  dashBoardActivity.h
//  NEEV
//
//  Created by admin on 08/05/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dashBoardActivity : NSObject

/*
 <S_OPTY_POSTN>
 <OPTY_NAME>1-788U78A</OPTY_NAME>
 <OPTY_ID>1-788U78A</OPTY_ID>
 <PRODUCT_NAME1>Ace Zip</PRODUCT_NAME1>
 <OPTY_CREATED>19-SEP-2014</OPTY_CREATED>
 
 <TGM_TKM_NAME xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
 <TGM_TKM_PHONE_NUMBER xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
 
 <ACCOUNT_TYPE>TGM</ACCOUNT_TYPE>
 <ACCOUNT_ID xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" null="true" xsi:nil="true" />
 <SALES_STAGE_NAME>Closed Lost at C1A</SALES_STAGE_NAME>
 <SALE_STAGE_UPDATED_DATE>27-JAN-2015</SALE_STAGE_UPDATED_DATE>
 <LEAD_ASSIGNED_NAME>AJAY PARAB</LEAD_ASSIGNED_NAME>
 <LEAD_ASSIGNED_CELL_NUMBER>9999999999</LEAD_ASSIGNED_CELL_NUMBER>
 <LEAD_ASSIGNED_POSITION_NAME>TMCV-Sal-W-MUM-1001680-Jogeshwari-Pickup-DSE-33</LEAD_ASSIGNED_POSITION_NAME>
 <LEAD_ASSIGNED_POSITION_ID>1-7F0Y20</LEAD_ASSIGNED_POSITION_ID>
 <CONTACT_NAME>ANAND KUMAR</CONTACT_NAME>
 <CONTACT_ID>1-788U783</CONTACT_ID>
 <ADDRESS_ID>1-788U788</ADDRESS_ID>
 <CONTACT_ADDRESS>FINANCE ONE INDIA BULLS, 20TH FLR,</CONTACT_ADDRESS>
 <CONTACT_CELL_NUMBER>2266586333</CONTACT_CELL_NUMBER>
 <ACTIVITY_PENDING_TYPE>Test Drive</ACTIVITY_PENDING_TYPE>
 <ACTIVITY_ID>1-7BN1O73</ACTIVITY_ID>
 <PLANNED_START_DATE>28-FEB-2015 17:14:05</PLANNED_START_DATE>
 <ACTIVITY_DESCRIPTION>FFF</ACTIVITY_DESCRIPTION>
 <ACTIVITY_STATUS>Open</ACTIVITY_STATUS>
 <PRODUCT_NAME>Ace_Zip</PRODUCT_NAME>
 </S_OPTY_POSTN>
 */

@property(nonatomic , strong)NSString *X_PROSPECT_SRC;
@property(nonatomic , strong)NSString *ACTIVITY_ROW_ID;
@property(nonatomic , strong)NSString *ACTIVITY_TYPE;
@property(nonatomic , strong)NSString *ACTIVITY_PLAN_START_DATE;
@property(nonatomic , strong)NSString *ACTIVITY_CREATED_DATE;
@property(nonatomic , strong)NSString *ACTIVITY_COMPLETION_DATE;
@property(nonatomic , strong)NSString *ACTIVITY_STATUS;
@property(nonatomic , strong)NSString *DESCRIPTION;
@property(nonatomic , strong)NSString *OPTY_CREAT_DATE;
@property(nonatomic , strong)NSString *OPPTY_ROWID;
@property(nonatomic , strong)NSString *OPPTY_NAME;
@property(nonatomic , strong)NSString *PRODUCT_LINE;
@property(nonatomic , strong)NSString *PRODUCT_NAME1;
@property(nonatomic , strong)NSString *VC;
@property(nonatomic , strong)NSString *CONTACT_ID;
@property(nonatomic , strong)NSString *CONTACT_NAME;
@property(nonatomic , strong)NSString *CONTACT_CELL_NUM;
@property(nonatomic , strong)NSString *CONTACT_ADDRESS;
@property(nonatomic , strong)NSString *ADDRESS_ID;
@property(nonatomic , strong)NSString *ACCOUNT_ID;
@property(nonatomic , strong)NSString *ACCOUNT_TYPE;
@property(nonatomic , strong)NSString *ACCOUNT_NAME;
@property(nonatomic , strong)NSString *ACCOUNT_PHONE_NUMBER;
@property(nonatomic , strong)NSString *ACCOUNT_LOCATION;
@property(nonatomic , strong)NSString *SALES_STAGE_DATE;
@property(nonatomic , strong)NSString *SALES_STAGE_NAME;
@property(nonatomic , strong)NSString *RNUM;
@property(nonatomic , strong)NSString *RESULT_COUNT;
@property(nonatomic , strong)NSString *LEAD_ASSIGNED_NAME;
@property(nonatomic , strong)NSString *ACTIVITY_PENDING_TYPE;
@property(nonatomic , strong)NSString *LEAD_ASSIGNED_CELL_NUMBER;
@property(nonatomic , strong)NSString *LEAD_ASSIGNED_POSITION_NAME;
@property(nonatomic , strong)NSString *LEAD_ASSIGNED_POSITION_ID;
@property(nonatomic , strong)NSString *PARENT_PRODUCT_NAME;
@property(nonatomic , strong)NSString *SALE_STAGE;

@property(nonatomic , strong)NSString *TGM_TKM_NAME;
@property(nonatomic , strong)NSString *TGM_TKM_PHONE_NUMBER;

@end

extern dashBoardActivity *dashboardActivity_list,*dashboardActivityMonth_list;
extern NSMutableArray *dashboardActivities_ListArr,*dashboardActivities_Month_Arr;
extern NSMutableArray *dashboardActivities_Customer_list;
extern NSMutableArray *dashboardActivities_ListDisplayArr;

