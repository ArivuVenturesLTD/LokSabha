//
//  ViewController.m
//  PDKTStickySectionHeadersCollectionViewLayoutDemo
//
//  Created by Daniel García on 31/12/13.
//  Copyright (c) 2013 Produkt. All rights reserved.
//

#import "News.h"
#import "CollectionViewManager.h"

#import "MWFeedParser.h"
#import "NSString+HTML.h"
#import "FeedsParser.h"
#import "DataClass.h"
#import "NewsController.h"
#import "PorterStemmer.h"
#import "M13ProgressHUD.h"
#import "M13ProgressViewRing.h"
#import "ALScrollViewPaging.h"
#import "UINavigationController+M13ProgressViewBar.h"
#import "DEMOAppDelegate.h"

@interface News ()

@property (nonatomic, strong) NSDictionary *totalDict;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong,nonatomic) CollectionViewManager *collectionViewManager;
@end

@implementation News
{
    M13ProgressHUD *HUD;

}

@synthesize moduleNum,feedsArray,searchArray,refreshCtrl;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _collectionViewManager = [[CollectionViewManager alloc]init];
        self.navigationController.navigationBarHidden = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionViewManager.collectionView=self.collectionView;
    
    [self readNewsPList];

    //    [[[DataClass class] sharedManager] updateTime];

    
    if ([[_totalDict allKeys] count] > 0) {
        [self.navigationController showProgress];
        [self reloadNewsForView];
    }

    
    
    
}




-(void)readNewsPList {
    
    
    NSString *strplistPath = [[NSBundle mainBundle] pathForResource:@"News" ofType:@"plist"];
    
    // read property list into memory as an NSData  object
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:strplistPath];
    NSString *strerrorDesc = nil;
    NSPropertyListFormat plistFormat;
    // convert static property liost into dictionary object
    _totalDict = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&plistFormat errorDescription:&strerrorDesc];
    if (!_totalDict)
        NSLog(@"Error reading plist: %@, format: %d", strerrorDesc, plistFormat);
    
    
    
    
    
    
    
}



-(void)showEmptyScreen {
    if (!noDataImg) {
        noDataImg = [[UIImageView alloc] initWithFrame:CGRectMake(95, 170, 130, 130)];
        noDataImg.alpha = 0.3;
        [noDataImg setImage:[UIImage imageNamed:@"rss.png"]];
        noDataLbl = [[UILabel alloc] initWithFrame:CGRectMake(65, 310, 190, 30)];
        noDataLbl.text = @"No content at the moment";
        noDataLbl.backgroundColor = [UIColor clearColor];
        noDataLbl.textAlignment = NSTextAlignmentCenter;
        noDataLbl.textColor = [UIColor lightGrayColor];
        [noDataLbl setFont:[UIFont fontWithName:@"Signika-Light" size:16]];
        
    }
    [self.view addSubview:noDataImg];
    [self.view addSubview:noDataLbl];
}

