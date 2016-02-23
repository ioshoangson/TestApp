//
//  RegisterViewController.h
//  TestApp
//
//  Created by Hoang Son on 2/22/16.
//  Copyright (c) 2016 Hoang Son. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class User;
@interface RegisterViewController : BaseViewController
@property (nonatomic, copy) void (^CompleteBlock)(User *user);

@end
