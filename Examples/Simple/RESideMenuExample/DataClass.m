//
//  DataClass.m
//  Example
//
//  Created by Praveen Kumar on 27/12/2013.
//  Copyright (c) 2013 Monospace Ltd. All rights reserved.
//

#import "DataClass.h"

@implementation DataClass

@synthesize channelsArray,nameList,channelDict,module,categoryList,stopWordsArray,technologyArray,topStoriesArray,indiaArray,watchingArray,worldArray,blockedArray,businessArray,entertainmentArray,healthArray,lifeStyleArray,nriArray,sportArray,blockedLogoImages,backgroundImages,timeToBeDisplayed,updatedTimeDict,navTitleView,feedsArray;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static DataClass *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        self.nameList = [[NSMutableDictionary alloc] init];
        self.channelsArray = [[NSMutableDictionary alloc] init];
        self.module = @"TopStories";
        self.feedsArray = [[NSMutableArray alloc] init];
        self.topStoriesArray = [[NSMutableArray alloc] init];
        self.indiaArray = [[NSMutableArray alloc] init];
        self.worldArray = [[NSMutableArray alloc] init];
        self.businessArray = [[NSMutableArray alloc] init];
        self.technologyArray = [[NSMutableArray alloc] init];
        self.sportArray = [[NSMutableArray alloc] init];
        self.entertainmentArray = [[NSMutableArray alloc] init];
        self.lifeStyleArray = [[NSMutableArray alloc] init];
        self.healthArray = [[NSMutableArray alloc] init];
        self.nriArray = [[NSMutableArray alloc] init];
        self.watchingArray = [[NSMutableArray alloc] init];
        self.blockedArray = [[NSMutableArray alloc] init];
        self.backgroundImages = [NSArray arrayWithObjects:@"back0.jpg",@"back1.jpg",@"back2.jpg",@"back3.jpg",@"back4.jpg",@"back5.jpg",@"back6.jpg",@"back7.jpg",@"back8.jpg",@"back8.jpg",@"back9.jpg",@"back10.jpg",@"back11.jpg", nil];
        self.blockedLogoImages = [[NSMutableArray alloc] init];
        self.updatedTimeDict = [[NSMutableDictionary alloc] init];
        self.stopWordsArray = [[NSMutableArray alloc] initWithObjects:@"a",@"able",@"about",@"above",@"abst",@"accordance",@"according",@"accordingly",@"across",@"act",@"actually",@"added",@"adj",@"affected",@"affecting",@"affects",@"after",@"afterwards",@"again",@"against",@"ah",@"all",@"almost",@"alone",@"along",@"already",@"also",@"although",@"always",@"am",@"among",@"amongst",@"an",@"and",@"announce",@"another",@"any",@"anybody",@"anyhow",@"anymore",@"anyone",@"anything",@"anyway",@"anyways",@"anywhere",@"apparently",@"approximately",@"are",@"aren",@"arent",@"arise",@"around",@"as",@"aside",@"ask",@"asking",@"at",@"auth",@"available",@"away",@"awfully",@"b",@"back",@"be",@"became",@"because",@"become",@"becomes",@"becoming",@"been",@"before",@"beforehand",@"begin",@"beginning",@"beginnings",@"begins",@"behind",@"being",@"believe",@"below",@"beside",@"besides",@"between",@"beyond",@"biol",@"both",@"brief",@"briefly",@"but",@"by",@"c",@"ca",@"came",@"can",@"cannot",@"can't",@"cause",@"causes",@"certain",@"certainly",@"co",@"com",@"come",@"comes",@"contain",@"containing",@"contains",@"could",@"couldnt",@"d",@"date",@"did",@"didn't",@"different",@"do",@"does",@"doesn't",@"doing",@"done",@"don't",@"down",@"downwards",@"due",@"during",@"e",@"each",@"ed",@"edu",@"effect",@"eg",@"eight",@"eighty",@"either",@"else",@"elsewhere",@"end",@"ending",@"enough",@"especially",@"et",@"et-al",@"etc",@"even",@"ever",@"every",@"everybody",@"everyone",@"everything",@"everywhere",@"ex",@"except",@"f",@"far",@"few",@"ff",@"fifth",@"first",@"five",@"fix",@"followed",@"following",@"follows",@"for",@"former",@"formerly",@"forth",@"found",@"four",@"from",@"further",@"furthermore",@"g",@"gave",@"get",@"gets",@"getting",@"give",@"given",@"gives",@"giving",@"go",@"goes",@"gone",@"got",@"gotten",@"h",@"had",@"happens",@"hardly",@"has",@"hasn't",@"have",@"haven't",@"having",@"he",@"hed",@"hence",@"her",@"here",@"hereafter",@"hereby",@"herein",@"heres",@"hereupon",@"hers",@"herself",@"hes",@"hi",@"hid",@"him",@"himself",@"his",@"hither",@"home",@"how",@"howbeit",@"however",@"hundred",@"i",@"id",@"ie",@"if",@"i'll",@"im",@"immediate",@"immediately",@"importance",@"important",@"in",@"inc",@"indeed",@"index",@"information",@"instead",@"into",@"invention",@"inward",@"is",@"isn't",@"it",@"itd",@"it'll",@"its",@"itself",@"i've",@"j",@"just",@"k",@"keep",@"keeps",@"kept",@"kg",@"km",@"know",@"known",@"knows",@"l",@"largely",@"last",@"lately",@"later",@"latter",@"latterly",@"least",@"less",@"lest",@"let",@"lets",@"like",@"liked",@"likely",@"line",@"little",@"'ll",@"look",@"looking",@"looks",@"ltd",@"m",@"made",@"mainly",@"make",@"makes",@"many",@"may",@"maybe",@"me",@"mean",@"means",@"meantime",@"meanwhile",@"merely",@"mg",@"might",@"million",@"miss",@"ml",@"more",@"moreover",@"most",@"mostly",@"mr",@"mrs",@"much",@"mug",@"must",@"my",@"myself",@"n",@"na",@"name",@"namely",@"nay",@"nd",@"near",@"nearly",@"necessarily",@"necessary",@"need",@"needs",@"neither",@"never",@"nevertheless",@"new",@"next",@"nine",@"ninety",@"no",@"nobody",@"non",@"none",@"nonetheless",@"noone",@"nor",@"normally",@"nos",@"not",@"noted",@"nothing",@"now",@"nowhere",@"o",@"obtain",@"obtained",@"obviously",@"of",@"off",@"often",@"oh",@"ok",@"okay",@"old",@"omitted",@"on",@"once",@"one",@"ones",@"only",@"onto",@"or",@"ord",@"other",@"others",@"otherwise",@"ought",@"our",@"ours",@"ourselves",@"out",@"outside",@"over",@"overall",@"owing",@"own",@"p",@"page",@"pages",@"part",@"particular",@"particularly",@"past",@"per",@"perhaps",@"placed",@"please",@"plus",@"poorly",@"possible",@"possibly",@"potentially",@"pp",@"predominantly",@"present",@"previously",@"primarily",@"probably",@"promptly",@"proud",@"provides",@"put",@"q",@"que",@"quickly",@"quite",@"qv",@"r",@"ran",@"rather",@"rd",@"re",@"readily",@"really",@"recent",@"recently",@"ref",@"refs",@"regarding",@"regardless",@"regards",@"related",@"relatively",@"research",@"respectively",@"resulted",@"resulting",@"results",@"right",@"run",@"s",@"said",@"same",@"saw",@"say",@"saying",@"says",@"sec",@"section",@"see",@"seeing",@"seem",@"seemed",@"seeming",@"seems",@"seen",@"self",@"selves",@"sent",@"seven",@"several",@"shall",@"she",@"shed",@"she'll",@"shes",@"should",@"shouldn't",@"show",@"showed",@"shown",@"showns",@"shows",@"significant",@"significantly",@"similar",@"similarly",@"since",@"six",@"slightly",@"so",@"some",@"somebody",@"somehow",@"someone",@"somethan",@"something",@"sometime",@"sometimes",@"somewhat",@"somewhere",@"soon",@"sorry",@"specifically",@"specified",@"specify",@"specifying",@"still",@"stop",@"strongly",@"sub",@"substantially",@"successfully",@"such",@"sufficiently",@"suggest",@"sup",@"sure",@"t",@"take",@"taken",@"taking",@"tell",@"tends",@"th",@"than",@"thank",@"thanks",@"thanx",@"that",@"that'll",@"thats",@"that've",@"the",@"their",@"theirs",@"them",@"themselves",@"then",@"thence",@"there",@"thereafter",@"thereby",@"thered",@"therefore",@"therein",@"there'll",@"thereof",@"therere",@"theres",@"thereto",@"thereupon",@"there've",@"these",@"they",@"theyd",@"they'll",@"theyre",@"they've",@"think",@"this",@"those",@"thou",@"though",@"thoughh",@"thousand",@"throug",@"through",@"throughout",@"thru",@"thus",@"til",@"tip",@"to",@"together",@"too",@"took",@"toward",@"towards",@"tried",@"tries",@"truly",@"try",@"trying",@"ts",@"twice",@"two",@"u",@"un",@"under",@"unfortunately",@"unless",@"unlike",@"unlikely",@"until",@"unto",@"up",@"upon",@"ups",@"us",@"use",@"used",@"useful",@"usefully",@"usefulness",@"uses",@"using",@"usually",@"v",@"value",@"various",@"'ve",@"very",@"via",@"viz",@"vol",@"vols",@"vs",@"w",@"want",@"wants",@"was",@"wasn't",@"way",@"we",@"wed",@"welcome",@"we'll",@"went",@"were",@"weren't",@"we've",@"what",@"whatever",@"what'll",@"whats",@"when",@"whence",@"whenever",@"where",@"whereafter",@"whereas",@"whereby",@"wherein",@"wheres",@"whereupon",@"wherever",@"whether",@"which",@"while",@"whim",@"whither",@"who",@"whod",@"whoever",@"whole",@"who'll",@"whom",@"whomever",@"whos",@"whose",@"why",@"widely",@"willing",@"wish",@"with",@"within",@"without",@"won't",@"words",@"world",@"would",@"wouldn't",@"www",@"x",@"y",@"yes",@"yet",@"you",@"youd",@"you'll",@"your",@"youre",@"yours",@"yourself",@"yourselves",@"you've",@"z",@"zero", nil];
        self.channelDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"News" ofType:@"plist"]];
        self.categoryList = [NSArray arrayWithObjects:@"Top Stories",@"India",@"World",@"Business",@"Technology",@"Sport",@"Entertainment",@"Lifestyle",@"Health",@"NRI", nil];
        self.timeToBeDisplayed = @"";
        [self makeChannelList];
        
        self.navTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        [self.navTitleView setBackgroundColor:[UIColor clearColor]];
        
        
        UILabel *mainTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 28)];
        [mainTitle setTag:10];
        [mainTitle setBackgroundColor:[UIColor clearColor]];
        mainTitle.textAlignment = NSTextAlignmentCenter;
        mainTitle.textColor = [UIColor blackColor];
        [mainTitle setFont:[UIFont fontWithName:@"Signika-Regular" size:17]];
        
        
        UILabel *subTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 28, 200, 16)];
        [subTitle setTag:20];
        [subTitle setBackgroundColor:[UIColor clearColor]];
        subTitle.textAlignment = NSTextAlignmentCenter;
        subTitle.textColor = [UIColor lightGrayColor];
        [subTitle setFont:[UIFont fontWithName:@"Signika-Light" size:10]];
        
        
        [self.navTitleView addSubview:mainTitle];
        [self.navTitleView addSubview:subTitle];
        
        
