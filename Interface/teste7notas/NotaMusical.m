//
//  NotaMusical.m
//  teste7notas
//
//  Created by Bruno Vargas Versignassi de Carvalho on 06/11/13.
//  Copyright (c) 2013 BEPiD. All rights reserved.
//

#import "NotaMusical.h"

@implementation NotaMusical

- (id) initWithValor:(NSString *)nome andFrequencia:(float)frequencia andNumOitava:(int)numOitava{
    self = [super init];
    if (self){
        
        self.nome = nome;
        self.frequencia = frequencia;
        self.numOitava = numOitava;
    }
    return self;
}



@end
