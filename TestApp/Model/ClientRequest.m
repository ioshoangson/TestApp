//
//  ClientRequest.m
//  AppTest
//
//  Created by Hoang Son on 2/22/16.
//  Copyright (c) 2016 Hoang Son. All rights reserved.
//

#import "ClientRequest.h"
#import "Global.h"
#import "User.h"
#import "API.h"

static NSString *const POST = @"POST";
static NSString *const GET  = @"GET";

@implementation ClientRequest
+ (ClientRequest *)share{
    static ClientRequest *clientRequest = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        clientRequest = [[ClientRequest alloc] init];
    });
    return clientRequest;
}


- (void)createUser:(NSDictionary *)param
          complete:(void (^)(User *user))completeBlock
             error:(void (^)(NSError *error))errorBlock{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", SERVER_DEV, CREATE_USER]]];
    request.HTTPMethod = POST;
    NSString *body = [NSString stringWithFormat:@"email=%@&password=%@&name=%@",
                      param[@"email"], param[@"password"], param[@"name"]];

    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSError *error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                             options:kNilOptions
                                                               error:&error];
        if (!error) {
            if (json[@"errors"]) {
                NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"%@%@", SERVER_DEV, CREATE_USER] code:-100 userInfo:@{@"mess": @"Can not create user"}];
                errorBlock(error);
            }else{
                User *user = [User instanceFromData:json];
                completeBlock(user);
            }
        }
    }];
}

- (void)signIn:(NSDictionary *)param
      complete:(void (^)(User *user))completeBlock
         error:(void (^)(NSError *error))errorBlock{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", SERVER_DEV, SIGN_IN]]];
    request.HTTPMethod = POST;
    NSString *body = [NSString stringWithFormat:@"email=%@&password=%@",
                      param[@"email"], param[@"password"]];
    
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSError *error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                             options:kNilOptions
                                                               error:&error];
        if (!error) {
            if (json[@"message"]) {
                NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"%@%@", SERVER_DEV, CREATE_USER] code:-100 userInfo:@{@"mess": json[@"message"]}];
                errorBlock(error);
            }else{
                User *user = [User instanceFromData:json[@"user"]];
                user.token = json[@"token"];;
                completeBlock(user);
            }
        }
    }];
}


- (void)getAllUser:(void (^)(NSArray *results))completeBlock
             error:(void (^)(NSError *error))errorBlock{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", SERVER_DEV, GET_USER]]];
    request.HTTPMethod = GET;
    [request addValue:[NSString stringWithFormat:@"token %@", [[Global share] shareToken]] forHTTPHeaderField:@"Authorization"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSError *error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                             options:kNilOptions
                                                               error:&error];
        if (!error) {
            NSMutableArray *results = [NSMutableArray array];
            for (NSDictionary *dict in json) {
                User *user = [User instanceFromData:dict];
                [results addObject:user];
            }
            completeBlock(results);
        }
    }];
}

@end
