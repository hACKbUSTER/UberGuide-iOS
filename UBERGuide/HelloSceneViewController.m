//
//  HelloSceneViewController.m
//  UBERGuide
//
//  Created by Fincher Justin on 16/1/16.
//  Copyright © 2016年 hACKbUSTER. All rights reserved.
//

#import "HelloSceneViewController.h"
#import "FBShimmeringView.h"
#import "CityWelcomeViewController.h"
#import "LocationManager.h"
#import "UBERGuide-Swift.h"
#define DEGREES_TO_RADIANS(degrees)((M_PI * degrees)/180)
#define bottomConstrainsValue 30.0

@interface HelloSceneViewController ()
@property (weak, nonatomic) IBOutlet FBShimmeringView *shimmeringView;

@property (strong,nonatomic) UIImageView *roadImageView;
@property (strong,nonatomic) UIImageView *personImageView;
@property (strong,nonatomic) UIImageView *carBodyImageView;
@property (strong,nonatomic) UIImageView *tireLeftImageView;
@property (strong,nonatomic) UIImageView *tireRightImageView;
@property (strong,nonatomic) UIView *carMainView;

@end

@implementation HelloSceneViewController
@synthesize roadImageView,personImageView,carBodyImageView,tireLeftImageView,tireRightImageView,carMainView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *helloLabel = [[UILabel alloc] initWithFrame:_shimmeringView.bounds];
    helloLabel.text = @"Hello";
    helloLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:100.0f];
    helloLabel.textAlignment = NSTextAlignmentCenter;
    
    _shimmeringView.contentView = helloLabel;
    _shimmeringView.shimmering = YES;
    _shimmeringView.shimmeringBeginFadeDuration = 0.2;
    _shimmeringView.shimmeringPauseDuration = 0.2;
    _shimmeringView.shimmeringOpacity = 0.1;
    _shimmeringView.shimmeringEndFadeDuration = 0.1;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
    
    [self configureBaseView];
    [self configureAnimationView];
}

- (void)configureBaseView
{
    //48.64
    roadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -bottomConstrainsValue + self.view.frame.size.height - self.view.frame.size.width/750*114, self.view.frame.size.width, self.view.frame.size.width/750*114)];
    roadImageView.image = [UIImage imageNamed:@"Road.png"];
    [self.view addSubview:roadImageView];
    
    
    personImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height - 549/2, 210/2, 549/2)];
    personImageView.image = [UIImage imageNamed:@"Person"];
    [self.view addSubview:personImageView];
    
    
    carMainView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width , self.view.frame.size.height - 165.0/2 - roadImageView.frame.size.height, 377.0/2, 165.0/2)];
    [self.view addSubview:carMainView];
    
    carBodyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0 ,0, 377/2, 145/2)];
    carBodyImageView.image = [UIImage imageNamed:@"Car Body"];
    [carMainView addSubview:carBodyImageView];
    
    tireLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(13, 46.5, 36, 36)];
    tireRightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(155, 46.5, 36, 36)];
    tireLeftImageView.image = [UIImage imageNamed:@"Tire"];
    tireRightImageView.image = [UIImage imageNamed:@"Tire"];
    
    [carMainView addSubview:tireRightImageView];
    [carMainView addSubview:tireLeftImageView];
    
    
    
    // Parallax effect
    // Set vertical effect
    UIInterpolatingMotionEffect *frontVerticalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.y"
     type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    frontVerticalMotionEffect.minimumRelativeValue = @(0);
    frontVerticalMotionEffect.maximumRelativeValue = @(30);
    
    // Set horizontal effect
    UIInterpolatingMotionEffect *frontHorizontalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.x"
     type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    frontHorizontalMotionEffect.minimumRelativeValue = @(-20);
    frontHorizontalMotionEffect.maximumRelativeValue = @(20);
    
    // Create group to combine both
    UIMotionEffectGroup *frontGroup = [UIMotionEffectGroup new];
    frontGroup.motionEffects = @[frontHorizontalMotionEffect, frontVerticalMotionEffect];
    
    // Add both effects to your view
    [personImageView addMotionEffect:frontGroup];
    
    
    UIInterpolatingMotionEffect *backVerticalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.y"
     type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    backVerticalMotionEffect.minimumRelativeValue = @(0);
    backVerticalMotionEffect.maximumRelativeValue = @(20);
    UIMotionEffectGroup *backGroup = [UIMotionEffectGroup new];
    backGroup.motionEffects = @[backVerticalMotionEffect];
    
    [roadImageView addMotionEffect:backGroup];

    
}

- (void)configureAnimationView
{
    [CATransaction begin];
    CABasicAnimation *rotationAnimation;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.byValue = [NSNumber numberWithFloat:20];
    rotationAnimation.duration = 2.5;
    rotationAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [CATransaction setCompletionBlock:^{
        tireLeftImageView.transform = CGAffineTransformRotate(tireLeftImageView.transform, DEGREES_TO_RADIANS(-60*32.72));
    }];
    
    [tireLeftImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [tireRightImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [CATransaction commit];

    
    CABasicAnimation *carBodyAnimation;
    carBodyAnimation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    carBodyAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    carBodyAnimation.duration=2;
    carBodyAnimation.repeatCount=1;
    carBodyAnimation.autoreverses=NO;
    carBodyAnimation.removedOnCompletion = NO;
    carBodyAnimation.fillMode = kCAFillModeForwards;
    carBodyAnimation.fromValue=[NSNumber numberWithFloat:0];
    carBodyAnimation.toValue=[NSNumber numberWithFloat:-377/2];
    [carMainView.layer addAnimation:carBodyAnimation forKey:@"animateLayer"];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    [self.navigationController.interactivePopGestureRecognizer setDelegate:nil];
}

- (void)tap:(id)sender
{

    [self presentCityWelcomeVC];
}

- (void)presentCityWelcomeVC
{
    [UberAuth.sharedInstance authenticate:^{
        [self performSegueWithIdentifier:@"CityWelcomeSegue" sender:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
