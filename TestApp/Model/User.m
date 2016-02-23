//
//  User.m
//  A
//
//  Created by Hoang Son on 2/22/16.
//  Copyright (c) 2016 Hoang Son. All rights reserved.
//

#import "User.h"

@implementation User
- (void)parseData{
    self.userId   = self.jsonData[@"_id"];
    self.avatar   = self.jsonData[@"avatar"];
    self.created  = self.jsonData[@"created"];
    self.email    = self.jsonData[@"email"];
    self.name = self.jsonData[@"name"];
    self.password = self.jsonData[@"password"];
    self.provider = self.jsonData[@"provider"];
    self.salt     = self.jsonData[@"salt"];
}

@end
