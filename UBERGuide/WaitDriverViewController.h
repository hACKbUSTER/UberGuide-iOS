//
//  WaitDriverViewController.h
//  UBERGuide
//
//  Created by Fincher Justin on 16/1/16.
//  Copyright © 2016年 hACKbUSTER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaitDriverViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *mapWebView;
@property (weak, nonatomic) IBOutlet UILabel *driverStarLabel;
@property (weak, nonatomic) IBOutlet UILabel *driverNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *driverProfileImageView;
@property (weak, nonatomic) IBOutlet UILabel *carTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *carPlateLabel;
@end
