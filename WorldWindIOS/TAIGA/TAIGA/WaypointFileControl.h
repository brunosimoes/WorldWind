/*
 Copyright (C) 2013 United States Government as represented by the Administrator of the
 National Aeronautics and Space Administration. All Rights Reserved.

 @version $Id: WaypointFileControl.h 1885 2014-03-30 23:03:42Z dcollins $
 */

#import <Foundation/Foundation.h>

@class WaypointDatabase;

@interface WaypointFileControl : UIView<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>
{
@protected
    NSMutableArray* waypoints;
    UISearchBar* waypointSearchBar;
    UITableView* waypointTable;
}

@property (nonatomic, readonly, weak) id target;

@property (nonatomic, readonly) SEL action;

@property (nonatomic) WaypointDatabase* waypointDatabase;

- (WaypointFileControl*) initWithFrame:(CGRect)frame target:(id)target action:(SEL)action;

- (void) flashScrollIndicators;

@end