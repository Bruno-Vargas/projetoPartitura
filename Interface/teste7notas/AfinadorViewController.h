//
//  AfinadorViewController.h
//  teste7notas
//
//  Created by Rodrigo Rovaron on 30/10/13.
//  Copyright (c) 2013 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioController.h"
#import "PitchDetector.h"
#import "Afinador.h"

@interface AfinadorViewController : UIViewController <PitchDetectorDelegate, AudioControllerDelegate>
{
    UILabel *freqLabel;
    AudioController *audioManager;
    PitchDetector *autoCorrelator;
    
    
    NSMutableArray *medianPitchFollow;
}



@property (nonatomic, strong) Afinador *objAfinador;



@property (nonatomic) int auxContTempo;
@property (nonatomic) double mili;

@property (weak, nonatomic) IBOutlet UIImageView *percurso;

@property (strong, nonatomic) IBOutlet UILabel *lOitava;
@property (strong, nonatomic) IBOutlet UILabel *lFrequencia;

@property (strong, nonatomic) IBOutlet UILabel *lNotaProxima;
@property (strong, nonatomic) IBOutlet UILabel *lNotaAtual;
@property (strong, nonatomic) IBOutlet UILabel *lNotaAnterior;


@property (nonatomic) NSDate *start;
@property (nonatomic) NSDate *end;


- (double) timeElapsedInSeconds;




@end
