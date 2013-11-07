//
//  jogoViewController.m
//  teste7notas
//
//  Created by Bruno Vargas Versignassi de Carvalho on 06/11/13.
//  Copyright (c) 2013 BEPiD. All rights reserved.
//

#import "jogoViewController.h"

@interface jogoViewController ()

@end

@implementation jogoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) jogar{

}
- (void) novoDesafio{
    int auxiliar = arc4random() % 7;
    switch (auxiliar) {
        case 0 : //do
            if (![self.notaAntiga.nome isEqualToString:@"do"])
                self.notaCorrente = [[NotaMusical alloc] initWithValor:@"do" andFrequencia:32.700 andNumOitava:1];
                break;
        case 1: //re
            if (![self.notaAntiga.nome isEqualToString:@"re"])
                self.notaCorrente = [[NotaMusical alloc] initWithValor:@"re" andFrequencia:36.6875 andNumOitava:1];
            
            break;
        case 2: //mi
            if (![self.notaAntiga.nome isEqualToString:@"mi"])
                self.notaCorrente = [[NotaMusical alloc] initWithValor:@"mi" andFrequencia:41.200 andNumOitava:1];
            
            break;
        case 3: //fa
            if (![self.notaAntiga.nome isEqualToString:@"fa"])
                self.notaCorrente = [[NotaMusical alloc] initWithValor:@"fa" andFrequencia:43.65 andNumOitava:1];
            
            break;
        case 4: //sol
            if (![self.notaAntiga.nome isEqualToString:@"sol"])
                self.notaCorrente = [[NotaMusical alloc] initWithValor:@"sol" andFrequencia:49.00 andNumOitava:1];
            break;
        case 5: //la
            if (![self.notaAntiga.nome isEqualToString:@"la"])
                self.notaCorrente = [[NotaMusical alloc] initWithValor:@"la" andFrequencia:55.00 andNumOitava:1];
            
            break;
        case 6: //si
            if (![self.notaAntiga.nome isEqualToString:@"si"])
                self.notaCorrente = [[NotaMusical alloc] initWithValor:@"si" andFrequencia:61.725 andNumOitava:1];
            break;
    }

}
- (BOOL) verificarNota{
    return TRUE;
}

- (IBAction)comecarJogo:(id)sender {
}

- (IBAction)pararJogo:(id)sender {
}


@end