//        [self.updatedTimeDict setObject:@"" forKey:@"TopStories"];
//        [self.updatedTimeDict setObject:@"" forKey:@"India"];
//        [self.updatedTimeDict setObject:@"" forKey:@"World"];
//        [self.updatedTimeDict setObject:@"" forKey:@"Business"];
//        [self.updatedTimeDict setObject:@"" forKey:@"Technology"];
//        [self.updatedTimeDict setObject:@"" forKey:@"Sport"];
//        [self.updatedTimeDict setObject:@"" forKey:@"Entertainment"];
//        [self.updatedTimeDict setObject:@"" forKey:@"Lifestyle"];
//        [self.updatedTimeDict setObject:@"" forKey:@"Health"];
//        [self.updatedTimeDict setObject:@"" forKey:@"NRI"];
        
//        [self retriveAndDecode];
    }
    return self;
}

- (void)dealloc {
    
    // Should never be called, but just here for clarity really.
}

-(NSString *)getChannelNameFromLink:(NSString *)iStr {
    
    NSString *outStr = [NSString string];
    
    for (int k = 0; k < [[self.nameList allKeys] count]; k++) {
        if ([iStr rangeOfString:[[self.nameList allKeys] objectAtIndex:k]].location != NSNotFound) {
            outStr = [self.nameList valueForKey:[[self.nameList allKeys] objectAtIndex:k]];
            break;
        }
    }
    
    return outStr;
}

