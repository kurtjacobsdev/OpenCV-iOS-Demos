//
//  GMMImageProcessingModule.m
//  GaussianMixtureModels
//
//  Created by Kurt Jacobs on 2015/12/01.
//  Copyright © 2015 RandomDudes. All rights reserved.
//

#import "GMMImageProcessingModule.h"

@implementation GMMImageProcessingModule

static Ptr<BackgroundSubtractor> bs;
static BOOL subtractorSet = false;

static GMMModelType modelType;

+ (void)createMixtureModelWithType:(GMMModelType)type
{
    if (type == GMMModelTypeMOG2)
    {
        bs = createBackgroundSubtractorMOG2(40);
        subtractorSet = YES;
    }
    else if (type == GMMModelTypeKNN)
    {
        bs = createBackgroundSubtractorKNN();
        subtractorSet = YES;
    }
    else{NSLog(@"Error type not found.");return;}
    modelType = type;
}

+ (Mat)processFrame:(cv::Mat &)frame
{
    Mat fgmask;
    if (subtractorSet)
    {
        Mat bg;
        bs->apply(frame,fgmask);
    }
    else
    {
        NSLog(@"Subtractor Not Set.");
    }
    return fgmask;
}

@end
