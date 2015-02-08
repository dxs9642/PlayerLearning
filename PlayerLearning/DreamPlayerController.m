//
//  DreamPlayerController.m
//  PlayerLearning
//
//  Created by 孙龙霄 on 2/7/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import "DreamPlayerController.h"
#import "DreamMusicTool.h"
#import "DreamMusic.h"
#import "DreamAudioTool.h"

@interface DreamPlayerController () <AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *playerImage;
@property (weak, nonatomic) IBOutlet UILabel *songName;
@property (weak, nonatomic) IBOutlet UILabel *playerName;
@property (weak, nonatomic) IBOutlet UILabel *duration;
@property (weak, nonatomic) IBOutlet UIButton *slider;
@property (weak, nonatomic) IBOutlet UIView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *progressShow;
@property (weak, nonatomic) IBOutlet UIButton *playButton;



@property (nonatomic,strong) DreamMusic *playingMusic;
@property (nonatomic,strong) NSTimer *progressTimer;
@property (nonatomic,strong) AVAudioPlayer *player;



- (IBAction)exit;
- (IBAction)LyricOrPic:(UIButton *)sender;
- (IBAction)progressTapGesture:(UITapGestureRecognizer *)sender;
- (IBAction)sliderPanGesture:(UIPanGestureRecognizer *)sender;
- (IBAction)playOrPause:(UIButton *)sender;
- (IBAction)previousSong:(UIButton *)sender;
- (IBAction)nextSong:(UIButton *)sender;




@end

@implementation DreamPlayerController

- (void)viewDidLoad {

    [super viewDidLoad];
    self.progressShow.layer.cornerRadius = 10;
}

- (void)show{
    self.view.hidden = NO;
    self.view.userInteractionEnabled = NO;
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self.view];
    self.view.frame = window.bounds;
    self.view.y = window.height;
    [UIView animateWithDuration:0.5 animations:^{
        self.view.y = 0;
    } completion:^(BOOL finished) {
        
        [self setupMusicData];
        self.view.userInteractionEnabled = YES;

        
    }];
    
}

#pragma mark - 私有方法

- (void)setupMusicData{
    
    DreamMusic *currentMusic = [DreamMusicTool playingMusic];
    
    if (!self.playingMusic||self.playingMusic != currentMusic) {
        self.playButton.selected = YES;
        [self resetPlayingMusic:currentMusic];
        self.player = [DreamAudioTool playMusic:self.playingMusic.filename];
        self.player.delegate = self;
        
        self.duration.text = [self strWithTime:self.player.duration];
    }
    
}

- (void)addProgressTimer{
    
    if (self.progressTimer) {
        [self removeProgressTimer];
    }
    
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateCurrentTime) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
}

- (void)removeProgressTimer{
    if (self.progressTimer){
        [self.progressTimer invalidate];
        self.progressTimer = nil;
    }
}

- (void)updateCurrentTime{
    double progress = self.player.currentTime / self.player.duration;
    
    CGFloat sliderMax = self.view.width - self.slider.width;
    
    
    [self.slider setTitle:[self strWithTime:self.player.currentTime] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.25 animations:^{
        self.slider.x = sliderMax * progress;
        self.progressView.width = sliderMax * progress + 21;
    }];

}

- (NSString *)strWithTime:(NSTimeInterval)time{
    
    int minute = (int)time / 60;
    int second = (int)time % 60;
    NSString *result = @"";
    NSString *minuteString;
    NSString *secondString;
    if (minute<10) {
        minuteString = [NSString stringWithFormat:@"0%d",minute];
    }else{
        minuteString = [NSString stringWithFormat:@"%d",minute];

    }
    result = [result stringByAppendingString:minuteString];
    result = [result stringByAppendingString:@":"];
    if (second<10) {
        secondString = [NSString stringWithFormat:@"0%d",second];
    }else{
        secondString = [NSString stringWithFormat:@"%d",second];
    }
    result = [result stringByAppendingString:secondString];
    return  result;
    
    
}


