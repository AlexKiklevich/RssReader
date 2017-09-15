//
//  FirstViewController.m
//  RssReader-SoftFx
//
//  Created by kiklevich Alex on 15.09.17.
//  Copyright © 2017 kiklevich Alex. All rights reserved.
//

#import "FirstViewController.h"
#import "Reachability.h"
#import "RssTableView.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable) {
        NSLog(@"There IS NO internet connection");
        __weak RssTableView* weakTableView = self.rssTableView;
        dispatch_async(dispatch_get_global_queue((NSInteger)QOS_CLASS_USER_INTERACTIVE, 0), ^{
            [weakTableView getNews:@"https://widgets.spotfxbroker.com:8088/GetAnalyticsRss" :NO];
        });
    } else {
        NSLog(@"There IS internet connection");
        __weak RssTableView* weakTableView = self.rssTableView;
        dispatch_async(dispatch_get_global_queue((NSInteger)QOS_CLASS_USER_INTERACTIVE, 0), ^{
            [weakTableView getNews:@"https://widgets.spotfxbroker.com:8088/GetAnalyticsRss" :YES];
        });
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
