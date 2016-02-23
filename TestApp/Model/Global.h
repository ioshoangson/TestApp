//
//  Global.h
//  A
//
//  Created by Hoang Son on 2/22/16.
//  Copyright (c) 2016 Hoang Son. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Global : NSObject
@property (nonatomic, copy) NSString *shareToken;

+ (Global *)share;

@end
