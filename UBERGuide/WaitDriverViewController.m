//
//  WaitDriverViewController.m
//  UBERGuide
//
//  Created by Fincher Justin on 16/1/16.
//  Copyright © 2016年 hACKbUSTER. All rights reserved.
//

#import "WaitDriverViewController.h"

@interface WaitDriverViewController ()


@end

@implementation WaitDriverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    self.title = @"Discover";
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor lightGrayColor];
    
    _driverProfileImageView.layer.masksToBounds = YES;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    _driverProfileImageView.layer.cornerRadius = _driverProfileImageView.frame.size.width/2;
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
