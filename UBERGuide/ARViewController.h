//
//  ARViewController.h
//  Renaissance
//
//  Created by Fincher Justin on 15/12/21.
//  Copyright © 2015年 Fincher Justin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARFrontView.h"
#import "GeoJSON_Root.h"

@interface ARViewController : UIViewController

@property (nonatomic,strong) ARFrontView *ARView;
@property (nonatomic,strong) GeoJSON_Root *ARdata;
@property (nonatomic,strong) CLLocation * playerLocation;
@property (nonatomic,strong) CLLocationManager *locationManager;

@end


