//
//  ViewController.m
//  Metronomo
//
//  Created by Bruno Vargas Versignassi de Carvalho on 25/10/13.
//  Copyright (c) 2013 Bruno Vargas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic) int cad;
@property(nonatomic) int com;
@property(nonatomic) BOOL rodando;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)comecar:(id)sender {
    NSLog(@"estou em comecar");
    
    self.cad = [self.numCadencia.text integerValue];
    self.com = [self.numCompasso.text integerValue];
    self.rodando = TRUE;
    self.metronomo =[[metronomo alloc] initWithTimer: self.com andCadencia: self.cad];
    
    [self.metronomo marcarCompasso];
    [self virarNumero];
    
}
-(IBAction)parar:(id)parar;{
    [self.metronomo pararCompasso];
    NSLog(@"estou na parar");
    
}

-(NSString*) numNome{
    switch (self.metronomo.contador){
        
        case 0:
            NSLog(@"um");
            return @"um";
            break;
        case 1:
            NSLog(@"2");
            return @"dois";
            break;
        case 2:
            NSLog(@"3");
            return @"tres";
            break;
        case 3:
            
            NSLog(@"4");
            return @"quatro";
            break;
        case 4:
            NSLog(@"5");
            return @"cinco";
            break;
        case 5:
            NSLog(@"6");
            return @"seis";
            break;
        case 6:
            NSLog(@"7");
            return @"sete";
            break;
        case 7:
            NSLog(@"8");
            return @"oito";
            break;
        case 8:
            NSLog(@"9");
            return @"nove";
            break;
        case 9:
            NSLog(@"10");
            return @"dez";
            break;
        case 10:
            NSLog(@"11");
            return @"onze";
            break;
        case 11:
            NSLog(@"12");
            return @"doze";
            break;
    }
    NSLog(@"nao achei um nome para a imagem");
    return @"erro";
}
-(void)virarNumero{
    NSLog(@"estou na virar numero");
    [self.numero setImage:[UIImage imageNamed:[self numNome]]];
}
@end
