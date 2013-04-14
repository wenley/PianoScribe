//
//  PSLearningViewController.h
//  PianoScribe
//
//  Created by Wenley Tong on 11/4/13.
//  Copyright (c) 2013 WenleyTong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSViewController.h"
#import "PSNoteDatabase.h"

@interface PSLearningViewController : UIViewController
{
   @private PSViewController * __unsafe_unretained parent;
   @private UILabel * label;
   @private UIButton * startButton;
   @private UIButton * finishedButton; //  Temporary
   
   @private PSNoteDatabase * database;
   @private NSString * name;
   @private NSString * directory;
}

@property (retain) IBOutlet UILabel * label;
@property (retain) IBOutlet UIButton * startButton;
@property (retain) IBOutlet UIButton * finishedButton; //  Temporary

@property (assign) PSViewController * parent;

@property NSString * name;
@property NSString * directory;
@property PSNoteDatabase * database;

- (IBAction) beginLearning:(UIButton *) sender;
- (IBAction) stop:(UIButton *)sender;
- (IBAction) finishedLearning:(UIButton *)sender; //  Temporary

@end
