//
//  Activity_List.h
//  DSM
//
//  Created by Sachin Sharma on 13/04/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Activity_List : NSObject

//@property(nonatomic , strong)NSString *X_PROSPECT_SRC;
//@property(nonatomic , strong)NSString *ACTIVITY_ROW_ID;
//@property(nonatomic , strong)NSString *ACTIVITY_TYPE;
//@property(nonatomic , strong)NSString *ACTIVITY_PLAN_START_DATE;
//@property(nonatomic , strong)NSString *ACTIVITY_CREATED_DATE;
//@property(nonatomic , strong)NSString *ACTIVITY_COMPLETION_DATE;
//@property(nonatomic , strong)NSString *ACTIVITY_STATUS;
//@property(nonatomic , strong)NSString *DESCRIPTION;
//@property(nonatomic , strong)NSString *OPTY_CREAT_DATE;
//@property(nonatomic , strong)NSString *OPPTY_ROWID;
//@property(nonatomic , strong)NSString *OPPTY_NAME;
//@property(nonatomic , strong)NSString *PRODUCT_LINE;
//@property(nonatomic , strong)NSString *PRODUCT_NAME1;
//@property(nonatomic , strong)NSString *VC;
//@property(nonatomic , strong)NSString *CONTACT_ID;
//@property(nonatomic , strong)NSString *CONTACT_NAME;
//@property(nonatomic , strong)NSString *CONTACT_CELL_NUM;
//@property(nonatomic , strong)NSString *CONTACT_ADDRESS;
//@property(nonatomic , strong)NSString *ADDRESS_ID;
//@property(nonatomic , strong)NSString *ACCOUNT_ID;
//@property(nonatomic , strong)NSString *ACCOUNT_TYPE;
//@property(nonatomic , strong)NSString *ACCOUNT_NAME;
//@property(nonatomic , strong)NSString *ACCOUNT_PHONE_NUMBER;
//@property(nonatomic , strong)NSString *ACCOUNT_LOCATION;
//@property(nonatomic , strong)NSString *SALES_STAGE_DATE;
//@property(nonatomic , strong)NSString *SALES_STAGE_NAME;
//@property(nonatomic , strong)NSString *RNUM;
//@property(nonatomic , strong)NSString *RESULT_COUNT;
//@property(nonatomic , strong)NSString *LEAD_ASSIGNED_NAME;
//@property(nonatomic , strong)NSString *ACTIVITY_PENDING_TYPE;
//@property(nonatomic , strong)NSString *LEAD_ASSIGNED_CELL_NUMBER;
//@property(nonatomic , strong)NSString *LEAD_ASSIGNED_POSITION_NAME;
//@property(nonatomic , strong)NSString *LEAD_ASSIGNED_POSITION_ID;

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
@property(nonatomic , strong)NSString *PARENT_PRODUCT_NAME;
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
@property(nonatomic , strong)NSString *SALE_STAGE;
@property(nonatomic , strong)NSString *RNUM;
@property(nonatomic , strong)NSString *RESULT_COUNT;


@end


extern Activity_List *activity_list;

extern NSMutableArray *Activities_ListArr;
extern NSMutableArray *Activities_Customer_list;

extern NSMutableArray *Activities_ListDisplayArr;