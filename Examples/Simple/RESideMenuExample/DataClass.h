//
//  DataClass.h
//  Example
//
//  Created by Praveen Kumar on 27/12/2013.
//  Copyright (c) 2013 Monospace Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataClass : NSObject {
    NSMutableDictionary *channelsArray;
    NSMutableDictionary *nameList;
    NSMutableDictionary *channelDict;
    NSString *module;
    NSArray *categoryList;
    NSArray *stopWordsArray;
    
    //Cached Data
    NSMutableArray *topStoriesArray;
    NSMutableArray *indiaArray;
    NSMutableArray *worldArray;
    NSMutableArray *businessArray;
    NSMutableArray *technologyArray;
    NSMutableArray *sportArray;
    NSMutableArray *entertainmentArray;
    NSMutableArray *lifeStyleArray;
    NSMutableArray *healthArray;
    NSMutableArray *nriArray;
    
    NSMutableArray *watchingArray;
    NSMutableArray *blockedArray;
    
    NSArray *backgroundImages;
    NSMutableArray *blockedLogoImages;
    
    NSMutableDictionary *updatedTimeDict;
    
    NSString *timeToBeDisplayed;
    
    UIView *navTitleView;
    
    NSMutableArray *feedsArray;
    
    

}

@property (strong, nonatomic) NSMutableDictionary *channelsArray;
@property (strong, nonatomic) NSMutableDictionary *nameList;
@property (strong, nonatomic) NSMutableDictionary *channelDict;
@property (strong, nonatomic) NSString *module;
@property (strong, nonatomic) NSArray *categoryList;
@property (strong, nonatomic) NSArray *stopWordsArray;

@property (strong, nonatomic) NSMutableArray *feedsArray;

@property (strong, nonatomic) NSMutableArray *topStoriesArray;
@property (strong, nonatomic) NSMutableArray *indiaArray;
@property (strong, nonatomic) NSMutableArray *worldArray;
@property (strong, nonatomic) NSMutableArray *businessArray;
@property (strong, nonatomic) NSMutableArray *technologyArray;
@property (strong, nonatomic) NSMutableArray *sportArray;
@property (strong, nonatomic) NSMutableArray *entertainmentArray;
@property (strong, nonatomic) NSMutableArray *lifeStyleArray;
@property (strong, nonatomic) NSMutableArray *healthArray;
@property (strong, nonatomic) NSMutableArray *nriArray;

@property (strong, nonatomic) NSMutableArray *watchingArray;
@property (strong, nonatomic) NSMutableArray *blockedArray;

@property (strong, nonatomic) NSArray *backgroundImages;
@property (strong, nonatomic) NSMutableArray *blockedLogoImages;
@property (strong, nonatomic) NSMutableDictionary *updatedTimeDict;
@property (strong, nonatomic) NSString *timeToBeDisplayed;

@property (strong,nonatomic) UIView *navTitleView;


+ (id)sharedManager;
-(NSString *)getChannelNameFromLink:(NSString *)iStr;
-(void)updateTime;
-(void)encodeAndSaveData;
-(void)setNavTitle:(NSString *)iTitle :(NSString *)iSubtitle;



@end