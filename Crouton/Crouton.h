//
//  Crouton.h
//  Crouton
//
//  Created by Kris Vandermast on 09/07/14.
//  Copyright (c) 2014 ACUZIO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CroutonStyle.h"

@interface Crouton : NSObject
@property (strong, nonatomic)   CroutonStyle        *style;
@property (nonatomic)   enum    CroutonBehaviour    behaviour;

- (id) initWithMessage:(NSString *) message forView:(UIView *) currentView style:(CroutonStyle *) style;

+ (void) show:(NSString *) message inView:(UIView *) currentView withStyle:(CroutonStyle*) style;

+ (Crouton *) alert:(NSString *) message inView:(UIView *) currentView;
+ (Crouton *) info:(NSString *) message inView:(UIView *) currentView;
+ (Crouton *) pleaseWait:(NSString *) message inView:(UIView *) currentView;

+ (Crouton *) customView:(UIView *) view inView:(UIView *) currentView;

- (void) show;
- (void) dismiss;
@end
