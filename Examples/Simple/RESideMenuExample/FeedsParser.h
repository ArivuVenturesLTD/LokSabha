//
//  FeedsParser.h
//  PDGesturedTableView
//
//  Created by Praveen Kumar on 01/12/2013.
//  Copyright (c) 2013 David Román Aguirre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWFeedParser.h"


@interface FeedsParser : NSObject<MWFeedParserDelegate>{
    // Parsing
	MWFeedParser *feedParser;
	NSMutableArray *parsedItems;
    int linkRef;
    NSMutableArray *parsedArr;
    

}

@property (nonatomic, strong) NSMutableArray *parsedItems;
@property (nonatomic, strong) NSMutableArray *parsedArr;
@property (nonatomic,strong) MWFeedParser *feedParser;

-(id)initWithURL:(NSString *)iStr withRef:(int)iLinkRef;


@end
