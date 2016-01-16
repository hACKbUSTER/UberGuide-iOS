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
#import "UBERGuide-Swift.h"
#import "WaitDriverViewController.h"

@interface LookForRideViewController ()
{
    NSDictionary *dict;
    BOOL hasBeenCanceled;
}

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
    dict = [NSDictionary dictionary];
    hasBeenCanceled = NO;
    
    // Do any additional setup after loading the view.
    
    if(self.tripTitle == nil)
        self.tripTitle = @"Beijing";
        
    self.discoverTagLabel.text = [NSString stringWithFormat:@"Discover\n%@",self.tripTitle];//@"Discover\nCulture";
    
    self.beginExplorationButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _beginExplorationButton.frame = CGRectMake(0.0f, ScreenHeight - 60.0f, ScreenWidth, 60.0f);
    [_beginExplorationButton setTitle:@"Begin Your Exploration >" forState:UIControlStateNormal];
    [_beginExplorationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _beginExplorationButton.backgroundColor = [UIColor colorWithRed:0.29f green:0.73f blue:0.89f alpha:1.0f];
    [_beginExplorationButton addTarget:self action:@selector(beginExploration:) forControlEvents:UIControlEventTouchUpInside];
    
    self.cancelExplorationButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _cancelExplorationButton.frame = CGRectMake(0.0f, ScreenHeight - 60.0f, ScreenWidth, 60.0f);
    [_cancelExplorationButton setTitle:@"Cancel this trip" forState:UIControlStateNormal];
    [_cancelExplorationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _cancelExplorationButton.backgroundColor = [UIColor redColor];
    [_cancelExplorationButton addTarget:self action:@selector(cancelExploration:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelExplorationButton];
    _cancelExplorationButton.hidden = YES;
    _cancelExplorationButton.alpha = 0.0f;
    
    self.lookingAnimationView = [[lookingAnimationView alloc] initWithFrame:CGRectMake(0.0f, _discoverTagLabel.bottom + 40.0f, ScreenWidth, 60.0f)];
    [self.view addSubview:_lookingAnimationView];
    _lookingAnimationView.hidden = YES;
    
    [self.view addSubview:_beginExplorationButton];
}

- (void)beginExploration:(id)sender
{
    _cancelExplorationButton.hidden = NO;
    [UIView animateWithDuration:0.3f animations:^{
        _beginExplorationButton.alpha = 0.0f;
        _cancelExplorationButton.alpha = 1.0f;
    } completion:^(BOOL finished) {
        _lookingAnimationView.hidden = NO;
        _beginExplorationButton.hidden = YES;
        [_lookingAnimationView animate];
    }];

    API *api = [[API alloc]init];
    [api updateStateWithState:@"completed" completionHandler:^{
        [api request];
        [self performSelector:@selector(updateStateToAccepted:) withObject:nil afterDelay:10.0f];
    }];
}

- (void)updateStateToAccepted:(id)object
{
    API *api = [[API alloc]init];
    [api updateStateWithState:@"accepted" completionHandler:^{
        _lookingAnimationView.titleLabel.text = @"Request accepted";
        [api updateStateWithState:@"arriving" completionHandler:^{
            [self performSelector:@selector(requestCurrent:) withObject:nil afterDelay:0.0f];
        }];
    }];
}

- (void)requestCurrent:(id)sender
{
    API *api = [[API alloc]init];
    [api requestCurrent:^(id object) {
        dict = [object objectForKey:@"data"];
        if(hasBeenCanceled)
        {
            hasBeenCanceled = NO;
            return;
        }
        [self performSegueWithIdentifier:@"GetDriverSegue" sender:self];
    }];
}

- (void)cancelExploration:(id)sender
{
    API *api = [[API alloc]init];
    hasBeenCanceled = YES;
    [api updateStateWithState:@"completed" completionHandler:^{
        NSLog(@"canceled anyway!");
        
        _beginExplorationButton.hidden = NO;
        [UIView animateWithDuration:0.3f animations:^{
            _lookingAnimationView.alpha = 0.0f;
            _beginExplorationButton.alpha = 1.0f;
            _cancelExplorationButton.alpha = 0.0f;
        } completion:^(BOOL finished) {
            _lookingAnimationView.hidden = YES;
            _lookingAnimationView.alpha = 1.0f;
            _lookingAnimationView.titleLabel.text = @"Looking for rides";
            _cancelExplorationButton.hidden = YES;
        }];

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"GetDriverSegue"])
    {
        WaitDriverViewController *vc = (WaitDriverViewController *)segue.destinationViewController;
        vc.dict = dict;
    }
}


@end
