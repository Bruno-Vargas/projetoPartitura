//
//  ViewController.h
//  TesteGithub
//
//  Created by Bruno Vargas Versignassi de Carvalho on 23/10/13.
//  Copyright (c) 2013 Bruno Vargas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *proxNota;
@property (strong, nonatomic) IBOutlet UIImageView *nota;
@property (strong, nonatomic) IBOutlet UIImageView *antNota;

- (IBAction)start:(id)sender;
@end
