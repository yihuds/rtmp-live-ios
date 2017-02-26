//
//  ViewController.m
//  rtmp-live-ios
//
//  Created by yihuds on 2017/2/13.
//  Copyright © 2017年 hudongsong. All rights reserved.
//

#import "ViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate,AVCaptureAudioDataOutputSampleBufferDelegate>

@property (weak, nonatomic) IBOutlet UIView     *playBtnContainView;
@property (weak, nonatomic) IBOutlet UIButton   *pushStreamBtn;
@property (weak, nonatomic) IBOutlet UIButton   *orderPlayBtn;
@property (weak, nonatomic) IBOutlet UIButton   *livePlayBtn;
@property (weak, nonatomic) IBOutlet UIView     *videoView;
@property (weak, nonatomic) IBOutlet UIButton *startOrStopBtn;

@property (nonatomic, assign) NSInteger         currentSelectPlayIndex;

@property (nonatomic, strong) AVCaptureSession           *session;
@property (nonatomic, strong) dispatch_queue_t           videoQueue;
@property (nonatomic, strong) dispatch_queue_t           AudioQueue;

@property (nonatomic, strong) AVCaptureDeviceInput       *captureDeviceInput;
@property (nonatomic, strong) AVCaptureVideoDataOutput   *videoOutput;
@property (nonatomic, strong) AVCaptureConnection        *videoConnection;
@property (nonatomic, strong) AVCaptureConnection        *audioConnection;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic, strong) NSMutableData              *data;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)playButtonOnClick:(UIButton*)sender {
    for (int tagIndex=1; tagIndex<=3; tagIndex++) {
        UIButton* playButton = (UIButton*)[self.playBtnContainView viewWithTag:tagIndex];
        if (tagIndex == sender.tag) {
            [sender setBackgroundColor:[UIColor blueColor]];
            _currentSelectPlayIndex = sender.tag;
        } else {
            [playButton setBackgroundColor:[UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1.0]];
        }
    }
}

- (IBAction)startOrStopOnClick:(id)sender {
    if (_currentSelectPlayIndex == 0) {
        
    } else if (_currentSelectPlayIndex ==1) {
        
    } else if (_currentSelectPlayIndex == 2) {
        
    }
}

- (void)initView {
    [self.pushStreamBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    self.startOrStopBtn.layer.cornerRadius = 4.0;
    self.startOrStopBtn.layer.borderColor = [UIColor colorWithRed:102.0/255 green:172.0/255 blue:252.0/255 alpha:1.0].CGColor;
    self.startOrStopBtn.layer.borderWidth = 1.0;
    
}



@end
