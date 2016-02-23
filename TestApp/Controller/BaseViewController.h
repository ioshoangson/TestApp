//
//  BaseViewController.h
//  TestApp
//
//  Created by Hoang Son on 2/22/16.
//  Copyright (c) 2016 Hoang Son. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property (nonatomic, assign) NSUInteger pageIndex;
@property (nonatomic, strong) UIBarButtonItem *menuBarButton;
@property (nonatomic, strong) UIBarButtonItem *backButton;

#pragma mark - Public Methods
- (void)setupUI;
- (void)showAlert:(NSString *)title message:(NSString *)message;
- (void)showHud;
- (void)hideHud;
- (void)menuHandler;
- (void)handleSwipeRight;
- (void)backHandle;

@end
