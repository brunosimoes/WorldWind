/*
 Copyright (C) 2013 United States Government as represented by the Administrator of the
 National Aeronautics and Space Administration. All Rights Reserved.

 @version $Id: WaypointFileControl.m 1885 2014-03-30 23:03:42Z dcollins $
 */

#import "WaypointFileControl.h"
#import "WaypointDatabase.h"
#import "Waypoint.h"
#import "UITableViewCell+TAIGAAdditions.h"

@implementation WaypointFileControl

//--------------------------------------------------------------------------------------------------------------------//
//-- Initializing WaypointTableViews --//
//--------------------------------------------------------------------------------------------------------------------//

- (WaypointFileControl*) initWithFrame:(CGRect)frame target:(id)target action:(SEL)action
{
    self = [super initWithFrame:frame];

    _target = target;
    _action = action;
    waypoints = [[NSMutableArray alloc] init];

    waypointSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    [waypointSearchBar setPlaceholder:@"Search or enter an ICAO code"];
    [waypointSearchBar setDelegate:self];
    [self addSubview:waypointSearchBar];

    waypointTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 1, 1) style:UITableViewStylePlain];
    [waypointTable setDataSource:self];
    [waypointTable setDelegate:self];
    [waypointTable setAllowsSelectionDuringEditing:YES];
    [waypointTable setEditing:YES];
    [self addSubview:waypointTable];

    // Disable automatic translation of autoresizing mask into constraints. We're using explicit layout constraints
    // below.
    [waypointSearchBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [waypointTable setTranslatesAutoresizingMaskIntoConstraints:NO];

    NSDictionary* viewsDictionary = NSDictionaryOfVariableBindings(waypointSearchBar, waypointTable);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[waypointSearchBar]|"
                                                                 options:0 metrics:nil views:viewsDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[waypointTable]|"
                                                                 options:0 metrics:nil views:viewsDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[waypointSearchBar(44)][waypointTable]|"
                                                                 options:0 metrics:nil views:viewsDictionary]];

    return self;
}

- (void) setWaypointDatabase:(WaypointDatabase*)waypointDatabase
{
    _waypointDatabase = waypointDatabase;

    [self filterWaypoints];
    [waypointTable reloadData];
}

- (void) filterWaypoints
{
    [waypoints removeAllObjects];
    [waypoints addObjectsFromArray:[_waypointDatabase waypoints]];
    [waypoints filterUsingPredicate:[NSPredicate predicateWithFormat:@"type != %d", (int) WaypointTypeMarker]];

    NSString* searchText = [waypointSearchBar text];
    if ([searchText length] > 0)
    {
        NSString* wildSearchText = [NSString stringWithFormat:@"*%@*", searchText];
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"displayName LIKE[cd] %@ ", wildSearchText];
        [waypoints filterUsingPredicate:predicate];
    }

    [waypoints sortUsingComparator:^(id waypointA, id waypointB)
    {
        return [[waypointA displayName] compare:[waypointB displayName]];
    }];

    [waypointTable reloadData];
}

- (void) didSelectWaypointForIndex:(NSUInteger)index
{
    Waypoint* waypoint = [waypoints objectAtIndex:index];
    [self sendActionForWaypoint:waypoint];

    [waypointSearchBar setText:nil]; // clear search field after waypoint selection
    [self filterWaypoints];
}

- (void) sendActionForWaypoint:(Waypoint*)waypoint
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [_target performSelector:_action withObject:waypoint];
#pragma clang diagnostic pop
}

- (void) flashScrollIndicators
{
    [waypointTable flashScrollIndicators];
}

- (BOOL) resignFirstResponder
{
    return [waypointSearchBar resignFirstResponder];
}

//--------------------------------------------------------------------------------------------------------------------//
//-- UISearchBarDelegate --//
//--------------------------------------------------------------------------------------------------------------------//

- (void) searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)searchText
{
    [self filterWaypoints];
}

- (void) searchBarSearchButtonClicked:(UISearchBar*)searchBar
{
    [searchBar resignFirstResponder];
    [self filterWaypoints];
}

//--------------------------------------------------------------------------------------------------------------------//
//-- UITableViewDataSource and UITableViewDelegate --//
//--------------------------------------------------------------------------------------------------------------------//

- (NSInteger) numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [waypoints count];
}

- (UITableViewCell*) tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* cellIdentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    Waypoint* waypoint = [waypoints objectAtIndex:(NSUInteger) [indexPath row]];
    [cell setToWaypoint:waypoint];

    return cell;
}

- (BOOL) tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle) tableView:(UITableView*)tableView editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return UITableViewCellEditingStyleInsert;
}

- (void) tableView:(UITableView*)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
 forRowAtIndexPath:(NSIndexPath*)indexPath
{
    [self didSelectWaypointForIndex:(NSUInteger) [indexPath row]];
}

- (void) tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self didSelectWaypointForIndex:(NSUInteger) [indexPath row]];
}

@end