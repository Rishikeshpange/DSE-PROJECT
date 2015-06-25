//
//  RequestDelegate.h
//  RetailerPortal
//
//  Created by madhu on 11/20/12.
//  Copyright (c) 2012 madhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
static void *mainViewControllerVC;


@interface RequestDelegate : NSObject
{
    AppDelegate *appdelegate;
    int statusCode;
    
    NSString *NSurl;
    
    
    
    
    NSURLConnection *artifactConnection, *authenticateOIDConnection, *getDistributorDetailsConnection, *getPricingListConnection, *getRetailerDetailsConnection, *getRetailerLandedPriceConnection, *bpmStatusConnection, *getDistPosConnection, *getInventoryConnection, *placeOrderConnection, *accessTokenConnection, *getOrderNumberConnection, *saveDraftConnection, *viewDraftsConnection, *updateMRPConnection, *updateQuantityConnection, *deletePartConnection, *resetPasswordConnection, *getAllOrdersConnection, *changeOrderStatusConnection , *getCurrentDateConnection , *getUserDetailsConnection,*getOpprtunityCountConnection , *getSaleStageForSearchOpportunityConnection ,*getTahshilSearchOpportunityConnection ,*getSaleStagePPLForSearchOpportunityConnection , *getSearchOpportunityConnection,*getSearchOpportunityAssignTo,*getAllOpportunity,
    *getActivityDetailsConnection ,*getActivityPPLConnection, *getActivityTypeConnection ,*getSearchActivitiesConnection , *getSearchContactConnection , *getCreateContactConnection,*getActivityTaluka,*getActivityAssignTo,
    *getOpportunityLOB_AgianstContactConnection , *getOpportunityPPL_AgianstContactConnection, *getOpportunityPL_AgianstContactConnection , *getOpportunityProductName_AgianstContactConnection , *getOpportunityApplication_AgianstContactConnection ,*getCreateOpportunity_AgainstContactConnection ,*getSearchAccountConnection ,*get_Acct_ContactDetailsConnection ,
    *getCreateContacWithAccountDetails_Connection , *getCreateQuoteRequest_Connection , *getCreateMakeLostTo_Connection, *getCreateModelLostTo_Connection,*getCreateReasonLostTo_Connection
    ,*getCreateLostOpportunity_Connection , *getActivityForOpportunity_Connection ,*getCreateActivity_ForOpportunity_Connection , *getCreateAccount_Connection,*get_Lob_List_Connection,*get_PPL_List_Connection,*get_PL_List_Connection,*get_Application_List_Connection,*get_Financier_List_Connection,*get_Indian_states_List_Connection,*get_District_List_Connection,*get_City_List_Connection,*get_Postal_code_List_Connection,*get_Taluka_List_Connection,*get_Contact_List_Connection,*getPendingActivityDetailsConnection,*getCreateActivityTypeConnection,*getLinkcampaign_Connection,*getLinkcampaign_Select_connection,*getReason_Lost_connection,*getMake_Lost_connection,*getModel_Lost_connection,*getLost_Opty_connection,*adressID_connection,*ContactSave_connection,*ProceedToQuoteCreation_connection,*GetProductconnection,*UpdateOptyconnection,*PL_ProductID_Connection,
    *getCreateAccountaginstcontact_Connection,*getSearchContactConnectiondashboard,*getSearchActivitiesMonthConnectiondashboard,*getdashboardOpportunityConnection,*getSearchOpportunityConnection1 ,*
    getSearchActivitiesConnection1  ,*getPLAnalyticsConnection ,*getPPLAnalyticsConnection,*getdsewisereport,*
    getSearchActivitiesConnection2, *Done_ActivityConnection,*
    After_Done_ActivityConnection ,*AfterQuoteCreationConnection ,*getupdateActivityConnection,*getAllOpportunity1 ,*ActivityDetailsConnection,*Done_Activity_second_request_Connection;
    
    NSMutableData *artifactData, *authenticateOIDData, *getDistributorDetailsData, *getPricingListData, *getRetailerDetailsData, *getRetailerLandedPriceData, *bpmStatusData, *getDistPosData, *getInventoryData, *placeOrderData, *accessTokenData, *getOrderNumberData, *saveDraftData, *viewDraftsData, *updateMRPData, *updateQuantityData, *deletePartData, *resetPasswordData, *getAllOrdersData, *changeOrderStatusData
    , *CurrentDateData ,*userDetailsData ,*opportunityCountData  ,*SaleStageForSearchOpportunityData ,*SalesOppAssingTOData,*SaleStagePPLForSearchOpportunityData,*SaleTahshilSearchOpportunityData,*Search_OpportunitiesData ,*ActivityDetailsData,*SaleAllOpportunity
    ,*ActivityPPLData, *ActivityTypeData , *seachActivitiesData , *SearchContactData ,*CreateContactData,*ActivityTaluka,*ActivityAssignTo,
    *OpportunityLOB_AgianstContactData , *OpportunityPPL_AgianstContactData ,*OpportunityPL_AgianstContactData ,*OpportunityProductName_AgianstContactData ,*OpportunityApplication_AgianstContactData
    ,*CreateOpportunity_AgainstContactData ,*getSearchAccountData   , *getAcct_ContactDetailsData , *CreateContacWithAccountDetails_Data,*CreateQuoteData
    ,*CreateMakeLostTo_Data,*CreateModelLostTo_Data, *CreateReasonLostTo_Data   ,*LostOpportunityData ,*getActivityForOpportunityData ,*getCreateActivity_ForOpportunityData ,*getCreateAccount_Data,*getLobList,*getPPL_List_Data,*getPL_List_Data,*getApplication_List_Data,*getFinancier_List_Data,*getIndian_States_List_Data,*getDistrict_List_Data,*getCityList_Data,*getPostalCode_List_Data,*getTaluka_List_Data,*getContact_List_Data,*PendingActivityDetailsData ,  *ActivityCreateTypeData,*Linkcampaign_Data,*Select_Linkcampaign_Data ,*Reason_lost_Data,*Make_lost_Data,*Model_lost_Data,*Lost_Opty_Data, *adressIDdata,*ContactSavedata,*ProceedToQuoteCreationdata,*GetProductdata,* UpdateOptydata,*PL_ProductID_Data,*getCreateAccountaginstcontact_Data,*SearchContactDataDashboard,*SearchActivitiesMonthDataDashboard,*GetOpportunityDashboard,*Search_OpportunitiesData1,*seachActivitiesData1, *getPLAnalyticsData, *getPPLAnalyticsData, *dsewisereport,*seachActivitiesData2,* Done_ActivityData,*After_Done_ActivityData ,*AfterQuoteCreationData,* PendingActivtyUpdate, *SaleAllOpportunity1,* getPendingActivityDetailsData,*
    Done_Activity_second_request_Data;
}
-(void)initiateRequest:(NSURLRequest*)request name:(NSString*)name;

-(void)CheckSamalArtExpires :(NSString*)str_samalART;

@end
