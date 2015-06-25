//
//  GlobalVariables.h
//  testSwitchCase
//
//  Created by Abhishek on 01/04/15.
//  Copyright (c) 2015 Tata Motors. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSMutableArray *GlobalVariablesArray_;

@interface GlobalVariables : NSObject
{
    NSString *g_Artifact;
    NSString *g_CurentDate;
    NSString *g_UserName;
}

//+(id)sharedmanager;
@property(nonatomic,strong) NSString *g_Artifact;
@property(nonatomic,strong) NSString *g_CurrentDate;
@property(nonatomic,strong) NSString *g_UserName;



@end
