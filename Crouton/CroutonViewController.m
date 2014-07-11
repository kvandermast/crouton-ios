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
   [Crouton showAlert:@"This is an alert" inView:self.view];
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
    [Crouton showInfo:@"It ain't a bad as it seems!" inView:self.view];
}
- (IBAction)pleaseWait:(id)sender {
    self.waitCrouton = [Crouton pleaseWait:@"Please wait 5s..." inView:self.view];

    [NSTimer scheduledTimerWithTimeInterval:5
                                     target:self
                                   selector:@selector(dismissWaitCrouton)
                                   userInfo:nil
                                    repeats:NO];
}

- (void) dismissWaitCrouton {
    [self.waitCrouton dismiss];
}

@end
