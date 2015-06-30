//
//  MasterViewController.m
//  test
//
//  Created by Sebastian Boldt on 07.03.13.
//  Copyright (c) 2013 LetsIDev. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
@implementation MasterViewController

UITableViewCell *cell;
NSArray *tableData,*tableText;
UILabel *mainLabel;



- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.preferredContentSize = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}


- (void)viewDidAppear:(BOOL)animated
{
    /*
     NSLog(@"Jaduuu");
     if(![(AppDelegate*)[[UIApplication sharedApplication] delegate] authenticated])
     {
     NSLog(@"not authenticated, put up login screen.");
     UIStoryboard *storyboard;
     if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
     storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
     } else {
     storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
     }
     LoginViewController *vc =  (LoginViewController*)[storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
     [vc setModalPresentationStyle:UIModalTransitionStylePartialCurl];
     [self presentViewController:vc animated:NO completion:nil];
     }*/
    
    
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.tableView.layer.borderColor =  [UIColor colorWithRed:(4/255.0) green:(41/255.0) blue:(82/255.0) alpha:1].CGColor;
//    self.tableView.layer.borderWidth = 3.0f;
    tableData = [NSArray arrayWithObjects:@"WELCOME",@"DASHBOARD", @"CREATE OPPORTUNITY", @"MANAGE OPPORTUNITY", @"ACTIVITY",@"ANALYTICS",@"LOGOUT" ,nil];
   // [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header_strip.png"] forBarMetrics:UIBarMetricsDefault];
     [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header_strip1.png"] forBarMetrics:UIBarMetricsDefault];
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]
                             animated:NO
                       scrollPosition:UITableViewScrollPositionTop];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
   // NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
 //   NSLog(@"index Path %@",indexPath);
   // [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition: UITableViewScrollPositionNone];
    
    UIImage *img = [UIImage imageNamed:@"tml_logo.png"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,18,18)];
    [imgView setImage:img];
    // setContent mode aspect fit
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    self.navigationItem.titleView = imgView;
    
    if(IS_OS_8_OR_LATER)
    {
        NSLog(@"ios 8 ");
        _maximumPrimaryColumnWidth = 240;
        
        self.splitViewController.maximumPrimaryColumnWidth = _maximumPrimaryColumnWidth;
    }
    else
    {
        NSLog(@"ios 7");
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Enter..");
    
//    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds] ;
//    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:(178/255.0) green:(183/255.0) blue:(63/255.0) alpha:1];
    tableView.backgroundColor=[UIColor colorWithRed:(48/255.0) green:(57/255.0) blue:(58/255.0) alpha:1] ;
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds] ;
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:(105/255.0) green:(171/255.0) blue:(60/255.0) alpha:1];
    
//    UIImageView *av = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 277, 58)];
//    av.backgroundColor = [UIColor clearColor];
//    av.opaque = NO;
//    av.image = [UIImage imageNamed:@"active_tab.jpg"];
//    cell.selectedBackgroundView=av;    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:(178/255.0) green:(183/255.0) blue:(63/255.0) alpha:1];
    static NSString *CellIdentifier = @"Cell";
    cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
        cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

