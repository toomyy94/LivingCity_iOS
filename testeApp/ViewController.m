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
    
    [self initConstraints];
    [self addAllPins];
    //---------------------------------------------------

    
    NSURL *url = [[NSURL alloc]initWithString:@"http://www.tixik.com/api/nearby?lat=39.480796165673446&lng=-8.55010986328125&limit=30&key=demo"]; //alterar para variaveis acima delocaliz. real
    NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:url];
    [parser setDelegate:self];
    BOOL result = [parser parse];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addAllPins
{
    self.mapview.delegate=self;
    
    NSArray *name=[[NSArray alloc]initWithObjects:
                   @"VelaCherry",
                   @"Perungudi",
                   @"Tharamani", nil];
    
    NSMutableArray *arrCoordinateStr = [[NSMutableArray alloc] initWithCapacity:name.count];
    
    [arrCoordinateStr addObject:@"37.970760345459, -122.2190093994141"];
    [arrCoordinateStr addObject:@"-8.9752297537231, 39.2313079833984"];
    [arrCoordinateStr addObject:@"12.9788103103638, 80.2412414550781"];
    
    for(int i = 0; i < name.count; i++)
    {
        [self addPinWithTitle:name[i] AndCoordinate:arrCoordinateStr[i]];
    }
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

-(IBAction):GetLocation:(id)sender{
    mapview.showsUserLocation = YES;
}

-(IBAction)Direction:(id)sender{
    NSString *urlString = @"http://maps.apple.com/maps?dadr=8,-4";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    
    
}

-(void)zoomInToMyLocation{

    MKCoordinateRegion region = {{0.0,0.0},{0.0,0.0}};
    region.center.latitude = locationManager.location.coordinate.latitude;
    region.center.longitude = locationManager.location.coordinate.longitude;
    region.span.longitudeDelta = 20.0f;
    region.span.latitudeDelta = 20.0f;
    [mapview setRegion:region animated:YES];
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    //
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //NSLog(@"Did end element");
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSString *name = @"name";
    NSString *lenght = [NSString stringWithFormat:@"%02d",[string length]];
    NSMutableArray *arrayNomes = [[NSMutableArray alloc] init];// alloc here
    // Print here
    NSMutableArray *arrayCoordenadas = [[NSMutableArray alloc] init];// alloc here
    NSMutableArray *arrayCoordenadasFinais = [[NSMutableArray alloc] init];// alloc here
    // Print here
    
    NSCharacterSet * set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789.\n\t\t\t_-()/[]{}"];
    
    NSInteger i = 0;
    if (string.length > 2 && [string rangeOfCharacterFromSet:set].location == NSNotFound
        &&  ![string rangeOfCharacterFromSet:set].location != NSNotFound && ![string containsString:@"http"])
    {
        
        arrayNomes = [arrayNomes arrayByAddingObject: string];
        
    }

    if ([lenght isEqualToString:@"13"])
    {
        if ([string containsString:@"."])
        {
            
            arrayCoordenadas = [arrayCoordenadas arrayByAddingObject: string];
            NSLog(@"'%@'",arrayCoordenadas);
            NSLog(@"ola");
            /*for(int i = 0; i < arrayCoordenadas.count; i+2)
            {
                NSString *rest = [NSString stringWithFormat: @"%@, %@", arrayCoordenadas[i], arrayCoordenadas[i+1]];
                NSLog(@"'%@'",rest);
                NSLog(@"'%@'",arrayCoordenadas);
                
                arrayCoordenadasFinais = [arrayCoordenadasFinais arrayByAddingObject: rest];
            }
            [self addPinWithTitle:arrayNomes[0] AndCoordinate:arrayCoordenadasFinais[0]];
            
            //NSLog(@"'%@'",arrayCoordenadasFinais);*/
            [self addPinWithTitle:@"cenas" AndCoordinate:@"-37.776, -122.4192"];
        }
    }
    
}


-(void)initConstraints
{
    self.mapview.translatesAutoresizingMaskIntoConstraints = NO;
    
    id views = @{
                 @"mapview": self.mapview
                 };
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[mapview]|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mapview]|" options:0 metrics:nil views:views]];
}


-(void)addPinWithTitle:(NSString *)title AndCoordinate:(NSString *)strCoordinate
{
    MKPointAnnotation *mapPin = [[MKPointAnnotation alloc] init];
    
    // clear out any white space
    strCoordinate = [strCoordinate stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    // convert string into actual latitude and longitude values
    NSArray *components = [strCoordinate componentsSeparatedByString:@","];
    
    double latitude = [components[0] doubleValue];
    double longitude = [components[1] doubleValue];
    
    // setup the map pin with all data and add to map view
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    
    mapPin.title = title;
    mapPin.coordinate = coordinate;
    
    [self.mapview addAnnotation:mapPin];
}


@end