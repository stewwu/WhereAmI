//
//  WhereAmIViewController.m
//  WhereAmI
//
//  Created by Ching on 2011/7/29.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "WhereAmIViewController.h"

@implementation WhereAmIViewController

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
  [super viewDidLoad];
  
  if ([CLLocationManager locationServicesEnabled]) {
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
  }

}

- (void)viewDidUnload
{
  [super viewDidUnload];
  
  if ([CLLocationManager locationServicesEnabled]) {
    [_locationManager stopUpdatingLocation];
    [_locationManager release];
  }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
  [manager stopUpdatingLocation];
  
  MKPointAnnotation *anno = [[[MKPointAnnotation alloc] init] autorelease];
  anno.title = @"I am here!";
  anno.coordinate = newLocation.coordinate;
  
  [_mapView addAnnotation:anno];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
  [manager stopUpdatingLocation];
}

#pragma mark -
#pragma mark MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
  if ([annotation isKindOfClass:[MKUserLocation class]]) {
    return nil;
  }
  
  static NSString *identifier = @"AnnotationView";
  MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
  if (pinView) {
    pinView.annotation = annotation;
  } else {
    pinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier] autorelease];
    pinView.pinColor = MKPinAnnotationColorRed;
    pinView.animatesDrop = YES;
    pinView.canShowCallout = YES;
  }
  return pinView;
}

@end
