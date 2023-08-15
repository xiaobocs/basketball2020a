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