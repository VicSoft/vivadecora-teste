//
//  VSCoreDataEngine.m
//
//  Created by Victor Barbosa on 7/22/14.
//  Copyright (c) 2014 VicSoft. All rights reserved.
//

#import "VSCoreDataEngine.h"
#import <CoreData/CoreData.h>

#warning Edit CoreData Model Name
#define kCoreDataModelName @""

@implementation VSCoreDataEngine

@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

static VSCoreDataEngine *SINGLETON = nil;
static bool isFirstAccess = YES;
static NSManagedObjectContext *managedObjectContext;
static NSManagedObjectModel* managedObjectModel;

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];
        [SINGLETON initCoreDataVars];
    });
    
    return SINGLETON;
}

- (void)initCoreDataVars {

    managedObjectModel = [self managedObjectModel];
    managedObjectContext = [self managedObjectContext];
    if (!managedObjectContext) {
        // Handle the error.
        NSLog(@"[E]No Managed Object Context");
    }
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Core Data stack

- (NSManagedObjectContext *)getManagedObjectContext {
    return managedObjectContext;
}

- (NSManagedObjectModel *)getManagedObjectModel {
    return managedObjectModel;
}

- (BOOL)saveContext {
    
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            return NO;
        }
    }
    
    return YES;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (__managedObjectContext != nil) {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        __managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
        
    }
    return __managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (__managedObjectModel != nil) {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:kCoreDataModelName withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (__persistentStoreCoordinator != nil) {
        return __persistentStoreCoordinator;
    }
    
    NSString *storePath = [NSString stringWithFormat:@"%@.sqlite",kCoreDataModelName];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:storePath];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        abort();
    }
    
    return __persistentStoreCoordinator;
}

- (NSArray*)getAllObjectsForEntityName:(NSString*)entityName
                   usingSortDescriptor:(NSSortDescriptor*)sortDescriptor
                          andPredicate:(NSPredicate*)predicate {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    
    [request setEntity:entity];
    [request setReturnsDistinctResults:YES];
    
    if( sortDescriptor != nil ) {
        NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
        [request setSortDescriptors:sortDescriptors];
    }
    
    if( predicate != nil ) {
        [request setPredicate:predicate];
    }
    
    NSError *error = nil;
    
    NSArray *mutableFetchResults = [managedObjectContext executeFetchRequest:request error:&error];
    if( mutableFetchResults == nil ) {
        NSLog(@"error gathering objects from entity %@: \n%@", entityName, error);
    }
    
    return mutableFetchResults;
}

- (NSArray*)getObjectsForEntityName:(NSString*)entityName
                   usingSortDescriptor:(NSSortDescriptor*)sortDescriptor
                       andPredicate:(NSPredicate*)predicate limit:(NSInteger)limit {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    
    [request setEntity:entity];
    [request setReturnsDistinctResults:YES];
    [request setFetchLimit:limit];
    
    if( sortDescriptor != nil ) {
        NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
        [request setSortDescriptors:sortDescriptors];
    }
    
    if( predicate != nil ) {
        [request setPredicate:predicate];
    }
    
    NSError *error = nil;
    
    NSArray *mutableFetchResults = [managedObjectContext executeFetchRequest:request error:&error];
    if( mutableFetchResults == nil ) {
        NSLog(@"error gathering objects from entity %@: \n%@", entityName, error);
    }
    
    return mutableFetchResults;
}

+ (void)deleteAllObjects:(NSString *)entityDescription {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityDescription inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *items = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    
    for (NSManagedObject *managedObject in items) {
        [managedObjectContext deleteObject:managedObject];
    }
    
    if (![managedObjectContext save:&error]) {
    }
    
}

+ (void)deleteObject:(id)managedObject {
    NSError *error;
    
    [managedObjectContext deleteObject:(NSManagedObject *)managedObject];
    
    if (![managedObjectContext save:&error]) {
    }
    
}

@end
