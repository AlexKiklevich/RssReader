//
//  RssChannel+CoreDataProperties.m
//  RssReader-SoftFx
//
//  Created by kiklevich Alex on 15.09.17.
//  Copyright © 2017 kiklevich Alex. All rights reserved.
//

#import "RssChannel+CoreDataProperties.h"

@implementation RssChannel (CoreDataProperties)

+ (NSFetchRequest<RssChannel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"RssChannel"];
}

@dynamic title;
@dynamic rssItems;

@end
