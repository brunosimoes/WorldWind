/*
 Copyright (C) 2014 United States Government as represented by the Administrator of the
 National Aeronautics and Space Administration. All Rights Reserved.
 
 @version $Id: GPSController.h 2160 2014-07-22 03:32:11Z tgaskins $
 */

#import <Foundation/Foundation.h>

@interface GPSController : NSObject

+ (void) setDefaultGPSDeviceAddress;

- (GPSController*) init;

- (void) dispose;

- (void) setUpdateFrequency:(int)updateFrequency;

- (int) getUpdateFrequency;

@end