-(void)makeChannelList {
    NSArray *channels = [self.channelDict objectForKey:@"Channels"];
    
    for (int j =0; j < [channels count]; j ++) {
        NSDictionary *dict = [channels objectAtIndex:j];
        NSString *str = [dict valueForKey:self.module];
        NSString *truncatedStr = [str substringToIndex: MIN(15, [str length])];
        [self.channelsArray setObject:truncatedStr forKey:truncatedStr];
        [self.nameList setValue:[dict valueForKey:@"name"] forKey:[dict valueForKey:@"identifier"]];
    }
    
    //    NSLog(@"nameList....%@",self.nameList);
}


-(void)updateTime{
    
    if (!self.updatedTimeDict) {
//        self.timeToBeDisplayed = [NSString stringWithFormat:@"Updating..."];
        [self.updatedTimeDict setObject:[NSDate date] forKey:self.module];
    }
    else{
        
    NSString *dateStr ;
    
    NSDate* date1 = [NSDate date];
    NSDate* date2 = [self.updatedTimeDict objectForKey:self.module];
    NSTimeInterval distanceBetweenDates = [date1 timeIntervalSinceDate:date2];
    double secondsInAnHour = 3600;
    double secondsInAMin = 60;
    NSInteger hoursBetweenDates = distanceBetweenDates / secondsInAnHour;
    NSInteger minsBetweenDate = distanceBetweenDates / secondsInAMin;
    
    if (hoursBetweenDates > 0) {
        dateStr = [[NSString alloc] initWithFormat:@"%d hours ago",hoursBetweenDates];
    } else if (minsBetweenDate > 0) {
        dateStr = [[NSString alloc] initWithFormat:@"%d mins ago",minsBetweenDate];
    } else if (minsBetweenDate == 0) {
        dateStr = [[NSString alloc] initWithFormat:@"now"];
    }
    
    self.timeToBeDisplayed = [NSString stringWithFormat:@"Updated %@",dateStr];
    [self.updatedTimeDict setObject:date1 forKey:self.module];
    }

}

