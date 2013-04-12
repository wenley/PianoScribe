//
//  PSLearningViewController.m
//  PianoScribe
//
//  Created by Wenley Tong on 11/4/13.
//  Copyright (c) 2013 WenleyTong. All rights reserved.
//

#import "PSLearningViewController.h"

@interface PSLearningViewController ()
- (void) finished;
- (void) unloadView;

@end

@implementation PSLearningViewController

@synthesize label, startButton, finishedButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction) beginLearning:(UIButton *) sender
{
   //  Swap out buttons
   startButton.hidden = YES;
   finishedButton.hidden = NO;
}

- (IBAction) finishedLearning:(UIButton *)sender
{
   [self finished];
}

- (void) finished
{
   //  Save learned data to disk
   [self unloadView];
}

- (void) unloadView
{
   
}

- (IBAction) stop:(UIButton *)sender
{
   [self unloadView];
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

@end
