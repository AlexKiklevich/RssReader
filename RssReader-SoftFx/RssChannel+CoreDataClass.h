//
//  RssChannel+CoreDataClass.h
//  RssReader-SoftFx
//
//  Created by kiklevich Alex on 15.09.17.
//  Copyright © 2017 kiklevich Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item;

NS_ASSUME_NONNULL_BEGIN

@interface RssChannel : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "RssChannel+CoreDataProperties.h"
