//
//  VenueDetailsTableViewController.h
//  vivadecora-teste
//
//  Created by Victor Barbosa on 9/26/16.
//  Copyright © 2016 Victor Barbosa. All rights reserved.
//

#import "MainTableViewController.h"
#import "Venue+Service.h"
#import <UIKit/UIKit.h>

@interface VenueDetailsTableViewController : MainTableViewController

@property (nonatomic, strong) Venue *venue;

@end