//    tableView.separatorColor =[UIColor colorWithRed:(1/255.0) green:(45/255.0) blue:(96/255.0) alpha:1];
    tableView.separatorColor =[UIColor colorWithRed:(59/255.0) green:(62/255.0) blue:(74/255.0) alpha:1];
    [tableView setContentOffset:tableView.contentOffset animated:NO];
    
    [tableView setSeparatorInset:UIEdgeInsetsZero];

    if(indexPath.row==0)
    {
        cell.userInteractionEnabled = NO;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.imageView.layer.cornerRadius = self.profileImageView.frame.size.width /6;
        cell.imageView.layer.borderWidth=3.0f;
        cell.imageView.layer.borderColor=[UIColor grayColor].CGColor;
        cell.imageView.clipsToBounds = YES;
        cell.imageView.image = [UIImage imageNamed:@"creme_brelee.jpg"];
        mainLabel= [[UILabel alloc] initWithFrame:CGRectMake(50.0, -15.0, 117.0,160.0)] ;
        mainLabel.text=@"    JIGNA JOSHI";
        //        cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
        mainLabel.font=[UIFont boldSystemFontOfSize:15];
        mainLabel.font = [UIFont systemFontOfSize:16.0];
        mainLabel.textAlignment = NSTextAlignmentRight;
        mainLabel.textColor =[UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1];
        [cell.contentView addSubview:mainLabel];
        
    }
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    //cell.backgroundColor = [UIColor colorWithRed:(1/255.0) green:(31/255.0) blue:(65/255.0) alpha:1] ;
    if(indexPath.row==0)
    {
        
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
        cell.imageView.frame = CGRectMake(cell.imageView.frame.origin.x, cell.imageView.frame.origin.y, 100, 100);
//        cell.textLabel.textColor=[UIColor colorWithRed:(178/255.0) green:(183/255.0) blue:(64/255.0) alpha:1];
          cell.textLabel.textColor=[UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
       // cell.backgroundColor = [UIColor colorWithRed:(11/255.0) green:(55/255.0) blue:(105/255.0) alpha:1];
        cell.backgroundColor = [UIColor colorWithRed:(36/255.0) green:(41/255.0) blue:(41/255.0) alpha:1];
      //  cell.backgroundColor=[UIColor redColor];
    }
    else
    {
//        UIImageView *av = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 277, 58)];
//        av.backgroundColor = [UIColor clearColor];
//        av.opaque = NO;
//        av.image = [UIImage imageNamed:@"normal_tab.jpg"];
//        cell.backgroundView=av;
      //  cell.backgroundColor = [UIColor colorWithRed:(1/255.0) green:(31/255.0) blue:(65/255.0) alpha:1] ;
           cell.backgroundColor = [UIColor colorWithRed:(48/255.0) green:(57/255.0) blue:(58/255.0) alpha:1] ;
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
        cell.textLabel.textColor=[UIColor colorWithRed:(216/255.0) green:(218/255.0) blue:(221/255.0) alpha:1];
//        cell.textLabel.highlightedTextColor = [UIColor colorWithRed:(0/255.0) green:(13/255.0) blue:(65/255.0) alpha:1];
         cell.textLabel.highlightedTextColor = [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds] ;
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:(178/255.0) green:(183/255.0) blue:(63/255.0) alpha:1];
    // cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:(48/255.0) green:(57/255.0) blue:(58/255.0) alpha:1];
    }
    
    // cell.backgroundColor = [UIColor colorWithHexString:@"#FFFFCC"];
    //cell.backgroundColor= [self colorWithHexString:@"FFFFFF"]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    //cell.backgroundColor=[UIColor clearColor];
    cell.backgroundColor = [UIColor colorWithRed:(178/255.0) green:(183/255.0) blue:(63/255.0) alpha:1];
    NSLog(@"Row index : %ld",(long)indexPath.row);
   // cell.textLabel.highlightedTextColor = [UIColor redColor];
   
    if (indexPath.row == 0) {
        
        cell.userInteractionEnabled = YES;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        NSLog(@"..");
        
        DetailViewController * dvc1 = [self.storyboard instantiateViewControllerWithIdentifier:@"view1"];
        self.splitViewController.viewControllers = [NSArray arrayWithObjects:[self.splitViewController.viewControllers objectAtIndex:0],dvc1,nil];
        self.splitViewController.delegate = dvc1;
    }
    else if(indexPath.row ==1)
    {
       
        DetailViewController * dvc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"view1"];
        self.splitViewController.viewControllers = [NSArray arrayWithObjects:[self.splitViewController.viewControllers objectAtIndex:0],dvc2,nil];
        self.splitViewController.delegate = dvc2;
         cell.backgroundColor=[UIColor redColor];
        
    }
    else if(indexPath.row == 2)
    {
        
        DetailViewController * dvc3 = [self.storyboard instantiateViewControllerWithIdentifier:@"view2"];
        self.splitViewController.viewControllers = [NSArray arrayWithObjects:[self.splitViewController.viewControllers objectAtIndex:0],dvc3,nil];
        self.splitViewController.delegate = dvc3;
         cell.backgroundColor=[UIColor redColor];
        
    }
    else if(indexPath.row == 3)
    {
       
        DetailViewController * dvc4 = [self.storyboard instantiateViewControllerWithIdentifier:@"viewmanage"];
        self.splitViewController.viewControllers = [NSArray arrayWithObjects:[self.splitViewController.viewControllers objectAtIndex:0],dvc4,nil];
        self.splitViewController.delegate = dvc4;
        
    }
    else if(indexPath.row == 4)
    {
        DetailViewController * dvc4 = [self.storyboard instantiateViewControllerWithIdentifier:@"activityList"];
        self.splitViewController.viewControllers = [NSArray arrayWithObjects:[self.splitViewController.viewControllers objectAtIndex:0],dvc4,nil];
        self.splitViewController.delegate = dvc4;
        
    }
    else if(indexPath.row ==5)
    {
        
        DetailViewController * dvc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"Analytics"];
        self.splitViewController.viewControllers = [NSArray arrayWithObjects:[self.splitViewController.viewControllers objectAtIndex:0],dvc2,nil];
        self.splitViewController.delegate = dvc2;
        
    }
    else if(indexPath.row ==6)
    {
         cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:(178/255.0) green:(183/255.0) blue:(63/255.0) alpha:1];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DSE"
                                           message:@"Do you want to Log out"
                                          delegate:self
                                 cancelButtonTitle:@"No"
                                 otherButtonTitles:@"Yes",nil];
        [alert show];

    }

    //  cell.backgroundColor = [UIColor colorWithRed:(178/255.0) green:(183/255.0) blue:(63/255.0) alpha:1];
    
}

- (BOOL)shouldAutorotate
{
    return YES;
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    //- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
    //{
    if (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation==UIInterfaceOrientationLandscapeRight)
        return YES;
    
   // return NO;
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft || interfaceOrientation==UIInterfaceOrientationLandscapeRight)
//        return YES;
//    
//    return NO;
//}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button Index =%ld",(long)buttonIndex);
    if (buttonIndex == 0) {
        
       
    }
    if (buttonIndex==1) {
      
        LoginViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        //[self.navigationController pushViewController:secondViewController animated:YES];
        [self presentViewController:secondViewController animated:YES completion:nil ];
        //  [self.navigationController popToRootViewControllerAnimated:TRUE];
        // [self dismissViewControllerAnimated:YES completion:nil];
        //  [self.parentViewController.navigationController popToRootViewControllerAnimated:YES];
        //  [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
