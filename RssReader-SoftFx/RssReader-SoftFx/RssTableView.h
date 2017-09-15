//
//  RssTableView.h
//  RssReader-SoftFx
//
//  Created by kiklevich Alex on 15.09.17.
//  Copyright © 2017 kiklevich Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RssTableView : UITableView <NSXMLParserDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong) NSXMLParser* xmlParcer;
@property (nonatomic, strong) NSMutableArray* feeds;

-(void)getNews :(NSString*)url :(BOOL)httpConnectionEnabled;
@end
