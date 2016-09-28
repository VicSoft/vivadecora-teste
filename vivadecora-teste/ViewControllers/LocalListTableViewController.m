//
//  LocalListTableViewController.m
//  vivadecora-teste
//
//  Created by Victor Barbosa on 9/23/16.
//  Copyright © 2016 Victor Barbosa. All rights reserved.
//

#import "LocalListTableViewController.h"
#import "Venue+Service.h"
#import "FeaturedListTableViewCell.h"
#import "AppDelegate.h"
#import "VenueDetailsTableViewController.h"

@interface LocalListTableViewController ()

@property (nonatomic, strong) NSArray *venueList;
@property (nonatomic, strong) NSThread *requestThread;

@end

@implementation LocalListTableViewController

static NSString *identifier = @"venueDetails";

#pragma mark - Class methods

- (void)makeRequest {
    [self makeGETRequest:[BASE_URL stringByAppendingString:BASE_URL_DATA_LIST] completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        long responseStatusCode = [((NSHTTPURLResponse *) response) statusCode];
        
        if (error) {
            [self showAlertMessage:@"" message:@"Connection Error!" cancelTitle:@"Cancel" anotherTitle:@"Try it again"];
        }
        
        if (responseStatusCode == 200) {
            if ([[responseObject objectForKey:@"avfms"] count]) {
                
                for (NSDictionary *data in [responseObject objectForKey:@"avfms"]) {
                    [Venue venue:@{
                                   @"id" : [data valueForKey:@"venue_id"],
                                   @"name" : [data valueForKey:@"venue"],
                                   @"section" : [data valueForKey:@"section"],
                                   @"seat" : [data valueForKey:@"seat"],
                                   @"views" : [data valueForKey:@"views"],
                                   @"row" : [data valueForKey:@"row"],
                                   @"home" : [data valueForKey:@"home"],
                                   @"away" : [data valueForKey:@"away"],
                                   @"note" : [data valueForKey:@"note"],
                                   @"image_url" : [data valueForKey:@"image"]
                                   }];
                }
                
                self.venueList = [Venue venueList];
                
                [[self tableView] reloadData];
            }
        }
        
        [SVProgressHUD dismiss];
    }];

}

#pragma mark - ViewController's lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setContentInset:UIEdgeInsetsMake(-20, 0, 0, 0)];
    
    self.venueList = [Venue venueList];
    
    if ([self.venueList count] == 0) {
        [SVProgressHUD show];
    }
    
    [[self tableView] reloadData];
    [self performSelectorInBackground:@selector(makeRequest) withObject:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [SVProgressHUD show];
        [self makeRequest];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.venueList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeaturedListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[FeaturedListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    Venue *entity = [self.venueList objectAtIndex:indexPath.section];
    
    [cell.dummyVenueView removeFromSuperview];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    cell.dummyVenueView = [[DummyVenueView alloc] initWithVenue:entity usingFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    
    [cell addSubview:cell.dummyVenueView];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([AppDelegate isIPad]) {
        return 320.0;
    }
    
    return 220.0;
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:identifier] &&
        [segue.destinationViewController isKindOfClass:[VenueDetailsTableViewController class]]) {
        FeaturedListTableViewCell *cell = sender;
        VenueDetailsTableViewController *venueDetailsViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        venueDetailsViewController.venue = ((Venue *)[self.venueList objectAtIndex:indexPath.section]);
    }
}

@end
