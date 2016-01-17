//
//  GeoJSON_Index.h
//  Renaissance
//
//  Created by Fincher Justin on 15/12/23.
//  Copyright © 2015年 Fincher Justin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GeoJSON_Geometry.h"
#include "GeoJSON_Properties.h"

@protocol GeoJSON_Index <NSObject>

@end


@interface GeoJSON_Index : NSObject

@property (copy, nonatomic) NSString *type;
@property (strong,nonatomic) GeoJSON_Properties *properties;
@property (strong,nonatomic) GeoJSON_Geometry *geometry;
@end
