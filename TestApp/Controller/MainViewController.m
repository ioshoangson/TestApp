//
//  MainViewController.m
//  TestApp
//
//  Created by Hoang Son on 2/22/16.
//  Copyright (c) 2016 Hoang Son. All rights reserved.
//

#import "MainViewController.h"
#import "ListUserViewController.h"
#import "SettingViewController.h"
#import "MenuViewController.h"
#import "AboutViewController.h"
#import "AppDelegate.h"
#import "Define.h"
#import "HeaderView.h"

#define LIMIT_PAGE 2
static float const HEADER_HEIGHT = 42;


@interface MainViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate, MenuProtocol>{
    BOOL isMenuShow;
}
@property (nonatomic, strong) ListUserViewController *listUserViewController;
@property (nonatomic, strong) SettingViewController *settingUserViewController;
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic, copy) void (^setUpUICompleteBlock)(void);
@property (nonatomic, weak) IBOutlet UIButton *menuButton;
@property (nonatomic, weak) IBOutlet UIView *menuContainerView;
@property (nonatomic, weak) IBOutlet UIView *aboutContainerView;
@property (nonatomic) CGFloat lastContentOffset;
@property (nonatomic, strong) MenuViewController *menuViewController;
@property (nonatomic, strong) AboutViewController *aboutViewController;

@end


@implementation MainViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    [self setupUIForPageController:^{
        [weakSelf.headerView setCompleteBlock:^(TabType type) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (type >= self.headerView.lastIndex) {
                    [weakSelf.pageViewController setViewControllers:[NSArray arrayWithObject:[weakSelf viewControllerAtIndex:type]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
                }else{
                    [weakSelf.pageViewController setViewControllers:[NSArray arrayWithObject:[weakSelf viewControllerAtIndex:type]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
                }
                weakSelf.headerView.lastIndex = type;
            });
        }];

    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)setupUI{
    self.menuContainerView.hidden = YES;
    self.aboutContainerView.hidden = YES;
}

- (void)setupUIForPageController:(void (^)(void))complete{
    self.setUpUICompleteBlock = complete;
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    [[self.pageViewController view] setFrame:CGRectMake(0, 106, SCREEN_WIDTH, SCREEN_HEIGHT)];

    ListUserViewController *startingViewController = (ListUserViewController *)[self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setUpHeaderView];
        if (self.setUpUICompleteBlock) {
            self.setUpUICompleteBlock();
            self.setUpUICompleteBlock = nil;
        }
    });
}



- (void)setUpHeaderView{
    if (!self.headerView) {
        self.headerView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([HeaderView class]) owner:self options:nil] firstObject];
        self.headerView.frame = CGRectMake(0, 64, SCREEN_WIDTH, HEADER_HEIGHT);
        [self.view addSubview:self.headerView];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"menuSegue"]) {
        self.menuViewController = (MenuViewController *)[segue destinationViewController];
        self.menuViewController.delegate = self;
    }
    if ([segue.identifier isEqualToString:@"aboutSegue"]) {
        self.aboutViewController = (AboutViewController *)[segue destinationViewController];
        self.aboutViewController.mainViewController = self;
    }
}


#pragma mark - Page View Controller
- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (index >= LIMIT_PAGE) {
        return nil;
    }
    
    BaseViewController *contentPageController = nil;
    switch (index) {
        case kEnumListUserTab:{
            if (!self.listUserViewController) {
                self.listUserViewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([ListUserViewController class])];
                self.listUserViewController.pageIndex = index;
            }
            contentPageController = self.listUserViewController;
            break;
        }
        case kEnumSettingTab:{
            if (!self.settingUserViewController) {
                self.settingUserViewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([SettingViewController class])];
                self.settingUserViewController.pageIndex = index;
            }
            contentPageController = self.settingUserViewController;
            break;
        }
        default:
            break;
    }
    return contentPageController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((BaseViewController *) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((BaseViewController *) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == LIMIT_PAGE) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers{
    
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed{
    if (!completed) return;
    
    NSArray *array = [pageViewController viewControllers];
    for (UIViewController *controller in array) {
        if ([controller isKindOfClass:[ListUserViewController class]]) {
            [self.headerView setupUIForForTab:kEnumListUserTab];
            return;
        }
        if ([controller isKindOfClass:[SettingViewController class]]) {
            [self.headerView setupUIForForTab:kEnumSettingTab];
            return;
        }
    }

}


#pragma mark - Menu
- (IBAction)showMenu:(id)sender{
    if (!isMenuShow) {
        [self showMenu];
    }
}

- (void)showMenu{
    self.menuContainerView.frame = CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.menuViewController.alphaView.backgroundColor = [self.menuViewController.alphaView.backgroundColor colorWithAlphaComponent:1.0];
    self.menuContainerView.alpha = 1.0f;
    [UIView animateWithDuration:0.75 animations:^{
        self.menuViewController.alphaView.backgroundColor = [self.menuViewController.alphaView.backgroundColor colorWithAlphaComponent:0.4];
        self.menuContainerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.menuContainerView.hidden = NO;
        isMenuShow = YES;
        [self.view bringSubviewToFront:self.menuContainerView];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.menuViewController.backButton.transform=CGAffineTransformMakeRotation(M_PI / -4);
        } completion:^(BOOL finished) {
            self.menuViewController.backButton.transform = CGAffineTransformIdentity;        }];
    }];

}

- (void)hideMenu{
    self.menuContainerView.alpha = 1.0f;
    [UIView animateWithDuration:0.75 animations:^{
        self.menuContainerView.hidden = YES;
        self.menuContainerView.alpha = 0.0f;
        isMenuShow = NO;
    }];
}

- (void)showAbout{
    self.menuContainerView.hidden = YES;
    self.aboutContainerView.alpha = 0.3f;
    [UIView animateWithDuration:0.1 animations:^{
        self.aboutContainerView.hidden = NO;
        self.aboutContainerView.alpha = 1.0f;
        [self.view bringSubviewToFront:self.aboutContainerView];
    }];
}

- (void)hideAbout{
    self.aboutContainerView.alpha = 0.3f;
    [UIView animateWithDuration:0.1 animations:^{
        self.aboutContainerView.hidden = YES;
        self.aboutContainerView.alpha = 1.0f;
        [self.view bringSubviewToFront:self.aboutContainerView];
    }];
}


#pragma mark - Menu Delegate
- (void)mainClickedEvent{
    [self hideMenu];
    [self hideAbout];
}

- (void)aboutClickedEvent{
    [self showAbout];
}

- (void)logoutClickedEvent{
    [SharedAppDelegate setupLogoutRootView];
}

@end
