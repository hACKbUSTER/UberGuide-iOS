//
//  ARNode.h
//  Renaissance
//
//  Created by Fincher Justin on 15/12/22.
//  Copyright © 2015年 Fincher Justin. All rights reserved.
//
@import CoreLocation;
#import <SceneKit/SceneKit.h>

@interface ARNode : SCNNode

@property (nonatomic) CLLocation *nodeLocation;
@property (nonatomic) CLLocation *playerLocation;

@property (nonatomic) UIView *ARView;

@property (nonatomic) SCNPlane *planeGeometry;

+ (ARNode *)nodeWithGeometry:(SCNGeometry *)geometry;

- (void)setNodeWithARView:(UIView *)view
             nodeLocation:(CLLocation *)nodeCLLocation
           playerLocation:(CLLocation *)playerCLLocation;

@end
