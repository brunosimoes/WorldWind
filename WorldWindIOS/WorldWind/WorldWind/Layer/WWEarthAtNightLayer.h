/*
 Copyright (C) 2013 United States Government as represented by the Administrator of the
 National Aeronautics and Space Administration. All Rights Reserved.
 
 @version $Id: WWEarthAtNightLayer.h 1381 2013-05-31 00:06:14Z tgaskins $
 */

#import <Foundation/Foundation.h>
#import "WorldWind/Layer/WWTiledImageLayer.h"

/**
* Provides an image of Earth at night.
*/
@interface WWEarthAtNightLayer : WWTiledImageLayer

/// @name Initializing the Earth at Night Layer

/**
* Initializes an Earth at Night layer.
*
* @return The initialized layer.
*/
- (WWEarthAtNightLayer*) init;

@end