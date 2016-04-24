//
//  VJImageProcessingModule.h
//  Viola-Jones
//
//  Created by Kurt Jacobs on 2015/11/25.
//  Copyright © 2015 RandomDudes. All rights reserved.
//

#import <Foundation/Foundation.h>

using namespace cv;
using namespace std;

@interface VJImageProcessingModule : NSObject

/*! @brief This method needs to be called before detecting any faces. It initialises the cascade classifier.
 */
+ (void)createCascadeClassifier;

/*! @brief Detects faces in a given frame using the specified HaarCascadeClassifier.
 *  @param image The image for which face detection should occur.
 *  @param maxFaceSize The maximum size of a face to be detected.
 *  @param minFaceSize The minimum size of a face to be detected.
 *  @param scaleFactor How much the image size is reduced at each image scale.
 *  @return a std::vector containing the rectangle locations of the faces found in the image.
 */
+ (vector<cv::Rect>)faceDetect:(Mat &)image maxFaceSize:(float)mxfs minimumFaceSize:(float)mnfs scaleFactor:(float)sf;

/*! @brief Draws rectangles onto an image given a std::vector<cv::Rect>.
 *  @param image The image to draw the face rectangles on.
 *  @param faces The vector containing the rect locations of the faces.
 */
+ (void)drawRectanglesOnFacesForImage:(Mat &)image andFacesRect:(vector<cv::Rect>)faces;

@end
