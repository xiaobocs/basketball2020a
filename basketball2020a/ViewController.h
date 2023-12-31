//
//  ViewController.h
//  basketball2020a
//
//  Created by ellen on 2023/8/13.
//

#import <opencv2/core.hpp>

#import <opencv2/videoio/cap_ios.h>
//#import "CvEffects/RetroFilter.hpp"

@interface ViewController : UIViewController<CvVideoCameraDelegate> {
    CvVideoCamera* videoCamera;
    BOOL isCapturing;
    
    int imageCount;
    cv::Mat ballBack, imageBack;
    
    //RetroFilter::Parameters params;
    //cv::Ptr<RetroFilter> filter;
    uint64_t prevTime;
    
    double m_array[200];
    int m_tail;
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *startCaptureButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *stopCaptureButton;
- (IBAction)startCaptureButtonPressed:(id)sender;
- (IBAction)stopCaptureButtonPressed:(id)sender;

@end

