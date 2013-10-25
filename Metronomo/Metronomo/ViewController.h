//
//  ViewController.h
//  Metronomo
//
//  Created by Bruno Vargas Versignassi de Carvalho on 25/10/13.
//  Copyright (c) 2013 Bruno Vargas. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <AudioToolBox/AudioToolbox.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UITextField *textoFrequencia;

-(IBAction)comecar:(id)sender;
@end
