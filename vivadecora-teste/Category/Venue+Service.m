//
//  Venue+Service.m
//  vivadecora-teste
//
//  Created by Victor Barbosa on 9/24/16.
//  Copyright © 2016 Victor Barbosa. All rights reserved.
//

#import "Venue+Service.h"
#import "VSCoreDataEngine.h"

@implementation Venue (Service)

+ (Venue *)venue:(NSDictionary *)data {
    Venue *entity = nil;
    NSDecimalNumber *entity_id = [data valueForKeyPath:@"id"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id == %@", entity_id];
    NSArray *result = [[VSCoreDataEngine sharedInstance]
                       getAllObjectsForEntityName:@"Venue"
                       usingSortDescriptor:nil
                       andPredicate:predicate];
    
    if ([result count]) {
        entity = [result firstObject];
    } else {
        entity = [NSEntityDescription insertNewObjectForEntityForName:@"Venue" inManagedObjectContext:[[VSCoreDataEngine sharedInstance] getManagedObjectContext]];
        
        [entity setId:[NSNumber numberWithInteger:[[data valueForKey:@"id"] integerValue]]];
    }
    
    if ([data valueForKey:@"name"]) {
        [entity setName:[data valueForKey:@"name"]];
    }
    
    if ([data valueForKey:@"section"] && ![self isNull:[data valueForKey:@"section"]]) {
        [entity setSection:[data valueForKey:@"section"]];
    }
    
    if ([data valueForKey:@"seat"] && ![self isNull:[data valueForKey:@"seat"]]) {
        [entity setSeat:[data valueForKey:@"seat"]];
    }
    
    if ([data valueForKey:@"views"] && ![self isNull:[data valueForKey:@"views"]]) {
        [entity setViews:[NSNumber numberWithInteger:[[data valueForKey:@"views"] integerValue]]];
    }
    
    if ([data valueForKey:@"row"] && ![self isNull:[data valueForKey:@"row"]]) {
        [entity setRow:[data valueForKey:@"row"]];
    }
    
    if ([data valueForKey:@"home"] && ![self isNull:[data valueForKey:@"home"]]) {
        [entity setHome:[data valueForKey:@"home"]];
    }
    
    if ([data valueForKey:@"away"] && ![self isNull:[data valueForKey:@"away"]]) {
        [entity setAway:[data valueForKey:@"away"]];
    }
    
    if ([data valueForKey:@"note"] && ![self isNull:[data valueForKey:@"note"]]) {
        [entity setNote:[data valueForKey:@"note"]];
    }
    
    if ([data valueForKey:@"image_url"] && ![self isNull:[data valueForKey:@"image_url"]]) {
        if ([[entity imageUrl] length] > 0 &&
            ![[data valueForKey:@"image_url"] isEqualToString:[entity imageUrl]]) {
            [entity setImage:nil];
        }
        
        [entity setImageUrl:[data valueForKey:@"image_url"]];
    }
    
    if ([data valueForKey:@"address"] && ![self isNull:[data valueForKey:@"address"]]) {
        [entity setAddress:[data valueForKey:@"address"]];
    }
    
    if ([data valueForKey:@"city"] && ![self isNull:[data valueForKey:@"city"]]) {
        [entity setCity:[data valueForKey:@"city"]];
    }
    
    if ([data valueForKey:@"state"] && ![self isNull:[data valueForKey:@"state"]]) {
        [entity setState:[data valueForKey:@"state"]];
    }
    
    if ([data valueForKey:@"country"] && ![self isNull:[data valueForKey:@"country"]]) {
        [entity setCountry:[data valueForKey:@"country"]];
    }
    
    if ([data valueForKey:@"stats"] && ![self isNull:[data valueForKey:@"stats"]]) {
        [entity setStats:[data valueForKey:@"stats"]];
    }
    
    if ([data valueForKey:@"average_rating"] && ![self isNull:[data valueForKey:@"average_rating"]]) {
        [entity setAverageRating:[NSNumber numberWithFloat:[[data valueForKey:@"average_rating"] floatValue]]];
    }
    
    if ([data valueForKey:@"sameas"] && ![self isNull:[data valueForKey:@"sameas"]]) {
        [entity setSameas:[data valueForKey:@"sameas"]];
    }
    
    [[[VSCoreDataEngine sharedInstance] getManagedObjectContext] save:nil];
    
    return entity;
}

+ (void)setVenueImage:(Venue *)venue image:(NSData *)image {
    [venue setImage:image];
    
    [[[VSCoreDataEngine sharedInstance] getManagedObjectContext] save:nil];
}

+ (NSArray *)venueList {
    NSArray *result = [[VSCoreDataEngine sharedInstance]
                       getAllObjectsForEntityName:@"Venue"
                       usingSortDescriptor:nil
                       andPredicate:nil];
    
    return result;
}


+ (BOOL)isNull:(NSString *)value {
    if (value == (id)[NSNull null]) return YES;
    
    return NO;
}

@end
