//
//  BaseViewController.m
//  TestApp
//
//  Created by Hoang Son on 2/22/16.
//  Copyright (c) 2016 Hoang Son. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    
    UISwipeGestureRecognizer *gestureLeft = [[UISwipeGestureRecognizer alloc]
                                             initWithTarget:self
                                             action:@selector(handleSwipeRight)];
    [gestureLeft setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:gestureLeft];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI{
}

#pragma mark - Private methods
- (void)setupNavigationBar{
    self.menuBarButton = [self barButtonWithImageNamed:@"ab_menu.png" title:@"" size:CGSizeMake(44, 21) edgeInsets:UIEdgeInsetsMake(0, 50, 0, 0) action:@selector(menuHandler)];
    self.backButton = [self barButtonWithImageNamed:@"back_icon" title:@"" size:CGSizeMake(30, 21) edgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) action:@selector(backHandle)];
}

- (UIBarButtonItem *)barButtonWithImageNamed:(NSString *)name title:(NSString *)title size:(CGSize)size edgeInsets:(UIEdgeInsets)insets action:(SEL)action;
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backgroundImage = [UIImage imageNamed:name];
    [button setImage:backgroundImage forState:UIControlStateNormal];
 
    if(!CGSizeEqualToSize(size, CGSizeZero)) button.frame = CGRectMake(0, 0, size.width, size.height);
    [button setImageEdgeInsets:insets];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}


#pragma mark - Public methods
- (void)showAlert:(NSString *)title message:(NSString *)message{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alertView show];
}

- (void)menuHandler{
}

- (void)showHud{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hideHud{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)handleSwipeRight{
    
}

- (void)backHandle{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
