//
//  UserCell.h
//  TestApp
//
//  Created by Hoang Son on 2/22/16.
//  Copyright (c) 2016 Hoang Son. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;
@interface UserCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *emailLable;

- (void)setData:(User *)user;

@end
