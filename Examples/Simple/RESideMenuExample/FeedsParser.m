//
//  FeedsParser.m
//  PDGesturedTableView
//
//  Created by Praveen Kumar on 01/12/2013.
//  Copyright (c) 2013 David Román Aguirre. All rights reserved.
//

#import "FeedsParser.h"
#import "NSString+HTML.h"
#import "MWFeedParser.h"

@implementation FeedsParser

@synthesize parsedItems= _parsedItems,parsedArr,feedParser;

-(id)initWithURL:(NSString *)iStr withRef:(int)iLinkRef{
    if (self=[super init]) {
        _parsedItems = [[NSMutableArray alloc] init];
        self.feedParser = [[MWFeedParser alloc] initWithFeedURL:[NSURL URLWithString:iStr]];
        self.feedParser.delegate = self;
        self.feedParser.feedParseType = ParseTypeFull; // Parse feed info and all items
        self.feedParser.connectionType = ConnectionTypeSynchronously;
        [self.feedParser parse];
        linkRef = iLinkRef;
        
        
    }
    return self;
    
}

- (void)updateTableWithParsedItems{
    
    NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[NSNumber numberWithInt:linkRef] forKey:@"linkRef"];
    [userInfo setObject:_parsedItems forKey:@"items"];
    [userInfo setObject:@"1" forKey:@"add"];
    
    self.parsedArr = [[NSMutableArray alloc] initWithArray:_parsedItems];
    
//    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
//    [nc postNotificationName:@"dataReceived" object:self userInfo:userInfo];
    
}




#pragma mark -
#pragma mark MWFeedParserDelegate

- (void)feedParserDidStart:(MWFeedParser *)parser {
//    	NSLog(@"Started Parsing: %@", parser.url);
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info {
//    	NSLog(@"Parsed Feed Info: “%@”", info.title);
    //	self.title = info.title;
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
//    	NSLog(@"Parsed Feed Item: “%@”", item.title);
	if (item){
        NSDate* timeNow = [NSDate date];
        
        // If less than 30 seconds, do something
        if ([timeNow timeIntervalSinceDate:item.date] < 86400.0f)
        {
            [_parsedItems addObject:item];
        }
    }
}

- (void)feedParserDidFinish:(MWFeedParser *)parser {
//    	NSLog(@"Finished Parsing%@", (parser.stopped ? @" (Stopped)" : @""));
    [self updateTableWithParsedItems];
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
//    	NSLog(@"Finished Parsing With Error: %@", error);
    if (_parsedItems.count == 0) {
        //        self.title = @"Failed"; // Show failed message in title
    } else {
        // Failed but some items parsed, so show and inform of error
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Parsing Incomplete"
        //                                                         message:@"There was an error during the parsing of this feed. Not all of the feed items could parsed."
        //                                                        delegate:nil
        //                                               cancelButtonTitle:@"Dismiss"
        //                                               otherButtonTitles:nil];
        //        [alert show];
    }
    //    [self updateTableWithParsedItems];
    
    NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:@"" forKey:@"linkRef"];
    [userInfo setObject:@"" forKey:@"items"];
    [userInfo setObject:@"-1" forKey:@"add"];
    
    self.parsedArr = [[NSMutableArray alloc] init];

    
//    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
//    [nc postNotificationName:@"dataReceived" object:self userInfo:userInfo];
}



@end
