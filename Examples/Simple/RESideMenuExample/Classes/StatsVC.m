//
//  StatsVC.m
//  RESideMenuExample
//
//  Created by Praveen Kumar on 08/03/2014.
//  Copyright (c) 2014 Roman Efimov. All rights reserved.
//

#import "StatsVC.h"

@interface StatsVC ()

@end

@implementation StatsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"Statistics";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.navigationController.title = @"Statistics";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
