//
//  CollectionViewManager.m
//  PDKTStickySectionHeadersCollectionViewLayoutDemo
//
//  Created by Daniel García on 31/12/13.
//  Copyright (c) 2013 Produkt. All rights reserved.
//

#import "CollectionViewManager.h"
#import "CollectionViewCell.h"
#import "CollectionViewSectionHeader.h"
#import "DataClass.h"
#import "MWFeedItem.h"
#import "NSString+HTML.h"

static NSUInteger const kNumberOfSections = 1;
static NSUInteger const kNumberItemsPerSection = 10;
@interface CollectionViewManager()
@property (strong,nonatomic) UINib *cellNib;
@property (strong,nonatomic) UINib *sectionHeaderNib;
@end
@implementation CollectionViewManager

- (void)setCollectionView:(UICollectionView *)collectionView{
    _collectionView=collectionView;
    if (_collectionView) {
        [self initCollectionView:collectionView];
    }
}
- (void)initCollectionView:(UICollectionView *)collectionView{
    collectionView.dataSource=self;
    collectionView.delegate=self;
    [self registerCellsForCollectionView:collectionView];
    [self registerSectionHeaderForCollectionView:collectionView];
    [collectionView reloadData];
}
#pragma mark - Cells
- (UINib *)cellNib{
    if (!_cellNib) {
        _cellNib = [UINib nibWithNibName:@"CollectionViewCell" bundle:nil];;
    }
    return _cellNib;
}
- (UINib *)sectionHeaderNib{
    if (!_sectionHeaderNib) {
        _sectionHeaderNib = [UINib nibWithNibName:@"CollectionViewSectionHeader" bundle:nil];
    }
    return _sectionHeaderNib;
}
- (void)registerCellsForCollectionView:(UICollectionView *)collectionView{
    [collectionView registerNib:self.cellNib forCellWithReuseIdentifier:@"CollectionViewCell"];
}
- (void)registerSectionHeaderForCollectionView:(UICollectionView *)collectionView{
    [collectionView registerNib:self.sectionHeaderNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionViewSectionHeader"];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return kNumberOfSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[[DataClass sharedManager] feedsArray] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell;
    static NSString *cellIdentifier=@"CollectionViewCell";
    cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
//    cell.titleLabel.text = [NSString stringWithFormat:@"Cell %d",indexPath.item];
    if (indexPath.section%2==0) {
//        cell.backgroundColor=[UIColor redColor];
    }else{
//        cell.backgroundColor=[UIColor blueColor];
    }
    
    UIView * view = [[UIView alloc] initWithFrame:cell.bounds];
    view.backgroundColor = [UIColor colorWithRed:100/255. green:50/255. blue:0/255. alpha:1.];
    
	   
    
    MWFeedItem *item;

    if ([[[DataClass sharedManager] feedsArray] count] > 0) {
    
        if ([[[[[DataClass sharedManager] feedsArray] objectAtIndex:indexPath.row] objectAtIndex:0] isKindOfClass:[NSArray class]]) {
            item = [[[[[DataClass sharedManager] feedsArray] objectAtIndex:indexPath.row] objectAtIndex:0] objectAtIndex:0];
            //            NSLog(@"count...%d",[[self.feedsArray objectAtIndex:indexPath.row] count]);
        } else{
            item = [[[[DataClass sharedManager] feedsArray] objectAtIndex:indexPath.row] objectAtIndex:0];
            //            NSLog(@"count...%d",[[self.feedsArray objectAtIndex:indexPath.row] count]);
            
        }
    
    if (item) {
        
        //        NSLog(@"item  %d....%@",indexPath.row,item.title);
        
        
        BOOL imagePresent = NO;
        //    BOOL videoPresent = NO;
        
        
        float textStartPos = 10.0f;
        
        if ([item.enclosures count] > 0) {
            //        NSLog(@"feeditm encolusure....%@",item.enclosures);
            
            for (int k = 0; k < 1; k ++) {
                NSDictionary *dict = [item.enclosures objectAtIndex:k];
                if ([[dict valueForKey:@"type"] isEqualToString:@"image/jpg"]) {
                    imagePresent = YES;
                    break;
                } else if ([[dict valueForKey:@"type"] isEqualToString:@"image/jpeg"]) {
                    imagePresent = YES;
                    break;
                } else if ([[dict valueForKey:@"type"] isEqualToString:@"image/png"]) {
                    imagePresent = YES;
                    break;
                } else if ([[dict valueForKey:@"type"] isEqualToString:@"image/gif"]) {
                    imagePresent = YES;
                    break;
                } else if ([[dict valueForKey:@"type"] isEqualToString:@"image/tiff"]) {
                    imagePresent = YES;
                    break;
                }
            }
            
            if (imagePresent) {
                
                textStartPos = 25.0f;
                UIImageView *iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(299, 58, 10, 10)];
                [iconImg setImage:[UIImage imageNamed:@"polaroid.png"]];
                //            iconImg.alpha = 1.0;
                [view addSubview:iconImg];
            }
        }
        
        
        
        
        // Process
        NSString *itemTitle = item.title ? [item.title stringByConvertingHTMLToPlainText] : @"";
        //		NSString *itemSummary = item.summary ? [item.summary stringByConvertingHTMLToPlainText] : @"[No Summary]";
        
        
        
        NSMutableString *subtitle = [NSMutableString string];
        //		if (item.date) [subtitle appendFormat:@"%@: ", [formatter stringFromDate:item.date]];
        [subtitle appendString:item.link];
        
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 12, 300, 40)];
        lbl.text = itemTitle;
        [lbl setFont:[UIFont fontWithName:@"Signika-Light" size:16]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        //    lbl.textColor = [UIColor colorWithRed:0.35 green:0.56 blue:0.87 alpha:1.0];
        lbl.numberOfLines = 2;
        lbl.tag = 55;
        [view addSubview:lbl];
        
        //    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        //            cell.textLabel.text = [NSString stringWithFormat:@"%@",[appdelegate getChannelNameFromLink:item.link]];
        
        NSString *dateStr ;
        
        NSDate* date1 = [NSDate date];
        NSDate* date2 = item.date;
        NSTimeInterval distanceBetweenDates = [date1 timeIntervalSinceDate:date2];
        double secondsInAnHour = 3600;
        double secondsInAMin = 60;
        NSInteger hoursBetweenDates = distanceBetweenDates / secondsInAnHour;
        NSInteger minsBetweenDate = distanceBetweenDates / secondsInAMin;
        
        if (hoursBetweenDates > 0) {
            dateStr = [[NSString alloc] initWithFormat:@"%d hours ago",hoursBetweenDates];
        } else if (minsBetweenDate > 0) {
            dateStr = [[NSString alloc] initWithFormat:@"%d mins ago",minsBetweenDate];
        }
        
        UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(240, 2, 70, 10)];
        lbl2.backgroundColor = [UIColor clearColor];
        lbl2.textAlignment = NSTextAlignmentRight;
        lbl2.textColor = [UIColor colorWithRed:0.78 green:0.35 blue:0.51 alpha:0.7];
        lbl2.text = dateStr;
        lbl2.tag = 56;
        [lbl2 setFont:[UIFont fontWithName:@"Signika-Light" size:9]];
        [view addSubview:lbl2];
        
        
        
        UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 100, 10)];
        lbl1.backgroundColor = [UIColor clearColor];
        lbl1.textColor = [UIColor colorWithRed:0.36 green:0.57 blue:0.93 alpha:0.9];
        lbl1.text = [[[DataClass class] sharedManager] getChannelNameFromLink:item.link];
        lbl1.tag = 56;
        [lbl1 setFont:[UIFont fontWithName:@"Signika-Light" size:9]];
        [view addSubview:lbl1];
        
        float textWidth = 300;
        if (textStartPos > 10) {
            textWidth = 290;
        }
        
        NSString *itemSummary = item.summary ? [item.summary stringByConvertingHTMLToPlainText] : @"";
        
        
        UILabel *lbl3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 54, textWidth, 16)];
        lbl3.backgroundColor = [UIColor clearColor];
        lbl3.textColor = [UIColor grayColor];
        lbl3.text = itemSummary;
        lbl3.tag = 56;
        [lbl3 setFont:[UIFont fontWithName:@"Signika-Light" size:12]];
        [view addSubview:lbl3];
        
    }
        
    }

    _pageController = [[APExtendedPageController alloc] initWithFrame:cell.bounds
                                                             mainView:cell
                                       extendedPageControllerDelegate:self];
    _pageController.tag = indexPath.row;

    [cell addSubview:_pageController];

    
        //    cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    
   
    
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    CollectionViewSectionHeader *sectionHeaderView;
    static NSString *viewIdentifier=@"CollectionViewSectionHeader";
    sectionHeaderView=[self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:viewIdentifier forIndexPath:indexPath];
    NSString *sectionHeaderTitle=[NSString stringWithFormat:@"Section %d",indexPath.section];
    if (![self shouldStickHeaderToTopInSection:indexPath.section]) {
        sectionHeaderTitle=[sectionHeaderTitle stringByAppendingString:@" (should not stick to top)"];
    }
    sectionHeaderView.titleLabel.text=sectionHeaderTitle;
    sectionHeaderView.titleLabel.textColor=[UIColor whiteColor];
    sectionHeaderView.backgroundColor=[UIColor blackColor];
    return sectionHeaderView;
}
#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section%2==0) {
//        return CGSizeMake((self.collectionView.bounds.size.width/2)-1, 150);
//    }
    return CGSizeMake(self.collectionView.bounds.size.width, 100);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1.0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1.0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.collectionView.bounds.size.width, 0);
}

