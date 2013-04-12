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

@synthesize record, play, pause, stop;
@synthesize keyboard;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil instrument:(NSString *)pathToInstrumentDirectory
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/* ---------------------------------------------------------------- */
/* Handle Button Events                                             */
/* ---------------------------------------------------------------- */

- (IBAction) record:(UIButton *)sender
{
}
- (IBAction) play:(UIButton *)sender
{
}
- (IBAction) pause:(UIButton *)sender
{
}
- (IBAction) stop:(UIButton *)sender
{
}

/* ---------------------------------------------------------------- */

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
