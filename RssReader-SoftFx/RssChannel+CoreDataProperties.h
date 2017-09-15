//
//  RssChannel+CoreDataProperties.h
//  RssReader-SoftFx
//
//  Created by kiklevich Alex on 15.09.17.
//  Copyright © 2017 kiklevich Alex. All rights reserved.
//

#import "RssChannel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface RssChannel (CoreDataProperties)

+ (NSFetchRequest<RssChannel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, retain) NSSet<Item *> *rssItems;

@end

@interface RssChannel (CoreDataGeneratedAccessors)

- (void)addRssItemsObject:(Item *)value;
- (void)removeRssItemsObject:(Item *)value;
- (void)addRssItems:(NSSet<Item *> *)values;
- (void)removeRssItems:(NSSet<Item *> *)values;

@end

NS_ASSUME_NONNULL_END
