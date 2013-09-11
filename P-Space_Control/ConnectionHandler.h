//
//  ConnectionHandler.h
//  P-Space Control
//
//  Created by Spyros Metallinos on 2/8/13.
//  Copyright (c) 2013 Spyros Metallinos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ConnectionHandler : NSMutableURLRequest

@property (nonatomic, strong) NSArray *nodesArray;

-(void) getValueForLightInRoom: (NSUInteger) room calledForInitialization: (BOOL) sync_async target: (UISwitch *) targetSwitch;
-(void) setValueForLightInRoom: (NSUInteger) room withValue: (BOOL) lightValue;
-(void) getValueForCurrentAirConditionStatusForInitialization: (BOOL) sync_async onOff: (UISwitch *) onOffSwitch mode: (UISegmentedControl*) modeInterface speed: (UISegmentedControl*) speedInterface stemp: (UILabel *) stempInterface tempStepper: (UIStepper *) stempStepper;
-(void) setValueForAirConditionOnOff: (BOOL) onOff;
-(void) setValueForAirConditionMode: (NSInteger) modeNumber;
-(void) setValueForAirConditionFanSpeed:(NSInteger)speedNumber;
-(void) setValueForAirConditionTemperature: (NSNumber *) stempNumber;

-(void) getCurrentPSpaceStatus: (UIImageView *) statusImage andStopActivityIndicator: (UIActivityIndicatorView*) activityIndicator;

@end
