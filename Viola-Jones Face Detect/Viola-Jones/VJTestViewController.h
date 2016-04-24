//
//  ViewController.h
//  Viola-Jones
//
//  Created by Kurt Jacobs on 2015/11/25.
//  Copyright © 2015 RandomDudes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VJImageProcessingModule.h"
#import <opencv2/videoio/cap_ios.h>

using namespace cv;

@interface VJTestViewController : UIViewController <CvVideoCameraDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *displayImageview;

@end

