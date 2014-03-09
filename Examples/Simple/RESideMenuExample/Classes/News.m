//
//  News.m
//  RESideMenuExample
//
//  Created by Praveen Kumar on 08/03/2014.
//  Copyright (c) 2014 Roman Efimov. All rights reserved.
//

#import "News.h"

@interface News ()

@end

@implementation News

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initializatio
        self.navigationItem.title = @"News";

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
