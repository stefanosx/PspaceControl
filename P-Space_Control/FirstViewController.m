//
//  FirstViewController.m
//  P-Space Control
//
//  Created by Spyros Metallinos on 2/8/13.
//  Copyright (c) 2013 Spyros Metallinos. All rights reserved.
//

#import "FirstViewController.h"
#import "ConnectionHandler.h"

@interface FirstViewController ()

@property (nonatomic, strong) ConnectionHandler *pSpaceConnectionHandler;

@end

@implementation FirstViewController

@synthesize FirstTabMainView = _FirstTabMainView;
@synthesize statusImage = _statusImage;
@synthesize pSpaceConnectionHandler = _pSpaceConnectionHandler;
@synthesize loadingStatusIndicator = _loadingStatusIndicator;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.loadingStatusIndicator.hidesWhenStopped = YES;
    [self.loadingStatusIndicator startAnimating];
    self.pSpaceConnectionHandler = [[ConnectionHandler alloc] init];
    [self.pSpaceConnectionHandler getCurrentPSpaceStatus: self.statusImage andStopActivityIndicator: self.loadingStatusIndicator];
    
    
    [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(proxyMethod) userInfo:nil repeats:YES];
    //[self.loadingStatusIndicator stopAnimating];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) proxyMethod
{
    [self.pSpaceConnectionHandler getCurrentPSpaceStatus: self.statusImage andStopActivityIndicator: self.loadingStatusIndicator];
}

- (IBAction)infoButtonPressed:(UIButton *)sender {
    //if(![[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"www.p-space.gr"]])
    //{NSLog(@"Well... Shit");}
}
@end
