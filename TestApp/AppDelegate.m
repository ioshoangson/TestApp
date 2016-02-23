//
//  AppDelegate.m
//  TestApp
//
//  Created by Hoang Son on 2/22/16.
//  Copyright (c) 2016 Hoang Son. All rights reserved.
//

#import "AppDelegate.h"
#import "Define.h"
#import <PubNub/PubNub.h>
#import "MainViewController.h"
#import "SigninViewController.h"
#import "User.h"

#define PUBLISH_KEY @"pub-c-e9987246-ee42-4a1e-bbb5-970a8005bbf6"
#define SUBSCRIBE_KEY @"sub-c-e384d700-d931-11e5-bdd5-02ee2ddab7fe"
#define MY_CHANNEL @"my_channel"


@interface AppDelegate ()<PNObjectEventListener>
@property (nonatomic) PubNub *client;
@property (nonatomic, strong) MainViewController *mainViewController;
@property (nonatomic, strong) SigninViewController *signInViewController;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    PNConfiguration *configuration = [PNConfiguration configurationWithPublishKey:PUBLISH_KEY
                                                                     subscribeKey:SUBSCRIBE_KEY];
    self.client = [PubNub clientWithConfiguration:configuration];
    [self.client addListener:self];
    [self.client subscribeToChannels: @[MY_CHANNEL] withPresence:YES];
    
    [self configUI];
    
    return YES;
}

- (void)configUI{
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0/255.0 green:196/255.0 blue:186/255.0 alpha:1.0]];

    
    NSShadow *shadow = [NSShadow new];
    [shadow setShadowColor: [UIColor clearColor]];
    [shadow setShadowOffset: CGSizeMake(0.0f, 1.0f)];
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIFont systemFontOfSize:17.0], NSFontAttributeName,
                                                          [UIColor whiteColor], NSForegroundColorAttributeName,
                                                          shadow, NSShadowAttributeName,nil]];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also  applicationDidEnterBackground:.
}

- (void)setupMainRootView{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.mainViewController = [mainStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass([MainViewController class])];
    self.window.rootViewController = self.mainViewController;
}

- (void)setupLogoutRootView{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.signInViewController = [mainStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass([SigninViewController class])];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.signInViewController];
    self.window.rootViewController = nav;
}

#pragma mark - Add User
- (void)addUser:(User *)user{
    [self.client publish:@{@"name": user.name,
                           @"email": user.email,
                           @"avatar": user.avatar} toChannel:MY_CHANNEL
          withCompletion:^(PNPublishStatus *status) {
              if (!status.isError) {
              }
              else {
                
              }
          }];

}

#pragma mark - PunNub Listener
- (void)client:(PubNub *)client didReceiveMessage:(PNMessageResult *)message {
    
    // Handle new message stored in message.data.message
    if (message.data.actualChannel) {
        
        // Message has been received on channel group stored in
        // message.data.subscribedChannel
    }
    else {
        
        // Message has been received on channel stored in
        // message.data.subscribedChannel
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_NEW_USER_NOTIFICATION object:nil userInfo:@{@"newUser": message.data.message}];
}

- (void)client:(PubNub *)client didReceiveStatus:(PNSubscribeStatus *)status {
    
    if (status.category == PNUnexpectedDisconnectCategory) {
        // This event happens when radio / connectivity is lost
    }
    
    else if (status.category == PNConnectedCategory) {
        
        // Connect event. You can do stuff like publish, and know you'll get it.
        // Or just use the connected event to confirm you are subscribed for
        // UI / internal notifications, etc
        
        
    }
    else if (status.category == PNReconnectedCategory) {
        
        // Happens as part of our regular operation. This event happens when
        // radio / connectivity is lost, then regained.
    }
    else if (status.category == PNDecryptionErrorCategory) {
        
        // Handle messsage decryption error. Probably client configured to
        // encrypt messages and on live data feed it received plain text.
    }
    
}


@end