-(void)encodeAndSaveData {
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    
    NSData *finalData = [NSKeyedArchiver archivedDataWithRootObject:self.topStoriesArray];
    NSString *fileName1 = [[NSString alloc] initWithFormat:@"TopStories.plist"];
    NSString *path1 = [documentsDirectory stringByAppendingPathComponent:fileName1]; //3
    [finalData writeToFile: path1 atomically:YES];
    
    NSData *finalData1 = [NSKeyedArchiver archivedDataWithRootObject:self.indiaArray];
    NSString *fileName2 = [[NSString alloc] initWithFormat:@"India.plist"];
    NSString *path2 = [documentsDirectory stringByAppendingPathComponent:fileName2]; //3
    [finalData1 writeToFile: path2 atomically:YES];
    
    NSData *finalData2 = [NSKeyedArchiver archivedDataWithRootObject:self.worldArray];
    NSString *fileName3 = [[NSString alloc] initWithFormat:@"World.plist"];
    NSString *path3 = [documentsDirectory stringByAppendingPathComponent:fileName3]; //3
    [finalData2 writeToFile: path3 atomically:YES];
    
    NSData *finalData3 = [NSKeyedArchiver archivedDataWithRootObject:self.businessArray];
    NSString *fileName4 = [[NSString alloc] initWithFormat:@"Business.plist"];
    NSString *path4 = [documentsDirectory stringByAppendingPathComponent:fileName4]; //3
    [finalData3 writeToFile: path4 atomically:YES];
    
    NSData *finalData4 = [NSKeyedArchiver archivedDataWithRootObject:self.technologyArray];
    NSString *fileName5 = [[NSString alloc] initWithFormat:@"Technology.plist"];
    NSString *path5 = [documentsDirectory stringByAppendingPathComponent:fileName5]; //3
    [finalData4 writeToFile: path5 atomically:YES];
    
    NSData *finalData5 = [NSKeyedArchiver archivedDataWithRootObject:self.sportArray];
    NSString *fileName6 = [[NSString alloc] initWithFormat:@"Sport.plist"];
    NSString *path6 = [documentsDirectory stringByAppendingPathComponent:fileName6]; //3
    [finalData5 writeToFile: path6 atomically:YES];
    
    NSData *finalData6 = [NSKeyedArchiver archivedDataWithRootObject:self.entertainmentArray];
    NSString *fileName7 = [[NSString alloc] initWithFormat:@"Entertainment.plist"];
    NSString *path7 = [documentsDirectory stringByAppendingPathComponent:fileName7]; //3
    [finalData6 writeToFile: path7 atomically:YES];
    
    NSData *finalData7 = [NSKeyedArchiver archivedDataWithRootObject:self.lifeStyleArray];
    NSString *fileName8 = [[NSString alloc] initWithFormat:@"Lifestyle.plist"];
    NSString *path8 = [documentsDirectory stringByAppendingPathComponent:fileName8]; //3
    [finalData7 writeToFile: path8 atomically:YES];
    
    NSData *finalData8 = [NSKeyedArchiver archivedDataWithRootObject:self.healthArray];
    NSString *fileName9 = [[NSString alloc] initWithFormat:@"Health.plist"];
    NSString *path9 = [documentsDirectory stringByAppendingPathComponent:fileName9]; //3
    [finalData8 writeToFile: path9 atomically:YES];
    
    NSData *finalData9 = [NSKeyedArchiver archivedDataWithRootObject:self.nriArray];
    NSString *fileName10 = [[NSString alloc] initWithFormat:@"NRI.plist"];
    NSString *path10 = [documentsDirectory stringByAppendingPathComponent:fileName10]; //3
    [finalData9 writeToFile: path10 atomically:YES];
    
    NSData *finalData50 = [NSKeyedArchiver archivedDataWithRootObject:self.updatedTimeDict];
    NSString *fileName50 = [[NSString alloc] initWithFormat:@"updatedTime.plist"];
    NSString *path50 = [documentsDirectory stringByAppendingPathComponent:fileName50]; //3
    [finalData50 writeToFile: path50 atomically:YES];
    
    [self encodeBlockedAndSave];
    [self encodeWatchingAndSave];
    
}

