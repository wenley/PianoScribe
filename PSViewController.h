//
//  PSViewController.h
//  PianoScribe
//
//  Created by Wenley Tong on 11/4/13.
//  Copyright (c) 2013 WenleyTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSViewController : UIViewController
{
   @private UIPickerView * picker;
}

@property (retain) IBOutlet UIPickerView * picker;

- (IBAction) initiateLearning:(UIButton *)sender;
- (IBAction) useExistingInstrument:(UIButton *)sender;

@end