-(void)removeEmptyScreen {
    [noDataImg removeFromSuperview];
    [noDataLbl removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Comparison methods

-(NSMutableArray *)removeDuplicates:(NSMutableArray *)array{
    NSMutableArray *uniqueArray = [[NSMutableArray alloc] init];
    //    for (MWFeedItem *tempFeedItem in array) {
    //        if ([uniqueArray containsObject:tempFeedItem]) {
    //            //Object already present
    //        } else{
    //            //add object to array
    //        }
    //    }
    
    
    for (int k = 0; k < [array count]; k++) {
        MWFeedItem *tempFeeditem = [array objectAtIndex:k];
        
        if ([uniqueArray count] == 0) {
            [uniqueArray addObject:tempFeeditem];
            
        } else{
            BOOL itemPresent = NO;
            
            for (int p = 0; p < [uniqueArray count]; p++) {
                MWFeedItem *tempFeeditem1 = [uniqueArray objectAtIndex:p];
                
                int length1 = [tempFeeditem.title length];
                int length2 = [tempFeeditem1.title length];
                
                if (length1 > 25 && length2 > 25 ) {
                    length1 = 25;
                    length2 = 25;
                } else if  (length1 < length2) {
                    length2 = length1;
                } else if (length2 < length1) {
                    length1 = length2;
                }
                
                //To be changed to bhattacharya comparison when the phones are efficient
                if ([[tempFeeditem.title substringToIndex:length1] isEqualToString:[tempFeeditem1.title substringToIndex:length2]]) {
                    itemPresent = YES;
                    break;
                } else{
                    
                }
            }
            if (itemPresent) {
            } else{
                [uniqueArray addObject:tempFeeditem];
            }
        }
    }
    //    NSLog(@"unique array...%@",uniqueArray);
    return uniqueArray;
}

-(void)setArrayToDataClass:(NSMutableArray *)iNewArray {
    
    NSMutableArray *newSortedArray = [[NSMutableArray alloc] initWithArray:[self sortArray:iNewArray]];
    
    if (moduleNum == 1) {
        [[[DataClass class] sharedManager] setTopStoriesArray:newSortedArray];
    } else if (moduleNum == 2) {
        [[[DataClass class] sharedManager] setIndiaArray:newSortedArray];
    } else if (moduleNum == 3) {
        [[[DataClass class] sharedManager] setWorldArray:newSortedArray];
    } else if (moduleNum == 4) {
        [[[DataClass class] sharedManager] setBusinessArray:newSortedArray];
    } else if (moduleNum == 5) {
        [[[DataClass class] sharedManager] setTechnologyArray:newSortedArray];
    } else if (moduleNum == 6) {
        [[[DataClass class] sharedManager] setSportArray:newSortedArray];
    } else if (moduleNum == 7) {
        [[[DataClass class] sharedManager] setEntertainmentArray:newSortedArray];
    } else if (moduleNum == 8) {
        [[[DataClass class] sharedManager] setLifeStyleArray:newSortedArray];
    } else if (moduleNum == 9) {
        [[[DataClass class] sharedManager] setHealthArray:newSortedArray];
    } else if (moduleNum == 10) {
        [[[DataClass class] sharedManager] setNriArray:newSortedArray];
    } else{
        [[[DataClass class] sharedManager] setTopStoriesArray:newSortedArray];
    }
    
}


-(void)updateFeedsArray{
    
    NSMutableArray *newSortedArray = [[NSMutableArray alloc] initWithArray:self.feedsArray];
    
    if (moduleNum == 1) {
        [[[DataClass class] sharedManager] setTopStoriesArray:newSortedArray];
    } else if (moduleNum == 2) {
        [[[DataClass class] sharedManager] setIndiaArray:newSortedArray];
    } else if (moduleNum == 3) {
        [[[DataClass class] sharedManager] setWorldArray:newSortedArray];
    } else if (moduleNum == 4) {
        [[[DataClass class] sharedManager] setBusinessArray:newSortedArray];
    } else if (moduleNum == 5) {
        [[[DataClass class] sharedManager] setTechnologyArray:newSortedArray];
    } else if (moduleNum == 6) {
        [[[DataClass class] sharedManager] setSportArray:newSortedArray];
    } else if (moduleNum == 7) {
        [[[DataClass class] sharedManager] setEntertainmentArray:newSortedArray];
    } else if (moduleNum == 8) {
        [[[DataClass class] sharedManager] setLifeStyleArray:newSortedArray];
    } else if (moduleNum == 9) {
        [[[DataClass class] sharedManager] setHealthArray:newSortedArray];
    } else if (moduleNum == 10) {
        [[[DataClass class] sharedManager] setNriArray:newSortedArray];
    } else{
        [[[DataClass class] sharedManager] setTopStoriesArray:newSortedArray];
    }
    
}



-(void)getLatestDataArray{
    
    if (moduleNum == 1) {
        self.feedsArray = [[[DataClass class] sharedManager] topStoriesArray];
    } else if (moduleNum == 2) {
        self.feedsArray = [[[DataClass class] sharedManager] indiaArray];
    } else if (moduleNum == 3) {
        self.feedsArray = [[[DataClass class] sharedManager] worldArray];
    } else if (moduleNum == 4) {
        self.feedsArray = [[[DataClass class] sharedManager] businessArray];
    } else if (moduleNum == 5) {
        self.feedsArray = [[[DataClass class] sharedManager] technologyArray];
    } else if (moduleNum == 6) {
        self.feedsArray = [[[DataClass class] sharedManager] sportArray];
    } else if (moduleNum == 7) {
        self.feedsArray = [[[DataClass class] sharedManager] entertainmentArray];
    } else if (moduleNum == 8) {
        self.feedsArray = [[[DataClass class] sharedManager] lifeStyleArray];
    } else if (moduleNum == 9) {
        self.feedsArray = [[[DataClass class] sharedManager] healthArray];
    } else if (moduleNum == 10) {
        self.feedsArray = [[[DataClass class] sharedManager] nriArray];
    } else{
        self.feedsArray = [[[DataClass class] sharedManager] topStoriesArray];
    }
    
    
}

-(void)reloadNewsForView{
    [self.refreshCtrl endRefreshing];
    
    [self resetArray];
    
    [self.navigationItem setTitle:[[[DataClass class] sharedManager] module]];
    
    //    NSArray *channels = [[[[DataClass class] sharedManager] channelDict] objectForKey:@"Channels"];
    
    //    for (int j =0; j < [channels count]; j ++) {
    [self animateProgress:nil];
    
    [self createRSSCall:0];
    
    
    
    
    
    
    
    [[[DataClass class] sharedManager] updateTime];
    //   self.navigationItem.prompt = [[[DataClass class] sharedManager] timeToBeDisplayed];
    //    [[[DataClass class] sharedManager] setNavTitle:[[[DataClass class] sharedManager] module] :[[[DataClass class] sharedManager] timeToBeDisplayed]];
    //    [[self navigationItem] setTitleView:[[[DataClass class] sharedManager] navTitleView]];
    
    
}

-(void)createRSSCall:(int)iChannelNum {
    
    
 
    
    
//    [[[DataClass class] sharedManager] setNavTitle:[[[DataClass class] sharedManager] module] :@"Updating..."];
    [[self navigationItem] setTitleView:[[[DataClass class] sharedManager] navTitleView]];
    
    __block int channelNum = iChannelNum;
 //   NSArray *channels = [[[[DataClass class] sharedManager] channelDict] objectForKey:@"Channels"];
    
    float partitions = 0.047;
    
    
//    NSDictionary *dict = [channels objectAtIndex:channelNum];
    
    NSString *str = [[_totalDict valueForKey:[NSString stringWithFormat:@"%d",iChannelNum]] valueForKey:@"link"];
    
    
//    NSString *str = [dict valueForKey:[[[DataClass class] sharedManager] module]];
    //    NSLog(@"Link %d = %@",channelNum,str);
    
    if (channelNum == 5) {
        //        NSLog(@"Link %d = %@",channelNum,str);
    }
    //        NSLog(@"Link to be called....%@",str);
    
    if ((channelNum + 1) == [[_totalDict allKeys] count]) {
        
        [self performSelector:@selector(setComplete) withObject:nil afterDelay:HUD.animationDuration + .05];
//        [[[DataClass class] sharedManager] setNavTitle:[[[DataClass class] sharedManager] module] :@"Updated Now"];
        [[self navigationItem] setTitleView:[[[DataClass class] sharedManager] navTitleView]];
    }
    
    if ([str length] > 5) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^() {
            // Make synchronous call to parser
            NSDate *methodStart = [NSDate date];
            FeedsParser *feedparser = [[FeedsParser alloc] initWithURL:str withRef:channelNum];
            //           NSLog(@"feed items...%@",feedparser.parsedArr);
            [self.navigationController setProgress:(partitions*iChannelNum) animated:YES];
            
            NSDate *methodFinish = [NSDate date];
            NSTimeInterval executionTime = [methodFinish timeIntervalSinceDate:methodStart];
            NSLog(@"executionTime = %f", executionTime);
            
            
            if ([feedparser.parsedArr count] > 0) {
                
                NSMutableArray *newCollatedArray = [[NSMutableArray alloc] init];
                NSMutableArray *oldNewsRemoved = [[NSMutableArray alloc] initWithArray:[self removeOldNews:feedparser.parsedArr]];
                //Get data from Parser
                // Remove duplicates using the item name
                NSArray *uniqueArray = [NSArray arrayWithArray:[self removeDuplicates:oldNewsRemoved]];
                
                //                    [newCollatedArray addObject:uniqueArray];
                
                //Find Hist Array and merge both items and hist array
                
                //                    NSMutableArray *histTempArr = [[NSMutableArray alloc] init];
                
                for (int m = 0; m < [uniqueArray count]; m++) {
                    NSMutableDictionary *histDict = [[NSMutableDictionary alloc] init];
                    MWFeedItem *item = [uniqueArray objectAtIndex:m];
                    NSString *itemTitle = item.title ? [item.title stringByConvertingHTMLToPlainText] : @" ";
                    NSString *itemSummary = item.summary ? [item.summary stringByConvertingHTMLToPlainText] : @" ";
                    itemTitle = [NSString stringWithFormat:@"%@ %@",itemTitle,itemSummary];
                    histDict = [self createHistDictforArray:itemTitle];
                    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
                    [tempArr addObject:[uniqueArray objectAtIndex:m]];
                    [tempArr addObject:histDict];
                    [newCollatedArray addObject:tempArr];
                }
                newCollatedArray = [self removeBlockedNews:newCollatedArray];
                
                
                dispatch_async(dispatch_get_main_queue(), ^() {
                    [self getLatestDataArray];
                    
                    // Compare and combine with previous feeds array
                    //                        NSMutableArray *comparedArray = [self compareAndCombineNewArray:newCollatedArray withOldArray:self.feedsArray];
                    
                    NSMutableArray *presentArr = [[NSMutableArray alloc] initWithArray:self.feedsArray];
                    NSMutableArray *newArray = [[NSMutableArray alloc] initWithArray:newCollatedArray];
                    
                    if ([presentArr count] == 0) {
                        NSMutableArray *returnArray = [[NSMutableArray alloc] initWithArray:newArray];
                        
                        
                        // Set the array to data Class feed array
                        [self setArrayToDataClass:returnArray];
                        [self getLatestDataArray];
                        [self removeWatchedNews];
                        //                            [self reloadTable];
                        
                        
                        
                        //                        [self showPreview];
                        
                        channelNum = channelNum +1;
                        
                        if (channelNum < [[_totalDict allKeys] count]) {
                            [self createRSSCall:channelNum];
                        } else{
                            [self performSelector:@selector(setComplete) withObject:nil afterDelay:HUD.animationDuration + .05];
                        }
                    } else{
                        NSMutableArray *finalArray = [[NSMutableArray alloc] initWithArray:presentArr];
                        NSMutableArray *itemRefArray   = [[NSMutableArray alloc] init];
                        int presentFeedsCount = [presentArr count];
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^() {
                            for (int k = 0; k < presentFeedsCount; k++) {
                                BOOL multipleArray = NO;
                                if ([[[presentArr objectAtIndex:k] objectAtIndex:0] isKindOfClass:[NSArray class]]) {
                                    multipleArray = YES;
                                } else{
                                    multipleArray = NO;
                                }
                                MWFeedItem *presentItem;
                                NSDictionary *presentItemDict;
                                
                                if (multipleArray) {
                                    presentItem = [[[presentArr objectAtIndex:k] objectAtIndex:0] objectAtIndex:0];
                                    presentItemDict = [[[presentArr objectAtIndex:k] objectAtIndex:0] objectAtIndex:1];
                                } else{
                                    presentItem = [[presentArr objectAtIndex:k] objectAtIndex:0];
                                    presentItemDict = [[presentArr objectAtIndex:k] objectAtIndex:1];
                                }
                                
                                //            NSDictionary *presentItemDict = [NSDictionary dictionaryWithDictionary:[[presentArr objectAtIndex:k] objectAtIndex:1]];
                                
                                for (int b =0; b<[newArray count]; b++) {
                                    //              MWFeedItem *newItem = [[newArray objectAtIndex:b] objectAtIndex:0];
                                    NSDictionary *newHistDict = [[newArray objectAtIndex:b] objectAtIndex:1];
                                    
                                    //                                    NSLog(@"New Hist Dict...%@",newHistDict);
                                    
                                    BOOL val1 = [self similarityBetweendictionary1:presentItemDict dictionary2:newHistDict];
                                    
                                    //                                    float val = [self getBhattacharyaCoefficientforString1:presentItemDict string2:newHistDict];
                                    
                                    //                                    if (val >= 0.35 && val <= 2) {
                                    if(val1) {
                                        
                                        NSMutableArray *arrayToAddNewItem = [[NSMutableArray alloc] init];
                                        
                                        if (multipleArray) {
                                            //                                            NSMutableArray *tempItemAr = [[NSMutableArray alloc] initWithArray:[[presentArr objectAtIndex:k] objectAtIndex:0]];
                                            //                                            [arrayToAddNewItem addObjectsFromArray:[presentArr objectAtIndex:k]];
                                            
                                            for (int m = 0; m < [[presentArr objectAtIndex:k] count]; m++) {
                                                [arrayToAddNewItem addObject:[[presentArr objectAtIndex:k] objectAtIndex:m]];
                                            }
                                            [arrayToAddNewItem addObject:[newArray objectAtIndex:b]];
                                            
                                        } else {
                                            NSMutableArray *tempItemAr = [[NSMutableArray alloc] initWithArray:[presentArr objectAtIndex:k]];
                                            [arrayToAddNewItem addObject:tempItemAr] ;
                                            [arrayToAddNewItem addObject:[newArray objectAtIndex:b]];
                                        }
                                        
                                        [finalArray replaceObjectAtIndex:k withObject:arrayToAddNewItem];
                                        
                                        if (![itemRefArray containsObject:[NSString stringWithFormat:@"%d",b]]) {
                                            [itemRefArray addObject:[NSString stringWithFormat:@"%d",b]];
                                        }
                                        
                                        break;
                                    }
                                }
                            }
                            
                            dispatch_async(dispatch_get_main_queue(), ^() {
                                for (int p =0; p<[newArray count]; p++) {
                                    if (![itemRefArray containsObject:[NSString stringWithFormat:@"%d",p]]) {
                                        NSMutableArray *tArr = [[NSMutableArray alloc] init];
                                        [tArr addObject:[newArray objectAtIndex:p]];
                                        [finalArray addObject:tArr];
                                    }
                                }
                                [itemRefArray removeAllObjects];
                                
                                // Set the array to data Class feed array
                                [self setArrayToDataClass:finalArray];
                                
                                NSSortDescriptor* descriptor= [NSSortDescriptor sortDescriptorWithKey: @"@count" ascending: NO];
                                NSArray* sortedArray= [self.feedsArray sortedArrayUsingDescriptors: @[ descriptor ]];
                                self.feedsArray = [NSMutableArray arrayWithArray:sortedArray];
                                [self getLatestDataArray];
                                [self removeWatchedNews];
                                [self reloadTable];
                                channelNum = channelNum +1;
                                
                                if (channelNum < [[_totalDict allKeys] count]) {
                                    [self createRSSCall:channelNum];
                                } else {
                                    [self performSelector:@selector(setComplete) withObject:nil afterDelay:HUD.animationDuration + .1];
                                }});});}});
            } else{
                channelNum = channelNum +1;
                
                if (channelNum < [[_totalDict allKeys] count]) {
                    [self createRSSCall:channelNum];
                } else{
                    [self removeWatchedNews];
                    [self reloadTable];
                    [self performSelector:@selector(setComplete) withObject:nil afterDelay:HUD.animationDuration + .05];
                }}});
    } else{
        channelNum = channelNum +1;
        
        if (channelNum < [[_totalDict allKeys] count]) {
            [self createRSSCall:channelNum];
        } else{
            [self removeWatchedNews];
            [self reloadTable];
            [self performSelector:@selector(setComplete) withObject:nil afterDelay:HUD.animationDuration + .05];
        }
    }
}


