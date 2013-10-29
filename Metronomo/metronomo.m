//
//  metronomo.m
//  Metronomo
//
//  Created by Bruno Vargas Versignassi de Carvalho on 28/10/13.
//  Copyright (c) 2013 Bruno Vargas. All rights reserved.
//

#import "metronomo.h"
#import "ViewController.h"

@implementation metronomo
- (id) initWithTimer: (int)compasso andCadencia: (int) cadencia andTick:(TickBlock)tick {
    NSError *erro;
    self.urlTick = [NSURL fileURLWithPath: [NSString stringWithFormat: @"%@/tick.mp3", [[NSBundle mainBundle] resourcePath]]];
    self.urlTec = [NSURL fileURLWithPath: [NSString stringWithFormat: @"%@/tec.mp3", [[NSBundle mainBundle] resourcePath]]];
    self.reprodutorAudioTick = [[AVAudioPlayer alloc] initWithContentsOfURL: self.urlTick error:&erro];
    self.reprodutorAudioTec = [[AVAudioPlayer alloc] initWithContentsOfURL: self.urlTec  error:&erro];
    self.reprodutorAudioTick.numberOfLoops = 0;
    self.reprodutorAudioTec.numberOfLoops  = 0;
    self.compasso = compasso;
    self.cadencia = cadencia;
    self.contador = 0;
    self.tick = tick;
    

    return self;
}

-(void)reproduzir{
    if (self.contador != 0)[self.reprodutorAudioTick play];
    else [self.reprodutorAudioTec play];
    self.tick();
    
    self.contador = (self.contador + 1)% self.compasso;
    
    
}
-(void)marcarCompasso{
    //inicializa o timer e comeca a funcionar;
    
    self.temporizador =
    [NSTimer scheduledTimerWithTimeInterval: 60.0/self.cadencia
                                     target:self
                                   selector:@selector(reproduzir)
                                   userInfo:nil
                                    repeats:YES];

}

-(void)pararCompasso{
    //para o temporizador e desaloca ele;
    [self.temporizador invalidate];
    self.temporizador = nil;
}

@end
