//
//  ViewController.m
//  TesteGithub
//
//  Created by Bruno Vargas Versignassi de Carvalho on 23/10/13.
//  Copyright (c) 2013 Bruno Vargas. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    audioManager = [AudioController sharedAudioManager];
    audioManager.delegate = self;
    autoCorrelator = [[PitchDetector alloc] initWithSampleRate:audioManager.audioFormat.mSampleRate lowBoundFreq:30 hiBoundFreq:4500 andDelegate:self];
    
    medianPitchFollow = [[NSMutableArray alloc] initWithCapacity:22];
    self.aux=0;
    
    self.objAfinador = [[Afinador alloc]init];
    
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
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

  

    
    
    self.lValorFreq.text = [NSString stringWithFormat:@"%4.3f Hz", value];

    
    
    [self.objAfinador calculaAfinacao:self.lValorFreq.text];
    
    
    
    //parar tempo
    if(self.aux==1){
        [self stopTimer];
        
        //verificar diferenca de tempo
        self.mili = [self timeElapsedInSeconds] * 1000.0f;
        printf("tempo %f\n", self.mili);
        
        
        NSLog(@"Nota mais afinada -> %f", [self.objAfinador.notaMaisAfinada doubleValue]);
        
        NSLog(@"Nota Atual -> %@ Nota Anterior -> %@ Nota Proxima -> %@", self.objAfinador.notaAtual, self.objAfinador.notaAnterior, self.objAfinador.notaProxima);
      
    }
    
    //apos a primeria passagem.. starta tempo
    [self startTimer];
    self.aux=1;
    
}

- (void) receivedAudioSamples:(SInt16 *)samples length:(int)len {
    [autoCorrelator addSamples:samples inNumberFrames:len];
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


- (IBAction)start:(id)sender {
    
}
@end
