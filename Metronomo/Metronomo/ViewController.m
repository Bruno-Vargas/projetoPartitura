//
//  ViewController.m
//  Metronomo
//
//  Created by Bruno Vargas Versignassi de Carvalho on 25/10/13.
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) tecFunction{
    NSURL *url = [NSURL fileURLWithPath: [NSString stringWithFormat: @"%@/tick.mp3", [[NSBundle mainBundle] resourcePath]]];
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: url error:&error];
    audioPlayer.numberOfLoops = 0;
    
    [audioPlayer play];

}
-(IBAction)comecar:(id)sender {
    [self tecFunction];
    
    NSTimer
    
}
@end
