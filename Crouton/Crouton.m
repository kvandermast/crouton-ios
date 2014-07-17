//
//  Crouton.m
//  Crouton
//
//  Created by Kris Vandermast on 09/07/14.
//  Copyright (c) 2014 ACUZIO. All rights reserved.
//

#import "Crouton.h"
#import "CroutonStyle.h"

enum CroutonBehaviour {
    CroutonBehaviourAutoDismiss,
    CroutonBehaviourManual
};


@interface Crouton() {
}

@property (strong, nonatomic)   NSString            *message;

@property (strong, nonatomic)   UIView              *parentView;
@property (strong, nonatomic)   UIView              *croutonView;

@property (nonatomic, weak)     NSTimer             *messageTimer;

@property (nonatomic)           CGFloat             screenWidth;
@property (nonatomic)           CGFloat             screenHeight;
@end


#define ALERT_BG_COLOR      [UIColor colorWithRed:255/255.0 green:85/255 blue:85.0/255.0 alpha:1.0f]
#define ALERT_TEXT_COLOR    [UIColor colorWithRed:255/255.0 green:255/255 blue:255.0/255.0 alpha:1.0f]
#define ALERT_TEXT_SIZE     18.0

#define INFO_BG_COLOR       [UIColor colorWithRed:0/255.0f green:128/255.0f blue:163/255.0f alpha:1.0f]
#define INFO_TEXT_COLOR     [UIColor colorWithRed:255/255.0 green:255/255 blue:255.0/255.0 alpha:1.0f]
#define INFO_TEXT_SIZE      18.0

#define PLEASE_WAIT_BG_COLOR [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.4f];

@implementation Crouton
#pragma mark - getters and setters
- (enum CroutonBehaviour) behaviour
{
    if(!_behaviour) {
        _behaviour = CroutonBehaviourAutoDismiss;
    }
    
    return _behaviour;
}

- (CGFloat) screenHeight
{
    BOOL inLandscape = UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]);
    
    return inLandscape ? [UIScreen mainScreen].bounds.size.width : [UIScreen mainScreen].bounds.size.height;
}

- (CGFloat) screenWidth
{
    BOOL inLandscape = UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]);
    
    return inLandscape ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.width;
}

#pragma mark - init
- (id) initWithMessage:(NSString *) message forView:(UIView *)currentView style:(CroutonStyle *) style
{
    self.message = message;
    self.parentView = currentView;
    self.style = style;
    
    return self;
}

#pragma mark - Class methods

+ (Crouton *) alert:(NSString *)message inView:(UIView *)currentView {

    CroutonStyle *style = [[CroutonStyle alloc] initStyleWithBackground:ALERT_BG_COLOR
                                                              textColor:ALERT_TEXT_COLOR
                                                               textSize:ALERT_TEXT_SIZE];
    Crouton *crouton = [[Crouton alloc] initWithMessage:message forView:currentView style:style];
    
    return crouton;
}

+ (Crouton *) info:(NSString *)message inView:(UIView *)currentView {
    CroutonStyle *style = [[CroutonStyle alloc] initStyleWithBackground:INFO_BG_COLOR
                                                              textColor:INFO_TEXT_COLOR
                                                               textSize:INFO_TEXT_SIZE];
  
    Crouton *crouton = [[Crouton alloc] initWithMessage:message forView:currentView style:style];
    
    return crouton;
}

+ (Crouton *) pleaseWait:(NSString *) message inView:(UIView *) currentView {
    BOOL inLandscape = UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]);
    
    CGFloat screenWidth = inLandscape ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = inLandscape ? [UIScreen mainScreen].bounds.size.width : [UIScreen mainScreen].bounds.size.height;
    CGRect screenFrame =  CGRectMake(0, 0, screenWidth, screenHeight);
    
    UIView *waitContainerView = [[UIView alloc] initWithFrame:screenFrame];
    waitContainerView.backgroundColor = PLEASE_WAIT_BG_COLOR;
    
    
    CGFloat w = 200;
    CGFloat h = 50;
    CGFloat x = (screenWidth-w)/2;
    CGFloat y = (screenHeight-h)/2;
    
    UIView *waitView = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    waitView.backgroundColor = [UIColor whiteColor];
    waitView.layer.cornerRadius = 5;
    waitView.layer.masksToBounds = YES;
    
    NSMutableAttributedString *attrLabel = [[NSMutableAttributedString alloc] initWithString:message];
    [attrLabel addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0,attrLabel.length)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(45,5, waitView.frame.size.width-70, 40)];
    label.numberOfLines = 0;
    label.attributedText = attrLabel;
    
    UIActivityIndicatorView *progress = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(5,5, 40, 40)];
    progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [progress startAnimating];
    
    [waitView addSubview:progress];
    [waitView addSubview:label];
    [waitView setAutoresizesSubviews:YES];
    
    [waitContainerView setAutoresizesSubviews:YES];
    [waitContainerView addSubview:waitView];
    
    CroutonStyle *style = [[CroutonStyle alloc] init];
    style.verticalAlignment = CroutonUIFill;
    style.horizontalAlignment = CroutonUIStretch;
    
    Crouton *crouton = [Crouton customView:waitContainerView inView:currentView];
    crouton.style = style;
    
    return crouton;
}