-(void)reloadTable {
 //   [self.tableView setContentOffset:CGPointMake(0, -20) animated:YES];
 //   [self.tableView reloadData];
    
    [[DataClass sharedManager] setFeedsArray:self.feedsArray];
    
    [self.collectionViewManager.collectionView reloadData];
    
    NSLog(@"self.feedsArray...%@",self.feedsArray);
    
}



-(NSMutableArray *)compareAndCombineNewArray:(NSArray *)newArray withOldArray:(NSArray *)presentArr{
    
    if ([presentArr count] == 0) {
        NSMutableArray *returnArray = [[NSMutableArray alloc] init];
        [returnArray addObject:newArray];
        return returnArray;
    } else{
        NSMutableArray *finalArray = [[NSMutableArray alloc] initWithArray:presentArr];
        NSMutableArray *itemRefArray   = [[NSMutableArray alloc] init];
        int presentFeedsCount = [presentArr count];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^() {
            
            for (int k = 0; k < presentFeedsCount; k++) {
                
                BOOL multipleArray = NO;
                
                if ([[[presentArr objectAtIndex:k] objectAtIndex:0] isKindOfClass:[NSArray class]]) {
                    multipleArray = YES;
                } else{
                    multipleArray = NO;
                }
                MWFeedItem *presentItem;
                NSDictionary *presentItemDict;
                
                if (multipleArray) {
                    presentItem = [[[presentArr objectAtIndex:k] objectAtIndex:0] objectAtIndex:0];
                    presentItemDict = [[[presentArr objectAtIndex:k] objectAtIndex:0] objectAtIndex:1];
                } else{
                    presentItem = [[presentArr objectAtIndex:k] objectAtIndex:0];
                    presentItemDict = [[presentArr objectAtIndex:k] objectAtIndex:1];
                }
                
                //            NSDictionary *presentItemDict = [NSDictionary dictionaryWithDictionary:[[presentArr objectAtIndex:k] objectAtIndex:1]];
                
                for (int b =0; b<[newArray count]; b++) {
                    //              MWFeedItem *newItem = [[newArray objectAtIndex:b] objectAtIndex:0];
                    NSDictionary *newHistDict = [[newArray objectAtIndex:b] objectAtIndex:1];
                    
                    BOOL val1 = [self similarityBetweendictionary1:presentItemDict dictionary2:newHistDict];
                    
                    
                    //                    float val = [self getBhattacharyaCoefficientforString1:presentItemDict string2:newHistDict];
                    //                    if (val >= 0.3 && val <= 2) {
                    
                    if (val1) {
                        
                        NSMutableArray *arrayToAddNewItem = [[NSMutableArray alloc] init];
                        
                        if (multipleArray) {
                            NSMutableArray *tempItemAr = [[NSMutableArray alloc] initWithArray:[[presentArr objectAtIndex:k] objectAtIndex:0]];
                            [arrayToAddNewItem addObject:tempItemAr] ;
                            [arrayToAddNewItem addObject:[newArray objectAtIndex:b]];
                        } else {
                            NSMutableArray *tempItemAr = [[NSMutableArray alloc] initWithArray:[presentArr objectAtIndex:k]];
                            [arrayToAddNewItem addObject:tempItemAr] ;
                            [arrayToAddNewItem addObject:[newArray objectAtIndex:b]];
                        }
                        
                        [finalArray replaceObjectAtIndex:k withObject:arrayToAddNewItem];
                        
                        if (![itemRefArray containsObject:[NSString stringWithFormat:@"%d",b]]) {
                            [itemRefArray addObject:[NSString stringWithFormat:@"%d",b]];
                        }
                        
                        break;
                    }
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^() {
                for (int p =0; p<[newArray count]; p++) {
                    if (![itemRefArray containsObject:[NSString stringWithFormat:@"%d",p]]) {
                        NSMutableArray *tArr = [[NSMutableArray alloc] init];
                        [tArr addObject:[newArray objectAtIndex:p]];
                        [finalArray addObject:tArr];
                    }
                }
                [itemRefArray removeAllObjects];
            });
        });
        return finalArray;
    }
    return nil;
}

