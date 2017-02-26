//
//  ViewController.m
//  rtmp-live-ios
//
//  Created by yihuds on 2017/2/13.
//  Copyright © 2017年 hudongsong. All rights reserved.
//

#import "ViewController.h"

#import <AVFoundation/AVFoundation.h>
#import "Define.h"

@interface ViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate,AVCaptureAudioDataOutputSampleBufferDelegate>

@property (weak, nonatomic) IBOutlet UIView     *playBtnContainView;
@property (weak, nonatomic) IBOutlet UIButton   *pushStreamBtn;
@property (weak, nonatomic) IBOutlet UIButton   *orderPlayBtn;
@property (weak, nonatomic) IBOutlet UIButton   *livePlayBtn;
@property (weak, nonatomic) IBOutlet UIView     *videoView;
@property (weak, nonatomic) IBOutlet UIButton *startOrStopBtn;

@property (nonatomic, assign) NSInteger                 currentSelectPlayIndex;
@property (nonatomic, assign) SelectStartOrStopBtnIndex currentSelectIndex;


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
    
    _session = [AVCaptureSession new];
    
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
    NSLog(@"startOrStopOnClick title = %@", self.startOrStopBtn.currentTitle);
    
    if ([self.startOrStopBtn.currentTitle isEqualToString:START_BTN_TITLE]) {
        [self.startOrStopBtn setTitle:STOP_BTN_TITLE forState:UIControlStateNormal];
        _currentSelectIndex = SelectStartIndex;
    } else if ([self.startOrStopBtn.currentTitle isEqualToString:STOP_BTN_TITLE]) {
        [self.startOrStopBtn setTitle:START_BTN_TITLE forState:UIControlStateNormal];
        _currentSelectIndex = SelectStopIndex;
    }
    
    if (_currentSelectPlayIndex == 1) {
        if (_currentSelectIndex == SelectStartIndex) { //开启
            [self startRecord];
        } else { //停止
            [self stopRecord];
        }
    } else if (_currentSelectPlayIndex ==2) {
        
    } else if (_currentSelectPlayIndex == 3) {
        
    }
    
    
}

- (void)initView {
    [self.pushStreamBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    self.startOrStopBtn.layer.cornerRadius = 4.0;
    self.startOrStopBtn.layer.borderColor = [UIColor colorWithRed:102.0/255 green:172.0/255 blue:252.0/255 alpha:1.0].CGColor;
    self.startOrStopBtn.layer.borderWidth = 1.0;
    
}

- (void) startRecord {
    [self setupVideoRecord];
}

- (void) stopRecord {
    [_session stopRunning];
}

#pragma mark - 设置音频录制
- (void) setupAudioRecord {
    
}

#pragma mark - 设置视频录制
- (void) setupVideoRecord {
    if ([_session canSetSessionPreset:AVCaptureSessionPreset1920x1080]) {
        _session.sessionPreset = AVCaptureSessionPreset1920x1080;
    }
    
    NSError *error = nil;
    AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
    if (error) {
        NSLog(@"Error getting video input device:%@",error.description);
        
    }
    if ([_session canAddInput:videoInput]) {
        [_session addInput:videoInput];
    }
    
    _videoQueue = dispatch_queue_create("VideoCaptureQueue", DISPATCH_QUEUE_SERIAL);
    _videoOutput = [AVCaptureVideoDataOutput new];
    [_videoOutput setSampleBufferDelegate:self queue:_videoQueue];
    
    NSDictionary *captureSettings = @{(NSString*)kCVPixelBufferPixelFormatTypeKey: @(kCVPixelFormatType_32BGRA)};
    _videoOutput.videoSettings = captureSettings;
    _videoOutput.alwaysDiscardsLateVideoFrames = YES;
    
    if ([_session canAddOutput:_videoOutput]) {
        [_session addOutput:_videoOutput];
    }
    
    _videoConnection = [_videoOutput connectionWithMediaType:AVMediaTypeVideo];
    
    [_session startRunning];
    
    _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [[_previewLayer connection] setVideoOrientation:AVCaptureVideoOrientationPortrait];
    
    _previewLayer.frame = CGRectMake(0, 0, self.videoView.frame.size.height, self.videoView.frame.size.height);
    [self.videoView.layer addSublayer:_previewLayer];

}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    
}


@end
