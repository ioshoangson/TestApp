//
//  BaseObject.h
//  A
//
//  Created by Hoang Son on 2/22/16.
//  Copyright (c) 2016 Hoang Son. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseObject : NSObject
@property (nonatomic, strong) NSDictionary *jsonData;


+ (id)instanceFromData:(NSDictionary *)jsonData;
- (void)parseData;

@end
