//
//  NewsController.h
//  PDGesturedTableView
//
//  Created by Praveen Kumar on 02/12/2013.
//  Copyright (c) 2013 David Román Aguirre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFeedItem.h"

@class PBWebViewController,AsyncImageView;

@interface NewsController : UIViewController <UITableViewDataSource,UITableViewDelegate> {
    
    NSMutableArray *dataArr;
    NSString *contentStr;
    MWFeedItem *feeditm;
    CGFloat labelHeight;
    AsyncImageView *imageView;
    
    UITableView *tableview;
    
}

@property (strong, nonatomic) NSMutableArray * strings;
@property (strong, nonatomic) NSMutableArray * dataArr;

@property (strong, nonatomic) UINavigationBar * navigationBar;
@property (strong, nonatomic) PBWebViewController *webViewController;
@property (strong, nonatomic) NSString *contentStr;
@property (nonatomic) CGFloat labelHeight;

@end
