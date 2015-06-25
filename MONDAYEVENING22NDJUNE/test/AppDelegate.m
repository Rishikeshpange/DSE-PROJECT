//
//  AppDelegate.m
//  test
//
//  Created by Sebastian Boldt on 07.03.13.
//  Copyright (c) 2013 LetsIDev. All rights reserved.
//

#import "AppDelegate.h"
#import <SystemConfiguration/CaptiveNetwork.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
//    CFArrayRef myArray = CNCopySupportedInterfaces();
//    CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
//    NSLog(@"Connected at:%@",myDict);
//    NSDictionary *myDictionary = (__bridge_transfer NSDictionary*)myDict;
//    NSString * BSSID = [myDictionary objectForKey:@"BSSID"];
//    NSLog(@"bssid is %@",BSSID);
    
    self.authenticated = NO;

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds] ];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    self.splitViewController = (UISplitViewController *)self.window.rootViewController;
    
    //[self.splitViewController.view setBackgroundColor:[UIColor redColor]];
    
    self.window.rootViewController=vc;
    
    [vc setModalTransitionStyle:UIModalTransitionStylePartialCurl];
    [self.splitViewController presentViewController:vc animated:YES completion:nil];
     self.URL=@"http://tmcrmappsqa.inservices.tatamotors.com/cordys/com.eibus.web.soap.Gateway.wcp?organization=o=MobileApps,cn=cordys,cn=cbop,o=tatamotors.com";
    [self.window makeKeyAndVisible];
    return YES;
 

    // Override point for customization after application launch.
    /*
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
    splitViewController.delegate = (id)navigationController.topViewController;
    return YES;*/
}
-(void)createAlertWithTitle:(NSString*)title message:(NSString*)message
{
    self.alertProgress = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    UIActivityIndicatorView *loadingView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [loadingView startAnimating];
    loadingView.frame=CGRectMake(130.0f, 82.0f, 20.0f, 20.0f);
    [self.alertProgress addSubview:loadingView];
    [self.alertProgress show];
}
-(void)hideAlert
{
    [self.alertProgress dismissWithClickedButtonIndex:0 animated:YES];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
