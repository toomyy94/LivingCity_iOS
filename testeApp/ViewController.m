//
//  ViewController.m
//  testeApp
//
//  Created by students@deti on 22/04/16.
//  Copyright © 2016 students@deti. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()

@end

@implementation ViewController{

}

@synthesize mapview;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
    
    // see device location -> NSLog(@"%@", [self deviceLocation]); funçtion dowstairs
    
    
    //[self performSelector:@selector(zoomInToMyLocation)
      //        withObject:nil
        //       afterDelay:5]; //zoom in after 3sec
    MKCoordinateRegion region = {{0.0,0.0},{0.0,0.0}};
    region.center.latitude = locationManager.location.coordinate.latitude;
    region.center.longitude = locationManager.location.coordinate.longitude;
    region.span.longitudeDelta = 1.0f;
    region.span.latitudeDelta = 1.0f;
    [mapview setRegion:region animated:YES];
    
    // Place a single pin
    MapPin *ann = [[MapPin alloc] init];
    ann.coordinate=region.center;
    ann.title = @"You are here!";
    ann.subtitle = @"Aveiro";
    [mapview addAnnotation:ann];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)SetMap:(id)sender{

    switch (((UISegmentedControl *) sender).selectedSegmentIndex) {
        case 0:
            mapview.mapType = MKMapTypeStandard;
            break;
        case 1:
            mapview.mapType = MKMapTypeSatellite;
            break;
        case 2:
            mapview.mapType = MKMapTypeHybrid;
            break;
            
        default:
            break;
    }
}


CLLocationManager *locationManager;

- (NSString *)deviceLocation {
    return [NSString stringWithFormat:@"%f %f", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude];
    
}

-(void)zoomInToMyLocation{

    MKCoordinateRegion region = {{0.0,0.0},{0.0,0.0}};
    region.center.latitude = locationManager.location.coordinate.latitude;
    region.center.longitude = locationManager.location.coordinate.longitude;
    region.span.longitudeDelta = 10.0f;
    region.span.latitudeDelta = 10.0f;
    [mapview setRegion:region animated:YES];
}


@end