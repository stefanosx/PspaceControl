//
//  FirstViewController.h
//  P-Space Control
//
//  Created by Spyros Metallinos on 2/8/13.
//  Copyright (c) 2013 Spyros Metallinos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *FirstTabMainView;
@property (strong, nonatomic) IBOutlet UIImageView *statusImage;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadingStatusIndicator;
- (IBAction)infoButtonPressed:(UIButton *)sender;

@end
