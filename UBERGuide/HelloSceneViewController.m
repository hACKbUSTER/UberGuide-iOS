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


@interface HelloSceneViewController ()
@property (weak, nonatomic) IBOutlet FBShimmeringView *shimmeringView;

@end

@implementation HelloSceneViewController

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
    
    UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    [self.view addGestureRecognizer:gesture];
}

- (void)swipe:(UISwipeGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateEnded)
    {
        if(gesture.direction == UISwipeGestureRecognizerDirectionRight)
        {
            [self presentCityWelcomeVC];
        }
    }
}

- (void)presentCityWelcomeVC
{
    [self performSegueWithIdentifier:@"CityWelcomeSegue" sender:nil];
    // call this when get location from CLLocationManager
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
