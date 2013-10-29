//
//  ViewController.h
//  Metronomo
//
//  Created by Bruno Vargas Versignassi de Carvalho on 25/10/13.
//  Copyright (c) 2013 Bruno Vargas. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "metronomo.h"

@interface ViewController : UIViewController{
    AVAudioPlayer *audioPlayer;
}
@property (weak, nonatomic) IBOutlet UITextField *numCadencia;
@property (weak, nonatomic) IBOutlet UITextField *numCompasso;
@property (nonatomic, strong) metronomo * metronomo;
@property (weak, nonatomic) IBOutlet UIImageView *numero;

-(IBAction)comecar:(id)sender;
-(IBAction)parar:(id)sender;

-(NSString *)numNome;
-(void) virarNumero;

@end
