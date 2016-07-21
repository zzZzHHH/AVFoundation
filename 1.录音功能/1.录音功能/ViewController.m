//
//  ViewController.m
//  1.录音功能
//
//  Created by 周立贺 on 16/7/21.
//  Copyright © 2016年 周立贺. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()

@property (nonatomic,strong)AVAudioRecorder *audioRecorder;

@end

@implementation ViewController

#pragma mark -- 懒加载
- (AVAudioRecorder *)audioRecorder{
    
    if (!_audioRecorder) {
        //1.确定录音存放的位置
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"text.caf"];
        NSURL *url = [NSURL URLWithString:path];
        
        //2.设置录音参数
        NSMutableDictionary *recorderSettings = [NSMutableDictionary dictionary];
        //设置编码格式
        [recorderSettings setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
        //采样率
        [recorderSettings setValue:[NSNumber numberWithFloat:11025.0] forKey:AVSampleRateKey];
        //通道数
        [recorderSettings setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
        //音频质量,采样质量
        [recorderSettings setValue:[NSNumber numberWithInt:AVAudioQualityMin] forKey:AVEncoderAudioQualityKey];
        
        //3.创建录音对象
        _audioRecorder = [[AVAudioRecorder alloc] initWithURL:url settings:recorderSettings error:nil];
    }
    return _audioRecorder;
}

#pragma mark -- 开始录音
- (IBAction)begin:(id)sender {
    
    [self.audioRecorder prepareToRecord];
    [self.audioRecorder record];
    
}

#pragma mark -- 结束录音
- (IBAction)end:(id)sender {
    
    [self.audioRecorder stop];
    NSLog(@"%@",[self.audioRecorder.url absoluteString]);
}



@end
