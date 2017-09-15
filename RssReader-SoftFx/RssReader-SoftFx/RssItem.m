//
//  RssItem.m
//  RssReader-SoftFx
//
//  Created by kiklevich Alex on 15.09.17.
//  Copyright © 2017 kiklevich Alex. All rights reserved.
//

#import "RssItem.h"

@implementation RssItem
-(instancetype)initItem
{
    if (self = [super init])
    {
        self.newsText = [[NSMutableString alloc] init];
        return self;
    }
    return  nil;
}
-(instancetype)initItemWithNews:(NSString *)title :(NSString *)time :(NSMutableString *)newstext
{
    if (self = [self initItem])
    {
        self.time = time;
        self.title = title;
        self.newsText = newstext;
        return self;
    }
    return nil;
}
@end