-(NSMutableArray *)sortArray:(NSMutableArray *)iArray {
    
    NSMutableArray *sortdArray = [[NSMutableArray alloc] init];
    NSSortDescriptor* descriptor= [NSSortDescriptor sortDescriptorWithKey: @"@count" ascending: NO];
    if ([iArray count]>1) {
        NSArray* sortedArray= [iArray sortedArrayUsingDescriptors: @[ descriptor ]];
        sortdArray = [NSMutableArray arrayWithArray:sortedArray];
    }
    
    return sortdArray;
}

-(void)resetArray{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self setArrayToDataClass:array];
    
}




-(NSMutableDictionary *)createHistDictforArray:(NSString *)iItemText {
    //item text can be just the title or description combined
    NSMutableDictionary *histArray = [[NSMutableDictionary alloc] init];
    
    NSMutableArray *wordsArr = [[NSMutableArray alloc] init];
    NSMutableArray *histArr = [[NSMutableArray alloc] init];
    NSMutableArray *speechArr = [[NSMutableArray alloc] init];
    
    
    
    NSMutableArray *nounArr = [[NSMutableArray alloc] init];
    NSMutableArray *verbArr = [[NSMutableArray alloc] init];
    NSMutableArray *adverbArr = [[NSMutableArray alloc] init];
    NSMutableArray *adjectiveArr = [[NSMutableArray alloc] init];
    NSMutableArray *pronounArr = [[NSMutableArray alloc] init];
    NSMutableArray *numberArr = [[NSMutableArray alloc] init];
    NSMutableArray *otherWordArr = [[NSMutableArray alloc] init];
    NSMutableArray *interJectionArr = [[NSMutableArray alloc] init];
    
    NSMutableArray *nounHistArr = [[NSMutableArray alloc] init];
    NSMutableArray *verbHistArr = [[NSMutableArray alloc] init];
    NSMutableArray *adverbHistArr = [[NSMutableArray alloc] init];
    NSMutableArray *adjectiveHistArr = [[NSMutableArray alloc] init];
    NSMutableArray *pronounHistArr = [[NSMutableArray alloc] init];
    NSMutableArray *numberHistArr = [[NSMutableArray alloc] init];
    NSMutableArray *otherWordHistArr = [[NSMutableArray alloc] init];
    NSMutableArray *interJectionHistArr = [[NSMutableArray alloc] init];
    
    __block NSString *lastNoun = [[NSString alloc] init];
    
    NSLinguisticTagger *tagger = [[NSLinguisticTagger alloc] initWithTagSchemes:[NSArray arrayWithObject:NSLinguisticTagSchemeLexicalClass] options:~NSLinguisticTaggerOmitWords];
    [tagger setString:iItemText];
    [tagger enumerateTagsInRange:NSMakeRange(0, [iItemText length])
                          scheme:NSLinguisticTagSchemeLexicalClass
                         options:~NSLinguisticTaggerOmitWords
                      usingBlock:^(NSString *tag, NSRange tokenRange, NSRange sentenceRange, BOOL *stop) {
                          //                          NSLog(@"found:%@ (%@)",[iItemText substringWithRange:tokenRange], tag);
                          
                          if (![speechArray containsObject:tag]){
                              
                              [speechArray addObject:tag];
                          }
                          
                          
                          //New algorithm to seperate the type of words and group them
                          if ([tag isEqualToString:@"Noun"]) {
                              lastNoun = tag;
                              NSString *stemmedStr  = [iItemText substringWithRange:tokenRange];
                              if ([nounArr containsObject:stemmedStr]) {
                                  int itemLoc = [nounArr indexOfObject:stemmedStr];
                                  int k  = [[nounHistArr objectAtIndex:itemLoc] integerValue];
                                  k = k +1;
                                  [nounHistArr replaceObjectAtIndex:itemLoc withObject:[NSNumber numberWithInt:k]];
                              } else{
                                  
                                  [nounArr addObject:stemmedStr];
                                  [nounHistArr addObject:[NSNumber numberWithInt:1]];
                              }
                              
                          } else if ([tag isEqualToString:@"Verb"]) {
                              NSString *stemmedStr  = [PorterStemmer stemFromString:[iItemText substringWithRange:tokenRange]];
                              if ([verbArr containsObject:stemmedStr]) {
                                  int itemLoc = [verbArr indexOfObject:stemmedStr];
                                  int k  = [[verbHistArr objectAtIndex:itemLoc] integerValue];
                                  k = k +1;
                                  [verbHistArr replaceObjectAtIndex:itemLoc withObject:[NSNumber numberWithInt:k]];
                              } else{
                                  
                                  [verbArr addObject:stemmedStr];
                                  [verbHistArr addObject:[NSNumber numberWithInt:1]];
                              }
                              
                          } else if ([tag isEqualToString:@"Adverb"]) {
                              NSString *stemmedStr  = [iItemText substringWithRange:tokenRange];
                              if ([adverbArr containsObject:stemmedStr]) {
                                  int itemLoc = [adverbArr indexOfObject:stemmedStr];
                                  int k  = [[adverbHistArr objectAtIndex:itemLoc] integerValue];
                                  k = k +1;
                                  [adverbHistArr replaceObjectAtIndex:itemLoc withObject:[NSNumber numberWithInt:k]];
                              } else{
                                  
                                  [adverbArr addObject:stemmedStr];
                                  [adverbHistArr addObject:[NSNumber numberWithInt:1]];
                              }
                              
                          } else if ([tag isEqualToString:@"Adjective"]) {
                              NSString *stemmedStr  = [PorterStemmer stemFromString:[iItemText substringWithRange:tokenRange]];
                              if ([adjectiveArr containsObject:stemmedStr]) {
                                  int itemLoc = [adjectiveArr indexOfObject:stemmedStr];
                                  int k  = [[adjectiveHistArr objectAtIndex:itemLoc] integerValue];
                                  k = k +1;
                                  [adjectiveHistArr replaceObjectAtIndex:itemLoc withObject:[NSNumber numberWithInt:k]];
                              } else{
                                  
                                  [adjectiveArr addObject:stemmedStr];
                                  [adjectiveHistArr addObject:[NSNumber numberWithInt:1]];
                              }
                              
                          } else if ([tag isEqualToString:@"Number"]) {
                              NSString *stemmedStr  = [iItemText substringWithRange:tokenRange];
                              if ([numberArr containsObject:stemmedStr]) {
                                  int itemLoc = [numberArr indexOfObject:stemmedStr];
                                  int k  = [[numberHistArr objectAtIndex:itemLoc] integerValue];
                                  k = k +1;
                                  [numberHistArr replaceObjectAtIndex:itemLoc withObject:[NSNumber numberWithInt:k]];
                              } else{
                                  
                                  [numberArr addObject:stemmedStr];
                                  [numberHistArr addObject:[NSNumber numberWithInt:1]];
                              }
                              
                          } else if ([tag isEqualToString:@"Pronoun"]) {
                              NSString *stemmedStr  = [iItemText substringWithRange:tokenRange];
                              if ([pronounArr containsObject:stemmedStr]) {
                                  int itemLoc = [pronounArr indexOfObject:stemmedStr];
                                  int k  = [[pronounHistArr objectAtIndex:itemLoc] integerValue];
                                  k = k +1;
                                  [pronounHistArr replaceObjectAtIndex:itemLoc withObject:[NSNumber numberWithInt:k]];
                              } else{
                                  
                                  [pronounArr addObject:stemmedStr];
                                  [pronounHistArr addObject:[NSNumber numberWithInt:1]];
                              }
                              
                              
                          } else if ([tag isEqualToString:@"OtherWord"]) {
                              NSString *stemmedStr  = [iItemText substringWithRange:tokenRange];
                              if ([otherWordArr containsObject:stemmedStr]) {
                                  int itemLoc = [otherWordArr indexOfObject:stemmedStr];
                                  int k  = [[otherWordHistArr objectAtIndex:itemLoc] integerValue];
                                  k = k +1;
                                  [otherWordHistArr replaceObjectAtIndex:itemLoc withObject:[NSNumber numberWithInt:k]];
                              } else{
                                  
                                  [otherWordArr addObject:stemmedStr];
                                  [otherWordHistArr addObject:[NSNumber numberWithInt:1]];
                              }
                              
                          } else if ([tag isEqualToString:@"Interjection"]) {
                              NSString *stemmedStr  = [iItemText substringWithRange:tokenRange];
                              if ([interJectionArr containsObject:stemmedStr]) {
                                  int itemLoc = [interJectionArr indexOfObject:stemmedStr];
                                  int k  = [[interJectionHistArr objectAtIndex:itemLoc] integerValue];
                                  k = k +1;
                                  [interJectionHistArr replaceObjectAtIndex:itemLoc withObject:[NSNumber numberWithInt:k]];
                              } else{
                                  
                                  [interJectionArr addObject:stemmedStr];
                                  [interJectionHistArr addObject:[NSNumber numberWithInt:1]];
                              }
                              
                          }
                          
                          
                          
                          
                          if ([[[[DataClass class] sharedManager] stopWordsArray] containsObject:[iItemText substringWithRange:tokenRange]]) {
                          } else {
                              
                              if ([tag isEqualToString:@"Noun"]) {
                                  NSString *stemmedStr  = [iItemText substringWithRange:tokenRange];
                                  if ([wordsArr containsObject:stemmedStr]) {
                                      int itemLoc = [wordsArr indexOfObject:stemmedStr];
                                      int k  = [[histArr objectAtIndex:itemLoc] integerValue];
                                      k = k +1;
                                      [histArr replaceObjectAtIndex:itemLoc withObject:[NSNumber numberWithInt:k]];
                                  } else{
                                      
                                      [wordsArr addObject:stemmedStr];
                                      [histArr addObject:[NSNumber numberWithInt:1]];
                                  }
                                  [speechArr addObject:tag];
                              } else{
                                  
                                  NSString *stemmedStr = [PorterStemmer stemFromString:[iItemText substringWithRange:tokenRange]];
                                  if ([[iItemText substringWithRange:tokenRange] length] != [stemmedStr length]) {
                                      //                                  NSLog(@"found:%@ %@ (%@)",[iItemText substringWithRange:tokenRange], stemmedStr, tag);
                                  }
                                  
                                  if ([wordsArr containsObject:stemmedStr]) {
                                      int itemLoc = [wordsArr indexOfObject:stemmedStr];
                                      int k  = [[histArr objectAtIndex:itemLoc] integerValue];
                                      k = k +1;
                                      [histArr replaceObjectAtIndex:itemLoc withObject:[NSNumber numberWithInt:k]];
                                  } else{
                                      
                                      [wordsArr addObject:stemmedStr];
                                      [histArr addObject:[NSNumber numberWithInt:1]];
                                  }
                                  [speechArr addObject:tag];
                              }
                          }
                      }];
    
    for (int l =0; l < [wordsArr count]; l++) {
        //        NSLog(@"%@(%@)",[wordsArr objectAtIndex:l],[histArr objectAtIndex:l]);
    }
    
    NSMutableDictionary *tDict = [[NSMutableDictionary alloc] init];
    
    for (int m =0; m < 8; m++) {
        NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
        if (m == 0) {
            [tempDict setObject:nounArr forKey:@"nounList"];
            [tempDict setObject:nounHistArr forKey:@"nounHist"];
            [tDict setObject:tempDict forKey:@"noun"];
        } else if (m == 1) {
            [tempDict setObject:verbArr forKey:@"verbList"];
            [tempDict setObject:verbHistArr forKey:@"verbHist"];
            [tDict setObject:tempDict forKey:@"verb"];
        } else if (m == 2) {
            [tempDict setObject:adverbArr forKey:@"adverbList"];
            [tempDict setObject:adverbHistArr forKey:@"adverbHist"];
            [tDict setObject:tempDict forKey:@"adverb"];
        } else if (m == 3) {
            [tempDict setObject:adjectiveArr forKey:@"adjectiveList"];
            [tempDict setObject:adjectiveHistArr forKey:@"adjectiveHist"];
            [tDict setObject:tempDict forKey:@"adjective"];
        } else if (m == 4) {
            [tempDict setObject:numberArr forKey:@"numberList"];
            [tempDict setObject:numberHistArr forKey:@"numberHist"];
            [tDict setObject:tempDict forKey:@"number"];
        } else if (m == 5) {
            [tempDict setObject:pronounArr forKey:@"pronounList"];
            [tempDict setObject:pronounHistArr forKey:@"pronounHist"];
            [tDict setObject:tempDict forKey:@"pronoun"];
        } else if (m == 6) {
            [tempDict setObject:otherWordArr forKey:@"otherList"];
            [tempDict setObject:otherWordHistArr forKey:@"otherHist"];
            [tDict setObject:tempDict forKey:@"otherWord"];
        } else if (m == 7) {
            [tempDict setObject:interJectionArr forKey:@"interjectionList"];
            [tempDict setObject:interJectionHistArr forKey:@"interjectionHist"];
            [tDict setObject:tempDict forKey:@"interjection"];
        }
    }
    
    [histArray setObject:wordsArr forKey:@"WordsArr"];
    [histArray setObject:histArr forKey:@"HistArr"];
    [histArray setObject:tDict forKey:@"EngArr"];
    //    [dict setObject:speechArr forKey:@"SpeechArr"];
    
    //    NSLog(@"Hist array....%@",histArray);
    return histArray;
}

