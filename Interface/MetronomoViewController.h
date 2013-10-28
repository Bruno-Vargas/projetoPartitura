//
//  MetronomoViewController.h
//  teste7notas
//
//  Created by Ivan Augusto Ortiz on 28/10/13.
//  Copyright (c) 2013 BEPiD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MetronomoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lCompasso;
@property (strong, nonatomic) IBOutlet UILabel *lBatimento;

- (IBAction)stCompasso:(id)sender;
- (IBAction)slBatimento:(id)sender;

@end