-(void)retriveAndDecode {
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    
    NSString *fileName1 = [[NSString alloc] initWithFormat:@"TopStories.plist"];
    NSString *path1 = [documentsDirectory stringByAppendingPathComponent:fileName1]; //3
    NSData *savedData1 = [NSData dataWithContentsOfFile:path1];
    self.topStoriesArray  = [NSKeyedUnarchiver unarchiveObjectWithData:savedData1];
    
    NSString *fileName2 = [[NSString alloc] initWithFormat:@"India.plist"];
    NSString *path2 = [documentsDirectory stringByAppendingPathComponent:fileName2]; //3
    NSData *savedData2 = [NSData dataWithContentsOfFile:path2];
    self.indiaArray  = [NSKeyedUnarchiver unarchiveObjectWithData:savedData2];
    
    NSString *fileName3 = [[NSString alloc] initWithFormat:@"World.plist"];
    NSString *path3 = [documentsDirectory stringByAppendingPathComponent:fileName3]; //3
    NSData *savedData3 = [NSData dataWithContentsOfFile:path3];
    self.worldArray  = [NSKeyedUnarchiver unarchiveObjectWithData:savedData3];
    
    NSString *fileName4 = [[NSString alloc] initWithFormat:@"Business.plist"];
    NSString *path4 = [documentsDirectory stringByAppendingPathComponent:fileName4]; //3
    NSData *savedData4 = [NSData dataWithContentsOfFile:path4];
    self.businessArray  = [NSKeyedUnarchiver unarchiveObjectWithData:savedData4];
    
    NSString *fileName5 = [[NSString alloc] initWithFormat:@"Technology.plist"];
    NSString *path5 = [documentsDirectory stringByAppendingPathComponent:fileName5]; //3
    NSData *savedData5 = [NSData dataWithContentsOfFile:path5];
    self.technologyArray  = [NSKeyedUnarchiver unarchiveObjectWithData:savedData5];
    
    NSString *fileName6 = [[NSString alloc] initWithFormat:@"Sport.plist"];
    NSString *path6 = [documentsDirectory stringByAppendingPathComponent:fileName6]; //3
    NSData *savedData6 = [NSData dataWithContentsOfFile:path6];
    self.sportArray  = [NSKeyedUnarchiver unarchiveObjectWithData:savedData6];
    
    NSString *fileName7 = [[NSString alloc] initWithFormat:@"Entertainment.plist"];
    NSString *path7 = [documentsDirectory stringByAppendingPathComponent:fileName7]; //3
    NSData *savedData7 = [NSData dataWithContentsOfFile:path7];
    self.entertainmentArray  = [NSKeyedUnarchiver unarchiveObjectWithData:savedData7];
    
    NSString *fileName8 = [[NSString alloc] initWithFormat:@"Lifestyle.plist"];
    NSString *path8 = [documentsDirectory stringByAppendingPathComponent:fileName8]; //3
    NSData *savedData8 = [NSData dataWithContentsOfFile:path8];
    self.lifeStyleArray  = [NSKeyedUnarchiver unarchiveObjectWithData:savedData8];
    
    NSString *fileName9 = [[NSString alloc] initWithFormat:@"Health.plist"];
    NSString *path9 = [documentsDirectory stringByAppendingPathComponent:fileName9]; //3
    NSData *savedData9 = [NSData dataWithContentsOfFile:path9];
    self.healthArray  = [NSKeyedUnarchiver unarchiveObjectWithData:savedData9];
    
    NSString *fileName10 = [[NSString alloc] initWithFormat:@"NRI.plist"];
    NSString *path10 = [documentsDirectory stringByAppendingPathComponent:fileName10]; //3
    NSData *savedData10 = [NSData dataWithContentsOfFile:path10];
    self.nriArray  = [NSKeyedUnarchiver unarchiveObjectWithData:savedData10];
    
    NSString *fileName50 = [[NSString alloc] initWithFormat:@"updatedTime.plist"];
    NSString *path50 = [documentsDirectory stringByAppendingPathComponent:fileName50]; //3
    NSData *savedData50 = [NSData dataWithContentsOfFile:path50];
    self.updatedTimeDict  = [NSKeyedUnarchiver unarchiveObjectWithData:savedData50];
    
    [self retriveAndDecodeBlocked];
    [self retriveAndDecodeWatching];
    
}

