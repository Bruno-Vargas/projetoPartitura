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
@property (nonatomic) float coordenadaX;
@property (nonatomic) float coordenadaY;
@property (nonatomic) float coordenadaAntigaX;
@property (nonatomic) float coordenadaAntigaY;

-(id) initWithValor: (float)valorX and: (float)valorY;
-(void) atualizarCoordenadas: (float) novoValorX and: (float) novoValorY;

@end
