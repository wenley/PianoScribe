//
//  PSViewController.m
//  PianoScribe
//
//  Created by Wenley Tong on 11/4/13.
//  Copyright (c) 2013 WenleyTong. All rights reserved.
//

#import "PSViewController.h"
#import "PSInstrumentViewController.h"
#import "PSLearningViewController.h"

@interface PSViewController ()



@end

@implementation PSViewController

@synthesize picker, instrumentName;
@synthesize instrumentDirectories, instrumentsDirectory, currentInstrumentPicked;

- (void)viewDidLoad
{
    [super viewDidLoad];
   //  Load instrument directories into instrumentDirectories
   self.instrumentsDirectory = [[NSBundle mainBundle] pathForResource:@"Instruments" ofType:nil];
   [self loadInstruments];
   
   //  Select the last instrument used
   NSString * lastInstrumentPath = [[NSBundle mainBundle] pathForResource:@"LastInstrumentUsed" ofType:@"txt"];
   NSString * lastInstrument = [NSString stringWithContentsOfFile:lastInstrumentPath
                                                         encoding:NSASCIIStringEncoding
                                                            error:nil];
   if (lastInstrument) {
      NSInteger lastRow = [instrumentDirectories indexOfObject:lastInstrument];
      [self.picker selectRow:lastRow inComponent:0 animated:NO];
   }
   else {
      [self.picker selectRow:0 inComponent:0 animated:NO];
   }
}

- (IBAction) initiateLearning:(UIButton *)sender
{
   if ([self.instrumentDirectories containsObject:self.instrumentName.text] ||
       [self.instrumentName.text isEqualToString:@""]) {
      NSLog(@"Invalid instrument name"); //  Display error message
   }
   else {
      PSLearningViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Learning"];
      vc.parent = self;
      vc.directory = self.instrumentsDirectory;
      vc.name = self.instrumentName.text;
      [self presentViewController:vc animated:YES completion:nil];
   }
}

- (IBAction) useExistingInstrument:(UIButton *)sender
{
   [self useInstrument:self.instrumentName.text];
}

- (void) useInstrument:(NSString *)pathToInstrumentDirectory
{
   PSInstrumentViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Instrument"];
   vc.parent = self;
   [self presentViewController:vc animated:YES completion:nil];
}

- (void) loadInstruments
{
   self.instrumentDirectories = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:instrumentsDirectory error:nil];
}

/* ---------------------------------------------------------------- */
/* UIPickerViewDatasource Methods                                   */
/* ---------------------------------------------------------------- */
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
   return 1; //  Only column of instrument names
}
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
   return self.instrumentDirectories.count;
}
/* ---------------------------------------------------------------- */
/* UIPickerViewDelegate Methods                                     */
/* ---------------------------------------------------------------- */
- (CGFloat) pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
   return 30.0;
}
- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
   return 300.0;
}
- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
   return [self.instrumentDirectories objectAtIndex:row];
}
- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
   NSAssert(component == 0, @"More than one component?");
   self.currentInstrumentPicked = [instrumentDirectories objectAtIndex:row];
}
/* ---------------------------------------------------------------- */
/* UITextField Methods                                              */
/* ---------------------------------------------------------------- */
- (BOOL) textFieldShouldEndEditing:(UITextField *)textField
{
   return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation
{
   return UIInterfaceOrientationPortrait;
}
- (NSUInteger) supportedInterfaceOrientations
{
   return UIInterfaceOrientationMaskPortrait;
}


@end
