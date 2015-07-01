//
//  LoginViewController.h
//  test
//
//  Created by admin on 02/03/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "GlobalVariables.h"
#import "UserDetails_Var.h"

@interface LoginViewController : UIViewController<NSURLConnectionDelegate,NSURLConnectionDataDelegate,NSXMLParserDelegate>
{
    AppDelegate *appdelegate;
    GlobalVariables *globalVariables_;
    UserDetails_Var *userDetailsVal_;
    
     NSMutableArray *userDetailsArray;
}






- (IBAction)loginScreeb:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIButton *LoginButton;

@property (weak, nonatomic) IBOutlet UIButton *Btnremeberme;

@property(strong,nonatomic) IBOutlet NSMutableData *webData;

@property(strong,nonatomic) IBOutlet NSMutableString *AssertionArtifact;

@property(strong,nonatomic) IBOutlet NSString *NewUrl;

@property(strong,nonatomic) IBOutlet NSMutableString *CurrentDate;

@property(strong,nonatomic) NSXMLParser *parser;

@property (nonatomic,readwrite) int flag;


-(void)createAlertWithTitle:(NSString*)title message:(NSString*)message;
-(void)callArtifactRequest;
-(void)CallUserDetails;


@end
