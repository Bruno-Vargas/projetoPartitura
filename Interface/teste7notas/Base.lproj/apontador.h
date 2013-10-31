//
//  apontador.h
//  Metronomo
//
//  Created by Bruno Vargas Versignassi de Carvalho on 31/10/13.
//  Copyright (c) 2013 Bruno Vargas. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface apontador : NSObject
@property (nonatomic) int coordenadaX;
@property (nonatomic) int coordenadaY;
@property (nonatomic) int coordenadaAntigaX;
@property (nonatomic) int coordenadaAntigaY;

-(id) initWithValor: (int)valorX and: (int)valorY;
-(void) atualizarCoordenadas: (int) novoValorX and: (int) novoValorY;

@end
