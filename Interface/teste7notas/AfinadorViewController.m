//
//  AfinadorViewController.m
//  teste7notas
//
//  Created by Rodrigo Rovaron on 30/10/13.
//  Copyright (c) 2013 BEPiD. All rights reserved.
//

#import "AfinadorViewController.h"
#import "apontador.h"

@interface AfinadorViewController ()

@property (nonatomic, strong) apontador* bolinha;

@end

@implementation AfinadorViewController

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
    self.bolinha = [[apontador alloc] initWithValor:0 and:0] ;
    self.bolinhaImagem = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bolinha.png"]];

}


- (void)viewDidUnload
{
    [super viewDidUnload];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) updatedPitch:(float)frequency {
    
    double value = frequency;
    
    
    
    //############ DATA SMOOTHING ###############
    //###     The following code averages previous values  ##
    //###  received by the pitch follower by using a             ##
    //###  median filter. Provides sub cent precision!          ##
    //#############################################

    
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
    
    
    self.lFrequencia.text = [NSString stringWithFormat:@"%4.3f Hz", value];
    [self performSelector:@selector(atualizarBolinha) withObject:nil afterDelay:0.1];
    
    [self.objAfinador calculaAfinacao:self.lFrequencia.text];

    //parar tempo
    if(self.auxContTempo==1){
        [self stopTimer];

        //verificar diferenca de tempo
        self.mili = [self timeElapsedInSeconds] * 1000.0f;

    }
    
    
    //preencher o numero da oitava que a nota esta
    self.lOitava.text = [NSString stringWithFormat:@"%2.0f",self.objAfinador.numOitava];
    
    
    
   // NSLog(@"freq reduzida -> %f", self.objAfinador.freqReduzida);
    [self.bolinha  atualizarCoordenadas: 0 and: self.objAfinador.freqReduzida];
    
    //preencher a nota atual.. a anterior e a proxima
    self.lNotaAnterior.text = self.objAfinador.notaAnterior;
    self.lNotaAtual.text = self.objAfinador.notaAtual;
    self.lNotaProxima.text = self.objAfinador.notaProxima;
    

    //apos a primeria passagem.. starta tempo
    [self startTimer];
    self.auxContTempo=1;
    
    
   
    
}

- (double) timeElapsedInSeconds {
    return [self.end timeIntervalSinceDate:self.start];
}

- (void) startTimer {
    self.start = [NSDate date];
}

- (void) stopTimer {
    self.end = [NSDate date];
}


- (void) receivedAudioSamples:(SInt16 *)samples length:(int)len {
    [autoCorrelator addSamples:samples inNumberFrames:len];
}


- (IBAction)bIniciar:(id)sender {
    
    //gambiarra.. para que ao clicar em inicar, ele sempre destrua os objetos.. e crie novos...
     [self bParar:(id)sender];
    audioManager = [AudioController sharedAudioManager];
    audioManager.delegate = self;
    autoCorrelator = [[PitchDetector alloc] initWithSampleRate:audioManager.audioFormat.mSampleRate lowBoundFreq:30 hiBoundFreq:4500 andDelegate:self];
    
    medianPitchFollow = [[NSMutableArray alloc] initWithCapacity:22];
    self.auxContTempo=0;
    
    self.objAfinador = [[Afinador alloc]init];

}


- (IBAction)bParar:(id)sender {
    
    
    self.objAfinador = nil;
    audioManager = nil;
    autoCorrelator = nil;
    
    self.lFrequencia.text = @"0.0 Hz";

    self.lOitava.text = @"0";
    
    
    self.lNotaAnterior.text = @"";
    self.lNotaAtual.text = @"";
    self.lNotaProxima.text = @"";
    
    //voltar a bolinha para a origem!
//    [self atualizaApontador:0 andTempo: 1]; //demora um segundo para ele voltar a origem;
    
}

- (IBAction)bVoltar:(id)sender {
    
    //quando voltar.. fazer as acoes de parar
    [self bParar:(id)sender];
    
}


-(void) atualizarBolinha{

    
   // NSLog(@"posicao y %f", self.bolinha.coordenadaY);
    self.bolinhaImagem.frame = CGRectMake(0, [self calculaCoordenada: self.objAfinador.diferencaFreqReal], 23, 30);
    
        [self.vBolinha addSubview:self.bolinhaImagem];
    
    [self performSelector:@selector(atualizarBolinha) withObject:nil afterDelay:1.0];

    
}
//funcao converte a distancia da nota musical para a localizacao da bolinha
-(float) calculaCoordenada: (float) frequencia{
    return 150 + frequencia * 32;
}

//-(void) atualizaApontador: (float) coordenadaY andTempo: (float) tempo{
//
//    CGRect newFrame;
//    UIImageView *bolinhaImagem2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bolinha.png"]];
//    bolinhaImagem2.frame = CGRectMake(0, self.bolinha.coordenadaY, 74, 79);
//
//    newFrame = CGRectMake(0 , coordenadaY, 74, 79);
//    [self.percurso addSubview:bolinhaImagem2];
//    
//    
//    [UIView animateWithDuration: tempo  //colocar o intervalo de tempo entre uma atualizacao da tela e outra!
//                          delay:0
//                        options: UIViewAnimationOptionCurveEaseOut
//                     animations:^{
//                         
//                         bolinhaImagem2.frame = newFrame;
//                         [self.bolinha atualizarCoordenadas:self.bolinha.coordenadaX and:coordenadaY];
//                     }
//                     completion: ^(BOOL anim){
//                         [bolinhaImagem2 removeFromSuperview];
//                     }];
//}

@end
