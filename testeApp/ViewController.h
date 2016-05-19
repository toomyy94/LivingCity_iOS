//
//  ViewController.h
//  testeApp
//
//  Created by students@deti on 22/04/16.
//  Copyright © 2016 students@deti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapPin.h"

@interface ViewController : UIViewController{

    MKMapView *mapview;
}
@property (nonatomic, retain) IBOutlet MKMapView *mapview;

-(IBAction)SetMap:(id)sender;

-(IBAction)GetLocation:(id)sender;

-(IBAction)Direction:(id)sender;

@end

