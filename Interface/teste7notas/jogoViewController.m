//
//  jogoViewController.m
//  teste7notas
//
//  Created by Bruno Vargas Versignassi de Carvalho on 06/11/13.
//  Copyright (c) 2013 BEPiD. All rights reserved.
//

#import "jogoViewController.h"
#import "Afinador.h"
@interface jogoViewController ()
@property (nonatomic) float progresso;
@property (nonatomic) NSString* frequenciaLida;
@property (nonatomic) Afinador* afinador;
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
    [self.tempo setProgress:0.0 animated:TRUE];
    
    //criar Label da nota que ira cair em animacao na tela
    self.notaCair = [[UILabel alloc] init];
    
    //determina a qtde de tempo que ira durar uma nota na tela
    //quanto maior o valor..mais dificil sera o game
    //tempo maximo é de 1.0
    self.tempoIncremeta = 0.2;
    
    //sabendo que o tempo total é de 1.0...
    //pega-se esse tempo e divide pelo tempoIncrementa para determinar a qtde de ciclos
    //a ser utilizado na pontuacao
   self.qtdeCiclosAnimacao = 1/self.tempoIncremeta;
    
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
            if (![self.notaAntiga.nome isEqualToString:@"Dó"])
                self.notaCorrente = [[NotaMusical alloc] initWithValor:@"Dó" andFrequencia:32.700 andNumOitava:1];
                break;
        case 1: //re
            if (![self.notaAntiga.nome isEqualToString:@"Ré"])
                self.notaCorrente = [[NotaMusical alloc] initWithValor:@"Ré" andFrequencia:36.6875 andNumOitava:1];
            
            break;
        case 2: //mi
            if (![self.notaAntiga.nome isEqualToString:@"Mi"])
                self.notaCorrente = [[NotaMusical alloc] initWithValor:@"Mi" andFrequencia:41.200 andNumOitava:1];
            
            break;
        case 3: //fa
            if (![self.notaAntiga.nome isEqualToString:@"Fá"])
                self.notaCorrente = [[NotaMusical alloc] initWithValor:@"Fá" andFrequencia:43.65 andNumOitava:1];
            
            break;
        case 4: //sol
            if (![self.notaAntiga.nome isEqualToString:@"Sol"])
                self.notaCorrente = [[NotaMusical alloc] initWithValor:@"Sol" andFrequencia:49.00 andNumOitava:1];
            break;
        case 5: //la
            if (![self.notaAntiga.nome isEqualToString:@"Lá"])
                self.notaCorrente = [[NotaMusical alloc] initWithValor:@"Lá" andFrequencia:55.00 andNumOitava:1];
            
            break;
        case 6: //si
            if (![self.notaAntiga.nome isEqualToString:@"Si"])
                self.notaCorrente = [[NotaMusical alloc] initWithValor:@"Si" andFrequencia:61.725 andNumOitava:1];
            break;
    }

}

- (void) rotinaJogo{ //ideia central do jogo
   
 
    [self atualizaBarra];
    NSLog(@"progresso %f",self.progresso);
    if (self.progresso == 1.0) {
        [self acaoErrar];
    }
    //como pegamos muitos ruídos do ambiente, não posso colocar que ele errou caso a entrada seja errada, por isso ele erra se nao acertar a nota.
    if ([self.afinador.notaAtual isEqualToString: self.notaCorrente.nome]){
        [self acaoAcertar];
    }
}
- (void) acaoAcertar {
    [self acaoPararJogo];
}

-(void) acaoCairNota{
    

    //caputar o comprimento da subView vCairNotas
    double heightSubView = [self vCairNotas].bounds.size.height;
    
    int posicaoX =  arc4random() % (int)([self vCairNotas].bounds.size.width);

    
    //ponto inicial da animacao
    self.notaCair.frame = CGRectMake(posicaoX, 0, 50, 15);

    
    //seta ponto de origem e termino de onde a nota é redesenhada com a animacao
    CGRect frameFinalAnimacao = CGRectMake(posicaoX, heightSubView, 50, 15);
    
    [self.notaCair setText:self.notaCorrente.nome];
    [self.vCairNotas addSubview:self.notaCair];
    
    
    [self calcularTempoAnimacao];
    
    //cria animacao de insercao da nota do ponto inicial ao ponto final
    [UIView animateWithDuration:self.tempoAnimacao
                          delay:0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.notaCair.frame = frameFinalAnimacao;
                     }
                     completion: nil];
    
    self.contadorCiclosAnimacao++;
    
    
}


-(void) acaoErrar {
    [self acaoPararJogo];
}

-(void) atualizaBarra{
    
    //pode-se definir o grau de dificuldade do game aumentando o valor a se incrementar no self.progresso
    self.progresso += self.tempoIncremeta;

    [self.tempo setProgress:self.progresso animated:TRUE] ;
    
}

- (IBAction)comecarJogo:(id)sender {
    [self acaoComecarJogo];
                [self acaoCairNota];
}


- (void) calcularTempoAnimacao{
    
    //Bruno aqui deve ser feito o calculo para saber quanto tempo durara a animacao
    //em segundos
    self.tempoAnimacao = 3;
    
}

- (void) acaoComecarJogo{
    self.botaoComecar.enabled = NO;
    self.botaoParar.enabled = YES;
    
    self.progresso = 0.0;
    self.afinador = [[Afinador alloc]init];

    self.contadorCiclosAnimacao = 0;
    
    [self audioManagerIniciate];
    [self.tempo setProgress:self.progresso animated:TRUE] ;
    [self novoDesafio]; //inicializa a nota do jogo
    [self atualizaTela];
    [self jogar]; //comeca o jogo
}
- (IBAction)pararJogo:(id)sender {
    
    [self acaoPararJogo];
}

- (void) acaoPararJogo{
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
    self.frequenciaLida = [NSString stringWithFormat:@"%4.3f Hz", value];

    
    //    NSLog(@"freq -> %f", value);
    
    //chamo a verificacão da nota musical tocada;
    [self.afinador calculaAfinacao:self.frequenciaLida];
    
    [self atualizaTela];
    
    
}

- (void) audioManagerIniciate{
    audioManager = [AudioController sharedAudioManager];
    audioManager.delegate = self;
    autoCorrelator = [[PitchDetector alloc] initWithSampleRate:audioManager.audioFormat.mSampleRate lowBoundFreq:30 hiBoundFreq:4500 andDelegate:self];
    
    medianPitchFollow = [[NSMutableArray alloc] initWithCapacity:22];
    
}
- (void) receivedAudioSamples:(SInt16 *)samples length:(int)len {
    [autoCorrelator addSamples:samples inNumberFrames:len];
}

- (void) atualizaTela{
    self.notaTocada.text = self.afinador.notaAtual;
   
}



@end
