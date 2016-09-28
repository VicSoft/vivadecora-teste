//
//  VenueDetailsTableViewController.m
//  vivadecora-teste
//
//  Created by Victor Barbosa on 9/26/16.
//  Copyright © 2016 Victor Barbosa. All rights reserved.
//

#import "VenueDetailsTableViewController.h"
#import "FeaturedListTableViewCell.h"
#import "AppDelegate.h"

@interface VenueDetailsTableViewController ()

@end

@implementation VenueDetailsTableViewController

static NSString *identifier = @"venue";

#pragma mark - Class methods

- (void)makeRequest {
    NSString *endUrlDetails = [BASE_URL_DATA_DETAILS stringByAppendingString:[[self.venue name] stringByAppendingString:@"&info=true"]];
    NSString *fullUrl = [[BASE_URL stringByAppendingString:endUrlDetails] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self makeGETRequest:fullUrl completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        long responseStatusCode = [((NSHTTPURLResponse *) response) statusCode];
        
        if (error) {
            [self showAlertMessage:@"" message:@"Connection Error!" cancelTitle:@"Cancel" anotherTitle:@"Try it again"];
        }
        
        if (responseStatusCode == 200) {
            
            if ([[responseObject objectForKey:@"avfms"] count]) {
                for (NSDictionary *data in [responseObject objectForKey:@"avfms"]) {
                    self.venue = [Venue venue:@{
                                                @"id" : [data valueForKey:@"venue_id"],
                                                @"name" : [data valueForKey:@"name"],
                                                @"address" : [data valueForKey:@"address"],
                                                @"city" : [data valueForKey:@"city"],
                                                @"state" : [data valueForKey:@"state"],
                                                @"country" : [data valueForKey:@"country"],
                                                @"stats" : [data valueForKey:@"stats"],
                                                @"average_rating" : [data valueForKey:@"average_rating"],
                                                @"sameas" : [data valueForKey:@"sameas"]
                                                }];
                }
                
                [self.tableView reloadData];
            }
        }
        
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - ViewController's lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setContentInset:UIEdgeInsetsMake(-36, 0, 0, 0)];
    
    NSString *pageTitle = [self.venue name];
    
    if ([pageTitle length] > 15) {
        NSRange range = [pageTitle rangeOfComposedCharacterSequencesForRange:(NSRange){0, 15}];
        pageTitle = [pageTitle substringWithRange:range];
        pageTitle = [pageTitle stringByAppendingString:@"…"];
    }
    
    [self.navigationItem setTitle:pageTitle];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeaturedListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[FeaturedListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    [cell.dummyVenueDetailView removeFromSuperview];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    cell.dummyVenueDetailView = [[DummyVenueDetailView alloc] initWithVenue:self.venue usingFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    
    [cell addSubview:cell.dummyVenueDetailView];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([AppDelegate isIPad]) {
        return 520.0;
    }
    
    return 420.0;
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
