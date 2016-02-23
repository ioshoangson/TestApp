//
//  MenuViewController.h
//  TestApp
//
//  Created by Hoang Son on 2/23/16.
//  Copyright (c) 2016 Hoang Son. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuProtocol <NSObject>
@required
- (void)mainClickedEvent;
- (void)aboutClickedEvent;
- (void)logoutClickedEvent;

@end

@interface MenuViewController : UIViewController
@property (nonatomic, weak) id<MenuProtocol> delegate;
@property (nonatomic, weak) IBOutlet UIView *alphaView;
@property (nonatomic, weak) IBOutlet UIButton *backButton;

@end
