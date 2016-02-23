//
//  Global.m
//  A
//
//  Created by Hoang Son on 2/22/16.
//  Copyright (c) 2016 Hoang Son. All rights reserved.
//

#import "Global.h"

@implementation Global
+ (Global *)share{
    static Global *global = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        global = [[Global alloc] init];
    });
    return global;
}

@end
