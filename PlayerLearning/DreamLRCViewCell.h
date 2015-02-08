//
//  DreamLRCViewCell.h
//  PlayerLearning
//
//  Created by 孙龙霄 on 2/8/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DreamLRCLine;

@interface DreamLRCViewCell : UITableViewCell

@property (nonatomic,strong) DreamLRCLine *line;
+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
