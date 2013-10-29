//
//  ViewController.h
//  teste7notas
//
//  Created by Ivan Augusto Ortiz on 24/10/13.
//  Copyright (c) 2013 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lProxNota;
@property (strong, nonatomic) IBOutlet UILabel *lNota;
@property (strong, nonatomic) IBOutlet UILabel *lAntNota;

- (IBAction)bIniciar:(id)sender;

- (IBAction)bParar:(id)sender;
@end

