//
//  ClientRequest.h
//  AppTest
//
//  Created by Hoang Son on 2/22/16.
//  Copyright (c) 2016 Hoang Son. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;
@interface ClientRequest :NSObject

+ (ClientRequest *)share;

#pragma USER
- (void)createUser:(NSDictionary *)param
          complete:(void (^)(User *user))completeBlock
             error:(void (^)(NSError *error))errorBlock;
- (void)signIn:(NSDictionary *)param
          complete:(void (^)(User *user))completeBlock
         error:(void (^)(NSError *error))errorBlock;
- (void)getAllUser:(void (^)(NSArray *results))completeBlock
             error:(void (^)(NSError *error))errorBlock;
@end
