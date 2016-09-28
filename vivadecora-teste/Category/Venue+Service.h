//
//  Venue+Service.h
//  vivadecora-teste
//
//  Created by Victor Barbosa on 9/24/16.
//  Copyright © 2016 Victor Barbosa. All rights reserved.
//

#import "Venue.h"

@interface Venue (Service)

+ (Venue *)venue:(NSDictionary *)data;
+ (void)setVenueImage:(Venue *)venue image:(NSData *)image;
+ (NSArray *)venueList;

@end
