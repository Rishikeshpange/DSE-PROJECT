//
//  ProductTableviewController.m
//  DSE
//
//  Created by Rishikesh on 02/04/15.
//  Copyright (c) 2015 LetsIDev. All rights reserved.
//

#import "ProductTableviewController.h"

@interface ProductTableviewController ()

@end

@implementation ProductTableviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.items == nil) {
        self.items = [NSMutableArray arrayWithObjects:@"PL",@"LPT709",@"LPT1613TC",@"Ace FBV",@"LPTA715TC FBV",@"Ace",@"Ace HT",@"LPT1615",@"LPY1616 FBV",@"1SA1313 FBV",@"SE1615TC",nil];
        
        self.colorArray = [NSMutableArray arrayWithObjects:[UIColor colorWithRed:231/255.0 green:63/255.0 blue:114/255.0 alpha:1],[UIColor colorWithRed:54/255.0 green:172/255.0 blue:221/255.0 alpha:1],[UIColor colorWithRed:127/255.0 green:197/255.0 blue:0/255.0 alpha:1],[UIColor colorWithRed:230/255.0 green:144/255.0 blue:0/255.0 alpha:1],[UIColor colorWithRed:231/255.0 green:63/255.0 blue:114/255.0 alpha:1],[UIColor colorWithRed:54/255.0 green:172/255.0 blue:221/255.0 alpha:1],[UIColor colorWithRed:230/255.0 green:144/255.0 blue:0/255.0 alpha:1],[UIColor colorWithRed:54/255.0 green:172/255.0 blue:221/255.0 alpha:1],[UIColor colorWithRed:127/255.0 green:197/255.0 blue:0/255.0 alpha:1],[UIColor colorWithRed:54/255.0 green:172/255.0 blue:221/255.0 alpha:1],[UIColor colorWithRed:127/255.0 green:197/255.0 blue:0/255.0 alpha:1],nil];
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.items count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"MyIdentifier";
    static NSString *CellIdentifier1 = @"Analyticsdentifier";
    
    Analyticstableviewcell *cell = (Analyticstableviewcell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (cell == nil)
    {
        cell = [[Analyticstableviewcell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:CellIdentifier1];
    }
  cell.ProductNameLabel.text=[NSString stringWithFormat:@"%@" ,[self.items objectAtIndex:indexPath.row]];
    cell.StatusImage.backgroundColor=[self.colorArray objectAtIndex:indexPath.row];
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewStylePlain reuseIdentifier:@"MyIdentifier"];
//    }
//    cell.textLabel.text = [NSString stringWithFormat:@"1.%@" ,[items objectAtIndex:indexPath.row]];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
