//
//  AboutViewController.m
//  TestApp
//
//  Created by Hoang Son on 2/22/16.
//  Copyright (c) 2016 Hoang Son. All rights reserved.
//

#import "AboutViewController.h"

@implementation AboutViewController

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)handleSwipeRight{
    [self.mainViewController showMenu]; 
}

- (IBAction)back:(id)sender{
    [self.mainViewController showMenu];
}

@end
