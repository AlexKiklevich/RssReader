//
//  RssItem.h
//  RssReader-SoftFx
//
//  Created by kiklevich Alex on 15.09.17.
//  Copyright © 2017 kiklevich Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RssItem : NSObject
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* time;
@property (nonatomic, strong) NSMutableString* newsText;
-(instancetype)initItem;
-(instancetype)initItemWithNews :(NSString*)title :(NSString*)time :(NSString*)newstext;
-(instancetype)init NS_UNAVAILABLE;
@end
