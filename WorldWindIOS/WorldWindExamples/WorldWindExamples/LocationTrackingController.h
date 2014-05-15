/*
 Copyright (C) 2013 United States Government as represented by the Administrator of the
 National Aeronautics and Space Administration. All Rights Reserved.

@version $Id: LocationTrackingController.h 1791 2014-01-02 22:50:26Z dcollins $
 */

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class WWPosition;
@class WorldWindView;

@interface LocationTrackingController : NSObject
{
@protected
    CLLocation* currentLocation;
    WWPosition* forecastPosition;
    WWPosition* smoothedPosition;
    BOOL followingPosition;
}

@property (nonatomic, readonly) WorldWindView* wwv;

@property (nonatomic) BOOL enabled;

- (LocationTrackingController*) initWithView:(WorldWindView*)wwv;

@end