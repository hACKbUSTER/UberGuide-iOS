//
//  LocationManager.m
//  UBERGuide
//
//  Created by 叔 陈 on 16/1/16.
//  Copyright © 2016年 hACKbUSTER. All rights reserved.
//

#import "LocationManager.h"
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>


@interface LocationManager() <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (strong, nonatomic) CLGeocoder *geoCoder;

@end

@implementation LocationManager

static NSString *currentLocation = @"currentLocation";
static NSString *currentLocationLatitude = @"currentLocationLatitude";
static NSString *currentLocationLongitude = @"currentLocationLongitude";
static NSString *currentLocationHorizontalAccuracy = @"currentLocationHorizontalAccuracy";
static NSString *currentLocationAltitude = @"currentLocationAltitude";
static NSString *currentLocationVerticalAccuracy = @"currentLocationVerticalAccuracy";

+ (LocationManager *) sharedInstance
{
    static dispatch_once_t  onceToken;
    static LocationManager * sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LocationManager alloc] init];
    });
    return sharedInstance;
    
}

- (id)init
{
    self = [super init];
    return self;
}

- (void)startCapture
{
    if(self)
    {
        self.dict = [NSDictionary dictionary];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        {
            //NSLog(@"[[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0");
            [_locationManager requestAlwaysAuthorization];
            _locationManager.allowsBackgroundLocationUpdates = YES;
        }
        
        if ([CLLocationManager locationServicesEnabled]) {
            //NSLog(@"[CLLocationManager locationServicesEnabled]");
            self.locationManager = [[CLLocationManager alloc] init];//创建位置管理器
            _locationManager.delegate=self;
            _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
            _locationManager.distanceFilter=1000.0f;
            [_locationManager startUpdatingLocation];
            
        }
    }
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"didUpdateLocations:(NSArray *)locations");
    CLLocation* newLocation = [locations lastObject];
    NSString *currentLatitude=[[NSString alloc]initWithFormat:@"%g",newLocation.coordinate.latitude];
    NSString *currentLongitude=[[NSString alloc]initWithFormat:@"%g",newLocation.coordinate.longitude];
    NSString *currentHorizontalAccuracy = [[NSString alloc]initWithFormat:@"%g",newLocation.horizontalAccuracy];
    NSString *currentAltitude = [[NSString alloc]initWithFormat:@"%g",newLocation.altitude];
    NSString *currentVerticalAccuracy =[[NSString alloc]initWithFormat:@"%g",newLocation.verticalAccuracy];

    
    self.dict = [NSDictionary dictionaryWithObjects:@[currentLatitude,currentLongitude,currentHorizontalAccuracy,currentAltitude,currentVerticalAccuracy] forKeys:@[currentLocationLatitude,currentLocationLongitude,currentLocationHorizontalAccuracy,currentLocationAltitude,currentLocationVerticalAccuracy]];
    

    _geoCoder = [[CLGeocoder alloc] init];
    [_geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!error)
         {
             CLPlacemark *placemark = placemarks[0];
             NSLog(@"Found %@", placemark.administrativeArea);
             //_currentLocationName = placemark.administrativeArea;
         }
         
     }];

}


@end
