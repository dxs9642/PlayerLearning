//
//  DreamMusicListCell.h
//  PlayerLearning
//
//  Created by 孙龙霄 on 2/7/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DreamMusic.h"
@interface DreamMusicListCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong)DreamMusic *music;

@end
