//
//  PSNoteDatabase.m
//  PianoScribe
//
//  Created by Wenley Tong on 12/4/13.
//  Copyright (c) 2013 WenleyTong. All rights reserved.
//

#import "PSNoteDatabase.h"
#import <Accelerate/Accelerate.h>

@interface PSNoteDatabase()

- (double **) alignDatabaseToSignal:(double *) signal ofLength:(unsigned)len;
- (int) maxConvolutionOfSignal:(double *)signal1 ofLength:(unsigned)len1
                    withSignal:(double *)signal2 ofLength:(unsigned)len2;
- (void) computeInverseOf:(double *) array withRows:(int) rows andColumns:(int) cols into:(double *) result;

@end

@implementation PSNoteDatabase

/* ---------------------------------------------------------------- */
/* Creation of Database ------------------------------------------- */
/* ---------------------------------------------------------------- */

- (id) init
{
   self = [super init];
   if (self) {
      notes = calloc(NUM_NOTES, sizeof(double *));
      finished = NO;
   }
   return self;
}

//  Takes notes
- (id) initFromDirectory:(NSString *)dirName
{
   self = [super init];
   if (self) {
      NSArray * directory = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dirName error:NULL];
      if (directory.count == 0)
         NSLog(@"Empty directory? %@", dirName);
      for (int i = 0; i < directory.count; i++) {
         NSString * contents = [NSString stringWithContentsOfFile:[directory objectAtIndex:i] encoding:NSASCIIStringEncoding error:NULL];
         NSArray * lines = [contents componentsSeparatedByString:@"\n"];
         int index = ((NSString *) [lines objectAtIndex:0]).intValue;
         if (index < 0 || index >= NUM_NOTES) {
            NSLog(@"Bad note index: %@", [directory objectAtIndex:i]);
            continue;
         }
         if (lines.count - 1 < WINDOW_SIZE) {
            NSLog(@"Bad window size: %@", [directory objectAtIndex:i]);
            continue;
         }
         double * wave = calloc(WINDOW_SIZE, sizeof(double));
         for (int i = 1; i < lines.count; i++) {
            int value = ((NSString *) [lines objectAtIndex:i]).intValue;
            wave[i-1] = value;
         }
         if (notes[index] == NULL)
            notes[index] = wave;
         else {
            NSLog(@"Duplicate note of index: %d", index);
         }
      }
      
   }
   return self;
}

//  Will make defensive copy
- (void) rememberWave:(double *)signal ofLength:(unsigned)len asNoteIndex:(unsigned)idx
{
}

//  fills in the rest of the database
- (void) extrapolate
{
}

/* ---------------------------------------------------------------- */
/* Utilization of Database and Support ---------------------------- */
/* ---------------------------------------------------------------- */

- (double **) alignDatabaseToSignal:(double *) signal ofLength:(unsigned int)len
{
   if (len != WINDOW_SIZE) {
      NSLog(@"Bad length: %u; should be %d", len, WINDOW_SIZE);
      return NULL;
   }
   double ** alignedNotes = calloc(NUM_NOTES, sizeof(double *));
   for (int i = 0; i < WINDOW_SIZE; i++) {
      double * note = notes[i];
      int maxt = [self maxConvolutionOfSignal:signal ofLength:len
                                   withSignal:note ofLength:WINDOW_SIZE];
      double * alignedNote = calloc(WINDOW_SIZE, sizeof(double));
      for (int n = 0; n < WINDOW_SIZE; n++) {
         int index = (n - maxt + WINDOW_SIZE) % WINDOW_SIZE;
         alignedNote[n] = note[index];
      }
      alignedNotes[i] = alignedNote;
   }
   return alignedNotes;
}

