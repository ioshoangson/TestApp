//
//  UserCell.m
//  TestApp
//
//  Created by Hoang Son on 2/22/16.
//  Copyright (c) 2016 Hoang Son. All rights reserved.
//

#import "UserCell.h"
#import "User.h"
#import "UIImageView+WebCache.h"

@implementation UserCell

- (void)setData:(User *)user{
    self.nameLabel.text = user.name;
    self.emailLable.text = user.email;
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:user.avatar]];
}

@end
