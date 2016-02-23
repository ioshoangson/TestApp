//
//  CustomTextField.m
//  TestApp
//
//  Created by Hoang Son on 2/22/16.
//  Copyright (c) 2016 Hoang Son. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.borderStyle = UITextBorderStyleNone;
        self.background = [[UIImage imageNamed:@"label_normal_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 4, 5)];
        self.spellCheckingType = UITextSpellCheckingTypeNo;
        self.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    return self;
}


- (BOOL)becomeFirstResponder
{
    self.background = [[UIImage imageNamed:@"label_selected_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 4, 5)];
    
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    self.background = [[UIImage imageNamed:@"label_normal_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 4, 5)];
    
    BOOL result = [super resignFirstResponder];
    self.textColor = self.textColor;// fix bug http://stackoverflow.com/questions/22285492/uitextfield-textcolor-reverts-after-resignfirstresponder
    
    return result;
}


// placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(10, 3, bounds.size.width - 20, bounds.size.height + 3);
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectMake(10, 3, bounds.size.width - 20, bounds.size.height + 3);
}


@end
