 //
//  DreamMusicTool.m
//  PlayerLearning
//
//  Created by 孙龙霄 on 2/7/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

#import "DreamMusicTool.h"
#import "MJExtension.h"
#import "DreamMusic.h"

@implementation DreamMusicTool

static NSArray *_musics;
static DreamMusic *_playingMusic;

+ (NSArray *)musics{
    if (!_musics){
        _musics =  [DreamMusic objectArrayWithFilename:@"Musics.plist"];
    }
    
    return _musics;
}

+ (DreamMusic *)playingMusic{
    return _playingMusic;
}

+ (DreamMusic *)nextMusic{
    
    if (!_playingMusic) return nil;
    
    NSInteger index = [[self musics] indexOfObject:_playingMusic];
    NSInteger count = [self musics].count;
    return [[self musics] objectAtIndex:(index+1)%count];
    
}

 + (DreamMusic *)previousMusic{
    if (!_playingMusic) return nil;
    
    NSInteger index = [[self musics] indexOfObject:_playingMusic];
    NSInteger count = [self musics].count;
    return [[self musics] objectAtIndex:(index-1)%count];
}

+ (void) setPlayingMusic:(DreamMusic *)playingMusic{
    

    if (_playingMusic && _playingMusic==playingMusic) return;
    if (!playingMusic || ![[self musics] containsObject:playingMusic]) return;
    
    
    _playingMusic = playingMusic;
    
    
        
        

    
}




@end
