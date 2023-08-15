//
//  ViewController.m
//  basketball2020a
//
//  Created by ellen on 2023/8/13.
//

#import "ViewController.h"
#import <mach/mach_time.h>

#import <opencv2/imgproc.hpp>

@interface ViewController ()

@end

@implementation ViewController

@synthesize imageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    videoCamera = [[CvVideoCamera alloc]
                   initWithParentView:imageView];
    videoCamera.delegate = self;
    videoCamera.defaultAVCaptureDevicePosition =
                                AVCaptureDevicePositionBack;
    //videoCamera.defaultAVCaptureSessionPreset =
    //                            AVCaptureSessionPreset352x288;
    videoCamera.defaultAVCaptureVideoOrientation =
                                AVCaptureVideoOrientationLandscapeRight;
    videoCamera.defaultFPS = 30;
    
    isCapturing = NO;
    
    // Load textures
    //UIImage* resImage = [UIImage imageNamed:@"scratches.png"];
    //UIImageToMat(resImage, params.scratches);
    
    //resImage = [UIImage imageNamed:@"fuzzy_border.png"];
    //UIImageToMat(resImage, params.fuzzyBorder);
    
    //filter = NULL;
    prevTime = mach_absolute_time();
    
    imageCount = 0;
}

- (NSInteger)supportedInterfaceOrientations
{
    // Only portrait orientation
    return UIInterfaceOrientationMaskPortrait;
}

- (IBAction)startCaptureButtonPressed:(id)sender {
    [videoCamera start];
    isCapturing = YES;
    
    //params.frameSize = cv::Size(videoCamera.imageWidth,
      //                          videoCamera.imageHeight);
    
    //if (!filter)
    //    filter = new RetroFilter(params);
    
    imageCount = 0;
}

- (IBAction)stopCaptureButtonPressed:(id)sender {
    //[videoCamera stop];
    isCapturing = !isCapturing;
}

//TODO: may be remove this code
static double machTimeToSecs(uint64_t time)
{
    mach_timebase_info_data_t timebase;
    mach_timebase_info(&timebase);
    return (double)time * (double)timebase.numer /
                          (double)timebase.denom / 1e9;
}

// Macros for time measurements
#if 1
  #define TS(name) int64 t_##name = cv::getTickCount()
  #define TE(name) printf("TIMER_" #name ": %.2fms\n", \
    1000.*((cv::getTickCount() - t_##name) / cv::getTickFrequency()))
#else
  #define TS(name)
  #define TE(name)
#endif

- (void)processImage:(cv::Mat &)image {
    // Do some OpenCV processing with the image
    cv::Mat inputFrame = image.clone();

    cv::Rect rcBallIn(150, 110, 55, 60);
    if(imageCount==0)  {
        
        ballBack = inputFrame(rcBallIn).clone();
        imageCount = 1;
    }
    
    cv::Mat matDiff;
    cv::Mat ballCurrent = inputFrame(rcBallIn).clone();
    cv::absdiff(ballBack, ballCurrent, matDiff);

    int dilation_size = 2;
    cv::Mat element = getStructuringElement(cv::MORPH_RECT, cv::Size(2 * dilation_size + 1, 2 * dilation_size + 1), cv::Point(dilation_size, dilation_size));
    cv::erode(matDiff, matDiff, element);
    threshold(matDiff, matDiff, 5, 255, CV_THRESH_BINARY);

    cv::Mat gray;
    cvtColor(matDiff, gray, CV_RGB2GRAY);
    double m = mean(gray)[0];

    if (m > 10)
    {
        putText(inputFrame, "Ball in!!!", cv::Point(40, 40),
        CV_FONT_HERSHEY_COMPLEX, 1, CV_RGB(0, 255, 0), 2);
    }

    ballBack.copyTo(inputFrame(cv::Rect(40, 300, rcBallIn.width, rcBallIn.height)));
    ballCurrent.copyTo(inputFrame(cv::Rect(100, 300, rcBallIn.width, rcBallIn.height)));
    matDiff.copyTo(inputFrame(cv::Rect(160, 300, rcBallIn.width, rcBallIn.height)));
    
    cv::rectangle(inputFrame, rcBallIn, CV_RGB(0, 255, 0), 2);
    
    
    m_array[m_tail] = m;
    m_tail = (m_tail+1) % 200;
    int x = 0;
    int y = 300 - ((int)m_array[m_tail]) %300 ;
    cv::Point pt1 = cv::Point(x, y);    //for(int i=((m_tail+1)%200); i==m_tail; i++) {
    for(int i=1; i<200; i++)  {
        x = i;
        y = 300 - ((int)m_array[(m_tail+i)%200]) %300 ;
        cv::Point pt2 = cv::Point(x, y);
        
        cv::line(inputFrame, pt1, pt2, CV_RGB(0, 255, 0), 1);
        pt1 = pt2;
    }
    cv::line(inputFrame, cv::Point(0, 300-10), cv::Point(199, 300-10), CV_RGB(255, 0, 0), 1);
    
    if(isCapturing == YES)  {
        inputFrame.copyTo(imageBack);
        inputFrame.copyTo(image);
    }
    else   {
        imageBack.copyTo(image);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (isCapturing)
    {
        [videoCamera stop];
    }
}

- (void)dealloc
{
    videoCamera.delegate = nil;
}

@end
