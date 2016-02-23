//
//  AboutViewController.h
//  TestApp
//
//  Created by Hoang Son on 2/22/16.
//  Copyright (c) 2016 Hoang Son. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MainViewController.h"

@interface AboutViewController : BaseViewController
@property (nonatomic, weak) MainViewController *mainViewController;

@end
