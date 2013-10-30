//
//  MetronomoViewController.h
//  teste7notas
//
//  Created by Ivan Augusto Ortiz on 28/10/13.
//  Copyright (c) 2013 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "metronomo.h"

@interface MetronomoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lCompasso;
@property (strong, nonatomic) IBOutlet UILabel *lBatimento;
@property (strong, nonatomic) metronomo *metronomo;
@property (weak, nonatomic) IBOutlet UIImageView *numero;
@property (weak, nonatomic) IBOutlet UIButton *bIniciar;


- (IBAction)stCompasso:(id)sender;
- (IBAction)slBatimento:(id)sender;
- (IBAction)parar:(id)sender;
- (IBAction)iniciar:(id)sender;
- (IBAction)bVoltar:(id)sender;

-(NSString *) numNome;
-(void) virarNumero;

@end
