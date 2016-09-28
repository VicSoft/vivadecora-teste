//
//  FeaturedListTableViewCell.h
//  vivadecora-teste
//
//  Created by Victor Barbosa on 9/23/16.
//  Copyright © 2016 Victor Barbosa. All rights reserved.
//

#import "DummyVenueView.h"
#import "DummyVenueDetailView.h"
#import <UIKit/UIKit.h>

@class DummyVenueView, DummyVenueDetailView;

@interface FeaturedListTableViewCell : UITableViewCell

@property (strong, nonatomic) DummyVenueView *dummyVenueView;
@property (strong, nonatomic) DummyVenueDetailView *dummyVenueDetailView;

@end
