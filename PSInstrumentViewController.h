//
//  PSInstrumentViewController.h
//  PianoScribe
//
//  Created by Wenley Tong on 11/4/13.
//  Copyright (c) 2013 WenleyTong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSViewController.h"
#import "PSNoteDatabase.h"

@interface PSInstrumentViewController : UIViewController
{
   @private PSViewController * __unsafe_unretained parent;
   
   @private UIButton * record;
   @private UIButton * play;
   @private UIButton * pause;
   @private UIButton * stop;
   @private UILabel * keyboard;
   
   @private NSString * instrumentDirectory;
   
   @private PSNoteDatabase * db;
}

@property (assign) PSViewController * parent;
@property (retain) IBOutlet UIButton * record, * play, * pause, * stop;
@property (retain) IBOutlet UILabel * keyboard;
@property PSNoteDatabase * db;
@property NSString * instrumentDirectory;

//  Loads the instrument from the instrumentDirectory;
- (BOOL) loadInstrument;

- (IBAction) record:(UIButton *)sender;
- (IBAction) play:(UIButton *)sender;
- (IBAction) pause:(UIButton *)pause;
- (IBAction) stop:(UIButton *)stop;
- (IBAction) quit:(UIButton *)quit;

@end
