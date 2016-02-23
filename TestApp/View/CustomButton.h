//
//  CustomButton.h
//  TestApp
//
//  Created by Hoang Son on 2/22/16.
//  Copyright (c) 2016 Hoang Son. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kEnumRedColorType = 0,
    kEnumBlueColorType  = 1,
    kEnumYellowColorType = 2,
    kEnumDefaultColorType = 3
}BorderColorTypes;

@interface CustomButton : UIButton
@property (nonatomic, assign) BorderColorTypes colorBoder;

@end
