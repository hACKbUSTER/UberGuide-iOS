//
//  ARFrontView.m
//  Renaissance
//
//  Created by Fincher Justin on 15/12/21.
//  Copyright © 2015年 Fincher Justin. All rights reserved.
//

#import "ARFrontView.h"

#define CC_RADIANS_TO_DEGREES(__ANGLE__) ((__ANGLE__) * 57.29577951f)

@implementation ARFrontView
@synthesize ARScene;
@synthesize motionManager;
@synthesize playerAttitude;
@synthesize cameraNode,mapNode,mapNodeMaterial;
@synthesize ARNodeArray;


#pragma mark - Init method
- (id)initWithFrame:(CGRect)frame dataSource:(id)dataSource
{
    self = [super initWithFrame:frame];
    if(self)
    {
        ARScene = [SCNScene scene];
        self.scene = ARScene;
        self.delegate = self;
        self.playing = YES;
        self.showsStatistics = YES;
        
        self.dataSource = dataSource;
        self.backgroundColor = [UIColor clearColor];
        [self setupARScene];
        [self setupCMMotionManager];
        ARNodeArray = [self setARNodeArray];
        //[self setupMapNode];
    }
    return self;
}
#pragma mark - setup
- (NSMutableArray *)setARNodeArray
{
    for (ARNode *node in [self.scene.rootNode childNodes])
    {
        if (node != mapNode)
        {
            [node removeFromParentNode];
        }
    }
    
    
    NSMutableArray *ARAllNodeArray = [[NSMutableArray alloc] init];
    NSInteger sectionNumber = [self.dataSource respondsToSelector:@selector(numberOfSectionsInARScene:)] ? [self.dataSource numberOfSectionsInARScene:self.scene] : 0;
    for (int i = 0 ; i < sectionNumber; i++)
    {
        NSMutableArray *ARSectionNodeArray = [[NSMutableArray alloc] init];
        NSInteger nodeInSectionNumber = [self.dataSource respondsToSelector:@selector(ARFrontView:numberOfRowsInSection:)] ? [self.dataSource ARFrontView:self.scene numberOfRowsInSection:sectionNumber] : 0;
        
        //NSLog(@"nodeInSectionNumber : %ld",(long)nodeInSectionNumber);
        for (int k = 0; k < nodeInSectionNumber; k ++)
        {
            if ([self.dataSource respondsToSelector:@selector(ARFrontView:nodeForRowAtIndexPath:)])
            {
                ARNode *node = [self.dataSource ARFrontView:self.scene nodeForRowAtIndexPath:[NSIndexPath indexPathForRow:k inSection:i]];
                NSLog(@"X %f, Y%f ,Z%f",node.position.x,node.position.y,node.position.z);
                [self.scene.rootNode addChildNode:node];
                [ARSectionNodeArray addObject:node];
            }
        }
        [ARAllNodeArray addObject:ARSectionNodeArray];
    }
    return ARAllNodeArray;
}

- (void)setupARScene
{
    cameraNode = [SCNNode node];
    cameraNode.camera = [SCNCamera camera];
    cameraNode.position = SCNVector3Make(0, 0, 0);
    [self.scene.rootNode addChildNode:cameraNode];
    [self setPointOfView:cameraNode];
    cameraNode.camera.zNear = 0.001;
    cameraNode.camera.zFar = 99999999;
    cameraNode.camera.yFov = 53.0;
    cameraNode.camera.xFov = 53.0;
    
    self.autoenablesDefaultLighting = YES;

}

- (void)setupCMMotionManager
{
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.showsDeviceMovementDisplay = YES;
    motionManager.deviceMotionUpdateInterval = 1.0/60.0;
    if (([CMMotionManager availableAttitudeReferenceFrames] & CMAttitudeReferenceFrameXTrueNorthZVertical) != 0)
    {
        [motionManager startDeviceMotionUpdatesUsingReferenceFrame: CMAttitudeReferenceFrameXTrueNorthZVertical
                                                           toQueue: [NSOperationQueue mainQueue]
                                                       withHandler: ^(CMDeviceMotion *motion, NSError *error)
         {
             playerAttitude = motion.attitude;
             CMQuaternion quat = motion.attitude.quaternion;
             cameraNode.orientation = [self orientationFromCMQuaternion:quat];

         }];
    }
}



#pragma mark - SCNQuaternion From CMQuaternion
- (SCNQuaternion)orientationFromCMQuaternion:(CMQuaternion)q
{
    GLKQuaternion gq1 =  GLKQuaternionMakeWithAngleAndAxis(GLKMathDegreesToRadians(-90.0), 1, 0, 0); // add a rotation of the pitch 90 degrees
    GLKQuaternion gq2 =  GLKQuaternionMake(q.x, q.y, q.z, q.w); // the current orientation
    GLKQuaternion qp  =  GLKQuaternionMultiply(gq1, gq2); // get the "new" orientation
    CMQuaternion rq =   {.x = qp.x, .y = qp.y, .z = qp.z, .w = qp.w};
    
    return SCNVector4Make(rq.x, rq.y, rq.z, rq.w);
}

#pragma mark - Render Protocol
- (void)renderer:(id<SCNSceneRenderer>)aRenderer
    updateAtTime:(NSTimeInterval)time
{
    //NSLog(@"Yaw : %f Roll : %f Pitch : %f",roundf((float)(CC_RADIANS_TO_DEGREES(cameraYaw))),roundf((float)(CC_RADIANS_TO_DEGREES(cameraRoll))),roundf((float)(CC_RADIANS_TO_DEGREES(cameraPitch))));
    //NSLog(@"Yaw : %f Roll : %f Pitch : %f",cameraYaw,cameraRoll,cameraPitch);
    
    //[self refreshMapNodeTexture];
}

- (void)reloadData
{
    NSLog(@"reloadData");
    [self setARNodeArray];
}

/*
#pragma mark - Map Node
- (void)refreshMapNodeTexture
{
    //UIImage *bitmap = [self imageWithView:invisbleMapView];
    mapNodeMaterial.diffuse.contents = invisbleMapView.layer;
    mapNodeMaterial.transparent.contents = invisbleMapView.layer;
}
 */

- (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}


@end
