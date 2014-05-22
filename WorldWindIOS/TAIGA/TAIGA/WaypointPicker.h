/*
 Copyright (C) 2013 United States Government as represented by the Administrator of the
 National Aeronautics and Space Administration. All Rights Reserved.

 @version $Id: WaypointPicker.h 2008 2014-05-16 22:18:40Z dcollins $
 */

#import <Foundation/Foundation.h>

@interface WaypointPicker : UIView<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>
{
@protected
    NSMutableArray* filteredWaypoints;
    UISearchBar* waypointSearchBar;
    UITableView* waypointTable;
}

@property (nonatomic, readonly, weak) id target;

@property (nonatomic, readonly) SEL action;

@property (nonatomic) NSArray* waypoints;

- (id) initWithFrame:(CGRect)frame target:(id)target action:(SEL)action;

- (void) flashScrollIndicators;

@end