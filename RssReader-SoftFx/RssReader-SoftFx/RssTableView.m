//
//  RssTableView.m
//  RssReader-SoftFx
//
//  Created by kiklevich Alex on 15.09.17.
//  Copyright © 2017 kiklevich Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RssTableView.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "RssItem.h"
#import "RssTableViewCell.h"
#import "RssChannel+CoreDataProperties.h"
#import "Item+CoreDataProperties.h"

@interface RssTableView ()
@property NSString* element;
@property RssItem* bufItem;
@property RssChannel* managedChannel;
@end

@implementation RssTableView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */



-(void)getNews:(NSString *)url :(BOOL)httpConnectionEnabled
{
    self.dataSource = self;
    self.feeds = [[NSMutableArray alloc]init];
    self.managedObjectContext = (((AppDelegate*)[UIApplication sharedApplication].delegate)).managedObjectContext;
    
    NSFetchRequest *request=[[NSFetchRequest alloc] initWithEntityName:@"RssChannel"];
    NSError* error;
    NSArray* channels = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if (httpConnectionEnabled) {
        if (channels.count > 0)
        {
            for (RssChannel* channel in channels)
            {
                if ([url isEqualToString:[channel valueForKey:@"title"]] == YES)
                {
                    self.managedChannel = channel;
                }
                else
                {
                    self.managedChannel = [NSEntityDescription insertNewObjectForEntityForName:@"RssChannel"
                                                                        inManagedObjectContext:self.managedObjectContext];
                    self.managedChannel.title = url;
                }
            }
        }
        else
        {
            self.managedChannel = [NSEntityDescription insertNewObjectForEntityForName:@"RssChannel"
                                                                inManagedObjectContext:self.managedObjectContext];
            self.managedChannel.title = url;
        }
        [self parseData:url];
        
        dispatch_async(dispatch_get_global_queue((NSInteger)QOS_CLASS_DEFAULT, 0), ^{
            [self sendLastTime];
        });
    }
    else{
        if (channels.count > 0)
        {
            for (RssChannel* channel in channels)
            {
                if ([url isEqualToString:[channel valueForKey:@"title"]] == YES)
                {
                    self.managedChannel = channel;
                }
            }
            NSSet* items = [self.managedChannel valueForKey:@"rssItems"];
            for (Item* item in items)
            {
                self.bufItem = [[RssItem alloc] initItemWithNews:[item valueForKey:@"titel"] :[item valueForKey:@"pubDate"] :[item valueForKey:@"newsText"]];
                [self.feeds addObject:self.bufItem];
            }
            __weak RssTableView* weakself = self;
            dispatch_async(dispatch_get_main_queue(),
                           ^{
                               [weakself reloadData];
                           });
        }
    }
    
}

-(void)parseData :(NSString*)url
{
    self.xmlParcer = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
    [self.xmlParcer setDelegate:self];
    [self.xmlParcer setShouldResolveExternalEntities:NO];
    [self.xmlParcer parse];
}

-(void)sendLastTime
{
    NSLocale* currentLocale = [NSLocale currentLocale];
    [[NSDate date] descriptionWithLocale:currentLocale];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.alexa.TodayExtensionSharingDefaults"];
    [sharedDefaults setObject:[dateFormatter stringFromDate:[NSDate date]] forKey:@"lastTime"];
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.feeds.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RssTableViewCell* cell = [self dequeueReusableCellWithIdentifier:@"RssTableViewCell" forIndexPath:indexPath];
    cell.title.text = ((RssItem*)([self.feeds objectAtIndex:indexPath.row])).title;
    cell.pubDate.text = ((RssItem*)([self.feeds objectAtIndex:indexPath.row])).time;
    cell.newsText.text = ((RssItem*)([self.feeds objectAtIndex:indexPath.row])).newsText;
    return cell;
}

#pragma mark - NSXmlParcerDelegate functions

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    self.element = elementName;
    if ([self.element isEqualToString:@"item"])
    {
        self.bufItem = [[RssItem alloc] initItem];
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([self.element isEqualToString:@"title"]) {
        self.bufItem.title = string;
    }
    if ([self.element isEqualToString:@"pubDate"]) {
        self.bufItem.time = string;
    }
    if ([self.element isEqualToString:@"description"]) {
        [self.bufItem.newsText appendString:string];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"item"])
    {
        [self.feeds addObject:self.bufItem];
        __weak RssTableView* weakself = self;
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           [weakself reloadData];
                       });
    }
}

-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        for(RssItem* rssItem in self.feeds)
        {
            Item* managedItem = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:self.managedObjectContext];
            managedItem.titel = rssItem.title;
            managedItem.pubDate = rssItem.time;
            managedItem.newsText = rssItem.newsText;
            managedItem.rssChannel = self.managedChannel;
            [self.managedChannel addRssItemsObject:managedItem];
        }
        NSLog(@"%@", [self.managedChannel valueForKey:@"title"]);
        if([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:nil]){
            NSLog(@"Unresolved error in save!");
            abort();
        }
        else{
            NSLog(@"cool");
        }
    });
}

@end

