#README.md

##工具
xcode 14.3.1
opencv 2.4.13.6

##功能
用手机来判别投篮进球率

##使用步骤
手机架在三脚架，摄像头朝向篮框
屏幕上显示后向摄像头的视频流
屏幕上有一个矩形，调整手机，使得屏幕的矩形框住篮框
点击屏幕上的Start Capture按钮，开始检测投篮
投篮进球后，屏幕上会显示“ball in！”，并计数

##软件开发
在storyboard增加imageView来显示后向摄像头的视频流
增加Start Capture Button和Stop Capture Button按钮
连接按钮和ViewController.h的类声明

##待开发
使用opencv识别篮板和篮框，避免手工调节“识别矩形”
https://www.coder.work/article/2084553
opencv - 检测篮球篮球和球跟踪
https://stackoverflow.com/questions/19046890/detect-basket-ball-hoops-and-ball-tracking
Detect basket ball Hoops and ball tracking
Ask Question
Asked 9 years, 10 months ago
Modified 3 years, 1 month ago
Viewed 3k times

https://www.linkedin.com/pulse/basketball-goal-detection-rnn-stephan-janssen
https://youtu.be/QEaFBtD_M_w
https://medium.com/swlh/automating-basketball-highlights-with-object-tracking-b134ce9afec2
https://youtu.be/PVtmK8LmYpA
https://github.com/Basket-Analytics/BasketTracking
https://github.com/browlm13/Basketball-Shot-Detection
https://forum.opencv.org/t/how-to-follow-the-action-on-a-basketball-court/3180
https://www.mi-research.net/en/article/doi/10.1007/s11633-020-1259-7
https://www.ijrte.org/wp-content/uploads/papers/v7i4s2/Es2066017519.pdf
https://gizmodo.com/ball-tracking-basketball-hoop-makes-it-impossible-to-mi-1843391186
https://www.researchgate.net/publication/234100963_A_real-time_trajectory-based_ball_detection-and-tracking_framework_for_basketball_video

#opencv 2 -> 3
#import <opencv2/opencv.hpp>
#import <opencv2/highgui/ios.h>
改成
#import <opencv2/core.hpp>
#import <opencv2/videoio/cap_ios.h>
#import <opencv2/imgproc.hpp>

#opencv 3 -> 4
opencv4与opencv3区别
   CV_RGB2GRAY -> cv::COLOR_RGB2GRAY
   CV_THRESH_BINARY -> cv::THRESH_BINARY
https://edu.csdn.net/skill/opencv/?utm_source=csdn_ai_skill_tree_blog
3可以使用C和C++格式
4只能用c++

