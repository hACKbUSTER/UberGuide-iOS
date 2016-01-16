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
    if(self)
    {
        self.dict = [NSDictionary dictionary];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        {
            [_locationManager requestWhenInUseAuthorization];
        }
    
        if ([CLLocationManager locationServicesEnabled]) {
            self.locationManager = [[CLLocationManager alloc] init];//创建位置管理器
            _locationManager.delegate=self;
            _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
            _locationManager.distanceFilter=1000.0f;
            [_locationManager startUpdatingLocation];
        }
    }
    return self;
}

-(void)locationManager:(CLLocationManager *)manager
   didUpdateToLocation:(CLLocation *)newLocation
          fromLocation:(CLLocation *)oldLocation
{
    NSString *currentLatitude=[[NSString alloc]initWithFormat:@"%g",newLocation.coordinate.latitude];
    NSString *currentLongitude=[[NSString alloc]initWithFormat:@"%g",newLocation.coordinate.longitude];
    NSString *currentHorizontalAccuracy = [[NSString alloc]initWithFormat:@"%g",newLocation.horizontalAccuracy];
    NSString *currentAltitude = [[NSString alloc]initWithFormat:@"%g",newLocation.altitude];
    NSString *currentVerticalAccuracy =[[NSString alloc]initWithFormat:@"%g",newLocation.verticalAccuracy];
    
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            NSString *test = [placemark locality];
            NSLog(@"city is:%@",test);
        }
    }];
    
    self.dict = [NSDictionary dictionaryWithObjects:@[currentLatitude,currentLongitude,currentHorizontalAccuracy,currentAltitude,currentVerticalAccuracy] forKeys:@[currentLocationLatitude,currentLocationLongitude,currentLocationHorizontalAccuracy,currentLocationAltitude,currentLocationVerticalAccuracy]];
}

@end
