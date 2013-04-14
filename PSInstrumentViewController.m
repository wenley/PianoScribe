//
//  PSInstrumentViewController.m
//  PianoScribe
//
//  Created by Wenley Tong on 11/4/13.
//  Copyright (c) 2013 WenleyTong. All rights reserved.
//

#import "PSInstrumentViewController.h"

@interface PSInstrumentViewController ()

@end

@implementation PSInstrumentViewController

@synthesize parent;
@synthesize record, play, pause, stop;
@synthesize keyboard;
@synthesize instrumentDirectory, db;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil instrument:(NSString *)pathToInstrumentDirectory
{
   if (pathToInstrumentDirectory == nil)
      return nil;
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       db = [[PSNoteDatabase alloc] initFromDirectory:pathToInstrumentDirectory];
       if (db == nil)
          return nil;
    }
    return self;
}

- (BOOL) loadInstrument
{
   self.db = [[PSNoteDatabase alloc] initFromDirectory:self.instrumentDirectory];
   return db != nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   pause.hidden = YES;
   stop.hidden = YES;
    // Do any additional setup after loading the view from its nib.
}

/* ---------------------------------------------------------------- */
/* Handle Button Events                                             */
/* ---------------------------------------------------------------- */

- (IBAction) record:(UIButton *)sender
{
   record.hidden = YES;
   play.hidden = YES;
   stop.hidden = NO;
   pause.hidden = NO;
}
- (IBAction) play:(UIButton *)sender
{
   record.hidden = YES;
   play.hidden = YES;
   stop.hidden = NO;
   pause.hidden = NO;
}
- (IBAction) pause:(UIButton *)sender
{
   record.hidden = NO;
   play.hidden = NO;
   pause.hidden = YES;
   stop.hidden = YES;
}
- (IBAction) stop:(UIButton *)sender
{
   record.hidden = NO;
   play.hidden = NO;
   pause.hidden = YES;
   stop.hidden = YES;
}
- (IBAction) quit:(UIButton *)quit
{
   [parent dismissViewControllerAnimated:YES completion:nil];
   //  Save / Send data somewhere?
}
/* ---------------------------------------------------------------- */

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation
{
   return UIInterfaceOrientationLandscapeLeft;
}
- (NSUInteger) supportedInterfaceOrientations
{
   return UIInterfaceOrientationMaskLandscape;
}

@end
