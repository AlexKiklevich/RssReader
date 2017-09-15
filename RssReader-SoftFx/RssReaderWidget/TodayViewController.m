//
//  TodayViewController.m
//  RssReaderWidget
//
//  Created by kiklevich Alex on 15.09.17.
//  Copyright © 2017 kiklevich Alex. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "WidgetView.h"

@interface TodayViewController () <NCWidgetProviding>
-(void)userDefaultsDidChange:(NSNotification *)notification;
@end

@implementation TodayViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(userDefaultsDidChange:)
                                                     name:NSUserDefaultsDidChangeNotification
                                                   object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    ((WidgetView*)self.view).parent = self;
    [self updateTimeLabelText];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

- (void)userDefaultsDidChange:(NSNotification *)notification {
    [self updateTimeLabelText];
}

- (void)updateTimeLabelText {
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.alexa.TodayExtensionSharingDefaults"];
    NSLog(@"%@",[NSString stringWithFormat:@"%@", [defaults objectForKey:@"lastTime"]]);
    self.pubDate.text = [NSString stringWithFormat:@"%@", [defaults objectForKey:@"lastTime"]];
}



@end