-(float )getBhattacharyaCoefficientforString1:(NSDictionary *)dict1 string2:(NSDictionary *)dict2 {
    
    //    NSLog(@"dict1...%@",dict1);
    //    NSLog(@"******************************");
    //    NSLog(@"dict2...%@",dict2);
    
    float distance = 0.0f;
    NSArray *hArr = [dict1 objectForKey:@"HistArr"];
    NSArray *hArr1 = [dict2 objectForKey:@"HistArr"];
    
    NSArray *arr2 = [dict1 objectForKey:@"WordsArr"];
    NSArray *arr1 = [dict2 objectForKey:@"WordsArr"];
    
    float count = 0;
    int wordsLength1 = [arr2 count];
    int wordsLength2 = [arr1 count];
    
    for (int k = 0; k< [arr2 count]; k++) {
        NSString *str = [arr2 objectAtIndex:k];
        for (int j = 0; j < [arr1 count]; j++) {
            NSString *str1 = [arr1 objectAtIndex:j];
            if ([str isEqualToString:str1] && [str length] > 1) {
                NSNumber *num = [hArr objectAtIndex:k];
                NSNumber *num1 = [hArr1 objectAtIndex:j];
                double dNum = [num doubleValue];
                double dNum1 = [num1 doubleValue];
                count = count + sqrt((dNum*dNum1)/(wordsLength1*wordsLength2));
                
                NSString* formattedNumber = [NSString stringWithFormat:@"%.05f", count];
                count = [formattedNumber floatValue];
            }
        }
    }
    
    if (count == 0) {
        //       NSLog(@"No match found.");
    } else {
        //        NSLog(@"distance....%.2f",count);
        
        distance = -log(count);
        NSString* formattedNumber = [NSString stringWithFormat:@"%.02f", count];
        count = [formattedNumber floatValue];
        //       NSLog(@"distance....%.2f",distance);
    }
    
    return count;
    
}

