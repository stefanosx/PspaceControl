//
//  SecondViewController.m
//  P-Space Control
//
//  Created by Spyros Metallinos on 2/8/13.
//  Copyright (c) 2013 Spyros Metallinos. All rights reserved.
//

#import "SecondViewController.h"
#import "ConnectionHandler.h"

@interface SecondViewController ()

@property (nonatomic, strong) ConnectionHandler *pSpaceConnectionHandler;

@end

@implementation SecondViewController

@synthesize tabItem = _tabItem;
@synthesize SecondTabMainView = _SecondTabMainView;
@synthesize onOffLightSwitchesOutletCollection = _onOffLightSwitchesOutletCollection;
@synthesize pSpaceConnectionHandler = _pSpaceConnectionHandler;
@synthesize lightSwitch1 = _lightSwitch1;
@synthesize lightSwitch2 = _lightSwitch2;
@synthesize lightSwitch3 = _lightSwitch3;
@synthesize lightSwitch4 = _lightSwitch4;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //[self.tabItem initWithTitle:@"Φωτισμός" image: tag:2];
    
    
    
    self.lightSwitch1.tag = 100;
    self.lightSwitch2.tag = 101;
    self.lightSwitch3.tag = 102;
    self.lightSwitch4.tag = 103;
    
    self.pSpaceConnectionHandler = [[ConnectionHandler alloc] init];
    
    
    
    [self.pSpaceConnectionHandler getValueForLightInRoom: 0 calledForInitialization: YES target: self.lightSwitch1];
    [self.pSpaceConnectionHandler getValueForLightInRoom: 1 calledForInitialization: YES target: self.lightSwitch2];
    [self.pSpaceConnectionHandler getValueForLightInRoom: 2 calledForInitialization: YES target: self.lightSwitch3];
    [self.pSpaceConnectionHandler getValueForLightInRoom: 3 calledForInitialization: YES target: self.lightSwitch4];
    
    [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(proxyMethod) userInfo:nil repeats:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)switchTurned:(UISwitch *)sender {
    [self.pSpaceConnectionHandler setValueForLightInRoom:sender.tag - 100 withValue: sender.on];
    NSLog(@"status %d", sender.on);
    [self.pSpaceConnectionHandler getValueForLightInRoom:sender.tag - 100 calledForInitialization:NO target:sender];
}

-(void) proxyMethod
{
    [self.pSpaceConnectionHandler getValueForLightInRoom: 0 calledForInitialization: NO target: self.lightSwitch1];
    [self.pSpaceConnectionHandler getValueForLightInRoom: 1 calledForInitialization: NO target: self.lightSwitch2];
    [self.pSpaceConnectionHandler getValueForLightInRoom: 2 calledForInitialization: NO target: self.lightSwitch3];
    [self.pSpaceConnectionHandler getValueForLightInRoom: 3 calledForInitialization: NO target: self.lightSwitch4];
}


@end





