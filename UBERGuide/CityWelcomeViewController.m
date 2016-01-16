//
//  CityWelcomeViewController.m
//  UBERGuide
//
//  Created by Fincher Justin on 16/1/16.
//  Copyright © 2016年 hACKbUSTER. All rights reserved.
//

#import "CityWelcomeViewController.h"
#import "LookForRideViewController.h"
#import "LocationManager.h"

@interface CityWelcomeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation CityWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _timer =  [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(setCityLabelText) userInfo:nil repeats:YES];
}

- (void)setCityLabelText
{
    if ([LocationManager sharedInstance].currentLocationName)
    {
        NSLog(@"[LocationManager sharedInstance].currentLocationName");
        _cityLabel.text = [LocationManager sharedInstance].currentLocationName;
        [_timer invalidate];
    }
}
- (IBAction)beginExploringButtonPressed:(id)sender {

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
