//
//  AppDelegate.h
//  TestApp
//
//  Created by Hoang Son on 2/22/16.
//  Copyright (c) 2016 Hoang Son. All rights reserved.
//

#import <UIKit/UIKit.h>


@class User;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;

- (void)addUser:(User *)user;
- (void)setupMainRootView;
- (void)setupLogoutRootView;

@end

