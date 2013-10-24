//
//  sound.h
//  TesteIOSom
//
//  Created by Bruno Vargas Versignassi de Carvalho on 24/10/13.
//  Copyright (c) 2013 Rodrigo Rovaron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface sound : NSObject

@property(nonatomic)    BOOL                 isStereo;           // set to true if there is data in the audioDataRight member
@property(nonatomic)    UInt32               frameCount;         // the total number of frames in the audio data
@property(nonatomic)    UInt32               sampleNumber;       // the next audio sample to play
@property(nonatomic)    AudioUnitSampleType  *audioDataLeft;     // the complete left (or mono) channel of audio data read from an audio file
@property(nonatomic)    AudioUnitSampleType  *audioDataRight;    // the complete right channel of audio data read from an audio file


@end
