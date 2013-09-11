//
//  ConnectionHandler.m
//  P-Space Control
//
//  Created by Spyros Metallinos on 2/8/13.
//  Copyright (c) 2013 Spyros Metallinos. All rights reserved.
//

#import "ConnectionHandler.h"

@implementation ConnectionHandler

@synthesize nodesArray = _nodesArray;

//lazy instantiation
-(NSArray *) nodesArray
{
    if (!_nodesArray) {
        return[[NSArray alloc] initWithObjects:@"0x0ba", @"0x2eb", @"0x319", @"0x328", nil];
    }
    else
    {return _nodesArray;}
}




-(void) getValueForLightInRoom: (NSUInteger) room calledForInitialization: (BOOL) sync_async target: (UISwitch *) targetSwitch
{
    
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[[NSURL alloc] initWithString:[[@"http://uberdust.cti.gr/rest/testbed/5/node/urn:pspace:" stringByAppendingString:[self.nodesArray objectAtIndex:room]] stringByAppendingString:@"/capability/urn:node:capability:lz1/latestreading"]]];
    
    request.timeoutInterval = 10.0;
    
    
    if(sync_async) //make a SYNCHRONOUS request
    {
        
        NSError *errorIndicator;
        NSURLResponse *response;
        
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error: &errorIndicator];
    
    
        if(errorIndicator)
        {
            //throw alert and navigate back
        }
        else
        {
            NSString *stringResponseData = [[NSString alloc] initWithData:responseData encoding: NSUTF8StringEncoding];
        
        
            if ([stringResponseData characterAtIndex:14] == '1')
            {targetSwitch.on = YES;}
            else
            {targetSwitch.on = NO;}
        }
    }
    else    //make an ASYCHRONOUS request
    {
        
        //NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest: request delegate: connectionDelegate startImmediately:NO];
        //[connection start];
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *responseData, NSError *errorIndicator){
        
            if(!errorIndicator)
            {
                NSString *stringResponseData = [[NSString alloc] initWithData:responseData encoding: NSUTF8StringEncoding];
                
                if ([stringResponseData characterAtIndex:14] == '1')
                {targetSwitch.on = YES;}
                else
                {targetSwitch.on = NO;}
            }
            
        }];
        
    }
}





-(void) setValueForLightInRoom: (NSUInteger) room  withValue: (BOOL) lightValue
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //http://uberdust.cti.gr/rest/testbed/5/node/urn:pspace:0x2eb/capability/urn:node:capability:lz1/1/ 
    
    //NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[[NSURL alloc] initWithString:[[@"http://uberdust.cti.gr/rest/testbed/5/node/urn:pspace:" stringByAppendingString:[self.nodesArray objectAtIndex:room]] stringByAppendingString:@"/capability/urn:node:capability:lz1"]]];
    NSMutableURLRequest *request;
    
    if(lightValue)
    {
        //[request setHTTPBody:[@"1" dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:1]];
        request = [NSMutableURLRequest requestWithURL:[[NSURL alloc] initWithString:[[@"http://uberdust.cti.gr/rest/testbed/5/node/urn:pspace:" stringByAppendingString:[self.nodesArray objectAtIndex:room]] stringByAppendingString:@"/capability/urn:node:capability:lz1/1/"]]];
    }
    else
    {
        //[request setHTTPBody:[@"0" dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:1]];
        request = [NSMutableURLRequest requestWithURL:[[NSURL alloc] initWithString:[[@"http://uberdust.cti.gr/rest/testbed/5/node/urn:pspace:" stringByAppendingString:[self.nodesArray objectAtIndex:room]] stringByAppendingString:@"/capability/urn:node:capability:lz1/0/"]]];
    }
    [request setHTTPMethod:@"POST"];
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *responseData, NSError *errorIndicator){
        
        if(errorIndicator)
        {
            //throw alert about the error
        }
        else if(responseData)
        {
            //throw alert about the error
        }
        
        
    }];
    
}

