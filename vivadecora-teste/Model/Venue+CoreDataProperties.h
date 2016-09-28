//
//  Venue+CoreDataProperties.h
//  vivadecora-teste
//
//  Created by Victor Barbosa on 9/25/16.
//  Copyright © 2016 Victor Barbosa. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Venue.h"

NS_ASSUME_NONNULL_BEGIN

@interface Venue (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *address;
@property (nullable, nonatomic, retain) NSNumber *averageRating;
@property (nullable, nonatomic, retain) NSString *away;
@property (nullable, nonatomic, retain) NSString *city;
@property (nullable, nonatomic, retain) NSString *country;
@property (nullable, nonatomic, retain) NSString *home;
@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *note;
@property (nullable, nonatomic, retain) NSString *row;
@property (nullable, nonatomic, retain) NSString *sameas;
@property (nullable, nonatomic, retain) NSString *seat;
@property (nullable, nonatomic, retain) NSString *section;
@property (nullable, nonatomic, retain) NSString *state;
@property (nullable, nonatomic, retain) NSString *stats;
@property (nullable, nonatomic, retain) NSNumber *views;
@property (nullable, nonatomic, retain) NSString *imageUrl;
@property (nullable, nonatomic, retain) NSData *image;

@end

NS_ASSUME_NONNULL_END
