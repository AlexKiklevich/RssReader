//
//  WidgetView.h
//  RssReader-SoftFx
//
//  Created by kiklevich Alex on 15.09.17.
//  Copyright © 2017 kiklevich Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodayViewController.h"

@interface WidgetView : UIView
@property(weak, nonatomic) TodayViewController* parent;
@end
