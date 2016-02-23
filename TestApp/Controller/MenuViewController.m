//
//  MenuViewController.m
//  TestApp
//
//  Created by Hoang Son on 2/23/16.
//  Copyright (c) 2016 Hoang Son. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark - Event
- (IBAction)mainEvent:(id)sender{
    if ([self.delegate respondsToSelector:@selector(mainClickedEvent)]) {
        [self.delegate mainClickedEvent];
    }
}

- (IBAction)aboutEvent:(id)sender{
    if ([self.delegate respondsToSelector:@selector(aboutClickedEvent)]) {
        [self.delegate aboutClickedEvent];
    }
}

- (IBAction)logout:(id)sender{
    if ([self.delegate respondsToSelector:@selector(logoutClickedEvent)]) {
        [self.delegate logoutClickedEvent];
    }
}

@end
