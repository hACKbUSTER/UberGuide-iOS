//
//  LocationManager.h
//  UBERGuide
//
//  Created by 叔 陈 on 16/1/16.
//  Copyright © 2016年 hACKbUSTER. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationManager : NSObject

@property (nonatomic, strong) NSDictionary *dict;

+ (LocationManager *) sharedInstance;

@end
