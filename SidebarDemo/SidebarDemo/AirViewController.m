//
//  MapViewController.m
//  SidebarDemo
//
//  Created by Simon on 30/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "AirViewController.h"
#import "SWRevealViewController.h"
#import <CoreLocation/CoreLocation.h>


@interface AirViewController ()

@end

@implementation AirViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

@synthesize mapview;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
    
    // see device location -> NSLog(@"%@", [self deviceLocation]); funçtion dowstairs
    

    
    //[self performSelector:@selector(zoomInToMyLocation)
    //        withObject:nil
    //       afterDelay:5]; //zoom in after 3sec
    MKCoordinateRegion region = {{0.0,0.0},{0.0,0.0}};
    //region.center.latitude = locationManager.location.coordinate.latitude;
    //region.center.longitude = locationManager.location.coordinate.longitude;
    region.center.latitude = 40;
    region.center.longitude = -8;
    region.span.longitudeDelta = 0.8f;
    region.span.latitudeDelta = 0.8f;
    [mapview setRegion:region animated:YES];
    
    
    /*
    MapPin *ann = [[MapPin alloc] init];
    ann.coordinate=region.center;
    ann.title = @"You are here!";
    ann.subtitle = @"Aveiro";
    [mapview addAnnotation:ann];
    */
    
    [self initConstraints];
    [self addAllPins];
    
    
    //---------------------------------------------------
    
    
    /* NSURL *url = [[NSURL alloc]initWithString:@"http://www.tixik.com/api/nearby?lat=39.480796165673446&lng=-8.55010986328125&limit=30&key=demo"]; //alterar para variaveis acima delocaliz. real
     NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:url];
     [parser setDelegate:self];
     BOOL result = [parser parse];
     }*/

    
    // Set the gesture
    //[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

}



- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    MKCircleRenderer *circleR = [[MKCircleRenderer alloc] initWithCircle:(MKCircle *)overlay];
    circleR.fillColor = [[UIColor greenColor] colorWithAlphaComponent:0.2];
    
    circleR.strokeColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    circleR.lineWidth = 2;
    
    
    
    
    return circleR;
}



- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //NSString *name = @"name";
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




-(void)addAllPins
{
    self.mapview.delegate=self;
    
    NSArray *name2=[[NSArray alloc]initWithObjects:
                   @"Meco-Perafita",@"Francisco Sá Carneiro-Campanha",@"João Gomes Laranjo-S.Hora",@"Alfragide/Amadora",@"Alverca",@"Anta-Espinho",@"Arcos",@"Aveiro",@"Avenida da Liberdade",@"Avintes",@"Santo Tirso",@"Cascais-Mercado",@"Chamusca",@"Coimbra/Avenida Fernao Magalhaes",@"D.Manuel II-Vermoim",@"Douro Norte",@"Ervedeira",@"Escavadeira",@"Estarreja/Teixugueira",@"Palmela",@"Fornelo do Monte",@"Fr Bartolomeu M·rtires-S.Vitor",@"Francisco S· Carneiro",@"Frossos-Braga",nil];

    
    
    NSMutableArray *arrCoordinateStr2 = [[NSMutableArray alloc] initWithCapacity:name2.count];
    
    [arrCoordinateStr2 addObject:@"41.232, -8.712"];[arrCoordinateStr2 addObject:@"41,164, -8.59"]; [arrCoordinateStr2 addObject:@"41,184, -8.662"]; [arrCoordinateStr2 addObject:@"38.738, -9.208"];[arrCoordinateStr2 addObject:@"38.896, -9.04"];[arrCoordinateStr2 addObject:@"41.006, -8.643"];[arrCoordinateStr2 addObject:@"38.529, -8.894"];[arrCoordinateStr2 addObject:@"40.636, -8.647"];[arrCoordinateStr2 addObject:@"38.719, -9.148"];[arrCoordinateStr2 addObject:@"41.097, -8.556"];[arrCoordinateStr2 addObject:@"41.346, -8.477"];[arrCoordinateStr2 addObject:@"38.7, -9.423"];[arrCoordinateStr2 addObject:@"39.353, -8.468"];[arrCoordinateStr2 addObject:@"40.216, -8.434"];[arrCoordinateStr2 addObject:@"41.237, -8.618"];[arrCoordinateStr2 addObject:@"41.37, -7.789"];[arrCoordinateStr2 addObject:@"39.922, -8.893"];[arrCoordinateStr2 addObject:@"38.661, -9.067"];[arrCoordinateStr2 addObject:@"40.75, -8.583"];[arrCoordinateStr2 addObject:@"38.636, -8.691"];[arrCoordinateStr2 addObject:@"40.64, -8.1"];[arrCoordinateStr2 addObject:@"41.55, -8.406"];[arrCoordinateStr2 addObject:@"41.164, -8.59"];[arrCoordinateStr2 addObject:@"41.566, -8.454"];
    
    for(int i=0;i<name2.count;i++){
        CLLocationDistance fenceDistance = 3000;
        
        arrCoordinateStr2[i] = [arrCoordinateStr2[i] stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        // convert string into actual latitude and longitude values
        NSArray *components = [arrCoordinateStr2[i] componentsSeparatedByString:@","];
        
        double latitude = [components[0] doubleValue];
        double longitude = [components[1] doubleValue];
        
        // setup the map pin with all data and add to map view
        CLLocationCoordinate2D circleMiddlePoint = CLLocationCoordinate2DMake(latitude, longitude);
        MKCircle *circle = [MKCircle circleWithCenterCoordinate:circleMiddlePoint radius:fenceDistance];
        [mapview addOverlay: circle];
    }
    
    for(int i = 0; i < name2.count; i++)
    {
        [self addPinWithTitle:name2[i] AndCoordinate:arrCoordinateStr2[i]];
    }
}



- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    //
    
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //NSLog(@"Did end element");
    
    
}




-(IBAction)Direction:(id)sender{
    NSString *urlString = @"http://maps.apple.com/maps?dadr=8,-4";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    
    
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
