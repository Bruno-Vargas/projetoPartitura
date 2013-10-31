//
//  ViewController.m
//  Metronomo
//
//  Created by Bruno Vargas Versignassi de Carvalho on 25/10/13.
//  Copyright (c) 2013 Bruno Vargas. All rights reserved.
//

#import "ViewController.h"
#define DEGREES_TO_RADIANS(angle) (angle / 180.0 * M_PI)

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
    self.metronomo =[[metronomo alloc] initWithTimer: self.com andCadencia: self.cad andTick:^{
        //[self virarNumero];
        //[self myAnimate]; //guga
        /*self.lanca.frame = CGRectMake(0, 0, 0, 0);
        [self.view addSubview:self.lanca];
        [self rotateImage:self.lanca duration: 60/self.cad
                        curve:UIViewAnimationCurveEaseIn degrees:self.metronomo.contador * 20]; //aqui colocar a distancia a ser percorrida
        */  //tutorial, quase funfa, mas perco o centro da imagem!
        
        CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.fromValue = [NSNumber numberWithFloat:0.0f];
        animation.toValue = [NSNumber numberWithFloat: 0.9];
        animation.duration = 60/self.cad;
        animation.repeatCount = 0;
        [self.lanca.layer addAnimation:animation forKey:@"SpinAnimation"];
        
    }];
    
    [self.metronomo marcarCompasso];
    
}

-(IBAction)parar:(id)parar;{
    [self.metronomo pararCompasso];
    NSLog(@"estou na parar");
    
}
-(void) configuraImagem{
    
    self.lanca.layer.anchorPoint = CGPointMake(0, 1);

}

-(void) myAnimate{
   // [self configuraImagem];
    NSLog(@"estou na animate");
    CABasicAnimation *apontar = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    
    
    [apontar setDelegate:self];
    [apontar setToValue: [NSNumber numberWithFloat:M_PI/2]]; // o quanto ele vai rodar (fazer funcao para calcular)
    [apontar setDuration: 60/self.cad];
    [UIView setAnimationBeginsFromCurrentState:YES];
    CAMediaTimingFunction *tf = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]; //muda o tempo de rotacao
    
    [apontar setTimingFunction: tf];
    
    //aqui devo ligar para a view que vou animar
    [[self.lanca layer] addAnimation:apontar forKey: @"apontarPara"];
   
    CGAffineTransform transform =
    CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(M_PI/2)); //ficar atento com o a rotacao
    self.lanca.transform = transform;
    
    // Commit the changes
    [UIView commitAnimations];

}



- (void)rotateImage:(UIImageView *)image duration:(NSTimeInterval)duration
              curve:(int)curve degrees:(CGFloat)degrees
{
    // Setup the animation
    //image.layer.anchorPoint = CGPointMake(0, 1);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    // The transform matrix
    CGAffineTransform transform =
    CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(degrees));
    image.transform = transform;
    
    // Commit the changes
    [UIView commitAnimations];
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