-(NSMutableArray *)removeOldNews:(NSArray *)iArray {
    
    NSMutableArray *finalArray = [[NSMutableArray alloc] init];
    
    NSDate *currentTime = [NSDate date];
    
    for(MWFeedItem *feed in iArray) {
        //        NSLog(@"date....%@",feed.date);
        NSTimeInterval secondsBetween = [currentTime timeIntervalSinceDate:feed.date];
        
        if (secondsBetween > 86400) {
            
        } else{
            [finalArray addObject:feed];
        }
        
    }
    
    return finalArray;
}


-(NSMutableArray *)removeBlockedNews:(NSArray *)iArray {
    
    if ([[[[DataClass class] sharedManager] blockedArray] count]> 0) {
        
        NSMutableArray *finalArray = [[NSMutableArray alloc] initWithArray:iArray];
        NSMutableIndexSet *mutableIndexSet = [[NSMutableIndexSet alloc] init];
        
        for(int n = 0; n < [iArray count]; n++) {
            NSArray *itemArray = [iArray objectAtIndex:n];
            
            for (int h = 0; h < [[[[DataClass class] sharedManager] blockedArray] count]; h++) {
                NSArray *blockArr = [[[[DataClass class] sharedManager] blockedArray] objectAtIndex:h];
                //            NSLog(@"itemArray...%@",itemArray);
                //            NSLog(@"******************************");
                //            NSLog(@"blockArr...%@",blockArr);
                
                NSDictionary *firTempArr;
                
                NSDictionary *secTempArr;
                
                if ([[itemArray objectAtIndex:1] isKindOfClass:[NSArray class]]) {
                    firTempArr = [[itemArray objectAtIndex:0] objectAtIndex:1];
                } else if ([[itemArray objectAtIndex:1] isKindOfClass:[NSDictionary class]]) {
                    firTempArr = [itemArray objectAtIndex:1];
                }
                
                if ([[blockArr objectAtIndex:1] isKindOfClass:[NSArray class]]) {
                    secTempArr = [[blockArr objectAtIndex:0] objectAtIndex:1];
                } else if ([[blockArr objectAtIndex:1] isKindOfClass:[NSDictionary class]]) {
                    secTempArr = [blockArr objectAtIndex:1];
                }
                
                //            float val = [self getBhattacharyaCoefficientforString1:firTempArr string2:secTempArr];
                BOOL val1 = [self similarityBetweendictionary1:firTempArr dictionary2:secTempArr];
                
                //            if (val >= 0.27) {
                
                if (val1) {
                    [mutableIndexSet addIndex:n];
                    break;
                }
            }
        }
        
        //    NSLog(@"removable Indexes...%@",mutableIndexSet);
        
        [finalArray removeObjectsAtIndexes:mutableIndexSet];
        
        
        return finalArray;
    } else{
        NSMutableArray *finalArray = [[NSMutableArray alloc] initWithArray:iArray];
        
        return finalArray;
    }
    
}

