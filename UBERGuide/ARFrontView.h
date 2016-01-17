//
//  ARFrontView.h
//  Renaissance
//
//  Created by Fincher Justin on 15/12/21.
//  Copyright © 2015年 Fincher Justin. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <CoreMotion/CoreMotion.h>
#import <CoreFoundation/CoreFoundation.h>
#import "ARNode.h"
@import SceneKit;
@import GLKit;

@protocol ARDataSourceDelegate <NSObject>
@required
- (ARNode *)ARFrontView:(SCNScene *)ARScene
   nodeForRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSInteger)ARFrontView:(SCNScene *)ARScene
 numberOfRowsInSection:(NSInteger)section;

- (NSInteger)numberOfSectionsInARScene:(SCNScene *)ARScene;

@optional


@end


@interface ARFrontView : SCNView<SCNSceneRendererDelegate>

@property (nonatomic, weak) id<ARDataSourceDelegate> dataSource;
@property (nonatomic,strong) SCNScene *ARScene;
@property (nonatomic, strong) CMMotionManager *motionManager;

@property (nonatomic,strong) CMAttitude *playerAttitude;

@property (nonatomic,strong) SCNNode *cameraNode;
@property (nonatomic,strong) NSMutableArray *ARNodeArray;


- (void)reloadData;
- (id)initWithFrame:(CGRect)frame dataSource:(id)dataSource;


@property (nonatomic,strong) SCNNode *mapNode;
@property (nonatomic,strong) SCNMaterial *mapNodeMaterial;

@end