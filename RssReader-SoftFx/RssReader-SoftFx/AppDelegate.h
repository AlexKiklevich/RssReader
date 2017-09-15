//
//  AppDelegate.h
//  RssReader-SoftFx
//
//  Created by kiklevich Alex on 15.09.17.
//  Copyright © 2017 kiklevich Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *coordinator;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

