//
//  GeoJSON_Root.h
//  Renaissance
//
//  Created by Fincher Justin on 15/12/23.
//  Copyright © 2015年 Fincher Justin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GeoJSON_Index.h"


@interface GeoJSON_Root : NSObject

@property (copy, nonatomic) NSString *type;
@property  (nonatomic,strong) NSMutableArray<GeoJSON_Index> *features;

@end
