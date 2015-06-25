//
//  analytics_list.h
//  DSM
//
//  Created by Sachin Sharma on 12/05/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSMutableArray *analyticslistarray;
extern NSMutableArray *analyticsdisplayarray;

@interface analytics_list : NSObject
{


}
//alias
@property(nonatomic,strong)NSString* PL;

@property(nonatomic,strong)NSString* alias;

@property(nonatomic,strong)NSString* alias1;

@property(nonatomic,strong)NSString* alias2;

@property(nonatomic,strong)NSString* alias3;

@property(nonatomic,strong)NSString* alias4;


@end
extern analytics_list *analytics;