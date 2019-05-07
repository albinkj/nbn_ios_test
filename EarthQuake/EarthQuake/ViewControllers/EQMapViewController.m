//
//  EQMapViewController.m
//  EarthQuake
//
//  Created by Albin Kallambi Johnson on 07/05/19.
//  Copyright © 2019 Albin Kallambi Johnson. All rights reserved.
//

#import "EQMapViewController.h"

#define EQPROPERTIES @"properties"
#define EQPLACE @"place"
#define EQTYPE @"type"
#define EQGEOMETRY @"geometry"
#define EQCOORDINATE @"coordinates"

@interface EQMapViewController ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *mActivityIndicator;

@end

@implementation EQMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadMap];
    
}

/**
 Load the map with provided location details.
 **/
-(void)loadMap
{
    [_mActivityIndicator setHidden:false];
    [_mActivityIndicator startAnimating];

    _mMapView.delegate = self;
    
    NSString* place = [[_mEQdeatils valueForKey:EQPROPERTIES] valueForKey:EQPLACE];
    NSArray* coordiante = [[_mEQdeatils valueForKey:EQGEOMETRY] valueForKey:EQCOORDINATE];
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    CLLocationCoordinate2D location;
    location.latitude = [[coordiante objectAtIndex:1] doubleValue];
    location.longitude= [[coordiante objectAtIndex:0]doubleValue];
    region.span = span;
    region.center = location;
    [_mMapView setRegion:region animated:YES];
    _mMapView.showsUserLocation=YES;
    
    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = location;
    point.title = place;
    
    [_mMapView addAnnotation:point];
}

#pragma mapViewDelegates

-(void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    [_mActivityIndicator stopAnimating];
    [_mActivityIndicator setHidden:true];
}
- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered
{
     [_mActivityIndicator stopAnimating];
     [_mActivityIndicator setHidden:true];
}

@end
