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
    
    
    //instanciar imagem bolinha
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
    
    
    
    //inserir frequencia recebida no campo FREQUENCIA
    self.lFrequencia.text = [NSString stringWithFormat:@"%4.3f Hz", value];

    //chamar animacao da bolinha para alocar ela na frequencia atual
    [self performSelector:@selector(atualizarBolinha) withObject:nil afterDelay:0.1];
    
    //chamar metodo para determinar a nota musica
    [self.objAfinador calculaAfinacao:self.lFrequencia.text];


    //preencher o numero da oitava que a nota esta
    self.lOitava.text = [NSString stringWithFormat:@"%2.0f",self.objAfinador.numOitava];
    
 
    [self.bolinha  atualizarCoordenadas: 0 and: self.objAfinador.freqReduzida];
    
    //preencher a nota atual.. a anterior e a proxima
    self.lNotaAnterior.text = self.objAfinador.notaAnterior;
    self.lNotaAtual.text = self.objAfinador.notaAtual;
    self.lNotaProxima.text = self.objAfinador.notaProxima;
    
    
}



- (void) receivedAudioSamples:(SInt16 *)samples length:(int)len {
    [autoCorrelator addSamples:samples inNumberFrames:len];
}


- (IBAction)bIniciar:(id)sender {
    
    //sempre ao clicar em iniciar.. clicar em parar... assim evita problemas de nao iniciar a captura de audio/frequencia
    
    [self bParar:(id)sender];
    
    audioManager = [AudioController sharedAudioManager];
    audioManager.delegate = self;
    autoCorrelator = [[PitchDetector alloc] initWithSampleRate:audioManager.audioFormat.mSampleRate lowBoundFreq:30 hiBoundFreq:4500 andDelegate:self];
    
    medianPitchFollow = [[NSMutableArray alloc] initWithCapacity:22];
    self.auxContTempo=0;
    
    self.objAfinador = [[Afinador alloc]init];

}


- (IBAction)bParar:(id)sender {
    
    
    //resetar objetos ao parar
    self.objAfinador = nil;
    audioManager = nil;
    autoCorrelator = nil;
    
    
    //zerar campos ao parar
    self.lFrequencia.text = @"0.0 Hz";
    self.lOitava.text = @"0";
    
    
    self.lNotaAnterior.text = @"";
    self.lNotaAtual.text = @"";
    self.lNotaProxima.text = @"";
    
}

- (IBAction)bVoltar:(id)sender {
    
    //quando voltar.. fazer as acoes de parar
    [self bParar:(id)sender];
    
}


-(void) atualizarBolinha{

    
   // NSLog(@"posicao y %f", self.bolinha.coordenadaY);
    self.bolinhaImagem.frame = CGRectMake(5, [self calculaCoordenada: self.objAfinador.diferencaFreqReal], 11, 15);
    
    //add bolinha na subview
    [self.vBolinha addSubview:self.bolinhaImagem];
    
    [self performSelector:@selector(atualizarBolinha) withObject:nil afterDelay:1.0];

    
}
//funcao converte a distancia da nota musical para a localizacao da bolinha
-(float) calculaCoordenada: (float) frequencia{
    return 122 + frequencia * 32;
}

@end
