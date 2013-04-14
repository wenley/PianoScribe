//
//  PSLearningViewController.m
//  PianoScribe
//
//  Created by Wenley Tong on 11/4/13.
//  Copyright (c) 2013 WenleyTong. All rights reserved.
//

#import "PSLearningViewController.h"
#import "PSInstrumentViewController.h"

@interface PSLearningViewController ()
- (void) finish;
- (void) unloadViewAnimated:(BOOL)animate;

@end

@implementation PSLearningViewController

@synthesize parent;
@synthesize label, startButton, finishedButton;
@synthesize name, directory, database;

- (IBAction) beginLearning:(UIButton *) sender
{
   //  Swap out buttons
   startButton.hidden = YES;
   self.database = [[PSNoteDatabase alloc] init];
   finishedButton.hidden = NO;
}

/* ---------------------------------------------------------------- */
/* Stop Learning                                                    */
/* ---------------------------------------------------------------- */

- (IBAction) finishedLearning:(UIButton *)sender
{
   [self finish];
}
- (void) finish
{
   //  Save learned data to disk
   NSString * instrumentWaves = [self.directory stringByAppendingPathComponent:self.name];
   [self.database saveDataAtDirectory:instrumentWaves];
   
   [parent loadInstruments]; //  Refresh parent's pickerView
   [self unloadViewAnimated:NO];
   
   //  Load Instrument View
   [parent useInstrument:instrumentWaves];
}
- (IBAction) stop:(UIButton *)sender
{
   [self unloadViewAnimated:YES];
}

- (void) unloadViewAnimated:(BOOL)animate
{
   [parent dismissViewControllerAnimated:animate completion:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
   //  Start with just the start and stop buttons
   finishedButton.hidden = YES;
}

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
