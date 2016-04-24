//
//  ViewController.m
//  Viola-Jones
//
//  Created by Kurt Jacobs on 2015/11/25.
//  Copyright © 2015 RandomDudes. All rights reserved.
//

#import "VJTestViewController.h"
#import "UIImage+OpenCV.h"

@interface VJTestViewController ()

@property (nonatomic, retain) CvVideoCamera *cameraUnit;
@property (weak, nonatomic) IBOutlet UIImageView *capturePreview;
@property (weak, nonatomic) IBOutlet UIButton *enabler;
@property (nonatomic) BOOL isActive;

@end

@implementation VJTestViewController

- (IBAction)enableDisable:(id)sender
{
    self.isActive = !self.isActive;
    if (self.isActive)
    {
        [self.cameraUnit start];
        [self.cameraUnit lockFocus];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.enabler setTitle:@"Deactivate Face Detect" forState:UIControlStateNormal];
        });
    }
    else if (!self.isActive)
    {
        [self.cameraUnit stop];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.capturePreview.backgroundColor = [UIColor blackColor];
            self.capturePreview.image = nil;
            [self.enabler setTitle:@"Activate Face Detect" forState:UIControlStateNormal];
        });

    }
}

- (IBAction)switchCam:(id)sender
{
    [self.cameraUnit switchCameras];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.isActive = NO;
    
    self.capturePreview.contentMode = UIViewContentModeScaleAspectFill;
    self.cameraUnit = [[CvVideoCamera alloc] init];
    self.cameraUnit.delegate = self;
    self.cameraUnit.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
    self.cameraUnit.defaultAVCaptureSessionPreset = AVCaptureSessionPreset352x288;
    self.cameraUnit.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self.cameraUnit.defaultFPS = 30;
    self.cameraUnit.grayscaleMode = NO;
    self.cameraUnit.rotateVideo = YES;
    [self enableDisable:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)processImage:(cv::Mat &)image
{
    if (self.isActive)
    {
      vector<cv::Rect>faces = [VJImageProcessingModule faceDetect:image maxFaceSize:30 minimumFaceSize:30 scaleFactor:1.1];
      if (faces.size() > 0)
      {
          [VJImageProcessingModule drawRectanglesOnFacesForImage:image andFacesRect:faces];
          Mat RGB;
          cvtColor(image, RGB, CV_BGR2RGB);
          dispatch_async(dispatch_get_main_queue(), ^{
              self.capturePreview.image = [UIImage UIImageFromCVMat:RGB];
          });
      }
      else
      {
        dispatch_async(dispatch_get_main_queue(), ^{
          Mat RGB;
          cvtColor(image, RGB, CV_BGR2RGB);
          self.capturePreview.image = [UIImage UIImageFromCVMat:RGB];
        });
      }
    }
  
}
@end
