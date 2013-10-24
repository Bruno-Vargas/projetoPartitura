//
//  mixerSound.h
//  TesteIOSom
//
//  Created by Bruno Vargas Versignassi de Carvalho on 24/10/13.
//  Copyright (c) 2013 Rodrigo Rovaron. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
#import "sound.h"


#define NUM_FILES 2                         // number of audio files read in by old method

#define kDelayBufferLength 1024 * 100

@interface mixerSound : NSObject <AVAudioSessionDelegate>
@property (nonatomic) Float64   graphSampleRate;                // audio graph sample rate
CFURLRef                        sourceURLArray[NUM_FILES];      // for handling loop files
@property (nonatomic)sound*     soundStruct;    // scope reference for loop file callback



// Before using an AudioStreamBasicDescription struct you must initialize it to 0. However, because these ASBDs
// are declared in external storage, they are automatically initialized to 0.

AudioStreamBasicDescription     stereoStreamFormat;     // standard stereo 8.24 fixed point
AudioStreamBasicDescription     monoStreamFormat;       // standard mono 8.24 fixed point
AudioStreamBasicDescription     SInt16StreamFormat;		// signed 16 bit int sample format
AudioStreamBasicDescription     floatStreamFormat;		// float sample format (for testing)
AudioStreamBasicDescription     auEffectStreamFormat;		// audio unit Effect format


AUGraph                         processingGraph;        // the main audio graph
BOOL                            playing;                // indicates audiograph is running
BOOL                            interruptedDuringPlayback;  // indicates interruption happened while audiograph running

// some of the audio units in this app


AudioUnit                       ioUnit;                  // remote io unit
AudioUnit                       mixerUnit;                  // multichannel mixer audio unit
AudioUnit						auEffectUnit;           // this is the master effect on mixer output
AudioUnit						auInputEffect1;         // this is a mixer input bus effect
AudioUnit						auSampler;              // midi sampler
AudioUnit						auFilePlayer;           // ios5 fileplayer


// audio graph nodes

AUNode      iONode;             // node for I/O unit speaker
AUNode      mixerNode;          // node for Multichannel Mixer unit
AUNode      auEffectNode;       // master mix effect node
AUNode      samplerNode;         // sampler node
AUNode      filePlayerNode;      // fileplayer node
AUNode      inputEffect1Node;    // input channel fx node


// fft

FFTSetup fftSetup;			// fft predefined structure required by vdsp fft functions
COMPLEX_SPLIT fftA;			// complex variable for fft
int fftLog2n;               // base 2 log of fft size
int fftN;                   // fft size
int fftNOver2;              // half fft size
size_t fftBufferCapacity;	// fft buffer size (in samples)
size_t fftIndex;            // read index pointer in fft buffer

// working buffers for sample data

void *dataBuffer;               //  input buffer from mic/line
float *outputBuffer;            //  fft conversion buffer
float *analysisBuffer;          //  fft analysis buffer
SInt16 *conversionBufferLeft;   // for data conversion from fixed point to integer
SInt16 *conversionBufferRight;   // for data conversion from fixed point to integer

// convolution

float *filterBuffer;        // impusle response buffer
int filterLength;           // length of filterBuffer
float *signalBuffer;        // signal buffer
int signalLength;           // signal length
float *resultBuffer;        // result buffer
int resultLength;           // result length


// new instance variables for UI display objects

int displayInputFrequency;              // frequency determined by analysis
float displayInputLevelLeft;            // average input level for meter left channel
float displayInputLevelRight;           // average input level for meter right channel
int displayNumberOfInputChannels;       // number of input channels detected on startup


// for the synth callback - these are now instance variables so we can pass em back and forth to mic callback using self for inrefcon

float sinFreq;        // frequency of sine wave to generate
float sinPhase;       // current phase
BOOL synthNoteOn;     // determines whether note is playing

// fileplayer

AudioFileID filePlayerFile;

// mic FX type selection

int micFxType;  // enumerated fx types:
// 0: ring mod
// 1: fft
// 2: pitch shift
// 3: echo (delay)
// 4: low pass filter (moving average)
// 5: low pass filter (convolution)

BOOL micFxOn;       // toggle for using mic fx
float micFxControl; // multipurpose mix fx control slider


BOOL inputDeviceIsAvailable;    // indicates whether input device is available on ipod touch

@end
