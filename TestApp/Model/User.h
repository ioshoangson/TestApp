//
//  User.h
//  A
//
//  Created by Hoang Son on 2/22/16.
//  Copyright (c) 2016 Hoang Son. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObject.h"

@interface User : BaseObject
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *created;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *provider;
@property (nonatomic, copy) NSString *salt;

@end
