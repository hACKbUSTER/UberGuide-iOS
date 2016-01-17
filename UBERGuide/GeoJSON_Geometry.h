//
//  GeoJSON_Geometry.h
//  Renaissance
//
//  Created by Fincher Justin on 15/12/23.
//  Copyright © 2015年 Fincher Justin. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@protocol GeoJSON_Geometry <NSObject>

@end

@interface GeoJSON_Geometry : NSObject

@property (copy, nonatomic) NSString *type;
@property (nonatomic) NSMutableArray *coordinates;

@end