-(void)removeWatchedNews{
    
    //    NSLog(@"speechArray...%@",speechArray);
    
    //    NSArray *iArray = [NSArray arrayWithArray:];
    
    NSMutableArray *finalArray = [[NSMutableArray alloc] initWithArray:self.feedsArray];
    NSMutableArray *wItemArray = [[NSMutableArray alloc] initWithArray:[[[DataClass class] sharedManager] watchingArray]];
    
    if ([finalArray count]> 0 && [[[[DataClass class] sharedManager] watchingArray] count]> 0 ) {
        
        NSMutableIndexSet *mutableIndexSet = [[NSMutableIndexSet alloc] init];
        
        
        for(int n = 0; n < [finalArray count]; n++) {
            
            NSArray *individualFeedItemArr = [finalArray objectAtIndex:n];
            
            BOOL multipleArray = NO;
            
            if ([[individualFeedItemArr objectAtIndex:0] isKindOfClass:[NSArray class]]) {
                multipleArray = YES;
            } else{
                multipleArray = NO;
            }
            
            MWFeedItem *presentItem;
            NSDictionary *presentItemDict;
            
            if (multipleArray) {
                presentItem = [[individualFeedItemArr objectAtIndex:0] objectAtIndex:0];
                presentItemDict = [[individualFeedItemArr objectAtIndex:0] objectAtIndex:1];
            } else{
                presentItem = [individualFeedItemArr objectAtIndex:0];
                presentItemDict = [individualFeedItemArr objectAtIndex:1];
            }
            
            
            for (int h = 0; h < [wItemArray count]; h++) {
                
                NSMutableDictionary *individualWatchItemArr = [[NSMutableDictionary alloc] init];
                individualWatchItemArr = [wItemArray objectAtIndex:h];
                
                
                NSArray *previousFeeditemArr = [individualWatchItemArr valueForKey:@"currentUpdate"];
                
                BOOL multipleArray1 = NO;
                
                if ([[previousFeeditemArr objectAtIndex:0] isKindOfClass:[NSArray class]]) {
                    multipleArray1 = YES;
                } else{
                    multipleArray1 = NO;
                }
                
                MWFeedItem *previousItem;
                NSDictionary *previousItemDict;
                
                if (multipleArray1) {
                    previousItem = [[previousFeeditemArr objectAtIndex:0] objectAtIndex:0];
                    previousItemDict = [[previousFeeditemArr objectAtIndex:0] objectAtIndex:1];
                } else{
                    previousItem = [previousFeeditemArr objectAtIndex:0];
                    previousItemDict = [previousFeeditemArr objectAtIndex:1];
                }
                
                if (presentItem.title != previousItem.title) {
                    
                    //float val = [self getBhattacharyaCoefficientforString1:presentItemDict string2:previousItemDict];
                    BOOL val1 = [self similarityBetweendictionary1:presentItemDict dictionary2:previousItemDict];
                    
                    
                    //                if (val >= 0.27) {
                    if (val1) {
                        
                        
                        if (![[individualWatchItemArr  objectForKey:@"timeline"] isKindOfClass:[NSString class]]) {
                            //                        NSArray *arr = [[individualWatchItemArr  objectForKey:@"timeline"] allKeys];
                            //                        NSArray *myArray = [arr sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"doubleValue" ascending:YES]]];
                            //
                            int itemNumToInsert = [arr count];
                            NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] initWithDictionary:[individualWatchItemArr objectForKey:@"timeline"]];
                            [tempDict setObject:previousFeeditemArr forKey:[NSString stringWithFormat:@"%d",itemNumToInsert]];
                            
                            int updatesCount = [[tempDict valueForKey:@"updatesToday"] intValue];
                            updatesCount = updatesCount+1;
                            
                            [individualWatchItemArr setObject:tempDict forKey:@"timeline"];
                            [individualWatchItemArr setObject:[NSString stringWithFormat:@"%d",updatesCount] forKey:@"updatesToday"];
                            [individualWatchItemArr setObject:individualFeedItemArr forKey:@"currentUpdate"];
                            
                            [wItemArray replaceObjectAtIndex:h withObject:individualWatchItemArr];
                            
                        } else{
                            NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
                            [tempDict setObject:previousFeeditemArr forKey:@"0"];
                            [individualWatchItemArr setObject:@"1" forKey:@"updatesToday"];
                            [individualWatchItemArr setObject:tempDict forKey:@"timeline"];
                            [wItemArray replaceObjectAtIndex:h withObject:individualWatchItemArr];
                        }
                        
                        //                    [individualWatchItemArr setObject:previousFeeditemArr forKey:@"timeline"];
                        
                        [mutableIndexSet addIndex:n];
                        
                        [[[DataClass class] sharedManager] setWatchingArray:wItemArray];
                        wItemArray = [[NSMutableArray alloc] initWithArray:[[[DataClass class] sharedManager] watchingArray]];
                    }
                }
                
            }
        }
        
        //    NSLog(@"removable Indexes...%@",mutableIndexSet);
        if ([mutableIndexSet count] > 0) {
            [finalArray removeObjectsAtIndexes:mutableIndexSet];
        }
        
        self.feedsArray = finalArray;
        
        //        [[[DataClass class] sharedManager] setFeedsArray:finalArray];
        
        [self updateFeedsArray];
        
        
    } else{
        
    }
    
    
    
}

