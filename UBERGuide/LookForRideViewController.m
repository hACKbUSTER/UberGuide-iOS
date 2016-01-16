//
//  LookForRideViewController.m
//  UBERGuide
//
//  Created by Fincher Justin on 16/1/16.
//  Copyright © 2016年 hACKbUSTER. All rights reserved.
//

#define buttonWidth 200.0
#define buttonHeight 60.0
#import "LookForRideViewController.h"
#import "UIView+ViewFrameGeometry.h"

@interface LookForRideViewController ()
@property (weak, nonatomic) IBOutlet UILabel *discoverTagLabel;
@end

@implementation LookForRideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.discoverTagLabel.text = @"Discover\nCulture";
    
    UIButton *beginExplorationButton = [UIButton buttonWithType:UIButtonTypeSystem];
    beginExplorationButton.frame = CGRectMake(ScreenWidth/2.0f - 100.0f, self.discoverTagLabel.bottom + 20.0f, 200.0f, 60.0f);
    [beginExplorationButton setTitle:@"Begin Your Exploration >" forState:UIControlStateNormal];
    [beginExplorationButton addTarget:self action:@selector(beginExploration:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:beginExplorationButton];
}

- (void)beginExploration:(id)sender
{
    
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
