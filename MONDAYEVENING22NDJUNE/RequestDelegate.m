//
//  RequestDelegate.m
//  RetailerPortal
//
//  Created by madhu on 11/20/12.
//  Copyright (c) 2012 madhu. All rights reserved.
//

#import "RequestDelegate.h"
#import "AppDelegate.h"
#import "LoginViewController.h"


@implementation RequestDelegate
-(void)initiateRequest:(NSURLRequest *)request name:(NSString *)name
{
    if([name isEqualToString:@"artifactRequest"]) // for artifactrequest
    {
        NSLog(@"SENDING ARTIFACT REQUEST");
        artifactData = [[NSMutableData alloc]init];
        artifactConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [artifactConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [artifactConnection start];
        NSLog(@"Ending..");
    }
    else if([name isEqualToString:@"authenticateOIDRequest"]) // for Authenticte
    {
        NSLog(@"SENDING authenticateOID REQUEST");
        authenticateOIDData = [[NSMutableData alloc]init];
        authenticateOIDConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [authenticateOIDConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [authenticateOIDConnection start];
    }
    
    else if([name isEqualToString:@"dateRequest"]) // for date
    {
        NSLog(@"SENDING dateRequest REQUEST");
        CurrentDateData = [[NSMutableData alloc]init];
        getCurrentDateConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getCurrentDateConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getCurrentDateConnection start];
    }
    
    else if([name isEqualToString:@"userDetailsRequest"]) // for User Details
    {
        NSLog(@"SENDING userDetailsRequest REQUEST");
        userDetailsData = [[NSMutableData alloc]init];
        getUserDetailsConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getUserDetailsConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getUserDetailsConnection start];
    }
    
    
    else if([name isEqualToString:@"getOpprtunityCountConnection"]) //for opprtunity Count
    {
        NSLog(@"SENDING userDetailsRequest REQUEST Opty");
        opportunityCountData = [[NSMutableData alloc]init];
        getOpprtunityCountConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getOpprtunityCountConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getOpprtunityCountConnection start];
    }
    
    else if([name isEqualToString:@"getSaleStageForSearchOpportunityConnection"]) //for search opportunity screen // for sale stage
    {
        NSLog(@"SENDING userDetailsRequest REQUEST");
        SaleStageForSearchOpportunityData = [[NSMutableData alloc]init];
        getSaleStageForSearchOpportunityConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getSaleStageForSearchOpportunityConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getSaleStageForSearchOpportunityConnection start];
    }
    
    else if([name isEqualToString:@"getSaleStagePPLForSearchOpportunityConnection"]) //for seach opportunity screen  // for PPL Stage
    {
        NSLog(@"SENDING userDetailsRequest REQUEST");
        SaleStagePPLForSearchOpportunityData = [[NSMutableData alloc]init];
        getSaleStagePPLForSearchOpportunityConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getSaleStagePPLForSearchOpportunityConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getSaleStagePPLForSearchOpportunityConnection start];
    }
    
    else if([name isEqualToString:@"getTahshilSearchOpportunityConnection"]) //for search opportunity screen // for sale stage
    {
        NSLog(@"SENDING userDetailsRequest REQUEST Tahshil");
        SaleTahshilSearchOpportunityData = [[NSMutableData alloc]init];
        getTahshilSearchOpportunityConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getTahshilSearchOpportunityConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getTahshilSearchOpportunityConnection start];
    }
    //getAllOpprtunity
    else if([name isEqualToString:@"getAllOpprtunity"]) //for search opportunity screen // for sale stage
    {
        NSLog(@"SENDING All Opty");
        SaleAllOpportunity = [[NSMutableData alloc]init];
        getAllOpportunity = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getAllOpportunity scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getAllOpportunity start];
    }
    else if([name isEqualToString:@"getAllOpprtunity1"]) //for search opportunity screen // for sale stage
    {
        NSLog(@"SENDING All Opty");
        SaleAllOpportunity1 = [[NSMutableData alloc]init];
        getAllOpportunity1 = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getAllOpportunity1 scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getAllOpportunity1 start];
    }
    else if([name isEqualToString:@"getActivity_AssignTo"]) //for search opportunity screen // for sale stage
    {
        NSLog(@"SENDING userDetailsRequest REQUEST Tahshil");
        SalesOppAssingTOData = [[NSMutableData alloc]init];
        getSearchOpportunityAssignTo = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getSearchOpportunityAssignTo scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getSearchOpportunityAssignTo start];
    }
    else if([name isEqualToString:@"SearchOpportunities_Connection"]) // for search a opportunities
    {
        NSLog(@"\nSEDING SearchOpportunities_Connection REQUEST");
        Search_OpportunitiesData = [[NSMutableData alloc]init];
        getSearchOpportunityConnection =[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getSearchOpportunityConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getSearchOpportunityConnection start];
    }
    else if([name isEqualToString:@"SearchOpportunities_Connection1"]) // for search a opportunities
    {
        NSLog(@"\nSEDING SearchOpportunities_Connection REQUEST");
        Search_OpportunitiesData1 = [[NSMutableData alloc]init];
        getSearchOpportunityConnection1 =[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getSearchOpportunityConnection1 scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getSearchOpportunityConnection1 start];
    }
    
    
    else if([name isEqualToString:@"ActivityDetails_Connection"]) // for Activity List Details //ACtivity_ViewController
    {
        NSLog(@"\nSEDING ActivityDetails_Connection REQUEST");
        ActivityDetailsData = [[NSMutableData alloc]init];
        getActivityDetailsConnection =[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getActivityDetailsConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getActivityDetailsConnection start];
    }
    
    else if([name isEqualToString:@"getActivityPPLConnection"]) // for Activity PPL List Details //searchActivity_VC
    {
        NSLog(@"\nSEDING getActivityPPLConnection REQUEST");
        ActivityPPLData = [[NSMutableData alloc]init];
        getActivityPPLConnection =[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getActivityPPLConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getActivityPPLConnection start];
    }
    
    else if([name isEqualToString:@"getActivityTaluka"]) // for Activity PPL List Details //searchActivity_VC
    {
        NSLog(@"\nSEDING getActivityPPLConnection REQUEST");
        ActivityTaluka = [[NSMutableData alloc]init];
        getActivityTaluka =[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getActivityTaluka scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getActivityTaluka start];
    }
    else if([name isEqualToString:@"getActivityAssignTo"]) // for Activity PPL List Details //searchActivity_VC
    {
        NSLog(@"\nSEDING getActivityPPLConnection REQUEST");
        ActivityAssignTo = [[NSMutableData alloc]init];
        getActivityAssignTo =[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getActivityAssignTo scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getActivityAssignTo start];
    }
    else if([name isEqualToString:@"getActivityTypeConnection"]) // for Activity TYPE List Details //searchActivity_VC
    {
        NSLog(@"\nSEDING getActivityTypeConnection REQUEST");
        ActivityTypeData = [[NSMutableData alloc]init];
        getActivityTypeConnection =[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getActivityTypeConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getActivityTypeConnection start];
    }
    
    else if([name isEqualToString:@"SearchActivities_Connection"]) // for searching Activities //searchActivity_VC
    {
        NSLog(@"\nSEDING SearchActivities_Connection REQUEST");
        seachActivitiesData = [[NSMutableData alloc]init];
        getSearchActivitiesConnection =[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getSearchActivitiesConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getSearchActivitiesConnection start];
    }
    else if([name isEqualToString:@"SearchActivities_Connection1"]) // for searching Activities //searchActivity_VC
    {
        NSLog(@"\nSEDING SearchActivities_Connection1 REQUEST");
        seachActivitiesData1 = [[NSMutableData alloc]init];
        getSearchActivitiesConnection1 =[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getSearchActivitiesConnection1 scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getSearchActivitiesConnection1 start];
    }
    else if([name isEqualToString:@"SearchActivities_Connection2"]) // for searching Activities //searchActivity_VC
    {
        NSLog(@"\nSEDING SearchActivities_Connection REQUEST");
        seachActivitiesData2 = [[NSMutableData alloc]init];
        getSearchActivitiesConnection2 =[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getSearchActivitiesConnection2 scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getSearchActivitiesConnection2 start];
    }

    
    else if([name isEqualToString:@"SearchContactConnection"]) // for searching Contacts //SearchContactVC
    {
        NSLog(@"\nSEDING SearchContactConnection REQUEST");
        SearchContactData = [[NSMutableData alloc]init];
        getSearchContactConnection =[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getSearchContactConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getSearchContactConnection start];
    }
    
    else if([name isEqualToString:@"CreateContactConnection"]) // for createContact Contacts //CreateContact_VC
    {
        NSLog(@"\nSEDING SearchContactConnection REQUEST");
        CreateContactData = [[NSMutableData alloc]init];
        getCreateContactConnection =[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getCreateContactConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getCreateContactConnection start];
    }
    
    else if([name isEqualToString:@"createOpportunity_LOB_ConnectionAgainstContact"]) // for LOB Contacts create opportunityAgianstContact //CreateOpportunityAgainstContact_VC
    {
        NSLog(@"\nSEDING SearchContactConnection REQUEST");
        OpportunityLOB_AgianstContactData = [[NSMutableData alloc]init];
        getOpportunityLOB_AgianstContactConnection =[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getOpportunityLOB_AgianstContactConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getOpportunityLOB_AgianstContactConnection start];
    }
    
    
    else if([name isEqualToString:@"createOpportunity_PPL_ConnectionAgainstContact"]) // for PPL Contacts create opportunityAgianstContact //CreateOpportunityAgainstContact_VC
    {
        NSLog(@"\nSEDING SearchContactConnection REQUEST");
        OpportunityPPL_AgianstContactData = [[NSMutableData alloc]init];
        getOpportunityPPL_AgianstContactConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getOpportunityPPL_AgianstContactConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getOpportunityPPL_AgianstContactConnection start];
    }
    
    else if([name isEqualToString:@"createOpportunity_PL_ConnectionAgainstContact"]) // for PL Contacts create opportunityAgianstContact //CreateOpportunityAgainstContact_VC
    {
        NSLog(@"\nSEDING SearchContactConnection REQUEST");
        OpportunityPL_AgianstContactData = [[NSMutableData alloc]init];
        getOpportunityPL_AgianstContactConnection =[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getOpportunityPL_AgianstContactConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getOpportunityPL_AgianstContactConnection start];
    }
    
    else if([name isEqualToString:@"createOpportunity_Application_ConnectionAgainstContact"]) // for Application Contacts create opportunityAgianstContact //CreateOpportunityAgainstContact_VC
    {
        NSLog(@"\nSEDING SearchContactConnection REQUEST");
        OpportunityApplication_AgianstContactData = [[NSMutableData alloc]init];
        getOpportunityApplication_AgianstContactConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getOpportunityApplication_AgianstContactConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getOpportunityApplication_AgianstContactConnection start];
    }
    
    
    else if([name isEqualToString:@"createOpportunity_AgainstContact"]) //for Create Opportunity //CreateOpportunityAgainstContact_VC
    {
        NSLog(@"\nSEDING SearchContactConnection REQUEST");
        CreateOpportunity_AgainstContactData = [[NSMutableData alloc]init];
        getCreateOpportunity_AgainstContactConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getCreateOpportunity_AgainstContactConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getCreateOpportunity_AgainstContactConnection start];
    }
    
    else if([name isEqualToString:@"AccountSearch_Connection"]) //for Search Account //SearchAccount_VC
    {
        NSLog(@"\nSEDING SearchContactConnection REQUEST");
        getSearchAccountData = [[NSMutableData alloc]init];
        getSearchAccountConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getSearchAccountConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getSearchAccountConnection start];
    }
    
    
    else if([name isEqualToString:@"AcctContacDetails_Connection"]) //for  Account Contact Details //AccountDetailsWithContact_VC
    {
        NSLog(@"\nSEDING SearchContactConnection REQUEST");
        getAcct_ContactDetailsData = [[NSMutableData alloc]init];
        get_Acct_ContactDetailsConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [get_Acct_ContactDetailsConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [get_Acct_ContactDetailsConnection start];
    }
    
    
    else if ([name isEqualToString:@"CreateContacWithAccountDetails_Connection"])// For create contact CreateContacWithAccount_VC
    {
        NSLog(@"\nSEDING SearchContactConnection REQUEST");
        CreateContacWithAccountDetails_Data = [[NSMutableData alloc]init];
        getCreateContacWithAccountDetails_Connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getCreateContacWithAccountDetails_Connection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getCreateContacWithAccountDetails_Connection start];
        
    }
    
    
    
    else if ([name isEqualToString:@"CreateQuoteRequest"])// For create contact Opportunity_DetailsVC
    {
        NSLog(@"\nSEDING SearchContactConnection REQUEST");
        CreateQuoteData = [[NSMutableData alloc]init];
        getCreateQuoteRequest_Connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getCreateQuoteRequest_Connection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getCreateQuoteRequest_Connection start];
    }
    
    
    else if ([name isEqualToString:@"CreateMakeLostTo_Connection"])// For create MakeLost TO Opportunity_DetailsVC
    {
        NSLog(@"\nSEDING CreateMakeLostTo_Connection REQUEST");
        CreateMakeLostTo_Data = [[NSMutableData alloc]init];
        getCreateMakeLostTo_Connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getCreateMakeLostTo_Connection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getCreateMakeLostTo_Connection start];
    }
    
    
    else if ([name isEqualToString:@"CreateModelLostTo_Connection"])// For create Modelost To Opportunity_DetailsVC
    {
        NSLog(@"\nSEDING CreateMakeLostTo_Connection REQUEST");
        CreateModelLostTo_Data = [[NSMutableData alloc]init];
        getCreateModelLostTo_Connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getCreateModelLostTo_Connection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getCreateModelLostTo_Connection start];
    }
    
    
    else if ([name isEqualToString:@"CreateReasonLostTo_Connection"])// For create Reason Lost Opportunity_DetailsVC
    {
        NSLog(@"\nSEDING CreateMakeLostTo_Connection REQUEST");
        CreateReasonLostTo_Data = [[NSMutableData alloc]init];
        getCreateReasonLostTo_Connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getCreateReasonLostTo_Connection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getCreateReasonLostTo_Connection start];
    }
    
    else if ([name isEqualToString:@"LostOpportunity_Connection"])// For create Reason Lost Opportunity_DetailsVC
    {
        NSLog(@"\nSEDING CreateMakeLostTo_Connection REQUEST");
        LostOpportunityData = [[NSMutableData alloc]init];
        getCreateLostOpportunity_Connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getCreateLostOpportunity_Connection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getCreateLostOpportunity_Connection start];
    }
    
    else if ([name isEqualToString:@"ActivityType_ForOpportunity_Request"])// For CreateActivityForOpportunity_VC
    {
        NSLog(@"\nSEDING ActivityType_ForOpportunity_Request REQUEST");
        getActivityForOpportunityData = [[NSMutableData alloc]init];
        getActivityForOpportunity_Connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getActivityForOpportunity_Connection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getActivityForOpportunity_Connection start];
    }
    
    
    else if ([name isEqualToString:@"CreateActivity_ForOpportunity_Request"]) //CreateActivityForOpportunity_VC //Save ActivityConnection
    {
        NSLog(@"\n sending CreateActivity_ForOpportunity_Request ");
        getCreateActivity_ForOpportunityData = [[NSMutableData alloc]init];
        getCreateActivity_ForOpportunity_Connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getCreateActivity_ForOpportunity_Connection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getCreateActivity_ForOpportunity_Connection start];
        
    }
    else if ([name isEqualToString:@"CreateAccount_ConnectionRequest"]) //CreateAccount_VC //For Create Account
    {
        NSLog(@"\n sending CreateAccount_ConnectionRequest ");
        getCreateAccount_Data = [[NSMutableData alloc]init];
        // getCreateAccount_Connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        // [getCreateAccount_Connection scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        //  [getCreateAccount_Connection start];
        
        
        
        
        getCreateAccount_Connection = [[NSURLConnection alloc] initWithRequest:request
                                                                      delegate:self startImmediately:NO];
        
        [getCreateAccount_Connection scheduleInRunLoop:[NSRunLoop mainRunLoop]
                                               forMode:NSDefaultRunLoopMode];
        [getCreateAccount_Connection start];
        
        
        
    }
    
    else if([name isEqualToString:@"getDistributorDetailsRequest"])
    {
        NSLog(@"SENDING getDistributorDetails REQUEST");
        getDistributorDetailsData=[[NSMutableData alloc]init];
        getDistributorDetailsConnection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getDistributorDetailsConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getDistributorDetailsConnection start];
    }
    
    else if([name isEqualToString:@"getPricingListRequest"])
    {
        NSLog(@"SENDING getPricingList REQUEST");
        getPricingListData=[[NSMutableData alloc]init];
        getPricingListConnection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getPricingListConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getPricingListConnection start];
    }
    
    else if([name isEqualToString:@"getRetailerDetailsRequest"])
    {
        NSLog(@"SENDING getRetailerDetails REQUEST");
        getRetailerDetailsData=[[NSMutableData alloc]init];
        getRetailerDetailsConnection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getRetailerDetailsConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getRetailerDetailsConnection start];
    }
    else if([name isEqualToString:@"getRetailerLandedPriceRequest"])
    {
        NSLog(@"SENDING getRetailerLandedPrice REQUEST");
        getRetailerLandedPriceData=[[NSMutableData alloc]init];
        getRetailerLandedPriceConnection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getRetailerLandedPriceConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getRetailerLandedPriceConnection start];
    }
    else if([name isEqualToString:@"bpmStatusRequest"])
    {
        NSLog(@"SENDING bpmStatus REQUEST");
        bpmStatusData=[[NSMutableData alloc]init];
        bpmStatusConnection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [bpmStatusConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [bpmStatusConnection start];
    }
    else if([name isEqualToString:@"getDistPosRequest"])
    {
        NSLog(@"SENDING getDistPos REQUEST");
        getDistPosData=[[NSMutableData alloc]init];
        getDistPosConnection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getDistPosConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getDistPosConnection start];
    }
    else if([name isEqualToString:@"getInventoryRequest"])
    {
        NSLog(@"SENDING getInventory REQUEST");
        getInventoryData=[[NSMutableData alloc]init];
        getInventoryConnection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getInventoryConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getInventoryConnection start];
    }
    else if([name isEqualToString:@"placeOrderRequest"])
    {
        NSLog(@"SENDING placeOrder REQUEST");
        placeOrderData=[[NSMutableData alloc]init];
        placeOrderConnection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [placeOrderConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [placeOrderConnection start];
    }
    else if([name isEqualToString:@"accessTokenRequest"])
    {
        NSLog(@"SENDING accessToken REQUEST");
        accessTokenData=[[NSMutableData alloc]init];
        accessTokenConnection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [accessTokenConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [accessTokenConnection start];
    }
    else if([name isEqualToString:@"getOrderNumberRequest"])
    {
        NSLog(@"SENDING getOrderNumber REQUEST");
        getOrderNumberData=[[NSMutableData alloc]init];
        getOrderNumberConnection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getOrderNumberConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getOrderNumberConnection start];
    }
    else if([name isEqualToString:@"saveDraftRequest"])
    {
        NSLog(@"SENDING saveDraft REQUEST");
        saveDraftData=[[NSMutableData alloc]init];
        saveDraftConnection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [saveDraftConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [saveDraftConnection start];
    }
    else if([name isEqualToString:@"viewDraftsRequest"])
    {
        NSLog(@"SENDING viewDrafts REQUEST");
        viewDraftsData=[[NSMutableData alloc]init];
        viewDraftsConnection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [viewDraftsConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [viewDraftsConnection start];
    }
    else if([name isEqualToString:@"updateMRPRequest"])
    {
        NSLog(@"SENDING updateMRP REQUEST");
        updateMRPData=[[NSMutableData alloc]init];
        updateMRPConnection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [updateMRPConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [updateMRPConnection start];
    }
    else if([name isEqualToString:@"updateQuantityRequest"])
    {
        NSLog(@"SENDING updateQuantity REQUEST");
        updateQuantityData=[[NSMutableData alloc]init];
        updateQuantityConnection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [updateQuantityConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [updateQuantityConnection start];
    }
    else if([name isEqualToString:@"deletePartRequest"])
    {
        NSLog(@"SENDING deletePart REQUEST");
        deletePartData=[[NSMutableData alloc]init];
        deletePartConnection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [deletePartConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [deletePartConnection start];
    }
    else if([name isEqualToString:@"resetPasswordRequest"])
    {
        NSLog(@"SENDING resetPassword REQUEST");
        resetPasswordData=[[NSMutableData alloc]init];
        resetPasswordConnection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [resetPasswordConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [resetPasswordConnection start];
    }
    else if([name isEqualToString:@"getAllOrdersRequest"])
    {
        NSLog(@"SENDING getAllOrders REQUEST");
        getAllOrdersData=[[NSMutableData alloc]init];
        getAllOrdersConnection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getAllOrdersConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getAllOrdersConnection start];
    }
    else if([name isEqualToString:@"changeOrderStatusRequest"])
    {
        NSLog(@"SENDING changeOrderStatus REQUEST");
        changeOrderStatusData=[[NSMutableData alloc]init];
        changeOrderStatusConnection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [changeOrderStatusConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [changeOrderStatusConnection start];
    }
    else if([name isEqualToString:@"GetLOB"]) // for LOB_List
    {
        NSLog(@"SENDING LOB_List REQUEST");
        getLobList = [[NSMutableData alloc]init];
        get_Lob_List_Connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [get_Lob_List_Connection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [get_Lob_List_Connection start];
    }
    else if([name isEqualToString:@"GetPPL_List"]) // for LOB_List
    {
        NSLog(@"SENDING PPL_List REQUEST");
        getPPL_List_Data = [[NSMutableData alloc]init];
        get_PPL_List_Connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [get_PPL_List_Connection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [get_PPL_List_Connection start];
    }
    
    else if([name isEqualToString:@"GetPL_List"]) // for LOB_List
    {
        NSLog(@"SENDING PL_List REQUEST");
        getPL_List_Data = [[NSMutableData alloc]init];
        get_PL_List_Connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [get_PL_List_Connection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [get_PL_List_Connection start];
    }
    else if([name isEqualToString:@"GetApplication_List"]) // for GetApplication_List
    {
        NSLog(@"SENDING Application_List REQUEST");
        getApplication_List_Data= [[NSMutableData alloc]init];
        get_Application_List_Connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [get_Application_List_Connection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [get_Application_List_Connection start];
    }
    else if([name isEqualToString:@"GetFinanceList"]) // for FinanceList
    {
        NSLog(@"SENDING Finance_List REQUEST");
        getFinancier_List_Data= [[NSMutableData alloc]init];
        get_Financier_List_Connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [get_Financier_List_Connection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [get_Financier_List_Connection start];
    }
    else if([name isEqualToString:@"GetIndianStates"]) // for IndianStatesList
    {
        NSLog(@"SENDING IndianStates REQUEST");
        getIndian_States_List_Data= [[NSMutableData alloc]init];
        get_Indian_states_List_Connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [get_Indian_states_List_Connection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [get_Indian_states_List_Connection start];
    }
    else if([name isEqualToString:@"GetDistrict"]) // for IndianStatesList
    {
        NSLog(@"SENDING District REQUEST");
        getDistrict_List_Data= [[NSMutableData alloc]init];
        get_District_List_Connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [get_District_List_Connection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [get_District_List_Connection start];
    }
    else if([name isEqualToString:@"GetCity"]) // for IndianStatesList
    {
        NSLog(@"SENDING City REQUEST");
        getCityList_Data= [[NSMutableData alloc]init];
        get_City_List_Connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [get_City_List_Connection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [get_City_List_Connection start];
    }
    else if([name isEqualToString:@"GetPostalCode"]) // for IndianStatesList
    {
        NSLog(@"SENDING postal code REQUEST");
        getPostalCode_List_Data= [[NSMutableData alloc]init];
        get_Postal_code_List_Connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [get_Postal_code_List_Connection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [get_Postal_code_List_Connection start];
    }
    else if([name isEqualToString:@"GetTaluka"]) // for IndianStatesList
    {
        NSLog(@"SENDING Taluka REQUEST");
        getTaluka_List_Data= [[NSMutableData alloc]init];
        get_Taluka_List_Connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [get_Taluka_List_Connection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [get_Taluka_List_Connection start];
    }
    else if([name isEqualToString:@"GetContact"]) // for IndianStatesList
    {
        NSLog(@"SENDING Contact REQUEST");
        getContact_List_Data= [[NSMutableData alloc]init];
        get_Contact_List_Connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [get_Contact_List_Connection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [get_Contact_List_Connection start];
    }
    else if([name isEqualToString:@"PendingActivityDetails_Connection"]) // for Activity List Details //ACtivity_ViewController
    {
        
        NSLog(@"\nSEDING PendingActivityDetails_Connection REQUEST");
        PendingActivityDetailsData = [[NSMutableData alloc]init];
        getPendingActivityDetailsConnection =[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getPendingActivityDetailsConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getPendingActivityDetailsConnection start];
    }
    
    else if([name isEqualToString:@"getPendingActivityDetails_Connection"]) // for Activity List Details //ACtivity_ViewController
    {
        
        NSLog(@"\nSEDING getPendingActivityDetails_Connection REQUEST");
        getPendingActivityDetailsData = [[NSMutableData alloc]init];
        ActivityDetailsConnection =[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [ActivityDetailsConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [ActivityDetailsConnection start];
    }
    
    else if([name isEqualToString:@"getCreateActivityTypeConnection"]) // for create Activity
    {
        
        NSLog(@"\nSEDING getActivityTypeConnection REQUEST");
        ActivityCreateTypeData = [[NSMutableData alloc]init];
        getCreateActivityTypeConnection =[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getCreateActivityTypeConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getCreateActivityTypeConnection start];
    }
    else if([name isEqualToString:@"Linkcampaign_Connection"]) // for create Activity
    {
        
        NSLog(@"\nSEDING Linkcampaign_Connection REQUEST");
        Linkcampaign_Data = [[NSMutableData alloc]init];
        getLinkcampaign_Connection =[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getLinkcampaign_Connection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getLinkcampaign_Connection start];
    }
    else if([name isEqualToString:@"Linkcampaign_select_request"]) // for create Activity
    {
        
        NSLog(@"\nSEDING Linkcampaign_select REQUEST");
        Select_Linkcampaign_Data = [[NSMutableData alloc]init];
        getLinkcampaign_Select_connection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getLinkcampaign_Select_connection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getLinkcampaign_Select_connection  start];
    }
    
    else if([name isEqualToString:@"Reason_Lost_Connection"]) // for create Activity
    {
        
        NSLog(@"\nSEDING Reason_Lost REQUEST");
        Reason_lost_Data = [[NSMutableData alloc]init];
        getReason_Lost_connection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getReason_Lost_connection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getReason_Lost_connection  start];
    }
    else if([name isEqualToString:@"Model_Lost_Connection"]) // for create Activity
    {
        
        NSLog(@"\nSEnDING Model_Lost REQUEST");
        Model_lost_Data = [[NSMutableData alloc]init];
        getModel_Lost_connection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getModel_Lost_connection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getModel_Lost_connection  start];
    }
    else if([name isEqualToString:@"Make_Lost_Connection"]) // for create Activity
    {
        
        NSLog(@"\nSEnDING Make_Lost REQUEST");
        Make_lost_Data = [[NSMutableData alloc]init];
        getMake_Lost_connection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getMake_Lost_connection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getMake_Lost_connection  start];
    }
    else if([name isEqualToString:@"Lost_Opty_Connection"])
    {
        
        NSLog(@"\nSEnDING Lost_Opty REQUEST");
        Lost_Opty_Data = [[NSMutableData alloc]init];
        getLost_Opty_connection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getLost_Opty_connection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getLost_Opty_connection  start];
    }
    else if([name isEqualToString:@"adressIDRequest"])
    {
        
        NSLog(@"\nSEnDING Lost_Opty REQUEST");
        adressIDdata = [[NSMutableData alloc]init];
        adressID_connection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [adressID_connection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [adressID_connection  start];
    }
    else if([name isEqualToString:@"ContactSaveRequest"])
    {
        
        NSLog(@"\nSEnDING Lost_Opty REQUEST");
        ContactSavedata = [[NSMutableData alloc]init];
        ContactSave_connection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [ContactSave_connection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [ContactSave_connection  start];
    }
    
    else if([name isEqualToString:@"ProceedToQuoteCreation_Connection"])
    {
        
        NSLog(@"\nProceedToQuote_Creation REQUEST");
        ProceedToQuoteCreationdata = [[NSMutableData alloc]init];
        ProceedToQuoteCreation_connection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [ProceedToQuoteCreation_connection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [ProceedToQuoteCreation_connection  start];
    }
    else if([name isEqualToString:@"GetProduct"])
    {
        
        NSLog(@"\nGetProduct REQUEST");
        GetProductdata = [[NSMutableData alloc]init];
        GetProductconnection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [GetProductconnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [GetProductconnection  start];
    }
    else if([name isEqualToString:@"UpdateOpty"])
    {
        
        NSLog(@"\nUpdateOpty REQUEST");
        UpdateOptydata = [[NSMutableData alloc]init];
        UpdateOptyconnection=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [UpdateOptyconnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [UpdateOptyconnection  start];
    }
    else if([name isEqualToString:@"PL_ProductID_Request"]) //for Create Opportunity //CreateOpportunityAgainstContact_VC
    {
        NSLog(@"\nSEDING PL_ProductID_Request REQUEST");
        NSLog(@"PL_ProductID_Request..!! %@ ",request);
        
        PL_ProductID_Data = [[NSMutableData alloc]init];
        PL_ProductID_Connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [PL_ProductID_Connection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [PL_ProductID_Connection start];
    }
    
    else if ([name isEqualToString:@"CreateAccountaginstcontact_Request"])
    {
        
        NSLog(@"\n sending CreateAccount_ConnectionRequest ");
        getCreateAccountaginstcontact_Data = [[NSMutableData alloc]init];
        getCreateAccountaginstcontact_Connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
        [getCreateAccountaginstcontact_Connection scheduleInRunLoop:[NSRunLoop mainRunLoop]forMode:NSDefaultRunLoopMode];
        [getCreateAccountaginstcontact_Connection start];
        
    }
    else if([name isEqualToString:@"SearchActivities_Connection_dashBoard"]) //for search opportunity screen // for sale stage
    {
        NSLog(@"SENDING Product Nname");
        SearchContactDataDashboard = [[NSMutableData alloc]init];
        getSearchContactConnectiondashboard = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getSearchContactConnectiondashboard scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getSearchContactConnectiondashboard start];
    }
    
    else if([name isEqualToString:@"SearchActivitiesMonth_Connection"]) //for search opportunity screen // for sale stage
    {
        NSLog(@"SENDING Product Nname");
        SearchActivitiesMonthDataDashboard = [[NSMutableData alloc]init];
        getSearchActivitiesMonthConnectiondashboard = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getSearchActivitiesMonthConnectiondashboard scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getSearchActivitiesMonthConnectiondashboard start];
    }//getActivityDone
    
    
    
    else if([name isEqualToString:@"Opty_Connection_dashBoard"]) //for search opportunity screen // for sale stage
    {
        NSLog(@"SENDING All Opty");
        GetOpportunityDashboard = [[NSMutableData alloc]init];
        getdashboardOpportunityConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getdashboardOpportunityConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getdashboardOpportunityConnection start];
    }
    else if([name isEqualToString:@"getselectedPL_Connection"])
    {
        NSLog(@"\nSEDING SearchContactConnection REQUEST");
        getPLAnalyticsData = [[NSMutableData alloc]init];
        getPLAnalyticsConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getPLAnalyticsConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getPLAnalyticsConnection start];
    }
    
    
    else if([name isEqualToString:@"getselectedPPL_Connection"]) //for Search Account //SearchAccount_VC
    {
        NSLog(@"\nSEDING SearchContactConnection REQUEST");
        getPPLAnalyticsData = [[NSMutableData alloc]init];
        getPPLAnalyticsConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getPPLAnalyticsConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getPPLAnalyticsConnection start];
    }

    else if([name isEqualToString:@"getdsewisereport"]) // for Activity PPL List Details //searchActivity_VC
    {
        NSLog(@"\nSEDING getActivityPPLConnection REQUEST");
        dsewisereport = [[NSMutableData alloc]init];
        getdsewisereport =[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [getdsewisereport scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getdsewisereport start];//getselecteddateproductreport
    }
    
    else if([name isEqualToString:@"Done_Activity"]) // for Activity PPL List Details //searchActivity_VC
    {
        NSLog(@"\nSEDING Done_ActivityConnection REQUEST");
        Done_ActivityData = [[NSMutableData alloc]init];
        Done_ActivityConnection =[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [Done_ActivityConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [Done_ActivityConnection start];//getselecteddateproductreport
    }
    
    else if([name isEqualToString:@"Done_Activity_second_request"]) // for Activity PPL List Details //searchActivity_VC
    {
        NSLog(@"\nSEDING Done_Activity_second_request_Connection REQUEST");
        Done_Activity_second_request_Data = [[NSMutableData alloc]init];
        Done_Activity_second_request_Connection =[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [Done_Activity_second_request_Connection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [Done_Activity_second_request_Connection start];//getselecteddateproductreport
    }
    
    else if([name isEqualToString:@"After_Done_Activity"]) // for Activity PPL List Details //searchActivity_VC
    {
        NSLog(@"\nSEDING Done_ActivityConnection REQUEST");
        After_Done_ActivityData = [[NSMutableData alloc]init];
        After_Done_ActivityConnection =[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [After_Done_ActivityConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [After_Done_ActivityConnection start];//getselecteddateproductreport
    }
    
    else if([name isEqualToString:@"AfterQuoteCreation_Connection"]) // for Activity PPL List Details //searchActivity_VC
    {
        NSLog(@"\nSEDING AfterQuoteCreation_ConnectionConnection REQUEST");
        AfterQuoteCreationData = [[NSMutableData alloc]init];
        AfterQuoteCreationConnection =[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
        [AfterQuoteCreationConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [AfterQuoteCreationConnection start];//getselecteddateproductreport
    }
    
    else if([name isEqualToString:@"getActivityUpdateConnection"]) // for search a opportunities
    {
        NSLog(@"\n SEDING REQUEST");
        PendingActivtyUpdate = [[NSMutableData alloc]init];
        getupdateActivityConnection =[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
        [getupdateActivityConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [getupdateActivityConnection start];
        NSLog(@"......Search ");
    }

    //     else if([name isEqualToString:@"CreateContactConnection"]) // for createContact Contacts //CreateContact_VC
    //     {
    //         NSLog(@"\nSEDING SearchContactConnection REQUEST");
    //         CreateContactData = [[NSMutableData alloc]init];
    //         getCreateContactConnection =[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
    //         [getCreateContactConnection scheduleInRunLoop: [NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    //         [getCreateContactConnection start];
    //     }
    
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if(connection == artifactConnection)
        [artifactData setLength:0];
    
    else if(connection == authenticateOIDConnection)
        [authenticateOIDData setLength:0];
    else if(connection == getCurrentDateConnection) //Abhishek //For system Date
        [CurrentDateData setLength:0];
    else if(connection == getUserDetailsConnection) //Abhishek //For user Deatails Date
        [userDetailsData setLength:0];
    else if(connection == getUserDetailsConnection) //Abhishek //For user Deatails Data
        [userDetailsData setLength:0];
    else if(connection == getOpprtunityCountConnection) //Abhishek //For opportunity Count
        [opportunityCountData setLength:0];
    else if(connection == getSaleStageForSearchOpportunityConnection) //Abhishek //For sale stage in search opportunity screen Details
        [SaleStageForSearchOpportunityData setLength:0];
    else if(connection == getSaleStagePPLForSearchOpportunityConnection) //Abhishek //For sale stage in search opportunity screen Details
        [SaleStagePPLForSearchOpportunityData setLength:0];
    
    else if(connection == getSearchOpportunityAssignTo) //Abhishek //For sale stage in search opportunity screen Details
        [SalesOppAssingTOData setLength:0];
    
    else if(connection == getAllOpportunity) //Abhishek //For sale stage in search opportunity screen Details
        [SaleAllOpportunity setLength:0];
    
    else if(connection == getAllOpportunity1) //Abhishek //For sale stage in search opportunity screen Details
        [SaleAllOpportunity1 setLength:0];
    
    
    else if(connection == getTahshilSearchOpportunityConnection){
        NSLog(@"James..Bond...");
        [SaleTahshilSearchOpportunityData setLength:0];
    }
    else if (connection == getSearchOpportunityConnection)//abhishek // for search Opportunities Details
        [Search_OpportunitiesData setLength:0];
    else if (connection == getSearchOpportunityConnection1)//abhishek // for search Opportunities Details
        [Search_OpportunitiesData1 setLength:0];
    else if (connection == getActivityDetailsConnection)//abhishek // for Activity Details
        [ActivityDetailsData setLength:0];
    else if (connection == getActivityPPLConnection)//abhishek // for Activity PPL Connection
        [ActivityDetailsData setLength:0];
    else if (connection == getActivityTaluka)//abhishek // for Activity PPL Connection
        [ActivityTaluka setLength:0];
    else if (connection == getActivityAssignTo)//abhishek // for Activity PPL Connection
        [ActivityAssignTo setLength:0];
    else if (connection == getActivityTypeConnection)//abhishek // for Activity TYPE Connection
        [ActivityTypeData setLength:0];
    else if (connection == getSearchActivitiesConnection)//abhishek // for Activity search Connection
        [seachActivitiesData setLength:0];
    else if (connection == getSearchActivitiesConnection1)//abhishek // for Activity search Connection
        [seachActivitiesData1 setLength:0];
    else if (connection == getSearchActivitiesConnection2)//abhishek // for Activity search Connection
        [seachActivitiesData2 setLength:0];
    else if (connection == getSearchContactConnection)//Abhishek // for Contact Search connection
        [SearchContactData setLength:0];
    
    else if (connection == getCreateContactConnection)// Abhishek // For Create ContactConnection
        [CreateContactData setLength:0];
    
    else if(connection == getOpportunityLOB_AgianstContactConnection)// Abhishek // ForLOB Opportunity against contact //CreateOpportunityAgainstContact_VC
        [OpportunityLOB_AgianstContactData setLength:0];
    
    else if(connection == getOpportunityPPL_AgianstContactConnection)// Abhishek //ForPPL Opportunity against contact //CreateOpportunityAgainstContact_VC
        [OpportunityPPL_AgianstContactData setLength:0];
    
    else if (connection == getOpportunityPL_AgianstContactConnection)//Abhishek //forPL Opportunity against contact // CreateOpportunityAgainstContact_VC
        [OpportunityPL_AgianstContactData setLength:0];
    
    else if (connection == getOpportunityApplication_AgianstContactConnection)//Abhishek //forApplication Opportunity against contact // CreateOpportunityAgainstContact_VC
        [OpportunityApplication_AgianstContactData setLength:0];
    
    else if (connection == getCreateOpportunity_AgainstContactConnection)//Abhishek //for create Oppty // CreateOpportunityAgainstContact_VC
        [CreateOpportunity_AgainstContactData setLength:0];
    
    else if (connection == getSearchAccountConnection)//Abhishek //for search Account//for searching Account
        [getSearchAccountData setLength:0];
    
    else if (connection == get_Acct_ContactDetailsConnection) // Abhishek // For Account Contacts //
        [getAcct_ContactDetailsData setLength:0];
    
    else if (connection == getCreateContacWithAccountDetails_Connection) // Abhishek // For Create Account Contacts //
        [CreateContacWithAccountDetails_Data setLength:0];
    
    else if (connection == getCreateQuoteRequest_Connection) // Abhishek // For createQuotations //
        [CreateQuoteData setLength:0];
    
    else if (connection == getCreateMakeLostTo_Connection)
        [CreateMakeLostTo_Data setLength:0];
    
    else if (connection == getCreateModelLostTo_Connection)
        [CreateModelLostTo_Data setLength:0];
    
    else if (connection == getCreateReasonLostTo_Connection)
        [CreateReasonLostTo_Data setLength:0];
    
    else if (connection == getCreateLostOpportunity_Connection)
        [LostOpportunityData setLength:0];
    
    else if (connection == getActivityForOpportunity_Connection)
        [getActivityForOpportunityData setLength:0];
    
    else if (connection == getCreateActivity_ForOpportunity_Connection)//Abhishek // For Create Activity Aginst Opportunity
        [getCreateActivity_ForOpportunityData setLength:0];
    
    else if (connection == getCreateAccount_Connection)//Abhishek // For create Accont
    {
        NSLog(@"\n Testing Abhishek Create Account....");
        [getCreateAccount_Data setLength:0];
    }
    
    
    else if(connection==getDistributorDetailsConnection)
        [getDistributorDetailsData setLength:0];
    else if(connection==getPricingListConnection)
        [getPricingListData setLength:0];
    else if(connection==getRetailerDetailsConnection)
        [getRetailerDetailsData setLength:0];
    else if(connection==getRetailerLandedPriceConnection)
        [getRetailerLandedPriceData setLength:0];
    else if(connection==bpmStatusConnection)
        [bpmStatusData setLength:0];
    else if(connection==getDistPosConnection)
        [getDistPosData setLength:0];
    else if(connection==getInventoryConnection)
        [getInventoryData setLength:0];
    else if(connection==placeOrderConnection)
    {
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        statusCode = [httpResponse statusCode];
        NSLog(@"%i",statusCode);
        [placeOrderData setLength:0];
    }
    else if(connection==accessTokenConnection)
        [accessTokenData setLength:0];
    else if(connection==getOrderNumberConnection)
        [getOrderNumberData setLength:0];
    else if(connection==saveDraftConnection)
        [saveDraftData setLength:0];
    else if(connection==viewDraftsConnection)
        [viewDraftsData setLength:0];
    else if(connection==updateMRPConnection)
        [updateMRPData setLength:0];
    else if(connection==updateQuantityConnection)
        [updateQuantityData setLength:0];
    else if(connection==deletePartConnection)
        [deletePartData setLength:0];
    else if(connection==resetPasswordConnection)
        [resetPasswordData setLength:0];
    else if(connection==getAllOrdersConnection)
        [getAllOrdersData setLength:0];
    else if(connection==changeOrderStatusConnection)
        [changeOrderStatusData setLength:0];
    else if(connection==get_Lob_List_Connection)
        [getLobList setLength:0];
    else if(connection==get_PPL_List_Connection)
        [getPPL_List_Data setLength:0];
    else if(connection==get_PL_List_Connection)
        [getPL_List_Data setLength:0];
    else if(connection==get_Application_List_Connection)
        [getApplication_List_Data setLength:0];
    else if(connection==get_Financier_List_Connection)
        [getFinancier_List_Data setLength:0];
    else if(connection==get_Indian_states_List_Connection)
        [getIndian_States_List_Data setLength:0];
    
    else if(connection==get_District_List_Connection)
        [getDistrict_List_Data setLength:0];
    
    else if(connection==get_City_List_Connection)
        [getCityList_Data setLength:0];
    
    else if(connection==get_Postal_code_List_Connection)
        [getPostalCode_List_Data setLength:0];
    
    else if(connection==get_Taluka_List_Connection)
        [getTaluka_List_Data setLength:0];
    
    else if(connection==get_Contact_List_Connection)
        [getContact_List_Data setLength:0];
    else if (connection == getPendingActivityDetailsConnection)
        [PendingActivityDetailsData setLength:0];
    
    else if (connection == ActivityDetailsConnection)
        [getPendingActivityDetailsData setLength:0];
    else if (connection == getCreateActivityTypeConnection)
        [ActivityCreateTypeData setLength:0];
    else if (connection == getLinkcampaign_Connection)
        [Linkcampaign_Data setLength:0];
    
    else if (connection == getLinkcampaign_Select_connection)
        [Select_Linkcampaign_Data setLength:0];
    
    
    else if (connection == getReason_Lost_connection)
        [Reason_lost_Data setLength:0];
    
    else if (connection == getMake_Lost_connection)
        [Make_lost_Data setLength:0];
    
    else if (connection == getModel_Lost_connection)
        [Model_lost_Data setLength:0];
    
    else if (connection == getLost_Opty_connection)
        [Lost_Opty_Data setLength:0];
    
    else if (connection == adressID_connection)
        [adressIDdata setLength:0];
    
    else if (connection == ContactSave_connection)
        [ContactSavedata setLength:0];
    
    else if (connection == ProceedToQuoteCreation_connection)
        [ProceedToQuoteCreationdata setLength:0];
    
    else if (connection == GetProductconnection)
        [GetProductdata setLength:0];
    
    else if (connection == UpdateOptyconnection)
        [UpdateOptydata setLength:0];
    
    else if (connection == PL_ProductID_Connection)//Abhishek //Product Id
        [PL_ProductID_Data setLength:0];
    
    else if (connection == getCreateAccountaginstcontact_Connection)//Abhishek // For create Accont against contact
    {
        [getCreateAccountaginstcontact_Data setLength:0];
    }
    else if(connection == getSearchContactConnectiondashboard) //Gautam's //For sale stage in search opportunity screen Details
        [SearchContactDataDashboard setLength:0];
    
    else if(connection == getSearchActivitiesMonthConnectiondashboard) //Gautam's //For sale stage in search opportunity screen Details
        [SearchActivitiesMonthDataDashboard setLength:0];
    
    else if(connection == getdashboardOpportunityConnection) //Gautam's //For sale stage in search opportunity screen Details
        [GetOpportunityDashboard setLength:0];
    
    else if (connection == getPLAnalyticsConnection)//Abhishek //for search Account//for searching Account
        [getPLAnalyticsData setLength:0];
    
    else if (connection == getPPLAnalyticsConnection)//Abhishek //for search Account//for searching Account
        [getPPLAnalyticsData setLength:0];
    
    else if (connection == getdsewisereport)//abhishek // for Activity PPL Connection
        [dsewisereport setLength:0];
    
    else if (connection == Done_ActivityConnection)//abhishek // for Activity PPL Connection
        [Done_ActivityData setLength:0];
    
    
    else if (connection == Done_Activity_second_request_Connection)//abhishek // for Activity PPL Connection
        [Done_Activity_second_request_Data setLength:0];
    
    else if (connection == After_Done_ActivityConnection)//abhishek // for Activity PPL Connection
        [After_Done_ActivityData setLength:0];
    
    else if (connection == AfterQuoteCreationConnection)//abhishek // for Activity PPL Connection
        [AfterQuoteCreationData setLength:0];
    
    else if (connection == getupdateActivityConnection)//Gautam's // for search Opportunities Details
        [PendingActivtyUpdate setLength:0];
    
    


   
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(connection == artifactConnection)
        [artifactData appendData:data];
    
    else if(connection == authenticateOIDConnection)
        [authenticateOIDData appendData:data];
    else if(connection == getCurrentDateConnection)//Abhishek //For Date
        [CurrentDateData appendData:data];
    
    else if(connection == getUserDetailsConnection)//Abhishek //For User Details
        [userDetailsData appendData:data];
    
    else if(connection == getOpprtunityCountConnection)//Abhishek //For opportunities Count Details
        [opportunityCountData appendData:data];
    
    else if(connection == getSaleStageForSearchOpportunityConnection)//Abhishek //For sale stage in search opportunity screen Details
        [SaleStageForSearchOpportunityData appendData:data];
    
    else if(connection == getSaleStagePPLForSearchOpportunityConnection)//Abhishek //For sale stage in search opportunity screen Details
        [SaleStagePPLForSearchOpportunityData appendData:data];
    
    else if(connection == getSearchOpportunityAssignTo)//Abhishek //For sale stage in search opportunity screen Details
        [SalesOppAssingTOData appendData:data];
    
    else if(connection == getAllOpportunity)//Abhishek //For sale stage in search opportunity screen Details
        [SaleAllOpportunity appendData:data];
    
    else if(connection == getAllOpportunity1)//Abhishek //For sale stage in search opportunity screen Details
        [SaleAllOpportunity1 appendData:data];
    
    else if(connection == getTahshilSearchOpportunityConnection)
        [SaleTahshilSearchOpportunityData appendData:data];
    
    else if (connection == getSearchOpportunityConnection)//abhishek // for search Opportunities Details
        [Search_OpportunitiesData appendData:data];
    
    else if (connection == getSearchOpportunityConnection1)//abhishek // for search Opportunities Details
        [Search_OpportunitiesData1 appendData:data];
    
    else if (connection == getActivityDetailsConnection)//abhishek // for Activity Details
        [ActivityDetailsData appendData:data];
    
    else if (connection == getActivityPPLConnection)//abhishek // for Activity PPL Details
        [ActivityPPLData appendData:data];
    
    else if (connection == getActivityTaluka)//abhishek // for Activity PPL Details
        [ActivityTaluka appendData:data];
    else if (connection == getActivityAssignTo)//abhishek // for Activity PPL Details
        [ActivityAssignTo appendData:data];
    
    else if (connection == getActivityTypeConnection)//abhishek // for Activity Type
        [ActivityTypeData appendData:data];
    
    else if (connection == getSearchActivitiesConnection)//abhishek // for Activity searchActivities
        [seachActivitiesData appendData:data];
    
    else if (connection == getSearchActivitiesConnection1)//abhishek // for Activity searchActivities
        [seachActivitiesData1 appendData:data];
    
    else if (connection == getSearchActivitiesConnection2)//abhishek // for Activity searchActivities
        [seachActivitiesData2 appendData:data];
    
    else if(connection == getSearchContactConnection)//Abhishek // For Search Contact Connection
        [SearchContactData appendData:data];
    else if (connection == getCreateContactConnection)//Abhishek //For Create Contact Connection
        [CreateContactData appendData:data];
    
    else if(connection == getOpportunityLOB_AgianstContactConnection)// Abhishek // ForLOB Opportunity against contact //CreateOpportunityAgainstContact_VC
        [OpportunityLOB_AgianstContactData appendData:data];
    
    else if(connection == getOpportunityPPL_AgianstContactConnection)// Abhishek // ForPPL Opportunity against contact //CreateOpportunityAgainstContact_VC
        [OpportunityPPL_AgianstContactData appendData:data];
    
    else if(connection == getOpportunityPL_AgianstContactConnection)// Abhishek // ForPL Opportunity against contact //CreateOpportunityAgainstContact_VC
        [OpportunityPL_AgianstContactData appendData:data];
    
    else if(connection == getOpportunityApplication_AgianstContactConnection)// Abhishek // ForApplication Opportunity against contact //CreateOpportunityAgainstContact_VC
        [OpportunityApplication_AgianstContactData appendData:data];
    
    else if(connection == getCreateOpportunity_AgainstContactConnection)// Abhishek // Create opportunity Aginst Contact //CreateOpportunityAgainstContact_VC
        [CreateOpportunity_AgainstContactData appendData:data];
    
    else if (connection == getSearchAccountConnection)// Abhishek // for search Account//SearchAccount_VC
        [getSearchAccountData appendData:data];
    
    else if (connection == get_Acct_ContactDetailsConnection)// Abhishek // for Account Contact Details//
        [getAcct_ContactDetailsData appendData:data];
    
    else if (connection == getCreateContacWithAccountDetails_Connection)//Abhishek // For create Contact  Account//
        [CreateContacWithAccountDetails_Data appendData:data];
    
    
    else if (connection == getCreateQuoteRequest_Connection)//Abhishek // For create Contact  Account//
        [CreateQuoteData appendData:data];
    
    else if (connection == getCreateMakeLostTo_Connection)
        [CreateMakeLostTo_Data appendData:data];
    
    else if (connection == getCreateModelLostTo_Connection)
        [CreateModelLostTo_Data appendData:data];
    
    else if (connection == getCreateReasonLostTo_Connection)
        [CreateReasonLostTo_Data appendData:data];
    
    
    else if (connection == getCreateLostOpportunity_Connection)//lost Opportunity
        [LostOpportunityData appendData:data];
    
    else if (connection == getActivityForOpportunity_Connection)
        [getActivityForOpportunityData appendData:data];
    
    else if (connection == getCreateActivity_ForOpportunity_Connection)//For Create Activity Aginst Opportunity
        [getCreateActivity_ForOpportunityData appendData:data];
    
    else if (connection == getCreateAccount_Connection)//For Create Account Create
        [getCreateAccount_Data appendData:data];
    
    
    
    
    
    else if(connection == getDistributorDetailsConnection)
        [getDistributorDetailsData appendData:data];
    else if(connection==getPricingListConnection)
        [getPricingListData appendData:data];
    else if(connection==getRetailerDetailsConnection)
        [getRetailerDetailsData appendData:data];
    else if(connection==getRetailerLandedPriceConnection)
        [getRetailerLandedPriceData appendData:data];
    else if(connection==bpmStatusConnection)
        [bpmStatusData appendData:data];
    else if(connection==getDistPosConnection)
        [getDistPosData appendData:data];
    else if(connection==getInventoryConnection)
        [getInventoryData appendData:data];
    else if(connection==placeOrderConnection)
        [placeOrderData appendData:data];
    else if(connection==accessTokenConnection)
        [accessTokenData appendData:data];
    else if(connection==getOrderNumberConnection)
        [getOrderNumberData appendData:data];
    else if(connection==saveDraftConnection)
        [saveDraftData appendData:data];
    else if(connection==viewDraftsConnection)
        [viewDraftsData appendData:data];
    else if(connection==updateMRPConnection)
        [updateMRPData appendData:data];
    else if(connection==updateQuantityConnection)
        [updateQuantityData appendData:data];
    else if(connection==deletePartConnection)
        [deletePartData appendData:data];
    else if(connection==resetPasswordConnection)
        [resetPasswordData appendData:data];
    else if(connection==getAllOrdersConnection)
        [getAllOrdersData appendData:data];
    else if(connection==changeOrderStatusConnection)
        [changeOrderStatusData appendData:data];
    else if(connection==get_Lob_List_Connection)
        [getLobList appendData:data];
    else if(connection==get_PPL_List_Connection)
        [getPPL_List_Data appendData:data];
    else if(connection==get_PL_List_Connection)
        [getPL_List_Data appendData:data];
    else if(connection==get_Application_List_Connection)
        [getApplication_List_Data appendData:data];
    else if(connection==get_Financier_List_Connection)
        [getFinancier_List_Data appendData:data];
    else if(connection==get_Indian_states_List_Connection)
        [getIndian_States_List_Data appendData:data];
    
    else if(connection==get_District_List_Connection)
        [getDistrict_List_Data appendData:data];
    
    else if(connection==get_City_List_Connection)
        [getCityList_Data appendData:data];
    
    else if(connection==get_Postal_code_List_Connection)
        [getPostalCode_List_Data appendData:data];
    
    else if(connection==get_Taluka_List_Connection)
        [getTaluka_List_Data appendData:data];
    
    else if(connection==get_Contact_List_Connection)
        [getContact_List_Data appendData:data];
    
    else if (connection == getPendingActivityDetailsConnection)
        [PendingActivityDetailsData appendData:data];
    
    
    else if (connection == ActivityDetailsConnection)
        [getPendingActivityDetailsData appendData:data];
    
    else if (connection == getCreateActivityTypeConnection)
        [ActivityCreateTypeData appendData:data];
    
    else if (connection == getLinkcampaign_Connection)
        [Linkcampaign_Data appendData:data];
    
    else if (connection == getLinkcampaign_Select_connection)
        [Select_Linkcampaign_Data appendData:data];
    
    
    else if (connection == getReason_Lost_connection)
        [Reason_lost_Data appendData:data];
    
    else if (connection == getMake_Lost_connection)
        [Make_lost_Data appendData:data];
    
    else if (connection == getModel_Lost_connection)
        [Model_lost_Data appendData:data];
    
    else if (connection == getLost_Opty_connection)
        [Lost_Opty_Data appendData:data];
    
    else if (connection == adressID_connection)
        [adressIDdata appendData:data];
    
    else if (connection == ContactSave_connection)
        [ContactSavedata appendData:data];
    
    else if (connection == ProceedToQuoteCreation_connection)
        [ProceedToQuoteCreationdata appendData:data];
    else if (connection == GetProductconnection)
        [GetProductdata appendData:data];
    
    else if (connection == UpdateOptyconnection)
        [UpdateOptydata appendData:data];
    
    else if (connection == PL_ProductID_Connection)//Abhishek //Product Id
        [PL_ProductID_Data appendData:data];
    
    else if (connection == getCreateAccountaginstcontact_Connection)//Abhishek // For create Account Against contact
        [getCreateAccountaginstcontact_Data appendData:data];
    
    else if(connection == getSearchContactConnectiondashboard)//Gautam's //For sale stage in search opportunity screen Details
        [SearchContactDataDashboard appendData:data];
    
    
    else if(connection == getSearchActivitiesMonthConnectiondashboard)//Gautam's //For sale stage in search opportunity screen Details
        [SearchActivitiesMonthDataDashboard appendData:data];
    
    else if(connection == getdashboardOpportunityConnection)//Gautam's //For sale stage in search opportunity screen Details
        [GetOpportunityDashboard appendData:data];
    
    else if (connection == getPLAnalyticsConnection)// Abhishek // for search Account//SearchAccount_VC
        [getPLAnalyticsData appendData:data];
    
    
    else if (connection == getPPLAnalyticsConnection)// Abhishek // for search Account//SearchAccount_VC
        [getPPLAnalyticsData appendData:data];
    
    else if (connection == getdsewisereport)//abhishek // for Activity PPL Details
        [dsewisereport appendData:data];
    
    
    else if (connection == Done_ActivityConnection)//abhishek // for Activity PPL Details
        [Done_ActivityData appendData:data];
   
    
    else if (connection == Done_Activity_second_request_Connection)//abhishek // for Activity PPL Details
        [Done_Activity_second_request_Data appendData:data];
    
    else if (connection == After_Done_ActivityConnection)//abhishek // for Activity PPL Details
        [After_Done_ActivityData appendData:data];
    
    else if (connection == AfterQuoteCreationConnection)//abhishek // for Activity PPL Details
        [AfterQuoteCreationData appendData:data];
   
    else if (connection == getupdateActivityConnection)//Gautam's // for search Opportunities Details
        [PendingActivtyUpdate appendData:data];
   
}

// to deal with self-signed certificates
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    NSLog(@"%i",[protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]);
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge.protectionSpace.authenticationMethod
         isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        // we only trust our own domain
        if ([challenge.protectionSpace.host isEqualToString:@"tmcrmapps.inservices.tatamotors.com"])
        {
            NSURLCredential *credential =
            [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
        }
    }
    
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"inside..did");
    if(connection == artifactConnection)
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[artifactData mutableBytes] length:[artifactData length] encoding:NSUTF8StringEncoding];
        NSLog(@"Artifact Response is ..%@",responseString);
        
        NSNotification *artifactNotification = [NSNotification notificationWithName:@"artifactFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:artifactNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
        
    }
    else if(connection == authenticateOIDConnection)
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[authenticateOIDData mutableBytes] length:[authenticateOIDData length] encoding:NSUTF8StringEncoding];
        NSLog(@"authenticateOID Response is %@",responseString);
        //  [self CheckSamalArtExpires:responseString];
        NSNotification *authenticateOIDtNotification=[NSNotification notificationWithName:@"authenticateOIDFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:authenticateOIDtNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    else if(connection == getCurrentDateConnection) //Abhishek For Date
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[CurrentDateData mutableBytes] length:[CurrentDateData length] encoding:NSUTF8StringEncoding];
        NSLog(@"authenticateOID Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For Checking SamalArt Expiration
        NSNotification *currentDateNotification = [NSNotification notificationWithName:@"requestDateFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:currentDateNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    else if(connection == getUserDetailsConnection) //Abhishek For user Details
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[userDetailsData mutableBytes] length:[userDetailsData length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For Checking samalArt Expiration
        NSNotification *userDetailsDateNotification = [NSNotification notificationWithName:@"userDetailsFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:userDetailsDateNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    else if(connection == getOpprtunityCountConnection) //Abhishek For opportunity Count Details
    {
        NSLog(@"Manage Opty");
        NSString *responseString = [[NSString alloc] initWithBytes:[opportunityCountData mutableBytes] length:[opportunityCountData length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *OpprtunityCountNotification = [NSNotification notificationWithName:@"opportunityCountFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:OpprtunityCountNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    else if(connection == getSaleStageForSearchOpportunityConnection)
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[SaleStageForSearchOpportunityData mutableBytes] length:[SaleStageForSearchOpportunityData length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *SaleStageForSearchOpportunityNotification = [NSNotification notificationWithName:@"SaleStageFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:SaleStageForSearchOpportunityNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
        
    }
    else if(connection == getSaleStagePPLForSearchOpportunityConnection) //Abhishek For PPL For Search Opportunity Connection
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[SaleStagePPLForSearchOpportunityData mutableBytes] length:[SaleStagePPLForSearchOpportunityData length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is..... %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *SaleStagePPLNotification = [NSNotification notificationWithName:@"SaleStage_PPL_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        NSLog(@"Nitificationsss %@",SaleStagePPLNotification);
        [[NSNotificationQueue defaultQueue]enqueueNotification:SaleStagePPLNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    else if(connection == getAllOpportunity) //Abhishek For PPL For Search Opportunity Connection
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[SaleAllOpportunity mutableBytes] length:[SaleAllOpportunity length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is..... %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *SaleStagePPLNotification = [NSNotification notificationWithName:@"SaleAllOpty_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        NSLog(@"Nitificationsss %@",SaleStagePPLNotification);
        [[NSNotificationQueue defaultQueue]enqueueNotification:SaleStagePPLNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    
    else if(connection == getAllOpportunity1) //Abhishek For PPL For Search Opportunity Connection
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[SaleAllOpportunity1 mutableBytes] length:[SaleAllOpportunity1 length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is..... %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *SaleAllOpty_Found1Notification = [NSNotification notificationWithName:@"SaleAllOpty_Found1" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        NSLog(@"Nitificationsss %@",SaleAllOpty_Found1Notification);
        [[NSNotificationQueue defaultQueue]enqueueNotification:SaleAllOpty_Found1Notification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }

    
    else if(connection == getSearchOpportunityAssignTo) //Abhishek For PPL For Search Opportunity Connection
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[SalesOppAssingTOData mutableBytes] length:[SalesOppAssingTOData length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is..... %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *SaleStagePPLNotification = [NSNotification notificationWithName:@"SaleAssign_To_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        NSLog(@"Nitificationsss %@",SaleStagePPLNotification);
        [[NSNotificationQueue defaultQueue]enqueueNotification:SaleStagePPLNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    else if(connection == getTahshilSearchOpportunityConnection) //Abhishek For PPL For Search Opportunity Connection
    {
        NSLog(@"Gautam..Testing");
        NSString *responseString = [[NSString alloc] initWithBytes:[SaleTahshilSearchOpportunityData mutableBytes] length:[SaleTahshilSearchOpportunityData length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is..... %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *SaleTahshilNotification = [NSNotification notificationWithName:@"SaleTahshilFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        //NSLog(@"Nitificationsss %@",SaleTahshilNotification);
        [[NSNotificationQueue defaultQueue]enqueueNotification:SaleTahshilNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    else if(connection == getSearchOpportunityConnection)
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[Search_OpportunitiesData mutableBytes] length:[Search_OpportunitiesData length] encoding:NSUTF8StringEncoding];
        // NSLog(@"responseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *SearchOpportunityNotification = [NSNotification notificationWithName:@"SearchOpportunities_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:SearchOpportunityNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    
    else if(connection == getSearchOpportunityConnection1)
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[Search_OpportunitiesData1 mutableBytes] length:[Search_OpportunitiesData1 length] encoding:NSUTF8StringEncoding];
        // NSLog(@"responseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *SearchOpportunityNotification1 = [NSNotification notificationWithName:@"SearchOpportunities_Found1" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:SearchOpportunityNotification1 postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }

    
    
    else if(connection == getActivityPPLConnection) //Abhishek Acivity PPL Conection
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[ActivityPPLData mutableBytes] length:[ActivityPPLData length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *ActivityPPLNotification = [NSNotification notificationWithName:@"Activity_PPL_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:ActivityPPLNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    
    else if(connection == getActivityPPLConnection) //Abhishek Acivity PPL Conection
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[ActivityPPLData mutableBytes] length:[ActivityPPLData length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *ActivityPPLNotification = [NSNotification notificationWithName:@"Activity_PPL_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:ActivityPPLNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    
    
    else if(connection == getActivityTaluka) //Abhishek Activity Type Connection
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[ActivityTaluka mutableBytes] length:[ActivityTaluka length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *ActivityTypeNotification = [NSNotification notificationWithName:@"ActivityTaluka_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:ActivityTypeNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    else if(connection == getActivityAssignTo) //Abhishek Activity Type Connection
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[ActivityAssignTo mutableBytes] length:[ActivityAssignTo length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *ActivityTypeNotification = [NSNotification notificationWithName:@"ActivityAssignTo_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:ActivityTypeNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    else if(connection == getActivityTypeConnection) //Abhishek Activity Type Connection
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[ActivityTypeData mutableBytes] length:[ActivityTypeData length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *ActivityTypeNotification = [NSNotification notificationWithName:@"ActivityType_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:ActivityTypeNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    else if(connection == getSearchActivitiesConnection)// Abhishek Search ACtivity Connection
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[seachActivitiesData mutableBytes] length:[seachActivitiesData length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *SearchActivitiesNotification = [NSNotification notificationWithName:@"searchActivities_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:SearchActivitiesNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    else if(connection == getSearchActivitiesConnection1)// Abhishek Search ACtivity Connection
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[seachActivitiesData1 mutableBytes] length:[seachActivitiesData1 length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *SearchActivitiesNotification1 = [NSNotification notificationWithName:@"searchActivities_Found1" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:SearchActivitiesNotification1 postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    else if(connection == getSearchActivitiesConnection2)// Abhishek Search ACtivity Connection
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[seachActivitiesData2 mutableBytes] length:[seachActivitiesData2 length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *searchActivities_Found2Notification = [NSNotification notificationWithName:@"searchActivities_Found2" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:searchActivities_Found2Notification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }


    
    else if (connection == getSearchContactConnection) //Search Contact Connection
    {
        NSString *responseString  = [[NSString alloc]initWithBytes:[SearchContactData mutableBytes] length:[SearchContactData length] encoding:NSUTF8StringEncoding];
        NSLog(@"ResponseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//forchecking samalart expiration
        NSNotification *SearchContactNotification = [NSNotification notificationWithName:@"SearchContact_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:SearchContactNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    
    else if (connection == getCreateContactConnection) // For Create Contact Connection
    {
        
        NSString *responseString  = [[NSString alloc]initWithBytes:[CreateContactData mutableBytes] length:[CreateContactData length] encoding:NSUTF8StringEncoding];
        NSLog(@"\nResponseString getCreateContactConnection %@",responseString);
        
        [self CheckSamalArtExpires:responseString];//forchecking samalart expiration
        NSNotification *CreateContactNotification = [NSNotification notificationWithName:@"CreateContact_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:CreateContactNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    
    else if (connection == getOpportunityLOB_AgianstContactConnection)
    {
        NSString *responseString  = [[NSString alloc]initWithBytes:[OpportunityLOB_AgianstContactData mutableBytes] length:[OpportunityLOB_AgianstContactData length] encoding:NSUTF8StringEncoding];
        NSLog(@"\nResponseString getCreateContactConnection %@",responseString);
        
        [self CheckSamalArtExpires:responseString];//forchecking samalart expiration
        NSNotification *OpportunityLOB_AgianstContactNotification = [NSNotification notificationWithName:@"GetLobForSFA_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:OpportunityLOB_AgianstContactNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    else if (connection == getOpportunityPPL_AgianstContactConnection)
    {
        NSString *responseString  = [[NSString alloc]initWithBytes:[OpportunityPPL_AgianstContactData mutableBytes] length:[OpportunityPPL_AgianstContactData length] encoding:NSUTF8StringEncoding];
        NSLog(@"\nResponseString getCreateContactConnection %@",responseString);
        
        [self CheckSamalArtExpires:responseString];//forchecking samalart expiration
        NSNotification *OpportunityPPL_AgianstContactNotification = [NSNotification notificationWithName:@"GetPPLFromLOB_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:OpportunityPPL_AgianstContactNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    else if (connection == getOpportunityPL_AgianstContactConnection)
    {
        NSString *responseString  = [[NSString alloc]initWithBytes:[OpportunityPL_AgianstContactData mutableBytes] length:[OpportunityPL_AgianstContactData length] encoding:NSUTF8StringEncoding];
        NSLog(@"\nResponseString getCreateContactConnection %@",responseString);
        
        [self CheckSamalArtExpires:responseString];//forchecking samalart expiration
        NSNotification *OpportunityPL_AgianstContactNotification = [NSNotification notificationWithName:@"GetPLFromPPL_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:OpportunityPL_AgianstContactNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    
    else if (connection == getOpportunityApplication_AgianstContactConnection)
    {
        NSString *responseString  = [[NSString alloc]initWithBytes:[OpportunityApplication_AgianstContactData mutableBytes] length:[OpportunityApplication_AgianstContactData length] encoding:NSUTF8StringEncoding];
        NSLog(@"\nResponseString getCreateContactConnection %@",responseString);
        
        [self CheckSamalArtExpires:responseString];//forchecking samalart expiration
        NSNotification *OpportunityApplication_AgianstContactNotification = [NSNotification notificationWithName:@"getTMCVIndentApps_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:OpportunityApplication_AgianstContactNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    else if (connection == getCreateOpportunity_AgainstContactConnection) // create opportunity aginst contact
    {
        NSString *responseString  = [[NSString alloc]initWithBytes:[CreateOpportunity_AgainstContactData mutableBytes] length:[CreateOpportunity_AgainstContactData length] encoding:NSUTF8StringEncoding];
        NSLog(@"\nResponseString getCreateOpportunity_AgainstContactConnection %@",responseString);
        
        [self CheckSamalArtExpires:responseString];//forchecking samalart expiration
        NSNotification *CreateOpportunity_AgainstContactNotification = [NSNotification notificationWithName:@"getCreateOpportunity_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:CreateOpportunity_AgainstContactNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    else if (connection == getSearchAccountConnection) // create opportunity aginst contact
    {
        NSString *responseString  = [[NSString alloc]initWithBytes:[getSearchAccountData mutableBytes] length:[getSearchAccountData length] encoding:NSUTF8StringEncoding];
        NSLog(@"\nResponseString getSearchAccountConnection %@",responseString);
        
        [self CheckSamalArtExpires:responseString];//forchecking samalart expiration
        NSNotification *SearchAccountNotification = [NSNotification notificationWithName:@"SearchAccountFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:SearchAccountNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    
    else if (connection == get_Acct_ContactDetailsConnection) // create opportunity aginst contact
    {
        NSString *responseString  = [[NSString alloc]initWithBytes:[getAcct_ContactDetailsData mutableBytes] length:[getAcct_ContactDetailsData length] encoding:NSUTF8StringEncoding];
        NSLog(@"\nResponseString getSearchAccountConnection %@",responseString);
        
        [self CheckSamalArtExpires:responseString];//forchecking samalart expiration
        NSNotification *Acct_ContactDetailsNotification = [NSNotification notificationWithName:@"Acct_ContactDetailsFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:Acct_ContactDetailsNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    
    else if (connection == getCreateContacWithAccountDetails_Connection) // create contact aginst Account
    {
        NSString *responseString  = [[NSString alloc]initWithBytes:[CreateContacWithAccountDetails_Data mutableBytes] length:[CreateContacWithAccountDetails_Data length] encoding:NSUTF8StringEncoding];
        NSLog(@"\nResponseString getCreateContacWithAccountDetails_Connection %@",responseString);
        
        [self CheckSamalArtExpires:responseString];//forchecking samalart expiration
        NSNotification *CreateContacWithAccountDetailsNotification = [NSNotification notificationWithName:@"CreateContact_FromAccountFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:CreateContacWithAccountDetailsNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    else if (connection == getCreateQuoteRequest_Connection) // create Quatation /CreateQuote
    {
        NSString *responseString  = [[NSString alloc]initWithBytes:[CreateQuoteData mutableBytes] length:[CreateQuoteData length] encoding:NSUTF8StringEncoding];
        NSLog(@"\nResponseString getCreateQuoteRequest_Connection %@",responseString);
        
        [self CheckSamalArtExpires:responseString];//forchecking samalart expiration
        NSNotification *CreateQuoteNotification = [NSNotification notificationWithName:@"CreateQuoteFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:CreateQuoteNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    
    else if (connection == getCreateMakeLostTo_Connection) // create MakeLostto /CreateQuote
    {
        NSString *responseString  = [[NSString alloc]initWithBytes:[CreateMakeLostTo_Data mutableBytes] length:[CreateMakeLostTo_Data length] encoding:NSUTF8StringEncoding];
        NSLog(@"\nResponseString getCreateQuoteRequest_Connection %@",responseString);
        
        [self CheckSamalArtExpires:responseString];//forchecking samalart expiration
        NSNotification *CreateMakeLostNotification = [NSNotification notificationWithName:@"CreateMakeLostFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:CreateMakeLostNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    
    
    else if (connection == getCreateModelLostTo_Connection) // create Model lost To /CreateQuote
    {
        NSString *responseString  = [[NSString alloc]initWithBytes:[CreateModelLostTo_Data mutableBytes] length:[CreateModelLostTo_Data length] encoding:NSUTF8StringEncoding];
        NSLog(@"\nResponseString getCreateQuoteRequest_Connection %@",responseString);
        
        [self CheckSamalArtExpires:responseString];//forchecking samalart expiration
        NSNotification *ModelLostNotification = [NSNotification notificationWithName:@"CreateModelLostFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:ModelLostNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    
    else if (connection == getCreateReasonLostTo_Connection) // create reasonLostTo /CreateQuote
    {
        NSString *responseString  = [[NSString alloc]initWithBytes:[CreateReasonLostTo_Data mutableBytes] length:[CreateReasonLostTo_Data length] encoding:NSUTF8StringEncoding];
        NSLog(@"\nResponseString getCreateQuoteRequest_Connection %@",responseString);
        
        [self CheckSamalArtExpires:responseString];//forchecking samalart expiration
        NSNotification *ReasonLostNotification = [NSNotification notificationWithName:@"CreateReasonLostFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:ReasonLostNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    
    else if (connection == getCreateLostOpportunity_Connection) // create For Lost Opportunity /LostOpportunity
    {
        NSString *responseString  = [[NSString alloc]initWithBytes:[LostOpportunityData mutableBytes] length:[LostOpportunityData length] encoding:NSUTF8StringEncoding];
        NSLog(@"\nResponseString getCreateQuoteRequest_Connection %@",responseString);
        
        [self CheckSamalArtExpires:responseString];//forchecking samalart expiration
        NSNotification *LostOpportunityNotification = [NSNotification notificationWithName:@"LostOpportunityFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:LostOpportunityNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    else if (connection == getActivityForOpportunity_Connection) // create For Lost Opportunity /LostOpportunity
    {
        NSString *responseString  = [[NSString alloc]initWithBytes:[getActivityForOpportunityData mutableBytes] length:[getActivityForOpportunityData length] encoding:NSUTF8StringEncoding];
        NSLog(@"\nResponseString getActivityForOpportunity_Connection %@",responseString);
        
        [self CheckSamalArtExpires:responseString];//forchecking samalart expiration
        NSNotification *getActivityForOpportunityNotification = [NSNotification notificationWithName:@"ActivityForOpportunityFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:getActivityForOpportunityNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    else if (connection == getCreateActivity_ForOpportunity_Connection) // create For Lost Opportunity /LostOpportunity
    {
        NSString *responseString  = [[NSString alloc]initWithBytes:[getCreateActivity_ForOpportunityData mutableBytes] length:[getCreateActivity_ForOpportunityData length] encoding:NSUTF8StringEncoding];
        NSLog(@"\nResponseString getCreateActivity_ForOpportunity_Connection %@",responseString);
        
        [self CheckSamalArtExpires:responseString];//forchecking samalart expiration
        NSNotification *getActivity_ForOpportunityNotification = [NSNotification notificationWithName:@"CreateActivityForOpportunityFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:getActivity_ForOpportunityNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    else if (connection == getCreateAccount_Connection) // create For Lost Opportunity /LostOpportunity
    {
        NSString *responseString  = [[NSString alloc]initWithBytes:[getCreateAccount_Data mutableBytes] length:[getCreateAccount_Data length] encoding:NSUTF8StringEncoding];
        NSLog(@"\nResponseString getCreateAccount_Connection %@",responseString);
        
        [self CheckSamalArtExpires:responseString];//forchecking samalart expiration
        NSNotification *getCreateAccountNotification = [NSNotification notificationWithName:@"CreateAccountFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:getCreateAccountNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    else if(connection==getDistributorDetailsConnection)
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[getDistributorDetailsData mutableBytes] length:[getDistributorDetailsData length] encoding:NSUTF8StringEncoding];
        // NSLog(@"getDistributorDetails Response is %@",responseString);
        NSNotification *getDistributorDetailstNotification=[NSNotification notificationWithName:@"getDistributorDetailsFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:getDistributorDetailstNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    else if(connection==getPricingListConnection)
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[getPricingListData mutableBytes] length:[getPricingListData length] encoding:NSUTF8StringEncoding];
        //  NSLog(@"getPricingList Response is %@",responseString);
        NSNotification *getPricingListtNotification=[NSNotification notificationWithName:@"getPricingListFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:getPricingListtNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    else if(connection==getRetailerDetailsConnection)
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[getRetailerDetailsData mutableBytes] length:[getRetailerDetailsData length] encoding:NSUTF8StringEncoding];
        //   NSLog(@"getRetailerDetails Response is %@",responseString);
        NSNotification *getRetailerDetailsNotification=[NSNotification notificationWithName:@"getRetailerDetailsFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:getRetailerDetailsNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    
    else if(connection==getRetailerLandedPriceConnection)
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[getRetailerLandedPriceData mutableBytes] length:[getRetailerLandedPriceData length] encoding:NSUTF8StringEncoding];
        //   NSLog(@"getRetailerLandedPrice Response is %@",responseString);
        NSNotification *getRetailerLandedPriceNotification=[NSNotification notificationWithName:@"getRetailerLandedPriceFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:getRetailerLandedPriceNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    else if(connection==bpmStatusConnection)
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[bpmStatusData mutableBytes] length:[bpmStatusData length] encoding:NSUTF8StringEncoding];
        //    NSLog(@"getRetailerLandedPrice Response is %@",responseString);
        NSNotification *bpmStatusNotification=[NSNotification notificationWithName:@"bpmStatusFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:bpmStatusNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    else if(connection==getDistPosConnection)
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[getDistPosData mutableBytes] length:[getDistPosData length] encoding:NSUTF8StringEncoding];
        //    NSLog(@"getRetailerLandedPrice Response is %@",responseString);
        NSNotification *getDistPosNotification=[NSNotification notificationWithName:@"getDistPosFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:getDistPosNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    else if(connection==getInventoryConnection)
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[getInventoryData mutableBytes] length:[getInventoryData length] encoding:NSUTF8StringEncoding];
        //    NSLog(@"getRetailerLandedPrice Response is %@",responseString);
        NSNotification *getInventoryNotification=[NSNotification notificationWithName:@"getInventoryFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:getInventoryNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    else if(connection == placeOrderConnection)
    {
        NSError *err;
        NSMutableDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:placeOrderData options:NSJSONReadingAllowFragments error:&err];
        NSMutableDictionary *mutableResponseDict = [responseDict mutableCopy];
        [mutableResponseDict setObject:[NSString stringWithFormat:@"%i",statusCode] forKey:@"statusCode"];
        NSLog(@"%@",mutableResponseDict);
        NSNotification *placeOrderNotification=[NSNotification notificationWithName:@"placeOrderFound" object:nil userInfo:mutableResponseDict];
        [[NSNotificationQueue defaultQueue]enqueueNotification:placeOrderNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    else if(connection==accessTokenConnection)
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[accessTokenData mutableBytes] length:[accessTokenData length] encoding:NSUTF8StringEncoding];
        //    NSLog(@"getRetailerLandedPrice Response is %@",responseString);
        NSNotification *accessTokenNotification=[NSNotification notificationWithName:@"accessTokenFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:accessTokenNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    else if(connection==getOrderNumberConnection)
    {
        //   NSString *responseString = [[NSString alloc] initWithBytes:[getOrderNumberData mutableBytes] length:[getOrderNumberData length] encoding:NSUTF8StringEncoding];
        //    NSLog(@"getRetailerLandedPrice Response is %@",responseString);
        NSError *err;
        NSDictionary *responseDict=[NSJSONSerialization JSONObjectWithData:getOrderNumberData options:NSJSONReadingAllowFragments error:&err];
        NSNotification *getOrderNumberNotification=[NSNotification notificationWithName:@"getOrderNumberFound" object:nil userInfo:responseDict];
        [[NSNotificationQueue defaultQueue]enqueueNotification:getOrderNumberNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    else if(connection==saveDraftConnection)
    {
        //  NSString *responseString = [[NSString alloc] initWithBytes:[saveDraftData mutableBytes] length:[saveDraftData length] encoding:NSUTF8StringEncoding];
        //    NSLog(@"getRetailerLandedPrice Response is %@",responseString);
        NSError *err;
        NSDictionary *responseDict=[NSJSONSerialization JSONObjectWithData:saveDraftData options:NSJSONReadingAllowFragments error:&err];
        NSNotification *saveDraftNotification=[NSNotification notificationWithName:@"saveDraftFound" object:nil userInfo:responseDict];
        [[NSNotificationQueue defaultQueue]enqueueNotification:saveDraftNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    
    
    
    else if(connection==viewDraftsConnection)
    {
        //  NSString *responseString = [[NSString alloc] initWithBytes:[saveDraftData mutableBytes] length:[saveDraftData length] encoding:NSUTF8StringEncoding];
        //    NSLog(@"getRetailerLandedPrice Response is %@",responseString);
        NSError *err;
        NSDictionary *responseDict=[NSJSONSerialization JSONObjectWithData:viewDraftsData options:NSJSONReadingAllowFragments error:&err];
        NSNotification *viewDraftsNotification=[NSNotification notificationWithName:@"viewDraftsFound" object:nil userInfo:responseDict];
        [[NSNotificationQueue defaultQueue]enqueueNotification:viewDraftsNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    else if(connection==updateMRPConnection)
    {
        //  NSString *responseString = [[NSString alloc] initWithBytes:[saveDraftData mutableBytes] length:[saveDraftData length] encoding:NSUTF8StringEncoding];
        //    NSLog(@"getRetailerLandedPrice Response is %@",responseString);
        NSError *err;
        NSDictionary *responseDict=[NSJSONSerialization JSONObjectWithData:updateMRPData options:NSJSONReadingAllowFragments error:&err];
        NSNotification *updateMRPsNotification=[NSNotification notificationWithName:@"updateMRPFound" object:nil userInfo:responseDict];
        [[NSNotificationQueue defaultQueue]enqueueNotification:updateMRPsNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    else if(connection==updateQuantityConnection)
    {
        //  NSString *responseString = [[NSString alloc] initWithBytes:[saveDraftData mutableBytes] length:[saveDraftData length] encoding:NSUTF8StringEncoding];
        //    NSLog(@"getRetailerLandedPrice Response is %@",responseString);
        NSError *err;
        NSDictionary *responseDict=[NSJSONSerialization JSONObjectWithData:updateQuantityData options:NSJSONReadingAllowFragments error:&err];
        NSNotification *updateQuantityNotification=[NSNotification notificationWithName:@"updateQuantityFound" object:nil userInfo:responseDict];
        [[NSNotificationQueue defaultQueue]enqueueNotification:updateQuantityNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    else if(connection==deletePartConnection)
    {
        //  NSString *responseString = [[NSString alloc] initWithBytes:[saveDraftData mutableBytes] length:[saveDraftData length] encoding:NSUTF8StringEncoding];
        //    NSLog(@"getRetailerLandedPrice Response is %@",responseString);
        NSError *err;
        NSDictionary *responseDict=[NSJSONSerialization JSONObjectWithData:deletePartData options:NSJSONReadingAllowFragments error:&err];
        NSNotification *deletePartNotification=[NSNotification notificationWithName:@"deletePartFound" object:nil userInfo:responseDict];
        [[NSNotificationQueue defaultQueue]enqueueNotification:deletePartNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    else if(connection==resetPasswordConnection)
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[resetPasswordData mutableBytes] length:[resetPasswordData length] encoding:NSUTF8StringEncoding];
        //    NSLog(@"getRetailerLandedPrice Response is %@",responseString);
        NSNotification *resetPasswordNotification=[NSNotification notificationWithName:@"resetPasswordFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:resetPasswordNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    else if(connection==getAllOrdersConnection)
    {
        NSError *err;
        NSDictionary *responseDict=[NSJSONSerialization JSONObjectWithData:getAllOrdersData options:NSJSONReadingAllowFragments error:&err];
        NSNotification *getAllOrdersNotification=[NSNotification notificationWithName:@"getAllOrdersFound" object:nil userInfo:responseDict];
        [[NSNotificationQueue defaultQueue]enqueueNotification:getAllOrdersNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    else if(connection==changeOrderStatusConnection)
    {
        NSError *err;
        NSDictionary *responseDict=[NSJSONSerialization JSONObjectWithData:changeOrderStatusData options:NSJSONReadingAllowFragments error:&err];
        NSNotification *changeOrderStatusNotification=[NSNotification notificationWithName:@"changeOrderStatusFound" object:nil userInfo:responseDict];
        [[NSNotificationQueue defaultQueue]enqueueNotification:changeOrderStatusNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    else if(connection==get_Lob_List_Connection)
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[getLobList mutableBytes] length:[getLobList length] encoding:NSUTF8StringEncoding];
        NSLog(@"authenticateOID Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For Checking SamalArt Expiration
        NSNotification *currentDateNotification = [NSNotification notificationWithName:@"LobListFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:currentDateNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    else if(connection==get_PPL_List_Connection)
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[getPPL_List_Data mutableBytes] length:[getPPL_List_Data length] encoding:NSUTF8StringEncoding];
        NSLog(@"PPL_List Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For Checking SamalArt Expiration
        NSNotification *PPL_List_Notification = [NSNotification notificationWithName:@"PPL_ListFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:PPL_List_Notification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    else if(connection==get_PL_List_Connection)
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[getPL_List_Data mutableBytes] length:[getPL_List_Data length] encoding:NSUTF8StringEncoding];
        NSLog(@"PL_List Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For Checking SamalArt Expiration
        NSNotification *PL_List_Notification = [NSNotification notificationWithName:@"PL_ListFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:PL_List_Notification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    else if(connection==get_Application_List_Connection)
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[getApplication_List_Data mutableBytes] length:[getApplication_List_Data length] encoding:NSUTF8StringEncoding];
        NSLog(@"PL_List Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For Checking SamalArt Expiration
        NSNotification *Application_List_Notification = [NSNotification notificationWithName:@"Application_ListFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:Application_List_Notification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    else if(connection==get_Financier_List_Connection)
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[getFinancier_List_Data mutableBytes] length:[getFinancier_List_Data length] encoding:NSUTF8StringEncoding];
        NSLog(@"Financier_List Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For Checking SamalArt Expiration
        NSNotification *Financier_List_Notification = [NSNotification notificationWithName:@"Financier_ListFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:Financier_List_Notification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    else if(connection==get_Indian_states_List_Connection)
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[getIndian_States_List_Data mutableBytes] length:[getIndian_States_List_Data length] encoding:NSUTF8StringEncoding];
        NSLog(@"Financier_List Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For Checking SamalArt Expiration
        NSNotification *Indian_States_Notification = [NSNotification notificationWithName:@"Indian_States_ListFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:Indian_States_Notification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    else if(connection==get_District_List_Connection)
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[getDistrict_List_Data mutableBytes] length:[getDistrict_List_Data length] encoding:NSUTF8StringEncoding];
        NSLog(@"District_List Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For Checking SamalArt Expiration
        NSNotification *District_Notification = [NSNotification notificationWithName:@"District_ListFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:District_Notification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    else if(connection==get_City_List_Connection)
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[getCityList_Data mutableBytes] length:[getCityList_Data length] encoding:NSUTF8StringEncoding];
        NSLog(@"City_List Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For Checking SamalArt Expiration
        NSNotification *City_Notification = [NSNotification notificationWithName:@"City_ListFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:City_Notification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    else if(connection==get_Postal_code_List_Connection)
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[getPostalCode_List_Data mutableBytes] length:[getPostalCode_List_Data length] encoding:NSUTF8StringEncoding];
        NSLog(@"Postal_code Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For Checking SamalArt Expiration
        NSNotification *Postal_Code_Notification = [NSNotification notificationWithName:@"Postal_code_ListFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:Postal_Code_Notification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    else if(connection==get_Taluka_List_Connection)
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[getTaluka_List_Data mutableBytes] length:[getTaluka_List_Data length] encoding:NSUTF8StringEncoding];
        NSLog(@"Taluka_List Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For Checking SamalArt Expiration
        NSNotification *Taluka_Notification = [NSNotification notificationWithName:@"Taluka_ListFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:Taluka_Notification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    else if(connection==get_Contact_List_Connection)
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[getContact_List_Data mutableBytes] length:[getContact_List_Data length] encoding:NSUTF8StringEncoding];
        NSLog(@"Contact_List Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For Checking SamalArt Expiration
        NSNotification *Taluka_Notification = [NSNotification notificationWithName:@"Contact_ListFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:Taluka_Notification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    
    else if(connection == getPendingActivityDetailsConnection) // abhishek // for getting activity details
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[PendingActivityDetailsData mutableBytes] length:[PendingActivityDetailsData length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *ActivityDetailsNotification = [NSNotification notificationWithName:@"PendingActivityListFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:ActivityDetailsNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    
    
    else if(connection == ActivityDetailsConnection) // abhishek // for getting activity details
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[getPendingActivityDetailsData mutableBytes] length:[getPendingActivityDetailsData length] encoding:NSUTF8StringEncoding];
        NSLog(@"getPendingActivityDetailsData Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *ActivityDetailsNotification = [NSNotification notificationWithName:@"getPendingActivityListFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:ActivityDetailsNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    else if(connection == getCreateActivityTypeConnection) // Activity Type Connection
    {
        NSLog(@"CReate Actiivty ..");
        NSString *responseString = [[NSString alloc] initWithBytes:[ActivityCreateTypeData mutableBytes] length:[ActivityCreateTypeData length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *ActivityTypeNotification = [NSNotification notificationWithName:@"ActivityCreateType_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:ActivityTypeNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    else if(connection == getLinkcampaign_Connection)
    {
        NSLog(@"LinkCampaign Data ..");
        NSString *responseString = [[NSString alloc] initWithBytes:[Linkcampaign_Data mutableBytes] length:[Linkcampaign_Data length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *LinkCampaignNotification = [NSNotification notificationWithName:@"LinkCampaign_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:LinkCampaignNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    
    else if(connection == getLinkcampaign_Select_connection)
    {
        NSLog(@"LinkCampaign Data ..");
        NSString *responseString = [[NSString alloc] initWithBytes:[Select_Linkcampaign_Data mutableBytes] length:[Select_Linkcampaign_Data length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *SelectLinkCampaignNotification = [NSNotification notificationWithName:@"SelectLinkCampaign_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:SelectLinkCampaignNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    
    else if(connection == getReason_Lost_connection)
    {
        NSLog(@"Reasonlost Data ..");
        NSString *responseString = [[NSString alloc] initWithBytes:[Reason_lost_Data mutableBytes] length:[Reason_lost_Data length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *Reason_Lost_Notification = [NSNotification notificationWithName:@"Reason_Lost_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:Reason_Lost_Notification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    
    else if(connection == getMake_Lost_connection)
    {
        NSLog(@"Reasonlost Data ..");
        NSString *responseString = [[NSString alloc] initWithBytes:[Make_lost_Data mutableBytes] length:[Make_lost_Data length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *Make_Lost_Notification = [NSNotification notificationWithName:@"Make_Lost_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:Make_Lost_Notification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    else if(connection == getMake_Lost_connection)
    {
        NSLog(@"Reasonlost Data ..");
        NSString *responseString = [[NSString alloc] initWithBytes:[Make_lost_Data mutableBytes] length:[Make_lost_Data length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *Make_Lost_Notification = [NSNotification notificationWithName:@"Make_Lost_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:Make_Lost_Notification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    else if(connection == getModel_Lost_connection)
    {
        NSLog(@"Reasonlost Data ..");
        NSString *responseString = [[NSString alloc] initWithBytes:[Model_lost_Data mutableBytes] length:[Model_lost_Data length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *Model_Lost_Notification = [NSNotification notificationWithName:@"Model_Lost_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:Model_Lost_Notification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    
    else if(connection == getLost_Opty_connection)
    {
        NSLog(@"Reasonlost Data ..");
        NSString *responseString = [[NSString alloc] initWithBytes:[Lost_Opty_Data mutableBytes] length:[Lost_Opty_Data length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *Lost_Opty_Notification = [NSNotification notificationWithName:@"Lost_Opty_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:Lost_Opty_Notification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    
    else if(connection == adressID_connection)
    {
        NSLog(@"adressID Data ..");
        NSString *responseString = [[NSString alloc] initWithBytes:[adressIDdata mutableBytes] length:[adressIDdata length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *adressIDdata_Notification = [NSNotification notificationWithName:@"adressID_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:adressIDdata_Notification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    else if(connection == ContactSave_connection)
    {
        NSLog(@"ContactSave Data ..");
        NSString *responseString = [[NSString alloc] initWithBytes:[ContactSavedata mutableBytes] length:[ContactSavedata length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *ContactSave_Notification = [NSNotification notificationWithName:@"ContactSave_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:ContactSave_Notification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    else if(connection == ProceedToQuoteCreation_connection)
    {
        NSLog(@"ProceedToQuoteCreation Data ..");
        NSString *responseString = [[NSString alloc] initWithBytes:[ProceedToQuoteCreationdata mutableBytes] length:[ProceedToQuoteCreationdata length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *ProceedToQuoteCreation_Notification = [NSNotification notificationWithName:@"ProceedToQuoteCreation_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:ProceedToQuoteCreation_Notification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    
    else if(connection == GetProductconnection)
    {
        NSLog(@"ProceedToQuoteCreation Data ..");
        NSString *responseString = [[NSString alloc] initWithBytes:[GetProductdata mutableBytes] length:[GetProductdata length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *GetProduct_Notification = [NSNotification notificationWithName:@"GetProduct_Notification_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:GetProduct_Notification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    
    else if(connection == UpdateOptyconnection)
    {
        NSLog(@"UPdateoPTY Data ..");
        NSString *responseString = [[NSString alloc] initWithBytes:[UpdateOptydata mutableBytes] length:[UpdateOptydata length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *UpdateOpty_Notification = [NSNotification notificationWithName:@"UpdateOpty_Notification_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:UpdateOpty_Notification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    
    else if (connection == PL_ProductID_Connection) // create opportunity aginst contact
    {
        NSString *responseString  = [[NSString alloc]initWithBytes:[PL_ProductID_Data mutableBytes] length:[PL_ProductID_Data length] encoding:NSUTF8StringEncoding];
        NSLog(@"\nResponseString PL_ProductID_Connection  %@",responseString);
        
        [self CheckSamalArtExpires:responseString];//forchecking samalart expiration
        NSNotification *PL_ProductID_Notification = [NSNotification notificationWithName:@"PL_ProductID_ListFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:PL_ProductID_Notification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    else if (connection == getCreateAccountaginstcontact_Connection) // create For Lost Opportunity /LostOpportunity
    {
        NSString *responseString  = [[NSString alloc]initWithBytes:[getCreateAccountaginstcontact_Data mutableBytes] length:[getCreateAccountaginstcontact_Data length] encoding:NSUTF8StringEncoding];
        NSLog(@"\nResponseString getCreateAccountaginstcontact_Connection %@",responseString);
        
        [self CheckSamalArtExpires:responseString];//forchecking samalart expiration
        
        NSNotification *getCreateAccountaginstcontactNotification = [NSNotification notificationWithName:@"CreateAccountAgainst_ContactFound" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        
        [[NSNotificationQueue defaultQueue]enqueueNotification:getCreateAccountaginstcontactNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    
    else if(connection == getSearchContactConnectiondashboard) //Gautam's For PPL For Search Opportunity Connection
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[SearchContactDataDashboard mutableBytes] length:[SearchContactDataDashboard length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is.....ofProduct %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *SaleStagePPLNotification = [NSNotification notificationWithName:@"searchActivitiesDashboard_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        NSLog(@"Nitificationsss %@",SaleStagePPLNotification);
        [[NSNotificationQueue defaultQueue]enqueueNotification:SaleStagePPLNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    
    else if(connection == getSearchActivitiesMonthConnectiondashboard) //Gautam's For PPL For Search Opportunity Connection
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[SearchActivitiesMonthDataDashboard mutableBytes] length:[SearchActivitiesMonthDataDashboard length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is.....ofProduct %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *SaleStagePPLNotification = [NSNotification notificationWithName:@"SearchActivitiesMonth_Connection" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        // NSLog(@"N0tificationsss %@",SaleStagePPLNotification);
        [[NSNotificationQueue defaultQueue]enqueueNotification:SaleStagePPLNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    
    else if(connection == getdashboardOpportunityConnection) //Gautam's For PPL For Search Opportunity Connection
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[GetOpportunityDashboard mutableBytes] length:[GetOpportunityDashboard length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is.....Done activity  %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *SaleStagePPLNotification = [NSNotification notificationWithName:@"OpportunitiesDashBoard_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        NSLog(@"Nitificationsss %@",SaleStagePPLNotification);
        [[NSNotificationQueue defaultQueue]enqueueNotification:SaleStagePPLNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    else if (connection == getPLAnalyticsConnection) // create opportunity aginst contact
    {
        NSString *responseString  = [[NSString alloc]initWithBytes:[getPLAnalyticsData mutableBytes] length:[getPLAnalyticsData length] encoding:NSUTF8StringEncoding];
        NSLog(@"\nResponseString getSearchAccountConnection %@",responseString);
        
        [self CheckSamalArtExpires:responseString];//forchecking samalart expiration
        NSNotification *SearchAccountNotification = [NSNotification notificationWithName:@"GetPL_Analytics_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:SearchAccountNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }

    else if (connection == getPPLAnalyticsConnection) // create opportunity aginst contact
    {
        NSString *responseString  = [[NSString alloc]initWithBytes:[getPPLAnalyticsData mutableBytes] length:[getPPLAnalyticsData length] encoding:NSUTF8StringEncoding];
        NSLog(@"\nResponseString getSearchAccountConnection %@",responseString);
        
        [self CheckSamalArtExpires:responseString];//forchecking samalart expiration
        NSNotification *SearchAccountNotification = [NSNotification notificationWithName:@"GetPPL_Analytics_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:SearchAccountNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    else if(connection == getdsewisereport) //Abhishek Activity Type Connection
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[dsewisereport mutableBytes] length:[dsewisereport length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *ActivityTypeNotification = [NSNotification notificationWithName:@"getdsewisereport_found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:ActivityTypeNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    
    else if(connection == Done_ActivityConnection) //Abhishek Activity Type Connection
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[Done_ActivityData mutableBytes] length:[Done_ActivityData length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *DONEACTIVITYNotification = [NSNotification notificationWithName:@"Activity_Done_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:DONEACTIVITYNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
        else if(connection == Done_Activity_second_request_Connection) //Abhishek Activity Type Connection
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[Done_Activity_second_request_Data mutableBytes] length:[Done_Activity_second_request_Data length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *DONEACTIVITY_second_request_Notification = [NSNotification notificationWithName:@"Activity_Done_second_request_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:DONEACTIVITY_second_request_Notification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    
    else if(connection == After_Done_ActivityConnection) //Abhishek Activity Type Connection
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[After_Done_ActivityData mutableBytes] length:[After_Done_ActivityData length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *AFTERDONEACTIVITYNotification = [NSNotification notificationWithName:@"After_Activity_Done_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:AFTERDONEACTIVITYNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    else if(connection == AfterQuoteCreationConnection) //Abhishek Activity Type Connection
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[AfterQuoteCreationData mutableBytes] length:[AfterQuoteCreationData length] encoding:NSUTF8StringEncoding];
        NSLog(@"responseString Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *AfterQuoteCreationNotification = [NSNotification notificationWithName:@"AfterQuoteCreation_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:AfterQuoteCreationNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
        
    }
    
    else if(connection == getupdateActivityConnection)
    {
        NSString *responseString = [[NSString alloc] initWithBytes:[PendingActivtyUpdate mutableBytes] length:[PendingActivtyUpdate length] encoding:NSUTF8StringEncoding];
        NSLog(@"search Opty Response is %@",responseString);
        [self CheckSamalArtExpires:responseString];//For checking samalArt Expiration
        NSNotification *SearchOpportunityNotification = [NSNotification notificationWithName:@"ActivityUpdates_Found" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:responseString,@"response", nil]];
        [[NSNotificationQueue defaultQueue]enqueueNotification:SearchOpportunityNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }

   
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"connection didFailWithError: %@ %@", error.localizedDescription,[error.userInfo objectForKey:NSURLErrorFailingURLStringErrorKey]);
    if(connection == getSearchOpportunityConnection)
    {
        NSDictionary *errDict;
        if([error.localizedDescription isEqualToString:@"The Internet connection appears to be offline."])
        {
            errDict=[NSDictionary dictionaryWithObjectsAndKeys:@"offline",@"error", nil];
        }
        NSNotification *errNotification = [NSNotification notificationWithName:@"artifactFailed" object:nil userInfo:errDict];
        [[NSNotificationQueue defaultQueue]enqueueNotification:errNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    if(connection == artifactConnection)
    {
        NSDictionary *errDict;
        if([error.localizedDescription isEqualToString:@"The Internet connection appears to be offline."])
        {
            errDict=[NSDictionary dictionaryWithObjectsAndKeys:@"offline",@"error", nil];
        }
        NSNotification *errNotification = [NSNotification notificationWithName:@"artifactFailed" object:nil userInfo:errDict];
        [[NSNotificationQueue defaultQueue]enqueueNotification:errNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    if(connection == getUserDetailsConnection)
    {
        NSDictionary *errDict;
        if([error.localizedDescription isEqualToString:@"The Internet connection appears to be offline."])
        {
            errDict=[NSDictionary dictionaryWithObjectsAndKeys:@"offline",@"error", nil];
        }
        NSNotification *errNotification = [NSNotification notificationWithName:@"userDetailsFailed" object:nil userInfo:errDict];
        [[NSNotificationQueue defaultQueue]enqueueNotification:errNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    
    if (connection == getOpprtunityCountConnection )
    {
        NSLog(@"\n Please check connection... opportunityCountFailed!!!  ");
        
        NSDictionary *errDict;
        if([error.localizedDescription isEqualToString:@"The Internet connection appears to be offline."])
        {
            errDict=[NSDictionary dictionaryWithObjectsAndKeys:@"offline",@"error", nil];
        }
        NSNotification *errNotification = [NSNotification notificationWithName:@"opportunityCountFailed" object:nil userInfo:errDict];
        [[NSNotificationQueue defaultQueue]enqueueNotification:errNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    if (connection == getSearchContactConnection)//SearchContactVC
    {
        NSLog(@"\n please check connection... opportunityCountFailed!!!  ");
        
        NSDictionary *errDict;
        if([error.localizedDescription isEqualToString:@"The Internet connection appears to be offline."])
        {
            errDict=[NSDictionary dictionaryWithObjectsAndKeys:@"offline",@"error", nil];
        }
        NSNotification *errNotification = [NSNotification notificationWithName:@"SearchContact_Failed" object:nil userInfo:errDict];
        [[NSNotificationQueue defaultQueue]enqueueNotification:errNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    if (connection == getSearchContactConnection)//CreateOpportunityAgainstContact_VC
    {
        NSLog(@"\n please check LOB... CreateOpportunityAgainstContact_VC!!!  ");
        
        NSDictionary *errDict;
        if([error.localizedDescription isEqualToString:@"The Internet connection appears to be offline."])
        {
            errDict=[NSDictionary dictionaryWithObjectsAndKeys:@"offline",@"error", nil];
        }
        NSNotification *errNotification = [NSNotification notificationWithName:@"GetLobForSFA_Failed" object:nil userInfo:errDict];
        [[NSNotificationQueue defaultQueue]enqueueNotification:errNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    
    if (connection == getCreateContacWithAccountDetails_Connection)//CreateOpportunityAgainstContact_VC
    {
        NSLog(@"\n please check LOB... CreateOpportunityAgainstContact_VC!!!  ");
        
        NSDictionary *errDict;
        if([error.localizedDescription isEqualToString:@"The Internet connection appears to be offline."])
        {
            errDict=[NSDictionary dictionaryWithObjectsAndKeys:@"offline",@"error", nil];
        }
        NSNotification *errNotification = [NSNotification notificationWithName:@"getCreateContacWithAccountDetails_Failed" object:nil userInfo:errDict];
        [[NSNotificationQueue defaultQueue]enqueueNotification:errNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    
    
    if (connection == getCreateAccount_Connection) /// Create Account Connection Error
    {
        
        NSLog(@"\n please check LOB... getCreateAccount_Connection!!!  ");
        
        NSDictionary *errDict;
        if([error.localizedDescription isEqualToString:@"The Internet connection appears to be offline."])
        {
            errDict=[NSDictionary dictionaryWithObjectsAndKeys:@"offline",@"error", nil];
        }
        NSNotification *errNotification = [NSNotification notificationWithName:@"getCreateAccountFailed" object:nil userInfo:errDict];
        [[NSNotificationQueue defaultQueue]enqueueNotification:errNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    if (connection == get_Lob_List_Connection) /// Create Account Connection Error
    {
        
        NSLog(@"\n please check LOB... getCreateAccount_Connection!!!  ");
        
        NSDictionary *errDict;
        if([error.localizedDescription isEqualToString:@"The Internet connection appears to be offline."])
        {
            errDict=[NSDictionary dictionaryWithObjectsAndKeys:@"offline",@"error", nil];
        }
        NSNotification *errNotification = [NSNotification notificationWithName:@"getLobListConnectionFailed" object:nil userInfo:errDict];
        [[NSNotificationQueue defaultQueue]enqueueNotification:errNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    if (connection == get_PPL_List_Connection) // Create Account Connection Error
    {
        NSLog(@"\n please check LOB... getCreateAccount_Connection!!!  ");
        
        NSDictionary *errDict;
        if([error.localizedDescription isEqualToString:@"The Internet connection appears to be offline."])
        {
            errDict=[NSDictionary dictionaryWithObjectsAndKeys:@"offline",@"error", nil];
        }
        NSNotification *errNotification = [NSNotification notificationWithName:@"getPPLListConnectionFailed" object:nil userInfo:errDict];
        [[NSNotificationQueue defaultQueue]enqueueNotification:errNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    }
    
    //    if(connection == OPP)
    //    {
    //        NSDictionary *errDict;
    //        if([error.localizedDescription isEqualToString:@"The Internet connection appears to be offline."])
    //        {
    //            errDict=[NSDictionary dictionaryWithObjectsAndKeys:@"offline",@"error", nil];
    //        }
    //        NSNotification *errNotification = [NSNotification notificationWithName:@"artifactFailed" object:nil userInfo:errDict];
    //        [[NSNotificationQueue defaultQueue]enqueueNotification:errNotification postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    //    }
    
    //    MainViewController *mainViewControllerVC_ = (__bridge MainViewController * )mainViewControllerVC;
    //    [mainViewControllerVC_ performSelectorOnMainThread:@selector(testMainthread) withObject:nil waitUntilDone:NO];
    
}


-(void)CheckSamalArtExpires:(NSString *)str_samalART
{
    NSString *tempSamalArt = str_samalART;
    NSString* ErrorMessage = @"Unable to bind an artifact";
    NSLog(@"\n tempsamalArt %@",tempSamalArt);
    
    if ([tempSamalArt rangeOfString:ErrorMessage].location != NSNotFound)
    {
        NSLog(@"Yes it does contain that word");
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate ];
        [appDelegate callArtifactRequest];
        
    }
}










@end
