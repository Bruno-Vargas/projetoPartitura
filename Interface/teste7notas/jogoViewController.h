//
//  jogoViewController.h
//  teste7notas
//
//  Created by Bruno Vargas Versignassi de Carvalho on 06/11/13.
//  Copyright (c) 2013 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "NotaMusical.h"

@interface jogoViewController : UIViewController

@property (nonatomic, strong) NotaMusical *notaAntiga;
@property (nonatomic, strong) NotaMusical *notaCorrente;
@property (nonatomic, strong) NSTimer *temporizador;

- (void) jogar;
- (void) novoDesafio;
- (BOOL) verificarNota;

@end