-(void) getValueForCurrentAirConditionStatusForInitialization: (BOOL) sync_async onOff: (UISwitch *) onOffSwitch mode: (UISegmentedControl*) modeInterface speed: (UISegmentedControl*) speedInterface stemp: (UILabel *) stempInterface tempStepper: (UIStepper *) stempStepper
{
    
    NSMutableURLRequest *onOffRequest = [NSMutableURLRequest requestWithURL:[[NSURL alloc] initWithString: @"http://uberdust.cti.gr/rest/testbed/5/node/urn:pspace:0x466/capability/urn:node:capability:on/latestreading"]];
    NSMutableURLRequest *modeRequest = [NSMutableURLRequest requestWithURL:[[NSURL alloc] initWithString: @"http://uberdust.cti.gr/rest/testbed/5/node/urn:pspace:0x466/capability/urn:node:capability:mode/latestreading"]];
    NSMutableURLRequest *speedRequest = [NSMutableURLRequest requestWithURL:[[NSURL alloc] initWithString: @"http://uberdust.cti.gr/rest/testbed/5/node/urn:pspace:0x466/capability/urn:node:capability:fan/latestreading"]];
    NSMutableURLRequest *stempRequest = [NSMutableURLRequest requestWithURL:[[NSURL alloc] initWithString: @"http://uberdust.cti.gr/rest/testbed/5/node/urn:pspace:0x466/capability/urn:node:capability:stemp/latestreading"]];
    
    
    if(sync_async) //make a SYNCHRONOUS request
    {
        
        NSError *errorIndicator;
        NSURLResponse *response;
        
        //make a request for the on/off value---------------------------------
        NSData *responseData = [NSURLConnection sendSynchronousRequest:onOffRequest returningResponse:&response error: &errorIndicator];
        
        
        if(errorIndicator)
        {
            //throw alert about the error
        }
        else
        {
            NSString *stringOnOffResponseData = [[NSString alloc] initWithData:responseData encoding: NSUTF8StringEncoding];
            
            if ([stringOnOffResponseData characterAtIndex:14] == '1')
            {onOffSwitch.on = YES;}
            else
            {onOffSwitch.on = NO;}
        }
        //--------------------------------------------------------------------
        
        
        //make a request for the mode value-----------------------------------
        responseData = [NSURLConnection sendSynchronousRequest:modeRequest returningResponse:&response error: &errorIndicator];
        
        
        if(errorIndicator)
        {
            //throw alert about the error
        }
        else
        {
            NSString *stringModeResponseData = [[NSString alloc] initWithData:responseData encoding: NSUTF8StringEncoding];
            
            if ([stringModeResponseData characterAtIndex:14] == '0')
            {modeInterface.selectedSegmentIndex = 0;}
            else if ([stringModeResponseData characterAtIndex:14] == '1')
            {modeInterface.selectedSegmentIndex = 1;}
            else if ([stringModeResponseData characterAtIndex:14] == '2')
            {modeInterface.selectedSegmentIndex = 2;}
            else if ([stringModeResponseData characterAtIndex:14] == '3')
            {modeInterface.selectedSegmentIndex = 3;}
        }
        //--------------------------------------------------------------------
        
        
        
        //make a request for the speed value----------------------------------
        responseData = [NSURLConnection sendSynchronousRequest:speedRequest returningResponse:&response error: &errorIndicator];
        
        
        if(errorIndicator)
        {
            //throw alert about the error
        }
        else
        {
            NSString *stringSpeedResponseData = [[NSString alloc] initWithData:responseData encoding: NSUTF8StringEncoding];
            
            if ([stringSpeedResponseData characterAtIndex:14] == '0')
            {speedInterface.selectedSegmentIndex = 0;}
            else if ([stringSpeedResponseData characterAtIndex:14] == '1')
            {speedInterface.selectedSegmentIndex = 1;}
            else if ([stringSpeedResponseData characterAtIndex:14] == '2')
            {speedInterface.selectedSegmentIndex = 2;}
            else if ([stringSpeedResponseData characterAtIndex:14] == '3')
            {speedInterface.selectedSegmentIndex = 3;}
        }
        //--------------------------------------------------------------------
        
        
        //make a request for the stemp value----------------------------------
        responseData = [NSURLConnection sendSynchronousRequest:stempRequest returningResponse:&response error: &errorIndicator];
        
        
        if(errorIndicator)
        {
            //throw alert about the error
        }
        else
        {
            NSString *stringStempResponseData = [[NSString alloc] initWithData:responseData encoding: NSUTF8StringEncoding];
            
            UniChar tempChars[2] = {[stringStempResponseData characterAtIndex:14], [stringStempResponseData characterAtIndex:15]};
            
            stempInterface.text = [[NSString alloc] initWithCharacters:tempChars length:2];
            stempStepper.value = [stempInterface.text doubleValue];
        }
        //--------------------------------------------------------------------
        
        
        
        
    }
    else
    {
      
        //make a request for the on/off value---------------------------------
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [NSURLConnection sendAsynchronousRequest:onOffRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *responseData, NSError *errorIndicator){
            
            if(!errorIndicator)
            {
                NSString *stringOnOffResponseData = [[NSString alloc] initWithData:responseData encoding: NSUTF8StringEncoding];
                
                if ([stringOnOffResponseData characterAtIndex:14] == '1')
                {onOffSwitch.on = YES;}
                else
                {onOffSwitch.on = NO;}
            }
            
        }];
        //--------------------------------------------------------------------
        
        
        //make a request for the mode value-----------------------------------
        [NSURLConnection sendAsynchronousRequest:modeRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *responseData, NSError *errorIndicator){
            
            if(!errorIndicator)
            {
                NSString *stringModeResponseData = [[NSString alloc] initWithData:responseData encoding: NSUTF8StringEncoding];
                
                if ([stringModeResponseData characterAtIndex:14] == '0')
                {modeInterface.selectedSegmentIndex = 0;}
                else if ([stringModeResponseData characterAtIndex:14] == '1')
                {modeInterface.selectedSegmentIndex = 1;}
                else if ([stringModeResponseData characterAtIndex:14] == '2')
                {modeInterface.selectedSegmentIndex = 2;}
                else if ([stringModeResponseData characterAtIndex:14] == '3')
                {modeInterface.selectedSegmentIndex = 3;}
            }
            
        }];
        //--------------------------------------------------------------------
        
        
        //make a request for the speed value----------------------------------
        [NSURLConnection sendAsynchronousRequest:speedRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *responseData, NSError *errorIndicator){
            
            if(!errorIndicator)
            {
                NSString *stringSpeedResponseData = [[NSString alloc] initWithData:responseData encoding: NSUTF8StringEncoding];
                
                if ([stringSpeedResponseData characterAtIndex:14] == '0')
                {speedInterface.selectedSegmentIndex = 0;}
                else if ([stringSpeedResponseData characterAtIndex:14] == '1')
                {speedInterface.selectedSegmentIndex = 1;}
                else if ([stringSpeedResponseData characterAtIndex:14] == '2')
                {speedInterface.selectedSegmentIndex = 2;}
                else if ([stringSpeedResponseData characterAtIndex:14] == '3')
                {speedInterface.selectedSegmentIndex = 3;}            }
            
        }];
        //--------------------------------------------------------------------
        
        //make a request for the stemp value----------------------------------
        [NSURLConnection sendAsynchronousRequest:stempRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *responseData, NSError *errorIndicator){
            
            if(!errorIndicator)
            {
                NSString *stringStempResponseData = [[NSString alloc] initWithData:responseData encoding: NSUTF8StringEncoding];
                
                UniChar tempChars[2] = {[stringStempResponseData characterAtIndex:14], [stringStempResponseData characterAtIndex:15]};
                
                stempInterface.text = [[NSString alloc] initWithCharacters:tempChars length:2];
                stempStepper.value = [stempInterface.text doubleValue];
                
            }
            
        }];
        //--------------------------------------------------------------------
        
        
    }
}







