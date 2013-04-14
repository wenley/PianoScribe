//
//  PSViewController.h
//  PianoScribe
//
//  Created by Wenley Tong on 11/4/13.
//  Copyright (c) 2013 WenleyTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSViewController : UIViewController <UIPickerViewDataSource,
                                                UIPickerViewDelegate,
                                                UITextFieldDelegate>
{
   //  Constants
   @private NSString * instrumentsDirectory;
   
   @private UIPickerView * picker;
   @private UITextField * instrumentName;
   @private NSArray * instrumentDirectories;
   
   @private NSString * currentInstrumentPicked;
}

@property (retain) IBOutlet UIPickerView * picker;
@property (retain) IBOutlet UITextField * instrumentName;
@property NSString * instrumentsDirectory;
@property NSArray * instrumentDirectories;
@property NSString * currentInstrumentPicked;

//  Receive UI messages
- (IBAction) initiateLearning:(UIButton *)sender;
- (IBAction) useExistingInstrument:(UIButton *)sender;

//  Transition to other view
- (void) useInstrument:(NSString *)pathToInstrumentDirectory;
- (void) loadInstruments;

@end