-(void)encodeBlockedAndSave {
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    
    NSData *finalData = [NSKeyedArchiver archivedDataWithRootObject:self.blockedArray];
    NSString *fileName1 = [[NSString alloc] initWithFormat:@"Blocked.plist"];
    NSString *path1 = [documentsDirectory stringByAppendingPathComponent:fileName1]; //3
    [finalData writeToFile: path1 atomically:YES];
    
}

-(void)retriveAndDecodeBlocked {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    
    NSString *fileName1 = [[NSString alloc] initWithFormat:@"Blocked.plist"];
    NSString *path1 = [documentsDirectory stringByAppendingPathComponent:fileName1]; //3
    NSData *savedData1 = [NSData dataWithContentsOfFile:path1];
    self.blockedArray  = [NSKeyedUnarchiver unarchiveObjectWithData:savedData1];
}


-(void)encodeWatchingAndSave {
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    
    NSData *finalData = [NSKeyedArchiver archivedDataWithRootObject:self.watchingArray];
    NSString *fileName1 = [[NSString alloc] initWithFormat:@"Watching.plist"];
    NSString *path1 = [documentsDirectory stringByAppendingPathComponent:fileName1]; //3
    [finalData writeToFile: path1 atomically:YES];
    
}

-(void)retriveAndDecodeWatching {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    
    NSString *fileName1 = [[NSString alloc] initWithFormat:@"Watching.plist"];
    NSString *path1 = [documentsDirectory stringByAppendingPathComponent:fileName1]; //3
    NSData *savedData1 = [NSData dataWithContentsOfFile:path1];
    self.watchingArray  = [NSKeyedUnarchiver unarchiveObjectWithData:savedData1];
}

-(void)setNavTitle:(NSString *)iTitle :(NSString *)iSubtitle {
    
    UILabel *lbl1 = (UILabel *)[self.navTitleView viewWithTag:10];
    UILabel *lbl2 = (UILabel *)[self.navTitleView viewWithTag:20];
    lbl1.text = iTitle ;
    lbl2.text = iSubtitle;
    

    
}



@end