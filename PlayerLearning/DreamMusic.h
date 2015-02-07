//
//  DreamMusic.h
//  PlayerLearning
//
//  Created by 孙龙霄 on 2/6/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DreamMusic : NSObject
/**
 *  歌曲名字
 */
@property (copy, nonatomic) NSString *name;
/**
 *  歌曲大图
 */
@property (copy, nonatomic) NSString *icon;
/**
 *  歌曲的文件名
 */
@property (copy, nonatomic) NSString *filename;
/**
 *  歌词的文件名
 */
@property (copy, nonatomic) NSString *lrcname;
/**
 *  歌手
 */
@property (copy, nonatomic) NSString *singer;
/**
 *  歌手图标
 */
@property (copy, nonatomic) NSString *singerIcon;

@end
