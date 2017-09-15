//
//  RssTableViewCell.h
//  RssReader-SoftFx
//
//  Created by kiklevich Alex on 15.09.17.
//  Copyright © 2017 kiklevich Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RssTableViewCell : UITableViewCell 
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *pubDate;
@property (strong, nonatomic) IBOutlet UITextField *newsText;


@end
