/*
 Copyright (C) 2014 United States Government as represented by the Administrator of the
 National Aeronautics and Space Administration. All Rights Reserved.
 
 @version $Id: GPSController.h 1980 2014-05-03 03:25:46Z tgaskins $
 */

#import <Foundation/Foundation.h>

@interface GPSController : NSObject

- (GPSController*) init;
- (void) dispose;

+ (void) setDefaultGPSDeviceAddress;

@end