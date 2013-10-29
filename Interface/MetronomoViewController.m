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
}

- (IBAction)slBatimento:(id)sender {
    double value = [(UISlider*)sender value];
    [self.lBatimento setText:[NSString stringWithFormat:@"%d", (int)value]];
    
}
- (IBAction)parar:(id)sender {
    
    [self.metronomo pararCompasso];
    NSLog(@"estou na parar");


}

- (IBAction)iniciar:(id)sender {
    NSLog(@"estou em comecar");
    
    self.cad = [self.lBatimento.text integerValue];
    self.com = [self.lCompasso.text integerValue];
    self.metronomo =[[metronomo alloc] initWithTimer: self.com andCadencia: self.cad];
    
    [self.metronomo marcarCompasso];
    
}
@end
