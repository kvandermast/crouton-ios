//
//  CroutonStyle.m
//  Crouton
//
//  Created by Kris Vandermast on 09/07/14.
//  Copyright (c) 2014 ACUZIO. All rights reserved.
//

#import "CroutonStyle.h"

@implementation CroutonStyle
#pragma mark - init
- (id) initStyleWithBackground:(UIColor *)backgroundColor textColor:(UIColor *)textColor textSize:(float)textSize
{
    self.backgroundColor = backgroundColor;
    self.textColor = textColor;
    self.textSize = textSize;
    
    return self;
}

#pragma mark - getters and setters
- (enum CroutonUIHorizontalAlignment) horizontalAlignment
{
    if(!_horizontalAlignment) {
        _horizontalAlignment = CroutonUIStretch;
    }
    
    return _horizontalAlignment;
}

- (enum CroutonUIVerticalAlignment)verticalAlignment
{
    if(!_verticalAlignment) {
        _verticalAlignment = CroutonUIAlignTop;
    }
    
    return _verticalAlignment;
}

- (float) duration {
    if(!_duration || _duration <= 0) {
        _duration = 5;
    }
    
    return _duration;
}

- (float) textSize {
    if(!_textSize || _textSize <= 0) {
        _textSize = 14;
    }
    
    return _textSize;
}
@end
