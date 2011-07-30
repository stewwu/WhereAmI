//
//  WhereAmIViewController.h
//  WhereAmI
//
//  Created by Ching on 2011/7/29.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface WhereAmIViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate> {
  IBOutlet MKMapView *_mapView;
  CLLocationManager *_locationManager;
}

@end
