//
//  apontador.m
//  Metronomo
//
//  Created by Bruno Vargas Versignassi de Carvalho on 31/10/13.
//  Copyright (c) 2013 Bruno Vargas. All rights reserved.
//

#import "apontador.h"

@implementation apontador


- (id) initWithValor:(int)valorX and:(int)valorY{
    self.coordenadaX = valorX;
    self.coordenadaY = valorY;
    self.coordenadaAntigaX = 0;
    self.coordenadaAntigaY = 0;
    
    return self;
}

- (void) atualizarCoordenadas:(int)novoValorX and:(int)novoValorY{
    self.coordenadaAntigaX = self.coordenadaX;
    self.coordenadaAntigaY = self.coordenadaY;
    self.coordenadaX = novoValorX;
    self.coordenadaY = novoValorY;
}
@end
