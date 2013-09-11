//
//  ThirdViewController.h
//  P-Space Control
//
//  Created by Spyros Metallinos on 2/8/13.
//  Copyright (c) 2013 Spyros Metallinos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *ThirdTabMainView;
@property (strong, nonatomic) IBOutlet UISwitch *onOffSwitch;
@property (strong, nonatomic) IBOutlet UISegmentedControl *airConditionModeInterface;
@property (strong, nonatomic) IBOutlet UISegmentedControl *airConditionSpeedInterface;
@property (strong, nonatomic) IBOutlet UIStepper *airConditionTemperatureInterface;
@property (strong, nonatomic) IBOutlet UILabel *temperatureIndicator;

- (IBAction)onOffAirConditionSwitchTurned:(UISwitch *)sender;
- (IBAction)airConditionModeSelected:(UISegmentedControl *)sender;
- (IBAction)airConditionSpeedSelected:(UISegmentedControl *)sender;
- (IBAction)airConditionTempChanged:(UIStepper *)sender;
-(void) proxyMethod;
@end
