//
//  UIImage+OpenCV.h
//  OpenCVTest
//
//  Created by Kurt Jacobs on 2015/08/25.
//  Copyright (c) 2015 Kurt Jacobs. All rights reserved.
//

#import <UIKit/UIKit.h>
using namespace cv;

typedef NS_ENUM (NSInteger, CV_MAT_READ_OPTION)
{
    CV_MAT_READ_OPTION_DEFAULT,
    CV_MAT_READ_OPTION_GRAY
};

@interface UIImage (OpenCV)

/*! @brief Converts a given Mat to a UIImage for display purposes in UIKit.
 *  @param cvMat The Mat to convert to UIImage.
 */
+ (UIImage *)UIImageFromCVMat:(Mat)cvMat;

/*! @brief Converts a given UIImage to a Mat for image processing purposes in OpenCV.
 *  @param image The UIImage to convert to Mat.
 */
+ (Mat)cvMatWithImage:(UIImage *)image;

+ (Mat)matWithName:(NSString *)name;

+ (Mat)matWithName:(NSString *)name readOptions:(CV_MAT_READ_OPTION)readOption;

@end
