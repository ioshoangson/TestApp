//
//  BaseObject.m
//  A
//
//  Created by Hoang Son on 2/22/16.
//  Copyright (c) 2016 Hoang Son. All rights reserved.
//

#import "BaseObject.h"

@implementation BaseObject

+ (id)instanceFromData:(NSDictionary *)jsonData
{
    BaseObject *instance = [[self alloc] init];
    instance.jsonData = jsonData;
    [instance parseData];
    return instance;
}

- (void)parseData{
}

@end