-(BOOL)similarityBetweendictionary1:(NSDictionary *)iDict1 dictionary2:(NSDictionary *)iDict2{
    
    
    if ([speechArr count] == 0) {
        speechArr = [[NSArray alloc] initWithObjects:@"noun",@"verb",@"adverb",@"adjective",@"number",@"pronoun",@"otherWord",@"interjection", nil];
    }
    
    NSMutableDictionary *resultDict = [[NSMutableDictionary alloc] init];
    
    NSDictionary *subDict1 = [iDict1 objectForKey:@"EngArr"];
    NSDictionary *subDict2 = [iDict2 objectForKey:@"EngArr"];
    
    //    NSNumber *nounFloat = [NSNumber numberWithFloat:0.0];
    //    NSNumber *verbFloat = [NSNumber numberWithFloat:0.0];
    //    NSNumber *adverbFloat = [NSNumber numberWithFloat:0.0];
    //    NSNumber *adjectiveFloat = [NSNumber numberWithFloat:0.0];
    //    NSNumber *pronounFloat = [NSNumber numberWithFloat:0.0];
    //    NSNumber *numberFloat = [NSNumber numberWithFloat:0.0];
    //    NSNumber *otherFloat = [NSNumber numberWithFloat:0.0];
    //    NSNumber *interjectionFloat = [NSNumber numberWithFloat:0.0];
    //
    //    BOOL similarityEnough = NO;
    float distance = 0.0f;
    for (int m = 0;m < [speechArr count]; m++) {
        
        
        NSString *iSpeech = [speechArr objectAtIndex:m];
        
        NSString *key1;
        NSString *key2;
        
        if ([iSpeech isEqualToString:@"noun"]) {
            key1 = @"nounList";
            key2 = @"nounHist";
        } else if ([iSpeech isEqualToString:@"verb"]) {
            key1 = @"verbList";
            key2 = @"verbHist";
        } else if ([iSpeech isEqualToString:@"adverb"]) {
            key1 = @"adverbList";
            key2 = @"adverbHist";
        } else if ([iSpeech isEqualToString:@"adjective"]) {
            key1 = @"adjectiveList";
            key2 = @"adjectiveHist";
        } else if ([iSpeech isEqualToString:@"number"]) {
            key1 = @"numberList";
            key2 = @"numberHist";
        } else if ([iSpeech isEqualToString:@"pronoun"]) {
            key1 = @"pronounList";
            key2 = @"pronounHist";
        } else if ([iSpeech isEqualToString:@"otherWord"]) {
            key1 = @"otherList";
            key2 = @"otherHist";
        } else if ([iSpeech isEqualToString:@"interjection"]) {
            key1 = @"interjectionList";
            key2 = @"interjectionHist";}
        
        NSArray *arr2 = [[subDict2 objectForKey:iSpeech] objectForKey:key1];
        NSArray *hArr2 = [[subDict2 objectForKey:iSpeech] objectForKey:key2];
        
        NSArray *arr1 = [[subDict1 objectForKey:iSpeech] objectForKey:key1];
        NSArray *hArr1 = [[subDict1 objectForKey:iSpeech] objectForKey:key2];
        
        float count = 0;
        int wordsLength1 = [arr1 count];
        int wordsLength2 = [arr2 count];
        
        if (wordsLength1 > 0 && wordsLength2 > 0) {
            
            NSMutableSet *set1 = [NSMutableSet setWithArray: arr1];
            NSSet *set2 = [NSSet setWithArray: arr2];
            [set1 intersectSet: set2];
            NSArray *resultArray = [set1 allObjects];
            
            //        NSLog(@"result Array....%@",resultArray);
            
            for (int l = 0; l <[resultArray count]; l++) {
                int index1 = [arr1 indexOfObject:[resultArray objectAtIndex:l]];
                int index2 = [arr2 indexOfObject:[resultArray objectAtIndex:l]];
                NSNumber *num2 = [hArr2 objectAtIndex:index2];
                NSNumber *num1 = [hArr1 objectAtIndex:index1];
                double dNum2 = [num2 doubleValue];
                double dNum1 = [num1 doubleValue];
                count = count + sqrt((dNum2*dNum1)/(wordsLength1*wordsLength2));
            }
            
            //        NSLog(@"resultArray...%@",resultArray);
            
            
            if (count == 0) {
            } else {
                distance = -log(count);
                //        NSLog(@"distance... %.05f",distance);
                
                //        if ([iSpeech isEqualToString:@"noun"]) {
                //            nounFloat = [NSNumber numberWithFloat:count];
                //        } else if ([iSpeech isEqualToString:@"verb"]) {
                //            verbFloat = [NSNumber numberWithFloat:count];
                //        } else if ([iSpeech isEqualToString:@"adverb"]) {
                //            adverbFloat = [NSNumber numberWithFloat:count];
                //        } else if ([iSpeech isEqualToString:@"adjective"]) {
                //            adjectiveFloat = [NSNumber numberWithFloat:count];
                //        } else if ([iSpeech isEqualToString:@"number"]) {
                //            numberFloat = [NSNumber numberWithFloat:count];
                //        } else if ([iSpeech isEqualToString:@"pronoun"]) {
                //            pronounFloat = [NSNumber numberWithFloat:count];
                //        } else if ([iSpeech isEqualToString:@"otherWord"]) {
                //            otherFloat = [NSNumber numberWithFloat:count];
                //        } else if ([iSpeech isEqualToString:@"interjection"]) {
                //            interjectionFloat = [NSNumber numberWithFloat:count];
                //        }
                //
                
                //        if (([nounFloat floatValue] >= LOWER_LIMIT) && ([nounFloat floatValue] <= UPPER_LIMIT)) {
                //            if (([verbFloat floatValue] >= LOWER_LIMIT) && ([verbFloat floatValue] <= UPPER_LIMIT)) {
                //                if (([adverbFloat floatValue] >= LOWER_LIMIT) && ([adverbFloat floatValue] <= UPPER_LIMIT)) {
                // //                   NSLog(@"subDict1....%@",subDict1);
                // //                   NSLog(@"subDict2....%@",subDict2);
                // //                   NSLog(@"*********************************************");
                //                }
                //            }
                //        }
                
                NSNumber *num = [NSNumber numberWithFloat:count];
                [resultDict setObject:num forKey:iSpeech];
                
                if (m == 0 && count > 0.5) {
                    return YES;
                } else if (( m == 1 && count > 0.5) && ([[resultDict objectForKey:@"noun"] floatValue] > 0.27)) {
                    return YES;
                } else if ( m == 2 && count > 0.5 && ([[resultDict objectForKey:@"noun"] floatValue] > 0.27)) {
                    return YES;
                } else if ( m == 3 && count > 0.5 && ([[resultDict objectForKey:@"noun"] floatValue] > 0.27)) {
                    return YES;
                }
            }
        }
    }
    return NO;
}





-(void)showPreview {
    HUD.status = @"Please feel free to read the preview while we get News sorted out for you.";
    
    //create the scrollview with specific frame
    ALScrollViewPaging *scrollView = [[ALScrollViewPaging alloc] initWithFrame:CGRectMake(10, 30, 290, 300)];
    //array for views to add to the scrollview
    NSMutableArray *views = [[NSMutableArray alloc] init];
    
    //cycle which creates views for the scrollview
    for (int i = 0; i < [self.feedsArray count]; i++) {
        MWFeedItem *item = [[self.feedsArray objectAtIndex:i] objectAtIndex:0];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 300)];
        view.backgroundColor = [UIColor clearColor];
        
        UILabel *heading = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 270, 90)];
        heading.textColor = [UIColor whiteColor];
        heading.text = item.title;
        heading.numberOfLines = 3;
        [heading setFont:[UIFont fontWithName:@"Signika-Light" size:16]];
        heading.backgroundColor = [UIColor clearColor];
        [views addObject:heading];
    }
    
    //add pages to scrollview
    [scrollView addPages:views];
    
    //add scrollview to the view
    [HUD addSubview:scrollView];
    
    [scrollView setHasPageControl:YES];
    
    
    
    
}

- (void)progressChanged:(id)sender
{
    [self.navigationController setProgress:_progressSlider.value animated:NO];
}

- (void)indeterminateChanged:(id)sender
{
    [self.navigationController setIndeterminate:_indeterminateSwitch.on];
}

- (void)animateProgress:(id)sender
{
    //Disable other controls
    _progressSlider.enabled = NO;
    _indeterminateSwitch.enabled = NO;
    //    [self.navigationController setProgress:.5 animated:YES];
    
    //    [self performSelector:@selector(setQuarter) withObject:Nil afterDelay:1];
}

- (void)setComplete
{
    [self.navigationController finishProgress];
}

- (void)titleChanged:(id)sender
{
    if (_titleSwitch.on) {
        [self.navigationController setProgressTitle:@"Processing..."];
    } else {
        [self.navigationController setProgressTitle:nil];
    }
}

- (void)finish:(id)sender
{
    [self.navigationController finishProgress];
}

- (void)cancel:(id)sender
{
    [self.navigationController cancelProgress];
}




@end
