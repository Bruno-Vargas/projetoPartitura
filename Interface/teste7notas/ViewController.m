//
//  ViewController.m
//  teste7notas
//
//  Created by Ivan Augusto Ortiz on 24/10/13.
//  Copyright (c) 2013 BEPiD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic) int teste;
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

- (IBAction)bIniciar:(id)sender {
    self.teste = 1;
    switch (_teste) {
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        default:
            break;
    }


}

-(void)colorirComVerde:(float)verde eAzul:(float)azul eVermelho:(float)vermelho {
    self.lProxNota.backgroundColor = [UIColor colorWithRed: vermelho green: verde blue: azul alpha:0.0];
    self.lNota.backgroundColor = [UIColor colorWithRed: 231/255 green: 0/255 blue: 141/255 alpha:0.0];
    self.lAntNota.backgroundColor = [UIColor colorWithRed: 231/255 green: 0/255 blue: 141/255 alpha:0.0];
}

- (IBAction)bParar:(id)sender {
    
}
@end
