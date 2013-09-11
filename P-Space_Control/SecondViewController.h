//
//  SecondViewController.h
//  P-Space Control
//
//  Created by Spyros Metallinos on 2/8/13.
//  Copyright (c) 2013 Spyros Metallinos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITabBarItem *tabItem;

@property (strong, nonatomic) IBOutlet UIView *SecondTabMainView;

@property (strong, nonatomic) IBOutletCollection(UISwitch) NSArray *onOffLightSwitchesOutletCollection;

@property (strong, nonatomic) IBOutlet UISwitch *lightSwitch1;

@property (strong, nonatomic) IBOutlet UISwitch *lightSwitch2;

@property (strong, nonatomic) IBOutlet UISwitch *lightSwitch3;

@property (strong, nonatomic) IBOutlet UISwitch *lightSwitch4;

- (IBAction)switchTurned:(UISwitch *)sender;

-(void) proxyMethod;

@end
