//
//  VJImageProcessingModule.m
//  Viola-Jones
//
//  Created by Kurt Jacobs on 2015/11/25.
//  Copyright © 2015 RandomDudes. All rights reserved.
//

#import "VJImageProcessingModule.h"
@implementation VJImageProcessingModule

static NSString *cascade_name = @"haarcascade_frontalface_default";
static NSString *cascade_name2 = @"haarcascade_frontalface_alt";
static NSString *cascade_name3 = @"haarcascade_frontalface_alt2";
static NSString *cascade_name4 = @"haarcascade_frontalface_alt_tree";

static CascadeClassifier cascade_model;

+ (void)createCascadeClassifier
{
    NSString *cascadefp = [[NSBundle mainBundle] pathForResource:cascade_name2 ofType:@"xml"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:cascadefp])
    {
        cascade_model.load([cascadefp UTF8String]);
    }
}

+ (vector<cv::Rect>)faceDetect:(Mat &)image maxFaceSize:(float)mxfs minimumFaceSize:(float)mnfs scaleFactor:(float)sf
{
    vector<cv::Rect> faces;
    if (cascade_model.empty()){NSLog(@"ERROR, Load Cascade Classifier.");return faces;};
    
    cascade_model.detectMultiScale(image, faces, sf, 2, 0|CV_HAAR_SCALE_IMAGE, cv::Size(mnfs, mxfs));
    
    return faces;
}

+ (void)drawRectanglesOnFacesForImage:(Mat &)image andFacesRect:(vector<cv::Rect>)faces
{
    for( int i = 0; i < faces.size(); i++)
    {
        cv::Point pt1(faces[i].x, faces[i].y);
        cv::Point pt2((faces[i].x + faces[i].height), (faces[i].y + faces[i].width));
        cv::rectangle(image,pt1,pt2, Scalar(255,0,0),3,8,0);
    }
}

@end