- (int) maxConvolutionOfSignal:(double *)signal1 ofLength:(unsigned int)len1
                    withSignal:(double *)signal2 ofLength:(unsigned int)len2
{
   if (len1 != len2) {
      NSLog(@"Mismatched lengths: %u vs. %u", len1, len2);
      return -1;
   }
   double * result = calloc(len1, sizeof(double));
   vDSP_convD(signal1, 1, signal2 + len2 - 1, -1, result, 1, len1, len2);
   
   //  Find t that gives max value
   int maxt = 0;
   double maxVal = 0.0;
   for (int i = 0; i < len1; i++) {
      double absVal = fabs(result[i]);
      if (absVal > maxVal) {
         maxt = i;
         maxVal = absVal;
      }
   }

   free(result);
   return maxt;
}

- (void) computeInverseOf:(double *) array withRows:(int) rows andColumns:(int) cols into:(double *) result
{
   //  Copy to avoid modifying array during Gauss-Jordan
   //  Also create 2D version of result
   double ** matrix = calloc(rows, sizeof(double *));
   double ** result2D = calloc(rows, sizeof(double *));
   for (int i = 0; i < rows; i++) {
      matrix[i] = calloc(cols, sizeof(double));
      for (int j = 0; j < cols; j++)
         matrix[i][j] = array[i*cols + j];
      result2D[i] = calloc(cols, sizeof(double));
      result2D[i][i] = 1.0;
   }
   
   //  Gauss-Jordan Elimination
   //  From pseudo-code on Wikipedia
   for (int k = 0; k < rows; k++) {
      //  Find pivot row
      int i_max = k;
      for (int i = k + 1; i < rows; i++)
         if (fabs(matrix[i][k]) > fabs(matrix[i_max][k]))
            i_max = i;
      if (matrix[i_max][k] == 0.0)
         NSLog(@"Failed; can't find inverse");
      //  Swap if necessary
      if (i_max != k) {
         double * temp = matrix[i_max];
         matrix[i_max] = matrix[k];
         matrix[k] = temp;
         
         temp = result2D[i_max];
         result2D[i_max] = result2D[k];
         result2D[k] = temp;
      }
      //  Perform row operation
      for (int i = k + 1; i < rows; i++) {
         double factor = matrix[i][k] / matrix[k][k];
         for (int j = k + 1; j < cols; j++) {
            matrix[i][j] = matrix[i][j] - matrix[k][j] * factor;
            result2D[i][j] = result2D[i][j] - result2D[k][j] * factor; //  Perform parallel computation
         }
         matrix[i][k] = 0.0;
      }
   }
   
   //  Clean up and write down results
   for (int i = 0; i < rows; i++)
      free(matrix[i]);
   free(matrix);
   for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++)
         result[i*cols + j] = result2D[i][j];
      free(result2D[i]);
   }
   free(result2D);
}

//  Returns array with indices of best guessed notes
- (NSArray *) bestHypothesisForSignal:(double *)signal ofLength:(unsigned)len
{
   double ** alignedNotes = [self alignDatabaseToSignal:signal ofLength:len];
   
   //  Make D, D^T, s
   int rows = NUM_NOTES;
   int columns = WINDOW_SIZE;
   double * D = calloc(rows * columns, sizeof(double));
   for (int i = 0; i < rows; i++)
      
   
   double * DT = calloc(rows * columns, sizeof(double));
   vDSP_mtransD(D, 1, DT, 1, columns, rows);
   double * sig = calloc(signal.count, sizeof(double));
   int i = 0;
   for (NSNumber * value in signal)
      sig[i++] = value.doubleValue;
   
   double * temp = calloc(rows * rows, sizeof(double));
   vDSP_mmulD(D, 1, DT, 1, temp, 1, rows, rows, columns);
   double * inv = calloc(rows * rows, sizeof(double));
   [self computeInverseOf:temp withRows:rows andColumns:rows into:inv];
   double * transform = calloc(rows * columns, sizeof(double));
   vDSP_mmulD(inv, 1, D, 1, transform, 1, rows, columns, rows);
   
   double * alpha = calloc(rows, sizeof(double));
   vDSP_mmulD(transform, 1, sig, 1, alpha, 1, rows, 1, columns);
   
   return nil;
}


@end
