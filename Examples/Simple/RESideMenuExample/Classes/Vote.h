//
//  Vote.h
//  RESideMenuExample
//
//  Created by Praveen Kumar on 08/03/2014.
//  Copyright (c) 2014 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PBWebViewController;


@interface Vote : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (strong, nonatomic) PBWebViewController *webViewController;


@end
