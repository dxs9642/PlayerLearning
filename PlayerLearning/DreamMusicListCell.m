//
//  DreamMusicListCell.m
//  PlayerLearning
//
//  Created by 孙龙霄 on 2/7/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

#import "DreamMusicListCell.h"
#import "UIImage+MJ.h"
#import "Colours.h"

@implementation DreamMusicListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"music";
    
    DreamMusicListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell){
        cell = [[DreamMusicListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (void)setMusic:(DreamMusic *)music{
    _music = music;
    
    self.textLabel.text = music.name;
    self.detailTextLabel.text = music.singer;
    self.imageView.image = [UIImage circleImageWithName:music.singerIcon borderWidth:2 borderColor:[UIColor midnightBlueColor]];

    
    
    
}




@end
