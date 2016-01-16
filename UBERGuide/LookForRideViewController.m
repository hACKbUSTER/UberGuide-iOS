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
#import "lookingAnimationView.h"

@interface LookForRideViewController ()
@property (weak, nonatomic) IBOutlet UILabel *discoverTagLabel;
@property (strong, nonatomic) UIButton *beginExplorationButton;
@property (strong, nonatomic) UIButton *cancelExplorationButton;
@property (strong, nonatomic) lookingAnimationView *lookingAnimationView;

@end

@implementation LookForRideViewController
- (void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(self.tripTitle == nil)
        self.tripTitle = @"Beijing";
        
    self.discoverTagLabel.text = [NSString stringWithFormat:@"Discover\n%@",self.tripTitle];//@"Discover\nCulture";
    
    self.beginExplorationButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _beginExplorationButton.frame = CGRectMake(ScreenWidth/2.0f - 100.0f, self.discoverTagLabel.bottom + 40.0f, 200.0f, 60.0f);
    [_beginExplorationButton setTitle:@"Begin Your Exploration >" forState:UIControlStateNormal];
    [_beginExplorationButton addTarget:self action:@selector(beginExploration:) forControlEvents:UIControlEventTouchUpInside];
    
    self.cancelExplorationButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _cancelExplorationButton.frame = CGRectMake(ScreenWidth/2.0f - 100.0f, ScreenHeight - 100.0f , 200.0f, 60.0f);
    [_cancelExplorationButton setTitle:@"Cancel this trip" forState:UIControlStateNormal];
    [_cancelExplorationButton addTarget:self action:@selector(cancelExploration:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelExplorationButton];
    _cancelExplorationButton.hidden = YES;
    
    self.lookingAnimationView = [[lookingAnimationView alloc] initWithFrame:_beginExplorationButton.frame];
    [self.view addSubview:_lookingAnimationView];
    _lookingAnimationView.hidden = YES;
    
    [self.view addSubview:_beginExplorationButton];
}

- (void)beginExploration:(id)sender
{
    _lookingAnimationView.hidden = NO;
    _beginExplorationButton.hidden = YES;
    _cancelExplorationButton.hidden = NO;
    [_lookingAnimationView animate];
}

- (void)cancelExploration:(id)sender
{
    _lookingAnimationView.hidden = YES;
    _beginExplorationButton.hidden = NO;
    _cancelExplorationButton.hidden = YES;
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
