//
//  MapViewController.h
//  SidebarDemo
//
//  Created by Simon on 30/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapPin.h"
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController{
    
    MKMapView *mapview;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic, retain) IBOutlet MKMapView *mapview;

-(IBAction)SetMap:(id)sender;

-(IBAction)GetLocation:(id)sender;

-(IBAction)Direction:(id)sender;

@end
