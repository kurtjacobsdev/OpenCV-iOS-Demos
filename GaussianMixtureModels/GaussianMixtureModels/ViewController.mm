//
//  ViewController.m
//  GaussianMixtureModels
//
//  Created by Kurt Jacobs on 2015/12/01.
//  Copyright © 2015 RandomDudes. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+OpenCV.h"
#import "GMMImageProcessingModule.h"

@interface ViewController ()

@property (nonatomic, retain) CvVideoCamera *cameraUnit;
@property (weak, nonatomic) IBOutlet UIImageView *capturePreview;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.capturePreview.contentMode = UIViewContentModeScaleAspectFill;
    
    self.cameraUnit = [[CvVideoCamera alloc] init];
    self.cameraUnit.delegate = self;
    self.cameraUnit.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
    self.cameraUnit.defaultAVCaptureSessionPreset = AVCaptureSessionPreset640x480;
    self.cameraUnit.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self.cameraUnit.defaultFPS = 30;
    self.cameraUnit.grayscaleMode = NO;
    self.cameraUnit.rotateVideo = YES;
    [self.cameraUnit start];
    [self.cameraUnit lockFocus];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)processImage:(cv::Mat &)image
{
    Mat mask = [GMMImageProcessingModule processFrame:image];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.capturePreview.image = [UIImage UIImageFromCVMat:mask];
    });
}

@end
