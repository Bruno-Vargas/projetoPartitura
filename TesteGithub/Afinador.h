//
//  Afinador.h
//  TesteGithub
//
//  Created by Rodrigo Rovaron on 28/10/13.
//  Copyright (c) 2013 Bruno Vargas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Afinador : NSObject




//criar matriz com nome da nota e valor da frequencia
@property (nonatomic, strong) NSMutableArray *notasMusicais;

@property (nonatomic) double rangeToleranciaAfinacao;

@property (nonatomic) double menorFrequencia;
@property (nonatomic) double maiorFrequencia;

@property (nonatomic, strong) NSString *notaMaisAfinada;

@property (nonatomic, strong) NSString *notaAnterior;

@property (nonatomic, strong) NSString *notaAtual;

@property (nonatomic, strong) NSString *notaProxima;


@property (nonatomic, strong) NSMutableArray *moduloMatrizAfinada;

@property (nonatomic) double numOitava;

@property (nonatomic, strong) NSMutableArray *matrizAfinada;

-(void) carregaNotasFrequencias;

-(void) calculaNumOitava: (double) freqAtual;

-(double) calculaAfinacao: (NSString *) freqAtual;



@end
