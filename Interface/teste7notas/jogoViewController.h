//
//  jogoViewController.h
//  teste7notas
//
//  Created by Bruno Vargas Versignassi de Carvalho on 06/11/13.
//  Copyright (c) 2013 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioController.h"
#import "PitchDetector.h"
#import <AVFoundation/AVFoundation.h>
#import "NotaMusical.h"

@interface jogoViewController : UIViewController <PitchDetectorDelegate, AudioControllerDelegate>
{
    UILabel *freqLabel;
    AudioController *audioManager;
    PitchDetector *autoCorrelator;
    
    
    NSMutableArray *medianPitchFollow;
}

@property (nonatomic) double tempoAnimacao;

@property (nonatomic) int contadorCiclosAnimacao;
@property (nonatomic) int qtdeCiclosAnimacao;
@property (nonatomic) double tempoIncremeta;
@property (strong, nonatomic) IBOutlet UIView *vCairNotas;
@property (nonatomic, strong) UILabel *notaCair;
@property (nonatomic, strong) NotaMusical *notaAntiga;
@property (nonatomic, strong) NotaMusical *notaCorrente;
@property (nonatomic, strong) NSTimer *temporizador;
@property (weak, nonatomic) IBOutlet UIButton *botaoParar;
@property (weak, nonatomic) IBOutlet UIButton *botaoComecar;
@property (weak, nonatomic) IBOutlet UIProgressView *tempo;
@property (weak, nonatomic) IBOutlet UILabel *notaTocada;


- (void) calcularTempoAnimacao;
- (void) jogar;
- (void) novoDesafio;//cria uma nova nota musical para ser utilizada no desafio. Esata nota eh verificada para que nao seja igual a anterior!
- (IBAction)comecarJogo:(id)sender;
- (IBAction)pararJogo:(id)sender;

@end
