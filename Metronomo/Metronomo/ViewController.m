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
    self.metronomo =[[metronomo alloc] initWithTimer: self.com andCadencia: self.cad];
    
    [self.metronomo marcarCompasso];
    
}

-(IBAction)parar:(id)parar;{
    [self.metronomo pararCompasso];
    NSLog(@"estou na parar");
}


@end
