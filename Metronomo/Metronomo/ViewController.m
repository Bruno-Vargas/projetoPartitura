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

-(IBAction)comecar:(id)sender {
    CFBundleRef mainBundle = CFBundleGetMainBundle();
    CFURLRef soundFileURLRef;
    soundFileURLRef = CFBundleCopyResourceURL (mainBundle, (CFStringRef) @"Tick-DeepFrozenApps-397275646", CFSTR ("raw"), NULL);
    UInt32 soundID;
    AudioServicesCreateSystemSoundID(soundFileURLRef, &soundID);
    AudioServicesPlaySystemSound(soundID);
    
}
@end
