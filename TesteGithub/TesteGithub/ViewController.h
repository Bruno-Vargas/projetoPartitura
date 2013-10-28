//
//  ViewController.h
//  TesteGithub
//
//  Created by Bruno Vargas Versignassi de Carvalho on 23/10/13.
//  Copyright (c) 2013 Bruno Vargas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioController.h"
#import "PitchDetector.h"
#import "Afinador.h"

@interface ViewController : UIViewController <PitchDetectorDelegate, AudioControllerDelegate>
{
    UILabel *freqLabel;
    AudioController *audioManager;
    PitchDetector *autoCorrelator;
    
    NSMutableArray *medianPitchFollow;
}
- (void) startTimer;

- (void) stopTimer;


@property (nonatomic, strong) Afinador *objAfinador;

@property (nonatomic) int aux;
- (double) timeElapsedInSeconds;
@property (nonatomic) double mili;
@property (strong, nonatomic) IBOutlet UIImageView *proxNota;
@property (strong, nonatomic) IBOutlet UIImageView *nota;
@property (strong, nonatomic) IBOutlet UIImageView *antNota;
@property (strong, nonatomic) IBOutlet UILabel *lValorFreq;


@property (nonatomic) NSDate *start;
@property (nonatomic) NSDate *end;


- (IBAction)start:(id)sender;
@end
