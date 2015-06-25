//
//  ActivityPendingList.m
//  NEEV
//
//  Created by admin on 15/04/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import "ActivityPendingList.h"
ActivityPendingList *activityPending_list;
NSMutableArray *pendingActivities_ListArr,*pendingActivities_Customer_list;
NSMutableArray *pendingActivities_ListDisplayArr;
@implementation ActivityPendingList

@synthesize ACTIVITY_PLAN_START_DT,ACTIVITY_TYPE,ACTIVITY_ID,ACTIVITY_STATUS,ACTIVITY_DESC,TGM_TKM_NAME,TGM_TKM_PHONE_NUMBER,ACCOUNT_ID,CONTACT_NAME,CONTACT_ID,CONTACT_ADDRESS,CONTACT_CELL_NUMBER,OPTY_ID,OPTY_NAME,OPTY_CREATED,SALES_STAGE_NAME,SALE_STAGE_UPDATED_DATE,LEAD_POSITION,LEAD_ASSIGNED_NAME,LEAD_ASSIGNED_CELL_NUMBER,X_PROSPECT_SRC,RESULT_COUNT,ACCOUNT_NAME,ACCOUNT_PHONE_NUMBER;

@end
