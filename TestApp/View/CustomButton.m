//
//  CustomButton.m
//  TestApp
//
//  Created by Hoang Son on 2/22/16.
//  Copyright (c) 2016 Hoang Son. All rights reserved.
//

#import "CustomButton.h"

static const CGFloat borderSize = 4.0;
static const CGFloat borderWidth = 1;

@implementation CustomButton
@synthesize colorBoder = _colorBoder;

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.layer.cornerRadius = borderSize;
        self.layer.borderWidth = borderWidth;
        self.layer.borderColor = [UIColor clearColor].CGColor;
    }
    return self;
}

- (void)setColorBoder:(BorderColorTypes)colorBoder{
    _colorBoder = colorBoder;
    switch (colorBoder) {
        case kEnumBlueColorType:{
            self.layer.borderColor = [UIColor blueColor].CGColor;
            self.backgroundColor = [UIColor redColor];
            break;
        }
        case kEnumRedColorType:{
            self.layer.borderColor = [UIColor redColor].CGColor;
            self.backgroundColor = [UIColor yellowColor];
            break;
        }
        case kEnumYellowColorType:{
            self.layer.borderColor = [UIColor yellowColor].CGColor;
            self.backgroundColor = [UIColor redColor];
            break;
        }
        case kEnumDefaultColorType:{
            self.layer.borderColor = [UIColor clearColor].CGColor;
            self.backgroundColor = [UIColor redColor];
            break;
        }
        default:
            break;
    }
}

@end
