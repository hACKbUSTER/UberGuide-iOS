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

@interface LookForRideViewController ()
@property (weak, nonatomic) IBOutlet UILabel *discoverTagLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *bottomScrollView;

@end

@implementation LookForRideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)configureBottomView;
{
    _bottomScrollView.contentSize = CGSizeMake(_bottomScrollView.frame.size.width*2, _bottomScrollView.frame.size.height);
    _bottomScrollView.clipsToBounds = NO;
    _bottomScrollView.pagingEnabled = YES;
    
    UIButton *beginExplorationButton = [UIButton buttonWithType:UIButtonTypeSystem];
    beginExplorationButton.frame = CGRectMake((_bottomScrollView.frame.size.width-buttonWidth)/2, (_bottomScrollView.frame.size.height-buttonHeight)/2, buttonWidth, buttonHeight);
    [beginExplorationButton setTitle:@"Begin Your Exploration >" forState:UIControlStateNormal];
    [_bottomScrollView addSubview:beginExplorationButton];
    
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
