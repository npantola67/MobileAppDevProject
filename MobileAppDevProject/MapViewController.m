//
//  MapViewController.m
//  MobileAppDevProject
//
//  Created by Nicholas Pantola on 5/27/13.
//  Copyright (c) 2013 Pantola. All rights reserved.
//

#import "MapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#define METERS_PER_MILE 5000

@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Map", @"Map");
        //self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 41.85000;
    zoomLocation.longitude= -87.65000;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, METERS_PER_MILE, METERS_PER_MILE);
    
    [_mapView setRegion:viewRegion animated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
