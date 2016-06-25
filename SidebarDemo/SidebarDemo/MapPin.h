//
//  MapPin.h
//  testeApp
//
//  Created by students@deti on 15/05/16.
//  Copyright © 2016 students@deti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapPin : NSObject<MKAnnotation>{
    NSString *title;
    NSString *subtitle;
    CLLocationCoordinate2D coordinate;
}

@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *subtitle;
@property(nonatomic, assign)CLLocationCoordinate2D coordinate;


@end
