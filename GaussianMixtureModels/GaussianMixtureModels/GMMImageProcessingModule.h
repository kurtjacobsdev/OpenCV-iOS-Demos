//
//  GMMImageProcessingModule.h
//  GaussianMixtureModels
//
//  Created by Kurt Jacobs on 2015/12/01.
//  Copyright © 2015 RandomDudes. All rights reserved.
//

#import <Foundation/Foundation.h>

using namespace cv;

typedef NS_ENUM(NSUInteger, GMMModelType)
{
    GMMModelTypeMOG,
    GMMModelTypeGMG,
    GMMModelTypeMOG2,
    GMMModelTypeKNN
};

@interface GMMImageProcessingModule : NSObject

/*! @brief This method needs to be called before processing any frames. It initialises the background subtractor to the appropriate type specified 
 *  @param type The specific type of background subtractor to create.
 */
+ (void)createMixtureModelWithType:(GMMModelType)type;

/*! @brief Applies the selected background subtrtactor to the given image.
 *  @param frame The image for which the mixture of gaussians should be applied.
 */
+ (Mat)processFrame:(Mat &)frame;

@end
