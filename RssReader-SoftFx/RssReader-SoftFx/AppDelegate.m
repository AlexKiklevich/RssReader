//
//  AppDelegate.m
//  RssReader-SoftFx
//
//  Created by kiklevich Alex on 15.09.17.
//  Copyright © 2017 kiklevich Alex. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.coordinator = [self initializePersistentStoreCoordinator];
    [self initializeContext];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - CoreData ManagedObject service
- (void)initializeContext
{
    NSPersistentStoreCoordinator *storeCoordinator = self.coordinator;
    
    if(nil != storeCoordinator){
        self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [self.managedObjectContext setPersistentStoreCoordinator:storeCoordinator];
    }
}

- (NSManagedObjectModel *)initializemanagedObjectModel
{
    self.managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    return self.managedObjectModel;
}

- (NSPersistentStoreCoordinator *)initializePersistentStoreCoordinator
{
    NSURL *storeURLAnalytics = [[[[NSFileManager defaultManager]
                                  URLsForDirectory:NSDocumentDirectory
                                  inDomains:NSUserDomainMask]
                                 lastObject]
                                URLByAppendingPathComponent:@"`DataBase.sqlite"];
    
    
    NSPersistentStoreCoordinator* coordinator = [[NSPersistentStoreCoordinator alloc]
                                                 initWithManagedObjectModel:[self initializemanagedObjectModel]];
    
    NSError *error = nil;
    if(![coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                  configuration:nil
                                            URL:storeURLAnalytics
                                        options:nil
                                          error:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    
    return coordinator;
}

@end
