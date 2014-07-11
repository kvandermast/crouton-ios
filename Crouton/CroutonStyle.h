//
//  CroutonStyle.h
//  Crouton
//
//  Created by Kris Vandermast on 09/07/14.
//  Copyright (c) 2014 ACUZIO. All rights reserved.
//

#import <Foundation/Foundation.h>

enum CroutonUIHorizontalAlignment {
    CroutonUIStretch,
    CroutonUIAlignLeft,
    CroutonUIAlignRight,
    CroutonUIAlignCenter
};

enum CroutonUIVerticalAlignment {
    CroutonUIAlignTop,
    CroutonUIAlignBottom,
    CroutonUIFill
};

@interface CroutonStyle : NSObject

@property (strong, nonatomic) UIColor *backgroundColor;
@property (strong, nonatomic) UIColor *textColor;
@property (nonatomic) float textSize;
@property (nonatomic) float duration;
@property (nonatomic) enum CroutonUIHorizontalAlignment horizontalAlignment;
@property (nonatomic) enum CroutonUIVerticalAlignment verticalAlignment;

- (id) initStyleWithBackground:(UIColor *)backgroundColor textColor:(UIColor *) textColor textSize:(float) textSize;

@end
