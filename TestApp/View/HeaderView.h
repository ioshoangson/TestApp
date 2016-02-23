//
//  HeaderView.h
//  TestApp
//
//  Created by Hoang Son on 2/22/16.
//  Copyright (c) 2016 Hoang Son. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kEnumListUserTab = 0,
    kEnumSettingTab = 1
}TabType;

@interface HeaderView : UIView
@property (nonatomic, assign) TabType selectedType;
@property (nonatomic, copy) void (^CompleteBlock)(TabType type);
@property (nonatomic, assign) int lastIndex;

- (void)setupUIForForTab:(TabType)tabType;

@end
