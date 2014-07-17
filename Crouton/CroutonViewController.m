//
//  CroutonViewController.m
//  Crouton
//
//  Created by Kris Vandermast on 09/07/14.
//  Copyright (c) 2014 ACUZIO. All rights reserved.
//

#import "CroutonViewController.h"
#import "Crouton.h"

@interface CroutonViewController ()
@property (strong, nonatomic) Crouton *waitCrouton;
@end

@implementation CroutonViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    

}
- (IBAction)showTopAlert:(id)sender {
   [[Crouton alert:@"This is an alert" inView:self.view] show];
}


- (IBAction)showBottomAlert:(id)sender {
    CroutonStyle *style = [[CroutonStyle alloc] initStyleWithBackground:[UIColor redColor]
                                                              textColor:[UIColor yellowColor]
                                                               textSize:15];
    style.verticalAlignment = CroutonUIAlignBottom;
    style.horizontalAlignment = CroutonUIAlignCenter;
    
    Crouton *crouton = [[Crouton alloc] initWithMessage:@"Yet another crouton" forView:self.view style:style];
    [crouton show];
}
- (IBAction)showRT:(id)sender {
    CroutonStyle *style = [[CroutonStyle alloc] initStyleWithBackground:[UIColor redColor]
                                                              textColor:[UIColor yellowColor]
                                                               textSize:15];
    style.verticalAlignment = CroutonUIAlignTop;
    style.horizontalAlignment = CroutonUIAlignRight;
    
    Crouton *crouton = [[Crouton alloc] initWithMessage:@"Yet another crouton" forView:self.view style:style];
    [crouton show];
}
- (IBAction)showCT:(id)sender {
    CroutonStyle *style = [[CroutonStyle alloc] initStyleWithBackground:[UIColor redColor]
                                                              textColor:[UIColor yellowColor]
                                                               textSize:15];
    style.verticalAlignment = CroutonUIAlignTop;
    style.horizontalAlignment = CroutonUIAlignCenter;
    style.duration = 1;
    
    Crouton *crouton = [[Crouton alloc] initWithMessage:@"Yet another crouton" forView:self.view style:style];
    [crouton show];
}
- (IBAction)showLT:(id)sender {
    CroutonStyle *style = [[CroutonStyle alloc] initStyleWithBackground:[UIColor redColor]
                                                              textColor:[UIColor yellowColor]
                                                               textSize:15];
    style.verticalAlignment = CroutonUIAlignTop;
    style.horizontalAlignment = CroutonUIAlignLeft;
    style.duration = 10;
    
    Crouton *crouton = [[Crouton alloc] initWithMessage:@"Yet another crouton" forView:self.view style:style];
    [crouton show];
}
- (IBAction)showBL:(id)sender {
    CroutonStyle *style = [[CroutonStyle alloc] initStyleWithBackground:[UIColor redColor]
                                                              textColor:[UIColor yellowColor]
                                                               textSize:15];
    style.verticalAlignment = CroutonUIAlignBottom;
    style.horizontalAlignment = CroutonUIAlignLeft;
    
    Crouton *crouton = [[Crouton alloc] initWithMessage:@"Yet another crouton" forView:self.view style:style];
    [crouton show];
}
- (IBAction)showCB:(id)sender {
    CroutonStyle *style = [[CroutonStyle alloc] initStyleWithBackground:[UIColor redColor]
                                                              textColor:[UIColor yellowColor]
                                                               textSize:15];
    style.verticalAlignment = CroutonUIAlignBottom;
    style.horizontalAlignment = CroutonUIAlignCenter;
    
    Crouton *crouton = [[Crouton alloc] initWithMessage:@"Yet another crouton" forView:self.view style:style];
    [crouton show];
}
- (IBAction)showRB:(id)sender {
    CroutonStyle *style = [[CroutonStyle alloc] initStyleWithBackground:[UIColor redColor]
                                                              textColor:[UIColor yellowColor]
                                                               textSize:15];
    style.verticalAlignment = CroutonUIAlignBottom;
    style.horizontalAlignment = CroutonUIAlignRight;
    
    Crouton *crouton = [[Crouton alloc] initWithMessage:@"Yet another crouton" forView:self.view style:style];
    [crouton show];
}
- (IBAction)showInfo:(id)sender {
    Crouton *crouton = [Crouton info:@"It ain't as bad as it seems!" inView:self.view];
    
    crouton.style.textSize = 24.0;
    
    [crouton show];
}
- (IBAction)pleaseWait:(id)sender {
    self.waitCrouton = [Crouton pleaseWait:@"Please wait 10s..." inView:self.view];

    [NSTimer scheduledTimerWithTimeInterval:10
                                     target:self
                                   selector:@selector(dismissWaitCrouton)
                                   userInfo:nil
                                    repeats:NO];
}

- (void) dismissWaitCrouton {
    [self.waitCrouton dismiss];
}

@end
