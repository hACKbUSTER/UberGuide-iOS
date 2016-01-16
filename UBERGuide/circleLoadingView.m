//
//  circleLoadingView.m
//  UBERGuide
//
//  Created by 叔 陈 on 16/1/16.
//  Copyright © 2016年 hACKbUSTER. All rights reserved.
//

#import "circleLoadingView.h"
#import "UIView+ViewFrameGeometry.h"

#define AnimationDeepBlueColor [UIColor colorWithRed:62/255.0f green:171/255.0f blue:219/255.0f alpha:1.0f]
#define AnimationLightBlueColor [UIColor colorWithRed:169/255.0f green:222/255.0f blue:241/255.0f alpha:1.0f]

@implementation circleLoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        
    }
    return self;
}

- (void)animate
{
    [self.layer addAnimation:[self loopAnimation] forKey:@"fuck"];
}

- (CAKeyframeAnimation *)loopAnimation
{
    NSMutableArray *tmp = [NSMutableArray array];
    for(NSInteger i=0;i<4;i++)
    {
        [tmp addObject:(id)[self viewFrameImageWithIndex:i].CGImage];
    }
    
    CAKeyframeAnimation *loopAnimation;
    loopAnimation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    loopAnimation.values = tmp;
    loopAnimation.duration = 1.2f;
    loopAnimation.cumulative = YES;
    loopAnimation.repeatCount = HUGE_VAL;
    loopAnimation.removedOnCompletion= NO;
    loopAnimation.fillMode=kCAFillModeForwards;
    loopAnimation.autoreverses = NO;
    loopAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    loopAnimation.speed = 1.0f;
    loopAnimation.beginTime = 0.0f;
    return loopAnimation;
}

- (UIImage *)viewFrameImageWithIndex:(NSInteger)index
{
    UIView *view = [[UIView alloc]initWithFrame:self.frame];
    CGFloat width = 10.0f;
    UIView *leftCircle = [[UIView alloc]initWithFrame:CGRectMake((self.width - 7*width)/2.0f, 0.0f, width, width)];
    leftCircle.layer.cornerRadius = width/2.0f;
    leftCircle.backgroundColor = AnimationLightBlueColor;
    
    UIView *centerCircle = [[UIView alloc]initWithFrame:CGRectMake(leftCircle.right + width * 2.0f, 0.0f, width, width)];
    centerCircle.layer.cornerRadius = width/2.0f;
    centerCircle.backgroundColor = AnimationLightBlueColor;
    
    UIView *rightCircle = [[UIView alloc]initWithFrame:CGRectMake(centerCircle.right + width * 2.0f, 0.0f, width, width)];
    rightCircle.layer.cornerRadius = width/2.0f;
    rightCircle.backgroundColor = AnimationLightBlueColor;
    
    if(index == 1) {
        leftCircle.backgroundColor = AnimationDeepBlueColor;
        centerCircle.backgroundColor = AnimationLightBlueColor;
        rightCircle.backgroundColor = AnimationLightBlueColor;
    } else if(index == 2) {
        leftCircle.backgroundColor = AnimationDeepBlueColor;
        centerCircle.backgroundColor = AnimationDeepBlueColor;
        rightCircle.backgroundColor = AnimationLightBlueColor;
    } else if(index == 3) {
        leftCircle.backgroundColor = AnimationDeepBlueColor;
        centerCircle.backgroundColor = AnimationDeepBlueColor;
        rightCircle.backgroundColor = AnimationDeepBlueColor;
    }
    
    [view addSubview:leftCircle];
    [view addSubview:centerCircle];
    [view addSubview:rightCircle];

    return [view convertViewToImage];
}
@end
