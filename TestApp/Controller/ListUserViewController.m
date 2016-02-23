//
//  ListUserViewController.m
//  TestApp
//
//  Created by Hoang Son on 2/22/16.
//  Copyright (c) 2016 Hoang Son. All rights reserved.
//

#import "ListUserViewController.h"
#import "ClientRequest.h"
#import "UserCell.h"
#import "SVPullToRefresh.h"
#import "UIScrollView+InfiniteScroll.h"
#import "Define.h"
#import "User.h"

static NSString *UserCellIdentifier = @"UserCellIdentifier";

@interface ListUserViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *userTableView;
@property (nonatomic, strong) NSMutableArray *results;

@end

@implementation ListUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateListUser:) name:UPDATE_NEW_USER_NOTIFICATION object:nil];
    
    [self.userTableView addPullToRefreshWithActionHandler:^{
        [self refreshData];
    }];
    
    self.userTableView.contentInset = UIEdgeInsetsMake(0, 0, 120, 0);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

#pragma mark - Data
- (void)loadData{
    [self showHud];
    [[ClientRequest share] getAllUser:^(NSArray *results) {
        [self hideHud];
        self.results = [results mutableCopy];
        [self.userTableView reloadData];
    } error:^(NSError *error) {
        [self hideHud];
    }];
}

- (void)refreshData{
    [[ClientRequest share] getAllUser:^(NSArray *results) {
        [self.userTableView.pullToRefreshView stopAnimating];
        self.results = [NSMutableArray array];
        self.results = [results mutableCopy];
        [self.userTableView reloadData];
    } error:^(NSError *error) {
        [self.userTableView.pullToRefreshView stopAnimating];
    }];
}
- (void)updateListUser:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    NSDictionary *userDic = userInfo[@"newUser"];
    User *user = [User instanceFromData:userDic];
    [self.results insertObject:user atIndex:0];
    NSIndexPath *rowInsert = [NSIndexPath indexPathForRow:0 inSection:0];
    NSArray *rowsToInsert = [NSArray arrayWithObjects:rowInsert, nil];
    [self.userTableView insertRowsAtIndexPaths:rowsToInsert withRowAnimation:UITableViewRowAnimationTop];
}

#pragma mark - TableView Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.results count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserCell *userCell = [tableView dequeueReusableCellWithIdentifier:UserCellIdentifier];
    User *user = [self.results objectAtIndex:indexPath.row];
    [userCell setData:user];
    return userCell;
}

@end