- (void)resetPlayingMusic:(DreamMusic *)currentMusic {
    
    CATransition *anim = [CATransition animation];
    anim.duration = 1;
    anim.type = @"rippleEffect";
    [self.playerImage.layer addAnimation:anim forKey:nil];
    self.playerImage.image = [UIImage imageNamed:currentMusic.icon];
    
    
    self.songName.text = currentMusic.name;
    self.playerName.text = currentMusic.singer;

    [DreamAudioTool stopMusic:self.playingMusic.filename];
    
    self.playingMusic = currentMusic;

    self.duration.text = @"00:00";
    [self removeProgressTimer];
    [UIView animateWithDuration:0.5 animations:^{
        self.slider.x = 0;
        self.progressView.width = 21;

    }];
    
    
    [self addProgressTimer];
    
}


- (IBAction)exit {
    self.view.userInteractionEnabled = NO;

    [UIView animateWithDuration:0.5 animations:^{
        self.view.y = self.view.height;
    } completion:^(BOOL finished) {
        self.view.hidden = YES;
        self.view.userInteractionEnabled = YES;

    }];
    
    [self removeProgressTimer];

}

- (IBAction)LyricOrPic:(UIButton *)sender {
}




- (IBAction)progressTapGesture:(UITapGestureRecognizer *)sender {
    
    CGPoint point = [sender locationInView:sender.view];
    
    
    self.player.currentTime = (point.x - 21) / (sender.view.width - 42) * self.player.duration;
    [self updateCurrentTime];
    
    
    
}

- (IBAction)sliderPanGesture:(UIPanGestureRecognizer *)sender {
    
    CGPoint point = [sender translationInView:sender.view];
    [sender setTranslation:CGPointZero inView:sender.view];
    
    NSTimeInterval time;
    
    
    int result = self.slider.x + point.x;
    int totalWidth = self.view.width - self.slider.width;
    if (result >= 0 && result <= totalWidth){
        self.slider.x = result;
        self.progressShow.x = self.slider.x;
        self.progressView.width = self.slider.center.x;
        CGFloat sliderMax = totalWidth;
        double percent = self.slider.x / sliderMax;
        time = self.player.duration * percent;
        [self.slider setTitle:[self strWithTime:time] forState:UIControlStateNormal];
        [self.progressShow setTitle:[self strWithTime:time] forState:UIControlStateNormal];
    }
    
    if (sender.state == UIGestureRecognizerStateBegan){

        [self removeProgressTimer];
        self.progressShow.hidden = NO;

    }else if(sender.state == UIGestureRecognizerStateEnded){
        
        self.player.currentTime = time;
        [self addProgressTimer];
        self.progressShow.hidden = YES;

    }
    

    
}

- (IBAction)playOrPause:(UIButton *)sender {

    if (self.playButton.selected) {
        self.playButton.selected = NO;
        [DreamAudioTool pauseMusic:self.playingMusic.filename];
        [self removeProgressTimer];

    }else{
        self.playButton.selected = YES;
        [DreamAudioTool playMusic:self.playingMusic.filename];
        [self addProgressTimer];
    }

    
}

- (IBAction)previousSong:(UIButton *)sender {
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    window.userInteractionEnabled = NO;
    
    
    [DreamMusicTool setPlayingMusic:[DreamMusicTool previousMusic]];
    [self setupMusicData];
    [self addProgressTimer];
    window.userInteractionEnabled = YES;

    
}

- (IBAction)nextSong:(UIButton *)sender {
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    window.userInteractionEnabled = NO;
    
    
    [DreamMusicTool setPlayingMusic:[DreamMusicTool nextMusic]];
    [self setupMusicData];
    [self addProgressTimer];
    window.userInteractionEnabled = YES;
    
}



- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    [self playOrPause:self.playButton];
    
}

@end
