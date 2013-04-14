//
//  PSNoteDatabase.h
//  PianoScribe
//
//  Created by Wenley Tong on 12/4/13.
//  Copyright (c) 2013 WenleyTong. All rights reserved.
//

#import <Foundation/Foundation.h>

enum { NUM_NOTES = 88 };
enum { WINDOW_SIZE = 2048 };

@interface PSNoteDatabase : NSObject
{
   @private double ** notes;
   @private BOOL finished;   //  All notes have been normalized
   @private BOOL filled;     //  All notes have a waveform
}

//  Takes notes
- (id) initFromDirectory:(NSString *)dirName;

//  Will make defensive copy
- (void) rememberWave:(double *)signal ofLength:(unsigned)len asNoteIndex:(unsigned)idx;

//  fills in the rest of the database
- (void) extrapolate;

//  Saves wave forms to files under the specified directory
- (void) saveDataAtDirectory:(NSString *)path;

//  Returns array with indices of best guessed notes
- (NSArray *) bestHypothesisForSignal:(double *)signal ofLength:(unsigned)len;

@end