+ (Crouton *) customView:(UIView *) view inView:(UIView *) currentView {
    Crouton *crouton = [[Crouton alloc] init];
    
    crouton.croutonView = view;
    crouton.parentView = currentView;
    crouton.behaviour = CroutonBehaviourManual;
    
    [crouton queueAndMakeVisible];
    
    return crouton;
}

+ (void) show:(NSString *) message inView:(UIView *)currentView withStyle:(CroutonStyle*) style;
{
    Crouton *crouton = [[Crouton alloc] initWithMessage:message forView:currentView style:style];
    
    [crouton show];
}


- (CGRect) createFrameByStyle:(CroutonStyle *) style
{
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = self.screenWidth;
    CGFloat height = style.verticalAlignment == CroutonUIFill ? self.screenHeight : 80;
    
    if(style.verticalAlignment == CroutonUIAlignTop || style.verticalAlignment == CroutonUIFill) {
        y = 0;
    } else {
        y = self.screenHeight - height;
    }
    
    switch (style.horizontalAlignment) {
        case CroutonUIAlignCenter:
            x = (self.screenWidth * 0.2)/2;
            width = (self.screenWidth * 0.8);
            break;
        case CroutonUIAlignLeft:
            x = 0;
            width = (self.screenWidth * 0.8);
            break;
        case CroutonUIAlignRight:
            width = (self.screenWidth * 0.8);
            x = self.screenWidth - width;
            break;
        case CroutonUIStretch:
        default:
            x = 0;
            width = self.screenWidth;
            break;
    }
    
    return CGRectMake(x, y, width, height);
}

# pragma mark - instance method
- (void) show
{
    [self build];
    
    [self queueAndMakeVisible];
}

- (void) build
{
    CGRect frame = [self createFrameByStyle:self.style];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5,20, frame.size.width, 55)];
    label.numberOfLines = 0;
    
    NSMutableAttributedString *attrLabel = [[NSMutableAttributedString alloc] initWithString:self.message];
    [attrLabel addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:self.style.textSize] range:NSMakeRange(0,attrLabel.length)];
    [attrLabel addAttribute:NSForegroundColorAttributeName value:self.style.textColor range:NSMakeRange(0,attrLabel.length)];
    label.attributedText = attrLabel;
    
    self.croutonView = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 0)];
    [self.croutonView addSubview:label];
    [self.croutonView setBackgroundColor:self.style.backgroundColor];
}

- (NSMutableArray *) croutons
{
    static NSMutableArray *roastedCroutons;
    
    if(!roastedCroutons) {
        roastedCroutons = [[NSMutableArray alloc] init];
    }
    
    return roastedCroutons;
}

- (void) queueAndMakeVisible
{
    [self.croutons addObject:self];
    
    //if we added the only crouton, display it
    if([self.croutons count] == 1) {
        [self render];
    }
}

- (void) dismiss
{
    if(self.croutonView) {
        [self.croutonView removeFromSuperview];
        self.croutonView = nil;
    }
    
    if(self.messageTimer) {
        [self.messageTimer invalidate];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
    [self.croutons removeObjectIdenticalTo:self];
    
    if([self.croutons count] > 0) {
        Crouton *crouton = (Crouton *) [self.croutons firstObject];
        [crouton render];
    }
    
}

- (void) dismissOnTap:(UITapGestureRecognizer *) recognizer
{
    [self dismiss];
}

- (void) relayoutOnOrientationChange:(NSNotification *) notification
{
    if(self && self.croutonView) {
        if(self.style) {
            CGRect frame = [self createFrameByStyle:self.style];
            
            for (UIView *subview in self.croutonView.subviews) {
                float x = subview.frame.origin.x * (frame.size.width / self.croutonView.frame.size.width);
                float y = subview.frame.origin.y * (frame.size.height / self.croutonView.frame.size.height);
                
                subview.frame = CGRectMake(x, y, subview.frame.size.width, subview.frame.size.height);
            }
            
            //Animation that sets the alpha from 1 to 0 or 0 to 1 and changes the frame of the view
            [UIView animateWithDuration:0.1 delay:0 options: UIViewAnimationOptionCurveEaseIn
                             animations:^{ self.croutonView.alpha = 1.0f; self.croutonView.frame = frame; }
                             completion:nil];
        }
    }
}


- (void) render
{
    [self.parentView addSubview:self.croutonView];
    
    if(self.behaviour == CroutonBehaviourAutoDismiss) {
        CGRect frame = [self createFrameByStyle:self.style];
        
        //Animation that sets the alpha from 1 to 0 or 0 to 1 and changes the frame of the view
        [UIView animateWithDuration:0.1 delay:0 options: UIViewAnimationOptionCurveEaseIn
                         animations:^{ self.croutonView.alpha = 1.0f; self.croutonView.frame = frame; }
                         completion:nil];
        
        //Sets timer on create
        [self.messageTimer invalidate];
        self.messageTimer = [NSTimer scheduledTimerWithTimeInterval:self.style.duration
                                                             target:self
                                                           selector:@selector(dismiss)
                                                           userInfo:nil
                                                            repeats:NO];
        
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(dismissOnTap:)];
        [self.croutonView addGestureRecognizer:gestureRecognizer];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(relayoutOnOrientationChange:)
                                                 name:@"UIDeviceOrientationDidChangeNotification"
                                               object:nil];
}
@end
