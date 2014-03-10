//
//  NewsController.m
//  PDGesturedTableView
//
//  Created by Praveen Kumar on 02/12/2013.
//  Copyright (c) 2013 David Román Aguirre. All rights reserved.
//

#import "NewsController.h"
#import "MWFeedItem.h"
#import "NSString+HTML.h"
#import "DataClass.h"
#import "AsyncImageView.h"
#import "PBWebViewController.h"
#import "PBSafariActivity.h"
#import "AsyncImageView.h"
#import "UIScrollView+APParallaxHeader.h"
#import "UIImage+BlurredFrame.h"


@interface NewsController ()
{
    BOOL parallaxWithView;
}
@end



@implementation NewsController

@synthesize dataArr,contentStr=_contentStr,labelHeight;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.strings = [NSMutableArray new];
        self.dataArr = [[NSMutableArray alloc] init];
//        self.navigationBar = [UINavigationBar new];
        //add AsyncImageView to cell
        imageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, 0.0f)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.title = feeditm.title;

    
//    [self.view.layer setCornerRadius:4.5];
//    [self.view.layer setMasksToBounds:YES];
//    [self.view setBackgroundColor:[UIColor clearColor]];
    

//    [self.view addSubview:self.navigationBar];
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (screenSize.height > 480.0f) {
            tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 576) style:  UITableViewStylePlain];
        } else {
            tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) style:  UITableViewStylePlain];
        }
    } else {
        /*Do iPad stuff here.*/
    }
    
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self.view addSubview:tableview];

//    [tableview setContentOffset:CGPointMake(0, -44) animated:YES];

    if ([[dataArr objectAtIndex:0] isKindOfClass:[MWFeedItem class]]) {
        feeditm = [dataArr objectAtIndex:0];
    } else{
        feeditm = [[dataArr objectAtIndex:0] objectAtIndex:0];
    }
    self.navigationItem.title = feeditm.title;


    _contentStr = feeditm.summary;
    
    if ([_contentStr length] == 0) {
        [dataArr removeObjectAtIndex:0];
        [dataArr addObject:feeditm];        
        feeditm = [dataArr objectAtIndex:0];
        _contentStr = feeditm.summary;

    }
    
    // UILabel *myLabel;
    
//    CGSize labelSize = [[feeditm.summary stringByConvertingHTMLToPlainText] sizeWithFont:[UIFont fontWithName:@"Signika-Light" size:16]
//                                   constrainedToSize:CGSizeMake(300, 5000)
//                                    lineBreakMode:NSLineBreakByWordWrapping];
    
    CGRect labelRect = [[feeditm.summary stringByConvertingHTMLToPlainText]
                        boundingRectWithSize:CGSizeMake(296, 5000)
                        options:NSStringDrawingUsesLineFragmentOrigin
                        attributes:@{
                                     NSFontAttributeName : [UIFont fontWithName:@"Signika-Light" size:15]
                                     }
                        context:nil];
    
    self.labelHeight = labelRect.size.height;
    
    
    
  

//    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"with view" style:UIBarButtonItemStylePlain target:self action:@selector(toggle:)];
//    [self.navigationItem setRightBarButtonItem:barButton];
//    
    [self toggle:nil];

    
    
    

    
    
}