-(void) setValueForAirConditionOnOff: (BOOL) airConditionOnOffValue
{
     NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    NSMutableURLRequest *request;
    
    if(airConditionOnOffValue)
    {request = [NSMutableURLRequest requestWithURL:[[NSURL alloc] initWithString: @"http://uberdust.cti.gr/rest/testbed/5/node/urn:pspace:0x466/capability/urn:node:capability:on/1/"]];}
    else
    {request = [NSMutableURLRequest requestWithURL:[[NSURL alloc] initWithString: @"http://uberdust.cti.gr/rest/testbed/5/node/urn:pspace:0x466/capability/urn:node:capability:on/0/"]];}

    
    [request setHTTPMethod:@"POST"];
    
    /*NSString *onOffString = [[NSString alloc] init];
    
        
    [request setHTTPBody:[onOffString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:1]];*/
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler: ^(NSURLResponse *response, NSData *responseData, NSError *errorIndicator){
        
        if(errorIndicator)
        {
            //throw alert about the error
        }
        else if(!responseData)
        {
            //throw alert about the error
        }
        
        
    }];
    
    
}



-(void) setValueForAirConditionMode:(NSInteger)modeNumber
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSMutableURLRequest *request;
    
    request = [NSMutableURLRequest requestWithURL:[[NSURL alloc] initWithString: [[@"http://uberdust.cti.gr/rest/testbed/5/node/urn:pspace:0x466/capability/urn:node:capability:mode/" stringByAppendingString: [NSString stringWithFormat: @"%d", (int)modeNumber]] stringByAppendingString:@"/"]]];
    
    
    [request setHTTPMethod:@"POST"];
        
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler: ^(NSURLResponse *response, NSData *responseData, NSError *errorIndicator){
        
        if(errorIndicator)
        {
            //throw alert about the error
        }
        else if(!responseData)
        {
            //throw alert about the error
        }
        
        
    }];
    
 
}


