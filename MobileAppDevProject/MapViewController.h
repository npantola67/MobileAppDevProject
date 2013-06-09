//
//  MapViewController.h
//  MobileAppDevProject
//
//  Created by Nicholas Pantola on 5/27/13.
//  Copyright (c) 2013 Pantola. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end
