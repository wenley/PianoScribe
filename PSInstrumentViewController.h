//
//  PSInstrumentViewController.h
//  PianoScribe
//
//  Created by Wenley Tong on 11/4/13.
//  Copyright (c) 2013 WenleyTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSInstrumentViewController : UIViewController
{
   @private UIButton * record;
   @private UIButton * play;
   @private UIButton * pause;
   @private UIButton * stop;
   @private UILabel * keyboard;
   
   
}

@property (retain) IBOutlet UIButton * record, * play, * pause, * stop;
@property (retain) IBOutlet UILabel * keyboard;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil instrument:(NSString *)pathToInstrumentDirectory;

- (IBAction) record:(UIButton *)sender;
- (IBAction) play:(UIButton *)sender;
- (IBAction) pause:(UIButton *)pause;
- (IBAction) stop:(UIButton *)stop;

@end
