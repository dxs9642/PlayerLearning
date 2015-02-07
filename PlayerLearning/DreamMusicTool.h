//
//  DreamMusicTool.h
//  PlayerLearning
//
//  Created by 孙龙霄 on 2/7/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DreamMusic;

@interface DreamMusicTool : NSObject
+ (NSArray *) musics;

+ (DreamMusic *)playingMusic;
+ (void) setPlayingMusic:(DreamMusic *)playingMusic;

+ (DreamMusic *)nextMusic;

+ (DreamMusic *)previousMusic;

@end