- (void)toggle:(id)sender
{
    if(parallaxWithView == NO)
    {
        
//        NSLog(@"feeditm.enclosures...%@",feeditm.enclosures);
        
        if ([feeditm.enclosures count] > 0) {
            //        NSLog(@"feeditm encolusure....%@",item.enclosures);
            
            for (int k = 0; k < 1; k ++) {
                NSDictionary *dict = [feeditm.enclosures objectAtIndex:k];
                if ([[dict valueForKey:@"type"] isEqualToString:@"image/jpg"]) {
//                    imageView.frame = CGRectMake(0, 54, 320, 160);
                    imageView.tag =  1;
                    imageView.imageURL = [NSURL URLWithString:[dict valueForKey:@"url"]];                break;
                } else if ([[dict valueForKey:@"type"] isEqualToString:@"image/jpeg"]) {
//                    imageView.frame = CGRectMake(0, 54, 320, 160);
                    imageView.tag =  1;
                    imageView.imageURL = [NSURL URLWithString:[dict valueForKey:@"url"]];                break;
                } else if ([[dict valueForKey:@"type"] isEqualToString:@"image/png"]) {
//                    imageView.frame = CGRectMake(0, 54, 320, 160);
                    imageView.tag =  1;
                    imageView.imageURL = [NSURL URLWithString:[dict valueForKey:@"url"]];                break;
                } else if ([[dict valueForKey:@"type"] isEqualToString:@"image/gif"]) {
//                    imageView.frame = CGRectMake(0, 54, 320, 160);
                    imageView.tag =  1;
                    imageView.imageURL = [NSURL URLWithString:[dict valueForKey:@"url"]];                break;
                } else if ([[dict valueForKey:@"type"] isEqualToString:@"image/tiff"]) {
//                    imageView.frame = CGRectMake(0, 54, 320, 160);
                    imageView.tag =  1;
                    imageView.imageURL = [NSURL URLWithString:[dict valueForKey:@"url"]];                break;
                }
            }
        
        imageView.frame = CGRectMake(0, 20, 320, 160);
        
        
        
        // add parallax with view

        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        [tableview addParallaxWithView:imageView andHeight:160];
        parallaxWithView = YES;
        }
    }
    else
    {

    }
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    
        return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    if (section == 0) {
        return 1;
    } else{
        if ([[dataArr objectAtIndex:0] isKindOfClass:[MWFeedItem class]]) {
            return 1;
        } else{
            return [dataArr count];
        }
    }
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.labelHeight + 30 ;
    } else {
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        
        if(indexPath.section == 0) {
                CGRect lblRect = CGRectMake(12, 5,296, labelHeight + 20 );
                UILabel *descLabel = [[UILabel alloc] initWithFrame:lblRect];
                descLabel.textColor = [UIColor blackColor];
                descLabel.backgroundColor = [UIColor clearColor];
                descLabel.text = [feeditm.summary stringByConvertingHTMLToPlainText];
                descLabel.font =[UIFont fontWithName:@"Signika-Light" size:15];
                descLabel.numberOfLines = 500;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell.contentView addSubview:descLabel];
                //            cell.backgroundColor = [UIColor colorWithRed:0.62 green:0.86 blue:0.93 alpha:0.25];
            
        } else{

//                cell.textLabel.text = [NSString stringWithFormat:@"Read from %@",[[[DataClass class] sharedManager] getChannelNameFromLink:feeditm.link]];
//                [cell.textLabel setFont:[UIFont fontWithName:@"Signika-Regular" size:16]];
//                [cell.textLabel setTextColor:[UIColor blueColor]];
//                
//                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            if ([[dataArr objectAtIndex:0] isKindOfClass:[MWFeedItem class]]) {
                feeditm = [dataArr objectAtIndex:0];
            } else{
                feeditm = [[dataArr objectAtIndex:indexPath.row] objectAtIndex:0];
            }
            
            cell.textLabel.text = [NSString stringWithFormat:@"Read from %@",[[[DataClass class] sharedManager] getChannelNameFromLink:feeditm.link]];
            [cell.textLabel setFont:[UIFont fontWithName:@"Signika-Regular" size:16]];
            [cell.textLabel setTextColor:[UIColor blueColor]];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }
       
    }


    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        

        if ([[dataArr objectAtIndex:indexPath.row] isKindOfClass:[MWFeedItem class]]) {
            feeditm = [dataArr objectAtIndex:0];
        } else{
            feeditm = [[dataArr objectAtIndex:indexPath.row] objectAtIndex:0];
        }
        
        
    MWFeedItem *item = feeditm;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        self.webViewController = [[PBWebViewController alloc] init];
    }
    PBSafariActivity *activity = [[PBSafariActivity alloc] init];
    
    NSURL *url = [NSURL URLWithString:[item.link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    NSLog(@"link...%@",item.link);
    self.webViewController.URL = url;
    self.webViewController.applicationActivities = @[activity];
    self.webViewController.excludedActivityTypes = @[UIActivityTypeMail, UIActivityTypeMessage, UIActivityTypePostToWeibo];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self.navigationController pushViewController:self.webViewController animated:YES];
    }
    }

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