#pragma mark - PDKTStickySectionHeadersCollectionViewLayoutDelegate
- (BOOL)shouldStickHeaderToTopInSection:(NSUInteger)section{
    // Every section multiple of 3 doesn't stick to top
//    return (section>0 && section%3==0)?NO:YES;
    return NO;
}


#define randomFloat ((float)(rand()%255))/255.

- (UIView *)extendedPageController:(APExtendedPageController *)extendedPageController
                       viewAtIndex:(NSInteger)index
{
    
        UIView * view = [[UIView alloc] initWithFrame:extendedPageController.frame];
//        view.backgroundColor = [UIColor colorWithRed:100/255. green:50/255. blue:0/255. alpha:1.];
//        view.backgroundColor = [UIColor colorWithRed:randomFloat green:randomFloat blue:randomFloat alpha:1.];
        
        
        MWFeedItem *item;
    
            if ([[[[[DataClass sharedManager] feedsArray] objectAtIndex:extendedPageController.tag] objectAtIndex:index] isKindOfClass:[NSArray class]]) {
                item = [[[[[DataClass sharedManager] feedsArray] objectAtIndex:extendedPageController.tag] objectAtIndex:index] objectAtIndex:0];
                //            NSLog(@"count...%d",[[self.feedsArray objectAtIndex:indexPath.row] count]);
            
            
            if (item) {
                
                //        NSLog(@"item  %d....%@",indexPath.row,item.title);
                
                
                BOOL imagePresent = NO;
                //    BOOL videoPresent = NO;
                
                
                float textStartPos = 10.0f;
                
                if ([item.enclosures count] > 0) {
                    //        NSLog(@"feeditm encolusure....%@",item.enclosures);
                    
                    for (int k = 0; k < 1; k ++) {
                        NSDictionary *dict = [item.enclosures objectAtIndex:k];
                        if ([[dict valueForKey:@"type"] isEqualToString:@"image/jpg"]) {
                            imagePresent = YES;
                            break;
                        } else if ([[dict valueForKey:@"type"] isEqualToString:@"image/jpeg"]) {
                            imagePresent = YES;
                            break;
                        } else if ([[dict valueForKey:@"type"] isEqualToString:@"image/png"]) {
                            imagePresent = YES;
                            break;
                        } else if ([[dict valueForKey:@"type"] isEqualToString:@"image/gif"]) {
                            imagePresent = YES;
                            break;
                        } else if ([[dict valueForKey:@"type"] isEqualToString:@"image/tiff"]) {
                            imagePresent = YES;
                            break;
                        }
                    }
                    
                    if (imagePresent) {
                        
                        textStartPos = 25.0f;
                        UIImageView *iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(299, 58, 10, 10)];
                        [iconImg setImage:[UIImage imageNamed:@"polaroid.png"]];
                        //            iconImg.alpha = 1.0;
                        [view addSubview:iconImg];
                    }
                }
                
                
                
                
                // Process
                NSString *itemTitle = item.title ? [item.title stringByConvertingHTMLToPlainText] : @"";
                //		NSString *itemSummary = item.summary ? [item.summary stringByConvertingHTMLToPlainText] : @"[No Summary]";
                
                
                
                NSMutableString *subtitle = [NSMutableString string];
                //		if (item.date) [subtitle appendFormat:@"%@: ", [formatter stringFromDate:item.date]];
                [subtitle appendString:item.link];
                
                UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 12, 300, 40)];
                lbl.text = itemTitle;
                [lbl setFont:[UIFont fontWithName:@"Signika-Light" size:16]];
                [lbl setBackgroundColor:[UIColor clearColor]];
                //    lbl.textColor = [UIColor colorWithRed:0.35 green:0.56 blue:0.87 alpha:1.0];
                lbl.numberOfLines = 2;
                lbl.tag = 55;
                [view addSubview:lbl];
                
                //    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                //            cell.textLabel.text = [NSString stringWithFormat:@"%@",[appdelegate getChannelNameFromLink:item.link]];
                
                NSString *dateStr ;
                
                NSDate* date1 = [NSDate date];
                NSDate* date2 = item.date;
                NSTimeInterval distanceBetweenDates = [date1 timeIntervalSinceDate:date2];
                double secondsInAnHour = 3600;
                double secondsInAMin = 60;
                NSInteger hoursBetweenDates = distanceBetweenDates / secondsInAnHour;
                NSInteger minsBetweenDate = distanceBetweenDates / secondsInAMin;
                
                if (hoursBetweenDates > 0) {
                    dateStr = [[NSString alloc] initWithFormat:@"%d hours ago",hoursBetweenDates];
                } else if (minsBetweenDate > 0) {
                    dateStr = [[NSString alloc] initWithFormat:@"%d mins ago",minsBetweenDate];
                }
                
                UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(240, 2, 70, 10)];
                lbl2.backgroundColor = [UIColor clearColor];
                lbl2.textAlignment = NSTextAlignmentRight;
                lbl2.textColor = [UIColor colorWithRed:0.78 green:0.35 blue:0.51 alpha:0.7];
                lbl2.text = dateStr;
                lbl2.tag = 56;
                [lbl2 setFont:[UIFont fontWithName:@"Signika-Light" size:9]];
                [view addSubview:lbl2];
                
                
                
                UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 100, 10)];
                lbl1.backgroundColor = [UIColor clearColor];
                lbl1.textColor = [UIColor colorWithRed:0.36 green:0.57 blue:0.93 alpha:0.9];
                lbl1.text = [[[DataClass class] sharedManager] getChannelNameFromLink:item.link];
                lbl1.tag = 56;
                [lbl1 setFont:[UIFont fontWithName:@"Signika-Light" size:9]];
                [view addSubview:lbl1];
                
                float textWidth = 300;
                if (textStartPos > 10) {
                    textWidth = 290;
                }
                
                NSString *itemSummary = item.summary ? [item.summary stringByConvertingHTMLToPlainText] : @"";
                
                
                UILabel *lbl3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 54, textWidth, 16)];
                lbl3.backgroundColor = [UIColor clearColor];
                lbl3.textColor = [UIColor grayColor];
                lbl3.text = itemSummary;
                lbl3.tag = 56;
                [lbl3 setFont:[UIFont fontWithName:@"Signika-Light" size:12]];
                [view addSubview:lbl3];
                
            }
            
        }

        
    
    
        
        
        
        return view;
    
}



@end
