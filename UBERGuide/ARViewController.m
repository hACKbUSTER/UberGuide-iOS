//
//  ARViewController.m
//  Renaissance
//
//  Created by Fincher Justin on 15/12/21.
//  Copyright © 2015年 Fincher Justin. All rights reserved.
//

#import "ARViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ARNode.h"
#import "UBERGuide-Swift.h"
#import "MJExtension.h"

@import CoreLocation;

#define fontSize 25.0f

@interface ARViewController ()<ARDataSourceDelegate,CLLocationManagerDelegate>

@property (nonatomic) BOOL isLocated;
@property (nonatomic) int dragCounter;
@property (nonatomic,strong) API *api;
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation ARViewController
@synthesize ARView;
@synthesize ARdata;
@synthesize playerLocation,locationManager,isLocated,dragCounter;
@synthesize api,timer;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!self.isLocated)
    {
        [self startUpAnimation];
    }
    
    api = [[API alloc]init];
    
    [self ARBeginBackgroundCamera];
    [self locationService];
    [self ARBeginFrontView];
    [self dataTask];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panRecognized:)];
    [self.view addGestureRecognizer:pan];
}

- (void)viewDidAppear:(BOOL)animated
{
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(dataTask) userInfo:nil repeats:YES];
}
                                                                                        
- (void)viewDidDisappear:(BOOL)animated
{
    [timer invalidate];
    NSLog(@"[timer invalidate];");
}


- (void)panRecognized:(UIPanGestureRecognizer *)rec
{
    CGPoint vel = [rec velocityInView:self.view];
    if (vel.y > 0)
    {
        //NSLog(@"UP");
        dragCounter ++ ;
    }
    else
    {
        //NSLog(@"DOWN");
        dragCounter -- ;
    }
    
    if (dragCounter > 20)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if (dragCounter < -20)
    {
        dragCounter = 0;
    }
}
#pragma mark - Start up animation
- (void)startUpAnimation
{
    
}
#pragma mark - CLLocationManager
- (void)locationService
{
    playerLocation = [[CLLocation alloc] initWithLatitude:0 longitude:0];
    isLocated = NO;
    locationManager = [[CLLocationManager alloc]init]; // initializing locationManager
    locationManager.delegate = self; // we set the delegate of locationManager to self.
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; // setting the accuracy
    
    [locationManager startUpdatingLocation];  //requesting location updates
}

#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"Error: %@",error.description);
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    isLocated = YES;
    CLLocationDistance meters = [playerLocation distanceFromLocation:[locations lastObject]];
    playerLocation = [locations lastObject];
    [ARView reloadData];
}

#pragma mark - AR Camera Setup
- (void)ARBeginBackgroundCamera
{
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    session.sessionPreset = AVCaptureSessionPresetHigh;
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    [session addInput:input];
    
    AVCaptureVideoPreviewLayer *newCaptureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    newCaptureVideoPreviewLayer.frame = self.view.bounds;
    
    [self.view.layer addSublayer:newCaptureVideoPreviewLayer];
    
    [session startRunning];
}

#pragma mark - AR Front View Setup
- (void)ARBeginFrontView
{
    ARView = [[ARFrontView alloc] initWithFrame:self.view.bounds dataSource:self];
    [self.view addSubview:ARView];
}

#pragma mark - Data source download
- (void)dataTask
{
    [api requestCloseSpot:^(id object)
    {
        NSLog(@"%@",object);
        if (object)
        {
            ARdata = [GeoJSON_Root mj_objectWithKeyValues:object];
            [ARView reloadData];
            
        }
    }];
    
    
    /*
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    NSURL *URL = [NSURL URLWithString:@"https://gist.githubusercontent.com/anonymous/71743091575a8c3c2412/raw/f0c5f044de5fc68c7da184665241048306cf1343/map.geojson"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            //NSLog(@"%@ %@", response, responseObject);
            ARdata = [GeoJSON_Root mj_objectWithKeyValues:responseObject];
            [ARView reloadData];
        }
    }];
    [dataTask resume];
     */
}


#pragma mark - AR Front View Protocol
- (SCNNode *)ARFrontView:(SCNScene *)ARScene
   nodeForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ARNode *node = [ARNode node];
    GeoJSON_Index *index = [ARdata.features objectAtIndex:indexPath.row];
    if (index && playerLocation)
    {
        NSString *titleString = [[index valueForKey:@"properties"] valueForKey:@"Title"];
        NSLog(@"%@",titleString);
        UIView *ARNodeView = [[UIView alloc] init];
        ARNodeView.backgroundColor = [UIColor whiteColor];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(100, 60, [self width:titleString], 40)];
        title.text = titleString;
        title.font = [UIFont systemFontOfSize:fontSize];
        title.textAlignment = NSTextAlignmentCenter;
        [ARNodeView addSubview:title];
        
        
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
        iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%u",arc4random()%9+1]];
        [ARNodeView addSubview:iconImageView];
        
        
        NSLog(@"if (index && playerLocation)");
        NSMutableArray *coordinatesArray = [[index valueForKey:@"geometry"] valueForKey:@"coordinates"];
        double longitude = [[coordinatesArray firstObject] doubleValue];
        double latitude = [[coordinatesArray lastObject] doubleValue];
        //CLLocationCoordinate2D nodeCoordinates = CLLocationCoordinate2DMake(latitude, longitude);
        CLLocation * nodeLocation  = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
        
        
        ARNodeView.frame = CGRectMake(0, 0, 100+title.frame.size.width, 100);
        
        [node setNodeWithARView:ARNodeView nodeLocation:nodeLocation playerLocation:playerLocation];
    }
    
    return node;
}

- (NSInteger)ARFrontView:(SCNScene *)ARScene
   numberOfRowsInSection:(NSInteger)section
{
    if (ARdata)
    {
        return ARdata.features.count;
    }else return 0;
}

- (NSInteger)numberOfSectionsInARScene:(SCNScene *)ARScene
{
    return 1;
}


#pragma mark - Something
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(float) width:(NSString *)text{
    CGSize size=[text sizeWithFont:[UIFont systemFontOfSize:fontSize]constrainedToSize:CGSizeMake(MAXFLOAT,36)];
    return size.width;
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
