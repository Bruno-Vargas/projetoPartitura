//
//  jogoViewController.m
//  teste7notas
//
//  Created by Bruno Vargas Versignassi de Carvalho on 06/11/13.
//  Copyright (c) 2013 BEPiD. All rights reserved.
//

#import "jogoViewController.h"

@interface jogoViewController ()
@property (nonatomic)float progresso;
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
    [self.tempo setProgress:0.0 animated:TRUE] ;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) jogar{
    self.temporizador = [NSTimer scheduledTimerWithTimeInterval: 0.5
                                     target:self
                                   selector:@selector(rotinaJogo)
                                   userInfo:nil
                                    repeats:YES];


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
- (BOOL) verificarNota{ //deve chamar a parte que o rodrigao esta fazendo.
    
    return TRUE;
}

- (void) rotinaJogo{ //ideia cebtral do jogo
    [self atualizaBarra];
}

-(void) atualizaBarra{
    self.progresso += 0.01;
    [self.tempo setProgress:self.progresso animated:TRUE] ;
    
}

- (IBAction)comecarJogo:(id)sender {

    audioManager = [AudioController sharedAudioManager];
    audioManager.delegate = self;
    autoCorrelator = [[PitchDetector alloc] initWithSampleRate:audioManager.audioFormat.mSampleRate lowBoundFreq:30 hiBoundFreq:4500 andDelegate:self];
    
    medianPitchFollow = [[NSMutableArray alloc] initWithCapacity:22];
    
    
    
    self.progresso = 0.0;
    [self.tempo setProgress:self.progresso animated:TRUE] ;
    self.botaoComecar.enabled = NO;
    self.botaoParar.enabled = YES;
    [self novoDesafio]; //inicializa a nota do jogo
    [self jogar]; //comeca o jogo
}

- (IBAction)pararJogo:(id)sender {
    
    //resetar objetos ao parar
    audioManager = nil;
    autoCorrelator = nil;
    
    
    self.botaoComecar.enabled = YES;
    self.botaoParar.enabled = NO;
    [self pararTemporizador];
}

- (void)pararTemporizador{
    [self.temporizador invalidate];
    self.temporizador = nil;
}

- (void) updatedPitch:(float)frequency {
    
    double value = frequency;
    
    
    //Receber frequencia e aumentar precisao..
    //utilizando um filtro com a media da amplitude
    NSNumber *nsnum = [NSNumber numberWithDouble:value];
    [medianPitchFollow insertObject:nsnum atIndex:0];
    
    if(medianPitchFollow.count>22) {
        [medianPitchFollow removeObjectAtIndex:medianPitchFollow.count-1];
    }
    double median = 0;
    
    
    
    if(medianPitchFollow.count>=2) {
        NSSortDescriptor *highestToLowest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];
        NSMutableArray *tempSort = [NSMutableArray arrayWithArray:medianPitchFollow];
        [tempSort sortUsingDescriptors:[NSArray arrayWithObject:highestToLowest]];
        
        if(tempSort.count%2==0) {
            double first = 0, second = 0;
            first = [[tempSort objectAtIndex:tempSort.count/2-1] doubleValue];
            second = [[tempSort objectAtIndex:tempSort.count/2] doubleValue];
            median = (first+second)/2;
            value = median;
        } else {
            median = [[tempSort objectAtIndex:tempSort.count/2] doubleValue];
            value = median;
        }
        
        [tempSort removeAllObjects];
        tempSort = nil;
    }
    
    //aqui vamos fazer os testes para plotar dados na tela
    //a freq que esta no mic eh -> value
    
    NSLog(@"freq -> %f", value);
    
    
}
- (void) receivedAudioSamples:(SInt16 *)samples length:(int)len {
    [autoCorrelator addSamples:samples inNumberFrames:len];
}



@end
