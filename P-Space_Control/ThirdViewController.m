//
//  ThirdViewController.m
//  P-Space Control
//
//  Created by Spyros Metallinos on 2/8/13.
//  Copyright (c) 2013 Spyros Metallinos. All rights reserved.
//

#import "ThirdViewController.h"
#import "ConnectionHandler.h"

@interface ThirdViewController ()

@property ConnectionHandler *pSpaceConnectionHandler;

@end

@implementation ThirdViewController

@synthesize pSpaceConnectionHandler = _pSpaceConnectionHandler;
@synthesize onOffSwitch = _onOffSwitch;
@synthesize airConditionModeInterface = _airConditionModeInterface;
@synthesize airConditionSpeedInterface = _airConditionSpeedInterface;
@synthesize airConditionTemperatureInterface = _airConditionTemperatureInterface;
@synthesize temperatureIndicator = _temperatureIndicator;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.airConditionTemperatureInterface.minimumValue = 16.00;
    self.airConditionTemperatureInterface.maximumValue = 30.00;
    
    self.pSpaceConnectionHandler = [[ConnectionHandler alloc] init];
    
    [self.pSpaceConnectionHandler getValueForCurrentAirConditionStatusForInitialization: YES onOff: self.onOffSwitch mode: self.airConditionModeInterface speed: self.airConditionSpeedInterface stemp: self.temperatureIndicator tempStepper: self.airConditionTemperatureInterface];
    [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(proxyMethod) userInfo:nil repeats:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)onOffAirConditionSwitchTurned:(UISwitch *)sender {
    
    [self.pSpaceConnectionHandler setValueForAirConditionOnOff:sender.on];
}

- (IBAction)airConditionModeSelected:(UISegmentedControl *)sender {
    
    [self.pSpaceConnectionHandler setValueForAirConditionMode: sender.selectedSegmentIndex];
}

- (IBAction)airConditionSpeedSelected:(UISegmentedControl *)sender {
    
    [self.pSpaceConnectionHandler setValueForAirConditionFanSpeed: sender.selectedSegmentIndex];
}

- (IBAction)airConditionTempChanged:(UIStepper *)sender {
    self.temperatureIndicator.text = [NSString stringWithFormat:@"%d", [[NSNumber numberWithDouble:sender.value] intValue]];
    [self.pSpaceConnectionHandler setValueForAirConditionTemperature: [NSNumber numberWithDouble:sender.value]];
    
}





- (void) proxyMethod
{
    [self.pSpaceConnectionHandler getValueForCurrentAirConditionStatusForInitialization: NO onOff: self.onOffSwitch mode: self.airConditionModeInterface speed: self.airConditionSpeedInterface stemp: self.temperatureIndicator tempStepper: self.airConditionTemperatureInterface];
}

@end







