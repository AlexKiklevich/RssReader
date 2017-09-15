//
//  SecondViewController.m
//  RssReader-SoftFx
//
//  Created by kiklevich Alex on 15.09.17.
//  Copyright © 2017 kiklevich Alex. All rights reserved.
//

#import "SecondViewController.h"
#import "Reachability.h"
#import "RssTableView.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable) {
        NSLog(@"There IS NO internet connection");
        __weak RssTableView* weakTableView = self.rssTableView;
        dispatch_async(dispatch_get_global_queue((NSInteger)QOS_CLASS_USER_INTERACTIVE, 0), ^{
            [weakTableView getNews:@"https://widgets.spotfxbroker.com:8088/GetLiveNewsRss" :NO];
        });
    } else {
        NSLog(@"There IS internet connection");
        __weak RssTableView* weakTableView = self.rssTableView;
        dispatch_async(dispatch_get_global_queue((NSInteger)QOS_CLASS_USER_INTERACTIVE, 0), ^{
            [weakTableView getNews:@"https://widgets.spotfxbroker.com:8088/GetLiveNewsRss" :YES];
        });
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
