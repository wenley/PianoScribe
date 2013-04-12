//
//  PSLearningViewController.h
//  PianoScribe
//
//  Created by Wenley Tong on 11/4/13.
//  Copyright (c) 2013 WenleyTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSLearningViewController : UIViewController
{
   @private UILabel * label;
   @private UIButton * startButton;
   @private UIButton * finishedButton; //  Temporary
}

@property (retain) IBOutlet UILabel * label;
@property (retain) IBOutlet UIButton * startButton;
@property (retain) IBOutlet UIButton * finishedButton; //  Temporary

- (IBAction) beginLearning:(UIButton *) sender;
- (IBAction) stop:(UIButton *)sender;
- (IBAction) finishedLearning:(UIButton *)sender; //  Temporary

@end
