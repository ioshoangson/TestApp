//
//  HeaderView.m
//  TestApp
//
//  Created by Hoang Son on 2/22/16.
//  Copyright (c) 2016 Hoang Son. All rights reserved.
//

#import "HeaderView.h"
#import "Define.h"

@interface HeaderView ()
@property (nonatomic, weak) IBOutlet UIView *sliderView;

@end

@implementation HeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.selectedType = kEnumListUserTab;
}

- (IBAction)changeTab:(id)sender{
    UIButton *button = (UIButton *)sender;
    [self setupUIForForTab:(int)button.tag];
    if (self.CompleteBlock) {
        self.CompleteBlock((int)button.tag);
    }
}

#pragma mark - Public methods
- (void)setupUIForForTab:(TabType)tabType{
    self.selectedType = tabType;
    switch (self.selectedType) {
        case kEnumListUserTab:{
            [UIView animateWithDuration:0.25 animations:^{
                self.sliderView.frame = CGRectMake(0, self.sliderView.frame.origin.y, SCREEN_WIDTH/2, self.sliderView.frame.size.height);
            } completion:^(BOOL finished) {
            }];
            
            break;
        }
        case kEnumSettingTab:{
            [UIView animateWithDuration:0.25 animations:^{
                self.sliderView.frame = CGRectMake(SCREEN_WIDTH/2, self.sliderView.frame.origin.y, SCREEN_WIDTH/2, self.sliderView.frame.size.height);
            } completion:^(BOOL finished) {
    
            }];
            break;
        }
        default:
            break;
    }
    
}


@end
