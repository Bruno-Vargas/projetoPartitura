//
//  metronomo.h
//  Metronomo
//
//  Created by Bruno Vargas Versignassi de Carvalho on 28/10/13.
//  Copyright (c) 2013 Bruno Vargas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


@interface metronomo : NSObject

@property (nonatomic, strong) NSURL *urlTick;
@property (nonatomic, strong) NSURL *urlTec;
@property (nonatomic, strong) AVAudioPlayer *reprodutorAudioTick;
@property (nonatomic, strong) AVAudioPlayer *reprodutorAudioTec;
@property (nonatomic, strong) NSTimer *temporizador;
@property (nonatomic) int contador;
@property (nonatomic) int compasso;
@property (nonatomic) int cadencia;

- (id) initWithTimer: (int)compasso andCadencia: (int) cadencia;
- (void) marcarCompasso;
//inicializa o compasso e chama reproduzir;
- (void) reproduzir;
//reproduz o som condizente com o compasso da musica;
- (void) pararCompasso;
//para o compasso

@end
