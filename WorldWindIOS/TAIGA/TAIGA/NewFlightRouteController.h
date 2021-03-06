/*
 Copyright (C) 2013 United States Government as represented by the Administrator of the
 National Aeronautics and Space Administration. All Rights Reserved.

 @version $Id: NewFlightRouteController.h 2002 2014-05-16 17:16:37Z dcollins $
 */

#import <Foundation/Foundation.h>

@interface NewFlightRouteController : UITableViewController
{
@protected
    NSMutableArray* tableCells;
    void (^_completionBlock)(void);
}

@property (nonatomic) NSString* displayName;

@property (nonatomic) NSUInteger colorIndex;

@property (nonatomic) double defaultAltitude;

- (void) setCompletionBlock:(void (^)(void))completionBlock;

@end