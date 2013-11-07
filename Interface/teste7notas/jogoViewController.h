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
@property (weak, nonatomic) IBOutlet UIButton *botaoParar;
@property (weak, nonatomic) IBOutlet UIButton *botaoComecar;
@property (weak, nonatomic) IBOutlet UILabel *notaDesafio;
@property (weak, nonatomic) IBOutlet UILabel *notaTocada;
@property (weak, nonatomic) IBOutlet UIProgressView *tempo;

- (void) jogar;
- (void) novoDesafio;//cria uma nova nota musical para ser utilizada no desafio. Esata nota eh verificada para que nao seja igual a anterior!
- (BOOL) verificarNota;
- (IBAction)comecarJogo:(id)sender;
- (IBAction)pararJogo:(id)sender;

@end
