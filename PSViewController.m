//
//  PSViewController.m
//  PianoScribe
//
//  Created by Wenley Tong on 11/4/13.
//  Copyright (c) 2013 WenleyTong. All rights reserved.
//

#import "PSViewController.h"
#import "PSInstrumentViewController.h"

@interface PSViewController ()

@end

@implementation PSViewController

@synthesize picker;

- (void)viewDidLoad
{
    [super viewDidLoad];
   //  Put appropriate names into picker
}

- (IBAction) initiateLearning:(UIButton *)sender
{
   //  Load new view to set name
   //  Collect data
}

- (IBAction) useExistingInstrument:(UIButton *)sender
{
   //  Load new view with some instrument database
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
