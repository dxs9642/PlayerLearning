//
//  ViewController.m
//  PlayerLearning
//
//  Created by 孙龙霄 on 2/6/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface ViewController ()
@property (nonatomic,strong) AVAudioPlayer *player;//nsobject跟其子类
@property (nonatomic,copy) NSString *string;
@property (nonatomic,retain) ViewController *controller;//nsobject跟其子类，不大用，由strong代替
@property (nonatomic,assign) NSInteger *intNum;//基础数据类型
@end

@implementation ViewController

- (AVAudioPlayer *)player{
    if (!_player){
        AVAudioPlayer *player = [[AVAudioPlayer alloc] init];
        [player prepareToPlay];
        _player = player;
        
    }
    return _player;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
