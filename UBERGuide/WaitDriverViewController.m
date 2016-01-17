//
//  WaitDriverViewController.m
//  UBERGuide
//
//  Created by Fincher Justin on 16/1/16.
//  Copyright © 2016年 hACKbUSTER. All rights reserved.
//

#import "WaitDriverViewController.h"
#import "UBERGuide-Swift.h"

@interface WaitDriverViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *mapImageView;

@end

@implementation WaitDriverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    self.title = @"Driver is on the way...";
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    self.driverProfileImageView.layer.masksToBounds = YES;
    self.mapImageView.clipsToBounds = YES;
    
    if(self.dict == nil)
    {
        self.dict = [NSDictionary dictionary];
    }
    
    self.driverStarLabel.text = [NSString stringWithFormat:@"%@",[[self.dict objectForKey:@"driver"] objectForKey:@"rating"]];
    self.driverNameLabel.text = [NSString stringWithFormat:@"Mr. %@",[[self.dict objectForKey:@"driver"] objectForKey:@"name"]];
    self.carTypeLabel.text = [NSString stringWithFormat:@"%@ %@",[[self.dict objectForKey:@"vehicle"] objectForKey:@"make"],[[self.dict objectForKey:@"vehicle"] objectForKey:@"model"]];
    
    self.driverProfileImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[self.dict objectForKey:@"driver"] objectForKey:@"picture_url"]]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.driverProfileImageView.alpha = 0.0f;
            [self.driverProfileImageView setImage:image];
            [UIView animateWithDuration:0.3f animations:^{
                self.driverProfileImageView.alpha = 1.0f;
            }];
        });
    });
    
    // After 15 seconds perform this selector to update the state to in_progress
    [self performSelector:@selector(updateState) withObject:nil afterDelay:15.0f];
}

- (void)updateState
{
    API *api = [[API alloc]init];
    [api updateStateWithState:@"in_progress" completionHandler:^{
        [self performSegueWithIdentifier:@"RideProgressSegue" sender:self];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    Because requesting map is meaningless in Sand Box Mode, and loading Map will cost a very long time, so we comment this out in order to make things simple.
    
//    API *api = [[API alloc]init];
//    [api requestMap:^(id object) {
//        [self.mapWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[[object objectForKey:@"data"] objectForKey:@"href"]]]];
//    }];
}

- (IBAction)ContactDriver:(id)sender {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",[[self.dict objectForKey:@"driver"] objectForKey:@"phone_number"]];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
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
