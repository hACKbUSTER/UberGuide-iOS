//
//  GeoJSON_Properties.h
//  Renaissance
//
//  Created by Fincher Justin on 15/12/24.
//  Copyright © 2015年 Fincher Justin. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@protocol GeoJSON_Properties <NSObject>

@end
@interface GeoJSON_Properties : NSObject
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSArray *tags;
@end