-(void) setValueForAirConditionFanSpeed:(NSInteger)speedNumber
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSMutableURLRequest *request;
    
    request = [NSMutableURLRequest requestWithURL:[[NSURL alloc] initWithString: [[@"http://uberdust.cti.gr/rest/testbed/5/node/urn:pspace:0x466/capability/urn:node:capability:fan/" stringByAppendingString: [NSString stringWithFormat: @"%d", (int)speedNumber]] stringByAppendingString:@"/"]]];
    
    
    [request setHTTPMethod:@"POST"];
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler: ^(NSURLResponse *response, NSData *responseData, NSError *errorIndicator){
        
        if(errorIndicator)
        {
            //throw alert about the error
        }
        else if(!responseData)
        {
            //throw alert about the error
        }
        
        
    }];
    
    
}


-(void) setValueForAirConditionTemperature:(NSNumber *)stempNumber
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSMutableURLRequest *request;
    
    request = [NSMutableURLRequest requestWithURL:[[NSURL alloc] initWithString: [[@"http://uberdust.cti.gr/rest/testbed/5/node/urn:pspace:0x466/capability/urn:node:capability:stemp/" stringByAppendingString: [NSString stringWithFormat: @"%d", [stempNumber intValue]]] stringByAppendingString:@"/"]]];
    
    
    [request setHTTPMethod:@"POST"];
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler: ^(NSURLResponse *response, NSData *responseData, NSError *errorIndicator){
        
        if(errorIndicator)
        {
            //throw alert about the error
        }
        else if(!responseData)
        {
            //throw alert about the error
        }
        
        
    }];

}


-(void) getCurrentPSpaceStatus: (UIImageView *) statusImage andStopActivityIndicator: (UIActivityIndicatorView*) activityIndicator
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[[NSURL alloc] initWithString: @"http://www.p-space.gr/statustest/"]];
    
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *responseData, NSError *errorIndicator){
        
        if(!errorIndicator)
        {
            NSString *stringResponseData = [[NSString alloc] initWithData:responseData encoding: NSUTF8StringEncoding];
            
            if ([stringResponseData characterAtIndex:0] == '1')
            {[statusImage setImage:[UIImage imageNamed: @"open.jpg"]];}
            else
            {[statusImage setImage:[UIImage imageNamed: @"closed.jpg"]];}
            [activityIndicator stopAnimating];
            //activityIndicator.hidden = YES;
        }
        
    }];

    [statusImage sizeToFit];
}


@end




