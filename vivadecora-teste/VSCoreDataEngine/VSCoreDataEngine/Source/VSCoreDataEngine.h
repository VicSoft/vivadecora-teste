//
//  VSCoreDataEngine.h
//
//  Created by Victor Barbosa on 7/22/14.
//  Copyright (c) 2014 VicSoft. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface VSCoreDataEngine : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (id)sharedInstance;

- (NSArray*)getAllObjectsForEntityName:(NSString*)entityName
                   usingSortDescriptor:(NSSortDescriptor*)sortDescriptor
                          andPredicate:(NSPredicate*)predicate;
- (NSArray*)getObjectsForEntityName:(NSString*)entityName
                usingSortDescriptor:(NSSortDescriptor*)sortDescriptor
                       andPredicate:(NSPredicate*)predicate limit:(NSInteger)limit;

- (BOOL)saveContext;

- (NSManagedObjectContext *)getManagedObjectContext;

- (NSManagedObjectModel *)getManagedObjectModel;

+ (void)deleteAllObjects:(NSString *)entityDescription;
+ (void)deleteObject:(id)managedObject;

@end
