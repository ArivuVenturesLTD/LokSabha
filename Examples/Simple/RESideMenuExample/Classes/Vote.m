//
//  Vote.m
//  RESideMenuExample
//
//  Created by Praveen Kumar on 08/03/2014.
//  Copyright (c) 2014 Roman Efimov. All rights reserved.
//

#import "Vote.h"
#import "PBWebViewController.h"
#import "PBSafariActivity.h"

@interface Vote ()

@property (nonatomic, strong) NSArray *contents;

@property (nonatomic, strong) NSDictionary *totalDict;


@end

@implementation Vote

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"Electors Search";

    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.webViewController clear];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self readElectorsList];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // In order to expand just one cell at a time. If you set this value YES, when you expand an cell, the already-expanded cell is collapsed automatically.
//    self.tableView.shouldExpandOnlyOneCell = YES;
}

- (NSArray *)contents
{
    if (!_contents) {
        _contents = @[@[@[@"Section0_Row0", @"Row0_Subrow1",@"Row0_Subrow2"],
                        @[@"Section0_Row1", @"Row1_Subrow1", @"Row1_Subrow2", @"Row1_Subrow3", @"Row1_Subrow4", @"Row1_Subrow5", @"Row1_Subrow6", @"Row1_Subrow7", @"Row1_Subrow8", @"Row1_Subrow9", @"Row1_Subrow10", @"Row1_Subrow11", @"Row1_Subrow12"],
                        @[@"Section0_Row2"]],
                      @[@[@"Section1_Row0", @"Row0_Subrow1", @"Row0_Subrow2", @"Row0_Subrow3"],
                        @[@"Section1_Row1"],
                        @[@"Section1_Row2", @"Row2_Subrow1", @"Row2_Subrow2", @"Row2_Subrow3", @"Row2_Subrow4", @"Row2_Subrow5"]]];
    }
    
    return _contents;
}




-(void)readElectorsList {
    
    
    NSString *strplistPath = [[NSBundle mainBundle] pathForResource:@"Electors" ofType:@"plist"];
    
    // read property list into memory as an NSData  object
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:strplistPath];
    NSString *strerrorDesc = nil;
    NSPropertyListFormat plistFormat;
    // convert static property liost into dictionary object
    _totalDict = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&plistFormat errorDescription:&strerrorDesc];
    if (!_totalDict)
        NSLog(@"Error reading plist: %@, format: %d", strerrorDesc, plistFormat);
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_totalDict allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SKSTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    
    NSString *title = [[_totalDict valueForKey:[NSString stringWithFormat:@"%d",indexPath.row]] valueForKey:@"name"];
    
    NSString *url = [[_totalDict valueForKey:[NSString stringWithFormat:@"%d",indexPath.row]] valueForKey:@"link"];

    if ([url length] < 5) {
        cell.accessoryType = UITableViewCellAccessoryNone ;
    } else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = title;

//    if ((indexPath.section == 0 && (indexPath.row == 1 || indexPath.row == 0)) || (indexPath.section == 1 && (indexPath.row == 0 || indexPath.row == 2)))
//        cell.isExpandable = YES;
//    else
//        cell.isExpandable = NO;
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
//    if (!cell)
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    
//    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.contents[indexPath.section][indexPath.row][indexPath.subRow]];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Returns 60.0 points for all subrows.
    return 60.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *url = [[_totalDict valueForKey:[NSString stringWithFormat:@"%d",indexPath.row]] valueForKey:@"link"];

    
    if ([url length] < 5) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"There are no links provided for this state or union territory." delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil];
        
        [alert show];
        
    } else{
    self.webViewController = [[PBWebViewController alloc] init];

    PBSafariActivity *activity = [[PBSafariActivity alloc] init];
    

    self.webViewController.URL = [NSURL URLWithString:url];
    self.webViewController.applicationActivities = @[activity];
    self.webViewController.excludedActivityTypes = @[UIActivityTypeMail, UIActivityTypeMessage, UIActivityTypePostToWeibo];
    [self.navigationController pushViewController:self.webViewController animated:YES];
    }
    
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}





@end
