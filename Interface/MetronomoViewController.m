//
//  MetronomoViewController.m
//  teste7notas
//
//  Created by Ivan Augusto Ortiz on 28/10/13.
//  Copyright (c) 2013 BEPiD. All rights reserved.
//

#import "MetronomoViewController.h"

@interface MetronomoViewController ()
@property(strong,nonatomic) IBOutlet UIStepper * stepper;
@property(nonatomic) int cad;
@property(nonatomic) int com;
@end

@implementation MetronomoViewController

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
    self.stepper.minimumValue = 2;
    self.stepper.maximumValue = 12;
    self.stepper.stepValue = 1;
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)stCompasso:(id)sender {
     double value = [(UIStepper*)sender value];
    [self.lCompasso setText:[NSString stringWithFormat:@"%d", (int)value]];
    if (self.metronomo != nil){
        [self parar: sender];
        [self iniciar: sender];
    }
   
    
}
- (IBAction)slBatimento:(id)sender {
    double value = [(UISlider*)sender value];
    [self.lBatimento setText:[NSString stringWithFormat:@"%d", (int)value]];
    if (self.metronomo != nil){
        [self parar: sender];
        [self iniciar: sender];
    }
}
- (IBAction)parar:(id)sender {
    [self.bIniciar setEnabled: YES];
    [self.metronomo pararCompasso];
    self.metronomo = nil;
}

- (IBAction)iniciar:(id)sender {
    [self.bIniciar setEnabled: NO];
    self.cad = [self.lBatimento.text integerValue];
    self.com = [self.lCompasso.text integerValue];
    self.metronomo =[[metronomo alloc] initWithTimer: self.com andCadencia: self.cad andTick:^{
        [self virarNumero];
    }];

    
    [self.metronomo marcarCompasso];
    
}

-(NSString*) numNome{
    switch (self.metronomo.contador){
            
        case 0:
            return @"um";
            break;
        case 1:
            return @"dois";
            break;
        case 2:
            return @"tres";
            break;
        case 3:
            return @"quatro";
            break;
        case 4:
            return @"cinco";
            break;
        case 5:
            return @"seis";
            break;
        case 6:
            return @"sete";
            break;
        case 7:
            return @"oito";
            break;
        case 8:
            NSLog(@"9");
            return @"nove";
            break;
        case 9:
            return @"dez";
            break;
        case 10:
            return @"onze";
            break;
        case 11:
            return @"doze";
            break;
    }
    NSLog(@"nao achei um nome para a imagem");
    return @"erro";
}

-(void)virarNumero{
    [self.numero setImage:[UIImage imageNamed:[self numNome]]];

}

@end
