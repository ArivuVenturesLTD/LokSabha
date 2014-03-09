//
//  Constituency.m
//  RESideMenuExample
//
//  Created by Praveen Kumar on 08/03/2014.
//  Copyright (c) 2014 Roman Efimov. All rights reserved.
//

#import "Constituency.h"

@interface Constituency ()

@end

@implementation Constituency

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"Constituencies";

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
